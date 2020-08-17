Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE660204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgHQLcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgHQLcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:32:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FADC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 04:32:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 91B6A28DA67
Subject: Re: [PATCH] platform: cros_ec: sensorhub: Simplify legacy timestamp
 spreading
To:     Gwendal Grignou <gwendal@chromium.org>, groeck@chromium.org,
        bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20200728091355.2506827-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8fdaba0f-be3d-84e7-c0df-8a70612402fe@collabora.com>
Date:   Mon, 17 Aug 2020 13:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200728091355.2506827-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On 28/7/20 11:13, Gwendal Grignou wrote:
> On some machine (nami), interrupt latency cause samples to appear
> to be from the future and are pegged to the current time.
> We would see samples with this pattern:
> 
> [t, t + ~5ms, t + ~10ms, t + ~10ms + 100us, t + ~10ms + 200us],
>                              (current now)      (current now)
> (t is the last timestamp time)
> 
> Last 2 samples would be barely spread, causing applications to
> complain.
> We now spread the entire sequence. This is not great: in the example
> the sensor was supposed to send samples every 5ms, it now appears to
> send one every 2.5ms, but it is slightly closer to reality:
> 
> sampling time in the example above
> At sensor level
> 
> 1             2             3             4            5
> +-----5ms-----+-----5ms-----+-----5ms-----+----5ms-----+---> t
> 
> Before, at host level
>                        1             2             3 4 5
> --interrupt delay------+-----5ms-----+-----5ms-----+-+-+---> t
> 
> Afer, at host level
>                        1       2       3       4       5
> --interrupt delay------+-2.5ms-+-2.5ms-+-2.5ms-+-2.5ms-+---> t
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>


Sorry for late notice. The patch has been applied for 5.9.

> ---
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 94 +++++++------------
>  1 file changed, 33 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index 1b9637655e63e..0b0bf93073c30 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -719,29 +719,22 @@ done_with_this_batch:
>   * cros_ec_sensor_ring_spread_add_legacy: Calculate proper timestamps then
>   * add to ringbuffer (legacy).
>   *
> - * Note: This assumes we're running old firmware, where every sample's timestamp
> - * is after the sample. Run if tight_timestamps == false.
> - *
> - * If there is a sample with a proper timestamp
> + * Note: This assumes we're running old firmware, where timestamp
> + * is inserted after its sample(s)e. There can be several samples between
> + * timestamps, so several samples can have the same timestamp.
>   *
>   *                        timestamp | count
>   *                        -----------------
> - * older_unprocess_out --> TS1      | 1
> - *                         TS1      | 2
> - *                out -->  TS1      | 3
> - *           next_out -->  TS2      |
> - *
> - * We spread time for the samples [older_unprocess_out .. out]
> - * between TS1 and TS2: [TS1+1/4, TS1+2/4, TS1+3/4, TS2].
> + *          1st sample --> TS1      | 1
> + *                         TS2      | 2
> + *                         TS2      | 3
> + *                         TS3      | 4
> + *           last_out -->
>   *
> - * If we reach the end of the samples, we compare with the
> - * current timestamp:
>   *
> - * older_unprocess_out --> TS1      | 1
> - *                         TS1      | 2
> - *                 out --> TS1      | 3
> + * We spread time for the samples using perod p = (current - TS1)/4.
> + * between TS1 and TS2: [TS1+p/4, TS1+2p/4, TS1+3p/4, current_timestamp].
>   *
> - * We know have [TS1+1/3, TS1+2/3, current timestamp]
>   */
>  static void
>  cros_ec_sensor_ring_spread_add_legacy(struct cros_ec_sensorhub *sensorhub,
> @@ -754,58 +747,37 @@ cros_ec_sensor_ring_spread_add_legacy(struct cros_ec_sensorhub *sensorhub,
>  	int i;
>  
>  	for_each_set_bit(i, &sensor_mask, sensorhub->sensor_num) {
> -		s64 older_timestamp;
>  		s64 timestamp;
> -		struct cros_ec_sensors_ring_sample *older_unprocess_out =
> -			sensorhub->ring;
> -		struct cros_ec_sensors_ring_sample *next_out;
> -		int count = 1;
> -
> -		for (out = sensorhub->ring; out < last_out; out = next_out) {
> -			s64 time_period;
> +		int count = 0;
> +		s64 time_period;
>  
> -			next_out = out + 1;
> +		for (out = sensorhub->ring; out < last_out; out++) {
>  			if (out->sensor_id != i)
>  				continue;
>  
>  			/* Timestamp to start with */
> -			older_timestamp = out->timestamp;
> -
> -			/* Find next sample. */
> -			while (next_out < last_out && next_out->sensor_id != i)
> -				next_out++;
> +			timestamp = out->timestamp;
> +			out++;
> +			count = 1;
> +			break;
> +		}
> +		for (; out < last_out; out++) {
> +			/* Find last sample. */
> +			if (out->sensor_id != i)
> +				continue;
> +			count++;
> +		}
> +		if (count == 0)
> +			continue;
>  
> -			if (next_out >= last_out) {
> -				timestamp = current_timestamp;
> -			} else {
> -				timestamp = next_out->timestamp;
> -				if (timestamp == older_timestamp) {
> -					count++;
> -					continue;
> -				}
> -			}
> +		/* Spread uniformly between the first and last samples. */
> +		time_period = div_s64(current_timestamp - timestamp, count);
>  
> -			/*
> -			 * The next sample has a new timestamp, spread the
> -			 * unprocessed samples.
> -			 */
> -			if (next_out < last_out)
> -				count++;
> -			time_period = div_s64(timestamp - older_timestamp,
> -					      count);
> -
> -			for (; older_unprocess_out <= out;
> -					older_unprocess_out++) {
> -				if (older_unprocess_out->sensor_id != i)
> -					continue;
> -				older_timestamp += time_period;
> -				older_unprocess_out->timestamp =
> -					older_timestamp;
> -			}
> -			count = 1;
> -			/* The next_out sample has a valid timestamp, skip. */
> -			next_out++;
> -			older_unprocess_out = next_out;
> +		for (out = sensorhub->ring; out < last_out; out++) {
> +			if (out->sensor_id != i)
> +				continue;
> +			timestamp += time_period;
> +			out->timestamp = timestamp;
>  		}
>  	}
>  
> 
