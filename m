Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D3C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B41D20789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWylZYFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCSSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:25:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33298 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgCSSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:25:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so2744413qtn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WQMFFPCO+74at5PzP7m8E1nRfExAwjm337OA4xAJ/bY=;
        b=NWylZYFzdbn1ZahTJRiXI8F/+RskWbaiYKrsw4+Z6vMy85fsYMBze3612um+4A88Qd
         kFB5FJJVfwPJXqVVA30/VyCGz6EQe0y8FO+/UoI+VWJqpTVa/bd3cS7ho68DoFk4yWD0
         P97o7vvHo/E8Pgh8PgZf1VP2mUHYaEaDx9TMqLrRV+gjYdFj8ib5xZhyrr0FCtrAlkzd
         E3a881fxwsk/pOxXFoXvo3I4xJWN+igtMy8bVerBCsdDnJlpCDJNP7el9v5QelNb62Zi
         DOqSIYlrELqe2T/LelnulfGaFupYf41vnm9u/Lm7Jq62JkNwrxUp1EdEHAE+AVXOJ3lx
         7XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQMFFPCO+74at5PzP7m8E1nRfExAwjm337OA4xAJ/bY=;
        b=YsnsgV6LusHbSfUeMZBEBRRSzZ9gmTT5GGf83BX1OU4f5GMeX5o1xNrvAtHxrucjdx
         JXnOoaOfj//KfzkVlPE/uS63vhT2IYvK4k3p8HPEcRXAA4MxRJ53smppy0xVdF88t3ab
         h/JWNGoa9fanO1AGKiE8T3GVmzDiZNPzApIUObDuVAp6X5vcS7xYCAGNIufH8LdWuqnj
         qamtwl5RDi3uoyi403yGVlXkMi2AcAvwYF7EWC40Th/UGNcS4RdNCz5YYGHxAqpUBHCH
         lTl3olZaOh5K2D3iHqIKSaBsPgzmhSlbp/IzhzBhHhe6BjwMEKoTXi3XRu824PIoMafu
         xmSg==
X-Gm-Message-State: ANhLgQ3qFsSI+EtNZTQfMTt6hCvnTCvAbAODt/fVz3DynIEz5yLA1M9+
        HkApLuBVNAQ4wm3pgvGsx/A=
X-Google-Smtp-Source: ADFU+vuLAFcupFhQ+85OqGe1ZhDiziy6x6dVYwOYqKTQIT+PO9y89kL7f8ZWr9H9xL9R1Efb3lbNuA==
X-Received: by 2002:aed:2591:: with SMTP id x17mr4396600qtc.380.1584642317278;
        Thu, 19 Mar 2020 11:25:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 73sm2125706qkf.82.2020.03.19.11.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 11:25:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F57E404E4; Thu, 19 Mar 2020 15:25:14 -0300 (-03)
Date:   Thu, 19 Mar 2020 15:25:14 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Unify a bit the build directory output
Message-ID: <20200319182514.GC14841@kernel.org>
References: <20200318204522.1200981-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318204522.1200981-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 09:45:22PM +0100, Jiri Olsa escreveu:
> Removing the extra 'SUBDIR' line from clean and doc build
> output. Because it's annoying.. ;-)
> 
> Before:
>   $ make clean
>   ...
>   SUBDIR   Documentation
>   CLEAN    Documentation
> 
> After:
>   $ make clean
>   ...
>   CLEAN    Documentation

Thanks, applied to perf/core.

- Arnaldo
