Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE40C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EE52076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B58UEQQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgD3NXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbgD3NXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:23:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC56C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:23:05 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 71so4836113qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=adQodhe8IpLisINRvWr4Jh5dPMBs2vc5JvfCsLBz4ng=;
        b=B58UEQQ8J1CXw8XEf9Ec6IMh/jCFduA9BxKZId1+QDKqS8IETNOmANJzc6rdKSVrKG
         TkN5MrXdhRqS1XbwzhyPfV0XMo849Vm7rsZK81VZ9TK+alobVzBN7sm1kE7Pbcd+BLOq
         wFdb3rgmXqbUOwNR0r3scDY0eqmGtwqPH2790q9g55ytnOSD8F1IsGwXKS4NaJEdCQIB
         NdNT/NlmvBq62MXCbM286w03bkzD92V3PuCZ42HwYwoIUW9iQzC1Y15NqPgc/caQWoJq
         HMAsVpVE2Y/dCscOTNneErXhcOOJByVKfrFpgOeUwbFIxoNORub91Gnr3zjIiTsC05Ab
         HNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=adQodhe8IpLisINRvWr4Jh5dPMBs2vc5JvfCsLBz4ng=;
        b=OH0t9Dh4f0c9IsrPo61iqn9fUMEr+dpGGaAEIiq2jzsgQdTMXelqqEOalzxHzZZDp0
         Wvm3h9GN9Rtt3V2BahCeRvZYTuDpMWL0kmrYHX2pm+5lSX1PNN/qUgOag4ayf5XFir6s
         bMv2keXCBLpPJlZjwFzpnzH699p/g7m/8jucKPeELWLKIk0RGFGDOq5AwNhtnS3klFea
         hG/CkEcUNQ+3nSIqgyyq8Xtyy2gi/Ao2E7joOqtFrJmcV7xtMShdlCf55PD9ksI2nGoL
         RSnwGGGByazRvRNJoq8sdfaRTQepbxTulfiYWA+h0GOZyRWNndSsbqQ0Xokt9w7jtcT3
         T6vw==
X-Gm-Message-State: AGi0Pua4GhLvYLgCv5HA2HjClW8lS0vgpe0ro0aNAJfsH7S0oBlJ0RIG
        ApCpRrPFN59Dwn/mcA6F4Y4=
X-Google-Smtp-Source: APiQypKrYMtcUAq4vJj+b8Yloxsqqz+Hx/gkUunkNsj0uNP0bCjbth8rPVfdnOQC43gjMYAuzPg5xw==
X-Received: by 2002:aed:2943:: with SMTP id s61mr3674041qtd.299.1588252984165;
        Thu, 30 Apr 2020 06:23:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s14sm2148497qts.70.2020.04.30.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:23:03 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D08D409A3; Thu, 30 Apr 2020 10:23:01 -0300 (-03)
Date:   Thu, 30 Apr 2020 10:23:00 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf mem2node: avoid double free related to realloc
Message-ID: <20200430132300.GI30487@kernel.org>
References: <20200320182347.87675-1-irogers@google.com>
 <20200430081541.GA1681583@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430081541.GA1681583@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 30, 2020 at 10:15:41AM +0200, Jiri Olsa escreveu:
> On Fri, Mar 20, 2020 at 11:23:47AM -0700, Ian Rogers wrote:
> > Realloc of size zero is a free not an error, avoid this causing a double
> > free. Caught by clang's address sanitizer:

> > ==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
> >     #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3

> > v2: add a WARN_ON_ONCE when the free condition arises.

> > Signed-off-by: Ian Rogers <irogers@google.com>

> I overlooked v2 for this, sry

> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied,

- Arnaldo
