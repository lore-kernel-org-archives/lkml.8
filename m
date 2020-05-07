Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C954CC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9726C206B9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWjU8nee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEGUj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEGUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:39:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D915C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:39:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so8349952wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXskb/U1rfTLrQamxPnaslHrIBvE9Q8wGx7sKVUquCs=;
        b=nWjU8neek1jkTd5k46MxzmPKEdK4LUWxb02CTjbKs+/rbvNriAUC1jj2lL11+w2Yig
         wavUdNEH6nKd7Wc/eesp8xTT2jYFRNY28imtWPswr8UjcMEXyJgSk8V8lM13A713W8yu
         LZuZ3mgoXZhZ24+nCPVgq+4hrkimkyBUF/P8bdozbd4BTI3nhZz6+Hadr40dna21NJqE
         o5cFi99J3JTJvKld3101AY6tH6Gw+xBuW7NiHZojjMXuTenzIboycox3/yJg2PwKE3cl
         cztmTZElbSEJAsEZx6OMDvAy1vtRiN1GC+NzVsYQ0nUVjhSFAvysNDTuDIxxT1i1JA0x
         stkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXskb/U1rfTLrQamxPnaslHrIBvE9Q8wGx7sKVUquCs=;
        b=nhvtm6/VKiSVPj3PTKiTACJaks09ey/NZVPIFji9tm5hS7TNJeuVeMzA1e63hBhsnl
         YAV/zvTFrPfdfmt7qA2dmMtS0+QW3cSTtKGUQNDabNeyCZftwiQ6A/G58vSnLfpxA1u2
         eCLKuTR/nDeHEI+nJHyDJlpnzQEGV+SmvJSDblwqXXWYxWgNfbX1/EJbY4moWYQulhWw
         7OyoJzSjTlRmGwY0VsyHyWp4dJvq9GO203r9DVVWuLkGC+RkjCwEDiuhWl8MZDBeYvV/
         afjWS+guk2sC4JTHZCbpp7tOvryw8VVGhX1N6viBlCN4ZCd1PdcpNS3Br+dwRfcWp3Ju
         zCnQ==
X-Gm-Message-State: AGi0PuZFxtqFBp4cm9ppOT+hddmc8T6GJNkxYBOIjYG7kc7AG9pXG6vP
        hIvoz7u7M9vAMoyXfSX4MUJc4d8C8VzwMQ==
X-Google-Smtp-Source: APiQypIe8aYj0LpthnAy1cmC+N58Li+3DTCxZohNo6wbhStE61FVn/fczz7X4dwdYQOkO0vNsEddrw==
X-Received: by 2002:a7b:ca53:: with SMTP id m19mr3868667wml.182.1588883993935;
        Thu, 07 May 2020 13:39:53 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-166.ip.btc-net.bg. [212.5.158.166])
        by smtp.googlemail.com with ESMTPSA id d1sm9214133wrx.65.2020.05.07.13.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 13:39:53 -0700 (PDT)
Subject: Re: [PATCH] media: venus: Replace zero-length array with
 flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200507190750.GA15755@embeddedor>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <a249b3b7-56dc-8bed-f079-2cf163b46712@linaro.org>
Date:   Thu, 7 May 2020 23:39:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507190750.GA15755@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Two patches from you are already queued in media_tree for v5.8.

0f61e171e4bbac4595175070c75707f1b12f4e37 media: venus: hfi_msgs.h:
Replace zero-length array with flexible-array member

380f3bbd9562dc93be2e3cadc329b15284fbedae media: venus: hfi_cmds.h:
Replace zero-length array with flexible-array member


On 5/7/20 10:07 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.h |    2 +-
>  drivers/media/platform/qcom/venus/hfi_msgs.h |   10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> index cae9d5d61c0c..83705e237f1c 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> @@ -107,7 +107,7 @@ struct hfi_session_abort_pkt {
>  struct hfi_session_set_property_pkt {
>  	struct hfi_session_hdr_pkt shdr;
>  	u32 num_properties;
> -	u32 data[0];
> +	u32 data[];
>  };
>  
>  struct hfi_session_set_buffers_pkt {
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.h b/drivers/media/platform/qcom/venus/hfi_msgs.h
> index 7694b1d25d9d..526d9f5b487b 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.h
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.h
> @@ -155,7 +155,7 @@ struct hfi_msg_session_empty_buffer_done_pkt {
>  	u32 input_tag;
>  	u32 packet_buffer;
>  	u32 extradata_buffer;
> -	u32 data[0];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_fbd_compressed_pkt {
> @@ -175,7 +175,7 @@ struct hfi_msg_session_fbd_compressed_pkt {
>  	u32 picture_type;
>  	u32 packet_buffer;
>  	u32 extradata_buffer;
> -	u32 data[0];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_fbd_uncompressed_plane0_pkt {
> @@ -202,7 +202,7 @@ struct hfi_msg_session_fbd_uncompressed_plane0_pkt {
>  	u32 picture_type;
>  	u32 packet_buffer;
>  	u32 extradata_buffer;
> -	u32 data[0];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_fbd_uncompressed_plane1_pkt {
> @@ -211,7 +211,7 @@ struct hfi_msg_session_fbd_uncompressed_plane1_pkt {
>  	u32 filled_len;
>  	u32 offset;
>  	u32 packet_buffer2;
> -	u32 data[0];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_fbd_uncompressed_plane2_pkt {
> @@ -220,7 +220,7 @@ struct hfi_msg_session_fbd_uncompressed_plane2_pkt {
>  	u32 filled_len;
>  	u32 offset;
>  	u32 packet_buffer3;
> -	u32 data[0];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_parse_sequence_header_done_pkt {
> 

-- 
regards,
Stan
