Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29455C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EDE21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taDS1MdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD2SQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2SQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:16:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7EFC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:16:13 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id q2so1648229qvd.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SrKffdmRFhPcH6LCFxQx/iVtcHHEcAQRHsgsM3r8tto=;
        b=taDS1MdI/S2Lrz3gWwl6a9PUHqvrnGgtXW2XlMxGUrtUE0sYUs2YdGuSYuHkJQHmOG
         nEsgwWqlv3gF3m5YzcqE4f5yXYZoAxn9D3+3SPF1wBbLjM4wgPzMfuLvnzJuaird8y/1
         EfdVaejY9WHjidxpUyM9Pk7hgRPQwZk1B9gUEzOGJH1wj0XnFvNPvCBfbLFIf+chFe0s
         bGMxx+BT2tOvUr87tofRxNktqioWipSB1mToa0U5lcj6O9ugO93B17vp4Tw/gmnrSFlX
         mAyb6XsKqkkRX7uw6c4V+/XxHliUKYqfYcp1areKxQTi3qucgpwr0edKai3uNAOxtV2b
         FfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrKffdmRFhPcH6LCFxQx/iVtcHHEcAQRHsgsM3r8tto=;
        b=MR2k1+63i1jzABy3CKNIv3foVNFdvaV5Qg92aX0gjcJK9alMhkf2lhPAXQYzDRFHP4
         yBlk28XdQbEHnbEz07nBhajMb737Lge4d0aszfaFCIsVe2gbPigOXBUKNy5lmiStoXsr
         g7IIPGSi/72NeIsVnfv7GhB0XeTGwSalejjRwZC9IgNcuo4ysXh4X4kHapPCV5qr64FJ
         c3a+uYwezKFqq3kyD2obdGNxM9FmIN9WgOHaA4PAUhDudkt/wVa6VFK+4DMWHicSxALd
         K6r67niav9Aye2Wi+pg1BSsutn835mAGlFosmdrzmVFXz3OW3Mac9MDTiSt1DQsv5jom
         XRsQ==
X-Gm-Message-State: AGi0PuZhfjuBz1UUWCQymebKRRTV/HnYRkzB6DvWLLlciMOsUALGK8uR
        dg13F/QR/S+kJPLSoPXV03g=
X-Google-Smtp-Source: APiQypK5X6r2DdBhSd2Zp/gAzUENHIhyUTNcSx13QfmPzwpXcjRWZJ6Z+e1YiHOvEA1E7NdxGIfhNg==
X-Received: by 2002:a0c:9a4f:: with SMTP id q15mr31289064qvd.132.1588184172377;
        Wed, 29 Apr 2020 11:16:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q57sm16992677qtj.55.2020.04.29.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:16:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD197409A3; Wed, 29 Apr 2020 15:16:09 -0300 (-03)
Date:   Wed, 29 Apr 2020 15:16:09 -0300
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH v2 3/3] perf tool: simplify checking active smt
Message-ID: <20200429181609.GG30487@kernel.org>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
 <158817741394.748034.9273604089138009552.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158817741394.748034.9273604089138009552.stgit@buzz>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 07:23:41PM +0300, Konstantin Khlebnikov escreveu:
> SMT now could be disabled via "/sys/devices/system/cpu/smt/control".
> Status shown in "/sys/devices/system/cpu/smt/active" simply as "0" / "1".
> 
> If this knob isn't here then fallback to checking topology as before.

I've manually applied this one, thanks, please check my perf/core branch
later before resending 2/3, thanks.

- Arnaldo
 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  tools/perf/util/smt.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index dc37b5abd1c3..c398528d1006 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -19,6 +19,9 @@ int smt_on(void)
>  	if (cached)
>  		return cached_result;
>  
> +	if (sysfs__read_int("devices/system/cpu/smt/active", &active) > 0)
> +		goto done;
> +
>  	ncpu = sysconf(_SC_NPROCESSORS_CONF);
>  	for (cpu = 0; cpu < ncpu; cpu++) {
>  		char fn[256];
> @@ -37,6 +40,7 @@ int smt_on(void)
>  	active = str && (strchr(str, ',') != NULL || strchr(str, '-') != NULL);
>  	free(str);
>  
> +done:
>  	if (!cached) {
>  		cached_result = active;
>  		cached = true;
> 

-- 

- Arnaldo
