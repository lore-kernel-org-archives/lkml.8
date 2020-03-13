Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B743520749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qq5X8eF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCMMPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:15:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39775 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:15:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id r15so11811539wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dkkOhNptW/+i6AyGAlAqxzIg7MAf9JOSQV9ZjZ8SZb0=;
        b=Qq5X8eF/pk2ONqTki4DzQ/QaR74gyCIuVgJhjAdSm6LRfjQvqIKFfJjp+MmGiCEmCF
         kCy+Kuh0WTq08v4WtL0QX7xPj9ZjHmYTA8dLuQDDfXdnqS18w7rJL57weHJ0D/QslzQY
         dCve5He1CXK81mR2k9/edV7/sGQdRz2XFxFY4c4VUq8LCAbAzNI1avYRfAGtLMc/p+MS
         nvGB4B/1r6i9leJd0cs9Oupl2a7bRuJRxBpC89Yv+mYXIHuU18Fljb1pYZ3pLZKlnUV4
         SLu8j8JzkMeHZMnZLTY+p7xGBwK0SSY7U6L0kBDbPc816Dv3+bLt6cEwXu6mdoEXtSzK
         7lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dkkOhNptW/+i6AyGAlAqxzIg7MAf9JOSQV9ZjZ8SZb0=;
        b=D9D80fnfErrtpNlozKmYfizhuuXzE0sup6bCtDMuWsPAulymsybBWBXmsuYGBVx2kV
         hUbX/soQ2E74u7G/FMR63eWv1oxjka14B4t7DuL8yOQh2elNunMKT6ONabHJ+sUqEV/2
         2o0Z9JCXx9f4Z3DmH1vJ+4LtmIFuBYW6NsHB0CgYf+/R2gPn/74NalFWg8ByZohAqu9i
         wOLpaky6VhsvnQRnFum2Byir8DIiMHjT+9zq7ynVcZLUXv77aYXISRtJiS4OzS7G3Em6
         mRJYxK9+YyFfw5ZVPOGoMkrQSw9qnisiPmqP1GUVLXr4YaeCYvKuXiYyB4SAOu7tiTgJ
         XpWQ==
X-Gm-Message-State: ANhLgQ0ZWcWcKc5Zor+RsY/ZCfnjEeak0II7WQjTnHD4vaf6P9qNCzBu
        gRxc6caYLpd6xDNPlAQRg6DySgbEAis=
X-Google-Smtp-Source: ADFU+vs9izdgrrewhtkxUU5LKPkaJ65rMQLgmOmqDgkmbdhOP1bk6wyZiC5daEz2RNyitsQZf1Ladw==
X-Received: by 2002:adf:f289:: with SMTP id k9mr11052126wro.220.1584101730877;
        Fri, 13 Mar 2020 05:15:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t1sm33778054wrq.36.2020.03.13.05.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:15:30 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 7/9] ASoC: qcom: q6asm: add support for alac and
 ape configs
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200313101627.1561365-1-vkoul@kernel.org>
 <20200313101627.1561365-8-vkoul@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a4002e22-81c8-e1bf-50dc-03fe6a55a6b1@linaro.org>
Date:   Fri, 13 Mar 2020 12:15:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200313101627.1561365-8-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/2020 10:16, Vinod Koul wrote:
> Qualcomm DSPs expect ALAC and APE configs to be send for decoders,
> so add the API to program the respective config to the DSP.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 118 +++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6asm.h |  32 ++++++++++
>   2 files changed, 150 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 4cec95c657ba..0e0e8f7a460a 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -48,6 +48,8 @@
>   #define ASM_STREAM_CMD_OPEN_READ_V3                 0x00010DB4
>   #define ASM_DATA_EVENT_READ_DONE_V2 0x00010D9A
>   #define ASM_STREAM_CMD_OPEN_READWRITE_V2        0x00010D8D
> +#define ASM_MEDIA_FMT_ALAC			0x00012f31
> +#define ASM_MEDIA_FMT_APE			0x00012f32
>   
>   
>   #define ASM_LEGACY_STREAM_SESSION	0
> @@ -133,6 +135,36 @@ struct asm_wmaprov10_fmt_blk_v2 {
>   	u32          advanced_enc_options2;
>   } __packed;
>   
> +struct asm_alac_fmt_blk_v2 {
> +	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
> +	u32 frame_length;
> +	u8 compatible_version;
> +	u8 bit_depth;
> +	u8 pb;
> +	u8 mb;
> +	u8 kb;
> +	u8 num_channels;
> +	u16 max_run;
> +	u32 max_frame_bytes;
> +	u32 avg_bit_rate;
> +	u32 sample_rate;
> +	u32 channel_layout_tag;
> +} __packed;
> +
> +struct asm_ape_fmt_blk_v2 {
> +	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
> +	u16 compatible_version;
> +	u16 compression_level;
> +	u32 format_flags;
> +	u32 blocks_per_frame;
> +	u32 final_frame_blocks;
> +	u32 total_frames;
> +	u16 bits_per_sample;
> +	u16 num_channels;
> +	u32 sample_rate;
> +	u32 seek_table_present;
> +} __packed;
> +
>   struct asm_stream_cmd_set_encdec_param {
>   	u32                  param_id;
>   	u32                  param_size;
> @@ -941,6 +973,12 @@ int q6asm_open_write(struct audio_client *ac, uint32_t format,
>   			goto err;
>   		}
>   		break;
> +	case SND_AUDIOCODEC_ALAC:
> +		open->dec_fmt_id = ASM_MEDIA_FMT_ALAC;
> +		break;
> +	case SND_AUDIOCODEC_APE:
> +		open->dec_fmt_id = ASM_MEDIA_FMT_APE;
> +		break;
>   	default:
>   		dev_err(ac->dev, "Invalid format 0x%x\n", format);
>   		rc = -EINVAL;
> @@ -1198,6 +1236,86 @@ int q6asm_stream_media_format_block_wma_v10(struct audio_client *ac,
>   }
>   EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_wma_v10);
>   
> +int q6asm_stream_media_format_block_alac(struct audio_client *ac,
> +					 struct q6asm_alac_cfg *cfg)
> +{
> +	struct asm_alac_fmt_blk_v2 *fmt;
> +	struct apr_pkt *pkt;
> +	void *p;
> +	int rc, pkt_size;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	fmt = p + APR_HDR_SIZE;
> +
> +	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
> +
> +	pkt->hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
> +	fmt->fmt_blk.fmt_blk_size = sizeof(*fmt) - sizeof(fmt->fmt_blk);
> +
> +	fmt->frame_length = cfg->frame_length;
> +	fmt->compatible_version = cfg->compatible_version;
> +	fmt->bit_depth =  cfg->bit_depth;
> +	fmt->num_channels = cfg->num_channels;
> +	fmt->max_run = cfg->max_run;
> +	fmt->max_frame_bytes = cfg->max_frame_bytes;
> +	fmt->avg_bit_rate = cfg->avg_bit_rate;
> +	fmt->sample_rate = cfg->sample_rate;
> +	fmt->channel_layout_tag = cfg->channel_layout_tag;
> +	fmt->pb = cfg->pb;
> +	fmt->mb = cfg->mb;
> +	fmt->kb = cfg->kb;
> +
> +	rc = q6asm_ac_send_cmd_sync(ac, pkt);
> +	kfree(pkt);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_alac);
> +
> +int q6asm_stream_media_format_block_ape(struct audio_client *ac,
> +					struct q6asm_ape_cfg *cfg)
> +{
> +	struct asm_ape_fmt_blk_v2 *fmt;
> +	struct apr_pkt *pkt;
> +	void *p;
> +	int rc, pkt_size;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	fmt = p + APR_HDR_SIZE;
> +
> +	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
> +
> +	pkt->hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
> +	fmt->fmt_blk.fmt_blk_size = sizeof(*fmt) - sizeof(fmt->fmt_blk);
> +
> +	fmt->compatible_version = cfg->compatible_version;
> +	fmt->compression_level = cfg->compression_level;
> +	fmt->format_flags = cfg->format_flags;
> +	fmt->blocks_per_frame = cfg->blocks_per_frame;
> +	fmt->final_frame_blocks = cfg->final_frame_blocks;
> +	fmt->total_frames = cfg->total_frames;
> +	fmt->bits_per_sample = cfg->bits_per_sample;
> +	fmt->num_channels = cfg->num_channels;
> +	fmt->sample_rate = cfg->sample_rate;
> +	fmt->seek_table_present = cfg->seek_table_present;
> +
> +	rc = q6asm_ac_send_cmd_sync(ac, pkt);
> +	kfree(pkt);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_ape);
> +
>   /**
>    * q6asm_enc_cfg_blk_pcm_format_support() - setup pcm configuration for capture
>    *
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> index 5d9fbc75688c..38a207d6cd95 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.h
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -58,6 +58,34 @@ struct q6asm_wma_cfg {
>   	u32 adv_enc_options2;
>   };
>   
> +struct q6asm_alac_cfg {
> +	u32 frame_length;
> +	u8 compatible_version;
> +	u8 bit_depth;
> +	u8 pb;
> +	u8 mb;
> +	u8 kb;
> +	u8 num_channels;
> +	u16 max_run;
> +	u32 max_frame_bytes;
> +	u32 avg_bit_rate;
> +	u32 sample_rate;
> +	u32 channel_layout_tag;
> +};
> +
> +struct q6asm_ape_cfg {
> +	u16 compatible_version;
> +	u16 compression_level;
> +	u32 format_flags;
> +	u32 blocks_per_frame;
> +	u32 final_frame_blocks;
> +	u32 total_frames;
> +	u16 bits_per_sample;
> +	u16 num_channels;
> +	u32 sample_rate;
> +	u32 seek_table_present;
> +};
> +
>   typedef void (*q6asm_cb) (uint32_t opcode, uint32_t token,
>   			  void *payload, void *priv);
>   struct audio_client;
> @@ -86,6 +114,10 @@ int q6asm_stream_media_format_block_wma_v9(struct audio_client *ac,
>   					   struct q6asm_wma_cfg *cfg);
>   int q6asm_stream_media_format_block_wma_v10(struct audio_client *ac,
>   					    struct q6asm_wma_cfg *cfg);
> +int q6asm_stream_media_format_block_alac(struct audio_client *ac,
> +					 struct q6asm_alac_cfg *cfg);
> +int q6asm_stream_media_format_block_ape(struct audio_client *ac,
> +					struct q6asm_ape_cfg *cfg);
>   int q6asm_run(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
>   	      uint32_t lsw_ts);
>   int q6asm_run_nowait(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
> 
