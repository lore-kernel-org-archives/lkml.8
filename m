Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC68C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09420661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD3Pj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:39:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49484 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgD3Pj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:39:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2A4432A29C3
Subject: Re: [PATCH] platform: chrome: Allocate sensorhub resource before
 claiming sensors
To:     Gwendal Grignou <gwendal@chromium.org>, dianders@chromium.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org
References: <20200427225902.30404-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <721e938c-9ef3-a01d-3e3e-98dd97172ba4@collabora.com>
Date:   Thu, 30 Apr 2020 17:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427225902.30404-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for your patch.

On 28/4/20 0:59, Gwendal Grignou wrote:
> Allocate callbacks array before enumerating the sensors:
> The probe routine for these sensors (for instance cros_ec_sensors_probe)
> can be called within the sensorhub probe routine
> (cros_ec_sensors_probe())
> 
> Fixes: 145d59baff594 ("platform/chrome: cros_ec_sensorhub: Add FIFO support")
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Applied as a fix for 5.7

> ---
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 80 +++++++++++--------
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 73 ++++++++++-------
>  .../linux/platform_data/cros_ec_sensorhub.h   |  1 +
>  3 files changed, 93 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index b7f2c00db5e1e..9c4af76a9956e 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -52,28 +52,15 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
>  	struct cros_ec_command *msg = sensorhub->msg;
>  	struct cros_ec_dev *ec = sensorhub->ec;
> -	int ret, i, sensor_num;
> +	int ret, i;
>  	char *name;
>  
> -	sensor_num = cros_ec_get_sensor_count(ec);
> -	if (sensor_num < 0) {
> -		dev_err(dev,
> -			"Unable to retrieve sensor information (err:%d)\n",
> -			sensor_num);
> -		return sensor_num;
> -	}
> -
> -	sensorhub->sensor_num = sensor_num;
> -	if (sensor_num == 0) {
> -		dev_err(dev, "Zero sensors reported.\n");
> -		return -EINVAL;
> -	}
>  
>  	msg->version = 1;
>  	msg->insize = sizeof(struct ec_response_motion_sense);
>  	msg->outsize = sizeof(struct ec_params_motion_sense);
>  
> -	for (i = 0; i < sensor_num; i++) {
> +	for (i = 0; i < sensorhub->sensor_num; i++) {
>  		sensorhub->params->cmd = MOTIONSENSE_CMD_INFO;
>  		sensorhub->params->info.sensor_num = i;
>  
> @@ -140,8 +127,7 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>  	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>  	struct cros_ec_sensorhub *data;
>  	struct cros_ec_command *msg;
> -	int ret;
> -	int i;
> +	int ret, i, sensor_num;
>  
>  	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
>  			   max((u16)sizeof(struct ec_params_motion_sense),
> @@ -166,10 +152,52 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, data);
>  
>  	/* Check whether this EC is a sensor hub. */
> -	if (cros_ec_check_features(data->ec, EC_FEATURE_MOTION_SENSE)) {
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
> +		sensor_num = cros_ec_get_sensor_count(ec);
> +		if (sensor_num < 0) {
> +			dev_err(dev,
> +				"Unable to retrieve sensor information (err:%d)\n",
> +				sensor_num);
> +			return sensor_num;
> +		}
> +		if (sensor_num == 0) {
> +			dev_err(dev, "Zero sensors reported.\n");
> +			return -EINVAL;
> +		}
> +		data->sensor_num = sensor_num;
> +
> +		/*
> +		 * Prepare the ring handler before enumering the
> +		 * sensors.
> +		 */
> +		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +			ret = cros_ec_sensorhub_ring_allocate(data);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* Enumerate the sensors.*/
>  		ret = cros_ec_sensorhub_register(dev, data);
>  		if (ret)
>  			return ret;
> +
> +		/*
> +		 * When the EC does not have a FIFO, the sensors will query
> +		 * their data themselves via sysfs or a software trigger.
> +		 */
> +		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +			ret = cros_ec_sensorhub_ring_add(data);
> +			if (ret)
> +				return ret;
> +			/*
> +			 * The msg and its data is not under the control of the
> +			 * ring handler.
> +			 */
> +			return devm_add_action_or_reset(dev,
> +					cros_ec_sensorhub_ring_remove,
> +					data);
> +		}
> +
>  	} else {
>  		/*
>  		 * If the device has sensors but does not claim to
> @@ -184,22 +212,6 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	/*
> -	 * If the EC does not have a FIFO, the sensors will query their data
> -	 * themselves via sysfs or a software trigger.
> -	 */
> -	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> -		ret = cros_ec_sensorhub_ring_add(data);
> -		if (ret)
> -			return ret;
> -		/*
> -		 * The msg and its data is not under the control of the ring
> -		 * handler.
> -		 */
> -		return devm_add_action_or_reset(dev,
> -						cros_ec_sensorhub_ring_remove,
> -						data);
> -	}
>  
>  	return 0;
>  }
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index c48e5b38a4417..24e48d96ed766 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -957,17 +957,15 @@ static int cros_ec_sensorhub_event(struct notifier_block *nb,
>  }
>  
>  /**
> - * cros_ec_sensorhub_ring_add() - Add the FIFO functionality if the EC
> - *				  supports it.
> + * cros_ec_sensorhub_ring_allocate() - Prepare the FIFO functionality if the EC
> + *				       supports it.
>   *
>   * @sensorhub : Sensor Hub object.
>   *
>   * Return: 0 on success.
>   */
> -int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
> +int cros_ec_sensorhub_ring_allocate(struct cros_ec_sensorhub *sensorhub)
>  {
> -	struct cros_ec_dev *ec = sensorhub->ec;
> -	int ret;
>  	int fifo_info_length =
>  		sizeof(struct ec_response_motion_sense_fifo_info) +
>  		sizeof(u16) * sensorhub->sensor_num;
> @@ -978,6 +976,49 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
>  	if (!sensorhub->fifo_info)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Allocate the callback area based on the number of sensors.
> +	 * Add one for the sensor ring.
> +	 */
> +	sensorhub->push_data = devm_kcalloc(sensorhub->dev,
> +			sensorhub->sensor_num,
> +			sizeof(*sensorhub->push_data),
> +			GFP_KERNEL);
> +	if (!sensorhub->push_data)
> +		return -ENOMEM;
> +
> +	sensorhub->tight_timestamps = cros_ec_check_features(
> +			sensorhub->ec,
> +			EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
> +
> +	if (sensorhub->tight_timestamps) {
> +		sensorhub->batch_state = devm_kcalloc(sensorhub->dev,
> +				sensorhub->sensor_num,
> +				sizeof(*sensorhub->batch_state),
> +				GFP_KERNEL);
> +		if (!sensorhub->batch_state)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cros_ec_sensorhub_ring_add() - Add the FIFO functionality if the EC
> + *				  supports it.
> + *
> + * @sensorhub : Sensor Hub object.
> + *
> + * Return: 0 on success.
> + */
> +int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +	int ret;
> +	int fifo_info_length =
> +		sizeof(struct ec_response_motion_sense_fifo_info) +
> +		sizeof(u16) * sensorhub->sensor_num;
> +
>  	/* Retrieve FIFO information */
>  	sensorhub->msg->version = 2;
>  	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> @@ -998,31 +1039,9 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
>  	if (!sensorhub->ring)
>  		return -ENOMEM;
>  
> -	/*
> -	 * Allocate the callback area based on the number of sensors.
> -	 */
> -	sensorhub->push_data = devm_kcalloc(
> -			sensorhub->dev, sensorhub->sensor_num,
> -			sizeof(*sensorhub->push_data),
> -			GFP_KERNEL);
> -	if (!sensorhub->push_data)
> -		return -ENOMEM;
> -
>  	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
>  		cros_ec_get_time_ns();
>  
> -	sensorhub->tight_timestamps = cros_ec_check_features(
> -			ec, EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
> -
> -	if (sensorhub->tight_timestamps) {
> -		sensorhub->batch_state = devm_kcalloc(sensorhub->dev,
> -				sensorhub->sensor_num,
> -				sizeof(*sensorhub->batch_state),
> -				GFP_KERNEL);
> -		if (!sensorhub->batch_state)
> -			return -ENOMEM;
> -	}
> -
>  	/* Register the notifier that will act as a top half interrupt. */
>  	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
>  	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index c588be843f61b..0ecce6aa69d5e 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -185,6 +185,7 @@ int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
>  void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
>  					    u8 sensor_num);
>  
> +int cros_ec_sensorhub_ring_allocate(struct cros_ec_sensorhub *sensorhub);
>  int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub);
>  void cros_ec_sensorhub_ring_remove(void *arg);
>  int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
> 
