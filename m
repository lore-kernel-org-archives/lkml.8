Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B3C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533E920738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIGKsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:48:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgIGKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:48:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8F5B9286125
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Update
 cros_ec_cmd_xfer() call-sites
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200903095415.2572049-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1e2de378-5f5b-939e-39d8-00d6cc5ab6c8@collabora.com>
Date:   Mon, 7 Sep 2020 12:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903095415.2572049-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for your patch.

On 3/9/20 11:54, Prashant Malani wrote:
> Since all the other call-sites of cros_ec_cmd_xfer() have been converted
> to use cros_ec_cmd_xfer_status() instead, update the remaining
> call-sites to prepare for the merge of cros_ec_cmd_xfer() into
> cros_ec_cmd_xfer_status().
> 
> As part of this update, change the error handling inside
> cros_ec_get_sensor_count() such that the legacy LPC interface is tried
> on all error values, not just when msg->result != EC_RESULT_SUCCESS.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Gwendal, I'd like to hear from you regarding this patch as you're the one that
know most about the corner cases for the sensors in different hardware. Could
you take a look and give us your Reviewed tag if all is good?

Thanks,

 Enric

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index dda182132a6a..2cb1defcdd13 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -650,7 +650,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  	msg->insize = size;
>  	msg->outsize = 0;
>  
> -	ret = cros_ec_cmd_xfer(ec_dev, msg);
> +	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
>  	if (ret > 0) {
>  		ec_dev->event_size = ret - 1;
>  		ec_dev->event_data = *event;
> @@ -694,7 +694,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
>  	msg->insize = sizeof(ec_dev->event_data.data);
>  	msg->outsize = 0;
>  
> -	ec_dev->event_size = cros_ec_cmd_xfer(ec_dev, msg);
> +	ec_dev->event_size = cros_ec_cmd_xfer_status(ec_dev, msg);
>  	ec_dev->event_data.event_type = EC_MKBP_EVENT_KEY_MATRIX;
>  	memcpy(&ec_dev->event_data.data, msg->data,
>  	       sizeof(ec_dev->event_data.data));
> @@ -883,11 +883,9 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>  	params = (struct ec_params_motion_sense *)msg->data;
>  	params->cmd = MOTIONSENSE_CMD_DUMP;
>  
> -	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> +	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>  	if (ret < 0) {
>  		sensor_count = ret;
> -	} else if (msg->result != EC_RES_SUCCESS) {
> -		sensor_count = -EPROTO;
>  	} else {
>  		resp = (struct ec_response_motion_sense *)msg->data;
>  		sensor_count = resp->dump.sensor_count;
> @@ -898,9 +896,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>  	 * Check legacy mode: Let's find out if sensors are accessible
>  	 * via LPC interface.
>  	 */
> -	if (sensor_count == -EPROTO &&
> -	    ec->cmd_offset == 0 &&
> -	    ec_dev->cmd_readmem) {
> +	if (sensor_count < 0 && ec->cmd_offset == 0 && ec_dev->cmd_readmem) {
>  		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
>  				1, &status);
>  		if (ret >= 0 &&
> @@ -915,9 +911,6 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>  			 */
>  			sensor_count = 0;
>  		}
> -	} else if (sensor_count == -EPROTO) {
> -		/* EC responded, but does not understand DUMP command. */
> -		sensor_count = 0;
>  	}
>  	return sensor_count;
>  }
> 
