Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5440FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3862E21531
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgFZJw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:52:28 -0400
Received: from foss.arm.com ([217.140.110.172]:59262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgFZJw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:52:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305D21FB;
        Fri, 26 Jun 2020 02:52:27 -0700 (PDT)
Received: from [10.57.13.97] (unknown [10.57.13.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C31963F71E;
        Fri, 26 Jun 2020 02:52:25 -0700 (PDT)
Subject: Re: [PATCH 3/6] hantro: Rework how encoder and decoder are identified
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, kernel@collabora.com,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20200625163525.5119-1-ezequiel@collabora.com>
 <20200625163525.5119-4-ezequiel@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <119b9832-c1bc-9010-cca6-ea82d61c8e9b@arm.com>
Date:   Fri, 26 Jun 2020 10:52:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625163525.5119-4-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On 2020-06-25 17:35, Ezequiel Garcia wrote:
> So far we've been using the .buf_finish hook to distinguish
> decoder from encoder. This is unnecessarily obfuscated.
> 
> Moreover, we want to move the buf_finish, so use a cleaner
> scheme to distinguish the driver decoder/encoder type.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>   drivers/staging/media/hantro/hantro.h     | 2 ++
>   drivers/staging/media/hantro/hantro_drv.c | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 3005207fc6fb..028b788ad50f 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -199,6 +199,7 @@ struct hantro_dev {
>    *
>    * @dev:		VPU driver data to which the context belongs.
>    * @fh:			V4L2 file handler.
> + * @is_encoder:		Decoder or encoder context?
>    *
>    * @sequence_cap:       Sequence counter for capture queue
>    * @sequence_out:       Sequence counter for output queue
> @@ -223,6 +224,7 @@ struct hantro_dev {
>   struct hantro_ctx {
>   	struct hantro_dev *dev;
>   	struct v4l2_fh fh;
> +	bool is_encoder;
>   
>   	u32 sequence_cap;
>   	u32 sequence_out;
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 0db8ad455160..112ed556eb90 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -197,7 +197,7 @@ static void device_run(void *priv)
>   
>   bool hantro_is_encoder_ctx(const struct hantro_ctx *ctx)
>   {
> -	return ctx->buf_finish == hantro_enc_buf_finish;
> +	return ctx->is_encoder;

FWIW I'd suggest removing the wrapper function entirely now - it makes 
sense when the check itself is implemented in a weird and non-obvious 
way, but a simple boolean flag named exactly what it means is already 
about as clear as it can get.

Robin.

>   }
>   
>   static struct v4l2_m2m_ops vpu_m2m_ops = {
> @@ -420,8 +420,10 @@ static int hantro_open(struct file *filp)
>   	if (func->id == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>   		allowed_codecs = vpu->variant->codec & HANTRO_ENCODERS;
>   		ctx->buf_finish = hantro_enc_buf_finish;
> +		ctx->is_encoder = true;
>   	} else if (func->id == MEDIA_ENT_F_PROC_VIDEO_DECODER) {
>   		allowed_codecs = vpu->variant->codec & HANTRO_DECODERS;
> +		ctx->is_encoder = false;
>   	} else {
>   		ret = -ENODEV;
>   		goto err_ctx_free;
> 
