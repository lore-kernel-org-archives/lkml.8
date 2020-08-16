Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94449C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD89206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXynFtJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgHPAe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgHPAe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 20:34:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A92C061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 17:34:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so11507598wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLqvtYgcGOn0TREoT66Qf8Ql36bsQQaBwgcLMRV+GVo=;
        b=aXynFtJTfjGz9XtJPw20qpQm6WGTn+BF+UDxCoVJrYMdrZOpbnp6FPkADcYla04one
         dZ2GGqMrtRiC34H0D3G3Rcbnl5lROfTw+CRUysIOz2HVEgh5HoQEOn3cuCsPFykue/u1
         EpENALUjlQP2N0PH56sr6mrYRCvImgw/LkkflTifVv8z6JfT/LlhNq53PSTFNw34rbPY
         4xEuwyzn3i+752mR/CWEEqhkBtOBEhDQw9SqVJywE1jBw70mTr4xp4NCFHFQA0OoiY1l
         z5PSvB5upWqbodDTiJYTLNbiUtJOeiIoYd2Ekd/ePyLC0QLDuAiGZ9mgnWOuI2vJs+5i
         oS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLqvtYgcGOn0TREoT66Qf8Ql36bsQQaBwgcLMRV+GVo=;
        b=nGhfvXEY86dKAZ+C6QfVE0d5blZ2Lu3ZqCSUquIfPlrMjnfNADaufpyUyObeH3fwQl
         migCXQuAoYtaQoHQpjJRpoivyhxfmD7HJc2sIZJz4tC2SgA2vPL7viRPDm9Yvk6dleaU
         DcuwyktrjzP05seAIX7l3XM1rI+ex5Jrwx07FH4qMZoioQ+3V7WqJ5CLnl+6fQ2XwE3N
         hBHO9weOLuxGYargOZnenhuTE7P3qqWdZH5zagbwubUmbfEnOnIjEpl066EWPit2TMng
         wyJigeWyfzrZJ1P+w40Wh3T0ASoC/iCq9j+K5qcmxnKu4fjMk2rzUvVsXXM0FZCm/r/F
         zkZg==
X-Gm-Message-State: AOAM530xpNRT5TtKsS2f3MgKkCYBMCBUDvloMN0H54qW7z3wKCTQsSbV
        z0RHA58iGOPRvv8wcYjBTT57Q0jLN7jEBgRH
X-Google-Smtp-Source: ABdhPJyJ3iGK2LrD4/QVvzF71N43SNeN4A5JcT6XbzE47Y6SYtj7PBVn+9QdS95GbZkVKCCjHgcGkw==
X-Received: by 2002:adf:a19e:: with SMTP id u30mr8496065wru.274.1597538096406;
        Sat, 15 Aug 2020 17:34:56 -0700 (PDT)
Received: from [192.168.1.236] (231.red-79-151-187.dynamicip.rima-tde.net. [79.151.187.231])
        by smtp.gmail.com with ESMTPSA id s16sm13648013wme.13.2020.08.15.17.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 17:34:55 -0700 (PDT)
Subject: Re: [PATCH] Add missing bound checks for software 842 decompressor
To:     haren@us.ibm.com
Cc:     linux-kernel@vger.kernel.org
References: <20200605154416.5022-1-joanbrugueram@gmail.com>
From:   Joan Bruguera <joanbrugueram@gmail.com>
Message-ID: <6b69d99f-515f-b53c-b1c1-d525788779e3@gmail.com>
Date:   Sun, 16 Aug 2020 02:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200605154416.5022-1-joanbrugueram@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any feedback?

- Joan

On 05.06.20 17:44, Joan Bruguera wrote:
> The software 842 decompressor receives, through the initial value of the
> 'olen' parameter, the capacity of the buffer pointed to by 'out'. If this
> capacity is insufficient to decode the compressed bitstream, -ENOSPC
> should be returned.
> 
> However, the bounds checks are missing for index references (for those
> ops. where decomp_ops includes a I2, I4 or I8 subop.), and also for
> OP_SHORT_DATA. Due to this, sw842_decompress can write past the capacity
> of the 'out' buffer.
> 
> The case for index references can be triggered by compressing data that
> follows a 16-byte periodic pattern (excluding special cases which are
> better encoded by OP_ZEROS) and passing a 'olen' somewhat smaller than the
> original length.
> The case for OP_SHORT_DATA can be triggered by compressing an amount of
> data that is not a multiple of 8, and then a slightly smaller 'olen' that
> can't fit those last <8 bytes.
> 
> Following is a small test module to demonstrate the issue.
> 
> -
> 
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/sw842.h>
> 
> static unsigned char workspace[1000000] = { 0 }; // Hacky
> 
> static void test_bound(const char *name, unsigned ibound, unsigned dbound)
> {
> 	uint8_t in[ibound], out[ibound * 4], decomp[ibound /* Overallocated */];
> 	unsigned clen = ibound * 4, dlen = dbound, i;
> 	int ret;
> 
> 	for (i = 0; i < ibound; i ++)
> 		in[i] = i % 16; // 0, 1, 2, ..., 14, 15, 0, 1, 2, ...
> 	for (i = dbound; i < ibound; i++)
> 		decomp[i] = 0xFF; // Place guard bytes
> 
> 	ret = sw842_compress(in, ibound, out, &clen, workspace);
> 	BUG_ON(ret != 0);
> 
> 	ret = sw842_decompress(out, clen, decomp, &dlen);
> 	if (ret != -ENOSPC) {
> 		printk(KERN_ERR "%s: Expected ENOSPC to be returned\n", name);
> 	}
> 	for (i = dbound; i < ibound; i++) {
> 		if (decomp[i] != 0xFF) {
> 			printk(KERN_ERR "%s: Guard overwritten\n", name);
> 			break;
> 		}
> 	}
> }
> 
> int init_module(void)
> {
> 	test_bound("Index reference test", 256, 64);
> 	test_bound("Short data test", 12, 8);
> 	return -ECANCELED; // Do not leave this test module hanging around
> }
> 
> void cleanup_module(void)
> {
> }
> 
> MODULE_LICENSE("GPL");
> MODULE_SOFTDEP("pre: 842");
> 
> Signed-off-by: Joan Bruguera <joanbrugueram@gmail.com>
> ---
>   lib/842/842_decompress.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/lib/842/842_decompress.c b/lib/842/842_decompress.c
> index 582085ef8b4..c29fbfc9d08 100644
> --- a/lib/842/842_decompress.c
> +++ b/lib/842/842_decompress.c
> @@ -202,6 +202,9 @@ static int __do_index(struct sw842_param *p, u8 size, u8 bits, u64 fsize)
>   			 (unsigned long)total,
>   			 (unsigned long)beN_to_cpu(&p->ostart[offset], size));
>   
> +	if (size > p->olen)
> +		return -ENOSPC;
> +
>   	memcpy(p->out, &p->ostart[offset], size);
>   	p->out += size;
>   	p->olen -= size;
> @@ -345,6 +348,9 @@ int sw842_decompress(const u8 *in, unsigned int ilen,
>   			if (!bytes || bytes > SHORT_DATA_BITS_MAX)
>   				return -EINVAL;
>   
> +			if (bytes > p.olen)
> +				return -ENOSPC;
> +
>   			while (bytes-- > 0) {
>   				ret = next_bits(&p, &tmp, 8);
>   				if (ret)
> 
