Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5688C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76AF206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Foj/fqXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgE1Mw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:52:57 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:44044 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389828AbgE1Mw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=2Dyep
        fzfBy/KOzfvHORsBmKYgJNqknyTEsRuBABT7qc=; b=Foj/fqXxXyDIVuGFEl7qi
        UlBxG5Za9tlCt3B/5YEQmywa9p9RNwgyUZ3sKhVgyOQct6Nm5A8MA45/q45nIOVV
        d2IetGiMAgSzc2tcmXfXYc6hGmD3t9slGCecKoMbJXhVFssB/29qGB0pvht5WzJ5
        o1NrqGhEWXp+XeJEda3KzE=
Received: from [172.20.10.2] (unknown [124.64.18.22])
        by smtp4 (Coremail) with SMTP id HNxpCgB3LyuIsM9ev5+aBA--.24S2;
        Thu, 28 May 2020 20:37:37 +0800 (CST)
Subject: Re: [PATCH] MIPS: Fix IRQ tracing when call handle_fpe() and
 handle_msa_fpe()
To:     tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, chenhc@lemote.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulichao@loongson.cn
References: <20200528123505.4219-1-yuanjunqing66@163.com>
From:   yuanjunqing <yuanjunqing66@163.com>
Message-ID: <57a8191b-1c64-9a5e-7935-050263d715fb@163.com>
Date:   Thu, 28 May 2020 20:37:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528123505.4219-1-yuanjunqing66@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: HNxpCgB3LyuIsM9ev5+aBA--.24S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4UAr18Cw1kWry5Aw1UZFb_yoWkJFc_Kr
        42kw4DKrn8Grn3ur17tay8X3s7tw4agrnayr1qvw1Yvr45Wrn0kFZ5K3Wvqwn3XrsakF4I
        y3W5JFnFkF1IyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe-Vy7UUUUU==
X-Originating-IP: [124.64.18.22]
X-CM-SenderInfo: h1xd0ypxqtx0rjwwqiywtou0bp/xtbBzxEyXFaD7WC+bwAAs5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry!

ÔÚ 2020/5/28 ÏÂÎç8:35, YuanJunQing Ð´µÀ:
>  Register "a1" is unsaved in this function,
>  when CONFIG_TRACE_IRQFLAGS is enabled,
>  the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
>  and this may change register "a1".
>  The changed register "a1" as argument will be send
>  to do_fpe() and do_msa_fpe().
>
> Signed-off-by: YuanJunQing <yuanjunqing66@163.com>
> ---
>  arch/mips/kernel/genex.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 8236fb291e3f..a1b966f3578e 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -476,20 +476,20 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	.endm
>  
>  	.macro	__build_clear_fpe
> +	CLI
> +	TRACE_IRQS_OFF
>  	.set	push
>  	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
>  	.set	mips1
>  	SET_HARDFLOAT
>  	cfc1	a1, fcr31
>  	.set	pop
> -	CLI
> -	TRACE_IRQS_OFF
>  	.endm
>  
>  	.macro	__build_clear_msa_fpe
> -	_cfcmsa	a1, MSA_CSR
>  	CLI
>  	TRACE_IRQS_OFF
> +	_cfcmsa	a1, MSA_CSR
>  	.endm
>  
>  	.macro	__build_clear_ade

