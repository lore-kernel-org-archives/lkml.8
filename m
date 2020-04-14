Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBAC2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483062072A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCvhU4O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbgDNBwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728247AbgDNBwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:52:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B651C0A3BDC;
        Mon, 13 Apr 2020 18:52:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so4091563plz.5;
        Mon, 13 Apr 2020 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ueS8P+6v2FrlXivoVjNe19uVCUfAZxgQePy2A4X+RsE=;
        b=OCvhU4O/qcMY2FRjZ40rJkFvcFiCnnlXdwpTxot5wBOLYRNgpnFCHbxz852a6MeIj4
         NPa5mtPY5kIIvICQIRdv37OLe4jCCFm8PShYINo9ATeH1KlDDfWsZ63+QG4jZNNEo+JT
         ZyYXrSwFwjTBYt3Q7xqkXtfvZ6bICTCH9ANVE52aI2sjgtoMB7gTeo1rGz6wLMQK2Pi3
         HPAAtEEsaclya5CZ9i66SK7RRcTQNe54wG7Z76wzS/QaxaFwFWDD4Am8L5ZsOUjDswix
         rdZ6h8419sEHgMfFI4g0w+/ucUvgIoU75+jPx9MwFrekVFL1Z78EFnshuf0yOivCZApK
         7YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ueS8P+6v2FrlXivoVjNe19uVCUfAZxgQePy2A4X+RsE=;
        b=oYJ9/86/cGpKHRd5PMcypSYg3JiPZT3h5vaJnJp0SKcMS/lshHPUDzF7GCvftWNY2x
         on5F6x0lPNkN5qT9GvilnbrdPoLiSXTv74cmzq7a61kYiImqo9b+W7J6xAq0Fze9GLYO
         S03i5LmbrAfR5QKc9crAnyOuBCjpron99HW0GQrhUBDGMfF5kZzOMV8IF7X3IoytTFRW
         kNtvdFPVqlHsGpu4cJ3QVrHIDctqzX83FwgmrWJ/DTVnrmI2JF5cn7VH8ZLr6HVlrmX8
         blSC0Mil2T4U8yDN3znlU6D0LBEUYu5klHZN96iU8zTlmPyLfwt9XQEGM0ZvIfyys/ui
         S9Jg==
X-Gm-Message-State: AGi0PuaRre0n+vUXz+DN4f2B8AQYa96q1mRNTRjwXJzLB/YOJuWeyhzJ
        nnztbYi/GALtzPVAvCHW/N3qa4uCZRw=
X-Google-Smtp-Source: APiQypLV5A3zPqygKILoFJrzU50eijbeEVBpOWKiwDq2bSqyS0pUFarFX0qGCERIK8ocAccEOj2a5A==
X-Received: by 2002:a17:90a:252f:: with SMTP id j44mr16076039pje.9.1586829149030;
        Mon, 13 Apr 2020 18:52:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x12sm2242431pfq.209.2020.04.13.18.52.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 18:52:28 -0700 (PDT)
Date:   Mon, 13 Apr 2020 18:52:37 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] ASoC: fsl_asrc: Support new property
 fsl,asrc-format
Message-ID: <20200414015235.GA10195@Asurada-Nvidia.nvidia.com>
References: <cover.1586747728.git.shengjiu.wang@nxp.com>
 <d10df72d2e9985fede7969b5da1f579627f5e821.1586747728.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10df72d2e9985fede7969b5da1f579627f5e821.1586747728.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:43:06AM +0800, Shengjiu Wang wrote:
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
