Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51ABC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C7821481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgIGKEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgIGKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:04:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC6C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:04:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EC9ED295A49
Subject: Re: [PATCH v3] platform: cros_ec: Reduce ligthbar get version command
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200830065937.2562679-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fa8587be-1fec-74e7-aa78-949997b18b43@collabora.com>
Date:   Mon, 7 Sep 2020 12:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830065937.2562679-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On 30/8/20 8:59, Gwendal Grignou wrote:
> By default, the lightbar commands are set to the
> biggest lightbar command and response. That length is greater than 128
> bytes and may not work on all machines.
> But all EC are probed for lightbar by sending a get version request.
> Set that request size precisely.
> 
> Before the command would be:
> cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
> Afer:
> cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0
> 
> Fixes: a841178445bb7 ("mfd: cros_ec: Use a zero-length array for command data")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I changed the subject to match "platform/chrome: cros_ec_lightbar" and applied
for 5.10.

Thanks,
 Enric

> ---
> Changes since v2:
> - Add fix field where the inefficiency was present.
> 
> Changes since v1:
> - Remove BUG and TEST fields.
> 
>  drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index b59180bff5a3e..ef61298c30bdd 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
>  
>  	param = (struct ec_params_lightbar *)msg->data;
>  	param->cmd = LIGHTBAR_CMD_VERSION;
> +	msg->outsize = sizeof(param->cmd);
> +	msg->result = sizeof(resp->version);
>  	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>  	if (ret < 0) {
>  		ret = 0;
> 
