Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC37A20873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgCCKBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:01:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54862 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgCCKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:01:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1244A29556D
Subject: Re: [PATCH] platform: chrome: cros_ec_spi: Use new structure for SPI
 transfer delays
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org
References: <20200227140917.10131-1-sergiu.cuciurean@analog.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <37aa3520-10c9-ca3a-228c-68dec8f8a3a7@collabora.com>
Date:   Tue, 3 Mar 2020 11:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227140917.10131-1-sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergiu

On 27/2/20 15:09, Sergiu Cuciurean wrote:
> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---

Applied for 5.7

>  drivers/platform/chrome/cros_ec_spi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 46786d2d679a..665ab154bb4f 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -127,7 +127,8 @@ static int terminate_request(struct cros_ec_device *ec_dev)
>  	 */
>  	spi_message_init(&msg);
>  	memset(&trans, 0, sizeof(trans));
> -	trans.delay_usecs = ec_spi->end_of_msg_delay;
> +	trans.delay.value = ec_spi->end_of_msg_delay;
> +	trans.delay.unit = SPI_DELAY_UNIT_NSECS;
>  	spi_message_add_tail(&trans, &msg);
>  
>  	ret = spi_sync_locked(ec_spi->spi, &msg);
> @@ -416,7 +417,8 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
>  	spi_message_init(&msg);
>  	if (ec_spi->start_of_msg_delay) {
>  		memset(&trans_delay, 0, sizeof(trans_delay));
> -		trans_delay.delay_usecs = ec_spi->start_of_msg_delay;
> +		trans_delay.delay.value = ec_spi->start_of_msg_delay;
> +		trans_delay.delay.unit = SPI_DELAY_UNIT_USECS;
>  		spi_message_add_tail(&trans_delay, &msg);
>  	}
>  
> 
