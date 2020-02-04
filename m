Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC688C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818DC21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTPsSAqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDHwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:52:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgBDHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:52:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so2289898wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lOYMh4ZhFB/j3+zJg7N4Iqbe6PxmPoLtgLZQuu/oXrc=;
        b=JTPsSAqZCvsbqWvceDNFHimTKwOV7v+qU7U2dCf5OhVRW/p2PtmdAud287oe9pjm91
         R0GuKY6onA6OxhyT1Zj0dwos92Ac7Uzt6GqII4Xc/b66bsVb17Tou5Isp23r4ZhHFMAv
         esx24OP7PeWzpDa6VDGmUhKDZ7eLT8ksnf7ArRtPDhOoSd7/JPhszIm/F2M+PKJXI4XX
         k/R7QD5u4LFaJmc0CbSL8jgnEDoEWOqfrnrxCYXeOZMHFT0lj1Q4rRaMhvDQgeBiPmxx
         b/2if9WTQbqY8vOktWsyMwgaDUOSLxpoVrOJ0PLSJleb+8WsXmIcga8b1S8OjARvm1ft
         z+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lOYMh4ZhFB/j3+zJg7N4Iqbe6PxmPoLtgLZQuu/oXrc=;
        b=jZve/623EZkvNKm6dopYs3JvDcAMkhnrWjRyhn8nItZevDpffYITdtucOXntPTErgF
         ZpEr7pJRGnS7aucM/PBp+clGh3kytpNEOhEQ87KNGmPy28msB9iW09b83O8WjJTEvDcx
         5tuFumXPXUQ1ejnTB9ph/tJq53IZS8HWENq1RIaqdDu9M2LlnQk20QBj9fhb9m/U0hdK
         KmCrnzANpxKbMhgPLszRytIdPJblcc9tPtxcoVodbGIKdaVROs4Eq+Y6PMszXvRVj8++
         99ODc35yGc5NbqLsnDbAcnAxyccUEWLLwOK4ddmCs4ttUQfq9SDu3tZOMldVeXB4MJxZ
         WUnw==
X-Gm-Message-State: APjAAAXAzJTWN1jPzN6YjV2HrPu5WmgU5xPd0zlBIVTJkpI+ZCBdlNwz
        qqLjJK6J4CMSydx7ylz5R1k23Q==
X-Google-Smtp-Source: APXvYqy4q3+wJrHNyrD5aG9J9+nmuyD2NhC/9/Q+mwXUTXmDmK7nDDUIWsYYWCk1ahVKiRCOzMHyuw==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr3979105wml.44.1580802769349;
        Mon, 03 Feb 2020 23:52:49 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id m9sm10246919wrx.55.2020.02.03.23.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 23:52:48 -0800 (PST)
Date:   Tue, 4 Feb 2020 07:53:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <20200204075304.GE15069@dell>
References: <20200204140300.7537283c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200204140300.7537283c@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Feb 2020, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the mfd tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> ld: sound/soc/codecs/wcd934x.o:(.toc+0x0): undefined reference to `of_clk_src_simple_get'
> ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
> wcd934x.c:(.text.wcd934x_codec_probe+0x3d4): undefined reference to `.__clk_get_name'
> ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438): undefined reference to `.clk_hw_register'
> ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474): undefined reference to `.of_clk_add_provider'

What's the cause of this?  I thought PowerPC made use of the CCF?

> Caused by commit
> 
>   6ac7e4d7ad70 ("mfd: wcd934x: Add support to wcd9340/wcd9341 codec")

Looks to me like the Codec is broken, rather than the MFD driver.

> Unfortunately that commit is now in Linus' tree (and was never in
> linux-next).
> 
> I marked CONFIG_MFD_STMFX as BROKEN for now.

Surely that should be SND_SOC_WCD934X?

Srini,

  What do you plan to do about this?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
