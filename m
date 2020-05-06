Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E5C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E7620B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNylaCm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgEFQsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730373AbgEFQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63BBC061A0F;
        Wed,  6 May 2020 09:48:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c64so2655921qkf.12;
        Wed, 06 May 2020 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ki5PYNVnxYNMO8RvE31YbzUBiOILi49P+Z4Q/LDDP+g=;
        b=GNylaCm/51/1HEp+W9FPFDFmdhNS+pFB/oQpta+Ph8RYPmHs9a+pCUpnWNtFE32HP0
         MvSTP51ijYzV93w/hwQ+7U5itFlI2XAa6gERVoM4pt7/704gpctdLtP+B7Cwq/cdHmS6
         BkfKRamQX9Dc/zEt+SXeBKo253+hlJhPtWOzO6hgE+w9lMZAIFkaJ+Z9+nPkJWS122uJ
         3gBfeZTeo+FwjTDy+ltknJ0KQtaaWOND/SBiW2qNRERJDPIPG0KLCqdzqAcFL5rQKPh2
         +/ZSM1+0EW/Gq5jkRViXgpWN5m1VAySgEEWyR36JaXRWIHFyTv8mWuU3DmFlwtM15itN
         iLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ki5PYNVnxYNMO8RvE31YbzUBiOILi49P+Z4Q/LDDP+g=;
        b=Kx5E2XDFwEUIKIQbGB9ZHd+Me3V3RNXHpdMvpmkhCplhcTNo1dKyhFRtMnFXnL47sE
         9cFv4WkaLDU/b/aZrdqpIqITXF1KZTLGcCCM80LUVzsDscC0/pcUSaEQumPgd2cSPIor
         9ZsGsifhBOLzFUTfC/VMCDYeZ635gEOcQpkqKsO8POM3QhIOiLcaCm4/ICC+KTW+H0aH
         nO+Ri4Hnup02bXuq+xQCKkcflfakC4Mo4f+n2Uu8lZdKqdS0ObTp4WrzuQ/7u4BCiO/t
         ZJVHAri/MwC1tuOAdCToWI2L0icFbuXw5Tlh5r5BjFDYJYJHJeS1iN2moxGuzO6TpPEu
         15Mg==
X-Gm-Message-State: AGi0PuaqSqk64pz5ExvhiQT4kbzyiNNvtIwOH0DLSs5u0ZRCFik/vmlx
        GVdOByCtl6BCIY0mqV8kYwo/MTj6GZM=
X-Google-Smtp-Source: APiQypKZhQJ6D9965vdo6korqphb1u5w9wFjVvlwDC7O9vCy1bHyGWDSu+dbf+vuaaA/svIsPURMlg==
X-Received: by 2002:a37:5143:: with SMTP id f64mr9616177qkb.155.1588783693667;
        Wed, 06 May 2020 09:48:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t14sm1903422qtj.71.2020.05.06.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:48:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A22E8409A3; Wed,  6 May 2020 13:48:10 -0300 (-03)
Date:   Wed, 6 May 2020 13:48:10 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] perf-probe: Fix __init function and blacklist
 checking
Message-ID: <20200506164810.GB4323@kernel.org>
References: <158763965400.30755.14484569071233923742.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158763965400.30755.14484569071233923742.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 23, 2020 at 08:00:54PM +0900, Masami Hiramatsu escreveu:
> Hi,
> 
> Here is a series of fixes related to __init function and
> blacklist checking routines. Arnaldo noticed me some cases
> which don't check the __init function checking. I found that
> the blacklist checking is also not working with KASLR, and
> also skipped probes are shown in result list unexpectedly.

thanks, tested and applied.

- Arnaldo
 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       perf-probe: Fix to check blacklist address correctly
>       perf-probe: Check address correctness by map instead of _etext
>       perf-probe: Do not show the skipped events
> 
> 
>  tools/perf/builtin-probe.c    |    3 +++
>  tools/perf/util/probe-event.c |   46 +++++++++++++++++++++++++----------------
>  2 files changed, 31 insertions(+), 18 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 

- Arnaldo
