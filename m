Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C52C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D80D20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/tsxhNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCZOeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:34:00 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37902 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:33:59 -0400
Received: by mail-qk1-f180.google.com with SMTP id h14so6607673qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDJcCICWbBvg13CmIRICUUgkZIihePfG6AfLGVtczXE=;
        b=V/tsxhNlgL1zE+ydPp6RYZSukW4QFUAyXDiouNnu1aT33E7W36MZpVDIAcVBiqNIGb
         kkxRCjrgowoDk3T0PwhGJ6qWxYFO/Vn2sY41C4iyl31Saq9d4xMp1lt2UeA0M+cYDfU0
         2Cob6N0r7EvNUltd2OvftrjsrV+YH048FkYxaO/TEH9QSZO3Gswy5SEuuPMoyrZoNhiR
         WwPF7HXzPcqxNZj3SN94kR2B1jingXnfPhAcGRsvhuxP8j/05UBLWHi6tuciSmQ6jKhg
         sq83Ctr2Xs04WDBEgkMksEFwNkJkZR5ICUP2AAGIQlUv4Xycj2dTkE1bq5e9sROwYdGc
         KzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDJcCICWbBvg13CmIRICUUgkZIihePfG6AfLGVtczXE=;
        b=a3Qms6pE8KIA5y0K6H9Ogf5Hik7irILQHTJ1ZWbDQvRmEeyJfFOs46BC5Xm9gnDRVA
         s1wquh+xbsfYBlvs7hPEMi0AipyBuzDLEsutU4p+Gy5J1CYzzBEVPF7dCHqiu/NsNDws
         n/5xINUyG3mio/RnuueN4jbC0VF0c9NVnUIWZJQTHA6tgvLQ56+nvolNT3a1STGXBWsm
         mP2706pIqdqWpZA042hbVD92PR2FklEq7dO6aWepcKkpPHRfp/04IZPLMmOjYm75emga
         639JnHB7a6dmrOUINsvqeqULGA7mTG7aunIXsG93g7rc0NHDJw9Z3IQE2Renx6zORoj2
         rgcQ==
X-Gm-Message-State: ANhLgQ1IwAxW5TVZywxUQPVMzDlu8amMzUHP8Tmutxxy7MdkNbLA9oAC
        bmctfXs9jDzueycktg/HFOY=
X-Google-Smtp-Source: ADFU+vuuspsU7l4L6IeTqyaXySgVBnIXRxjK4Wmy7I7wbgJu9/aSgAgbD+KAisRxWWWnXd6bud4UXA==
X-Received: by 2002:ae9:eb0b:: with SMTP id b11mr8213333qkg.75.1585233238542;
        Thu, 26 Mar 2020 07:33:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x89sm1672947qtd.43.2020.03.26.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:33:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62CD840061; Thu, 26 Mar 2020 11:33:55 -0300 (-03)
Date:   Thu, 26 Mar 2020 11:33:55 -0300
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf script: introduce deltatime option
Message-ID: <20200326143355.GB6411@kernel.org>
References: <20200204173709.489161-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204173709.489161-1-hagen@jauu.net>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 04, 2020 at 06:37:09PM +0100, Hagen Paul Pfeifer escreveu:
> For some kind of analysis a deltatime output is more human friendly and reduce
> the cognitive load for further analysis.
> 
> The following output demonstrate the new option "deltatime": calculate
> the time difference in relation to the previous event.
> 
> $ perf script --deltatime
> test  2525 [001]     0.000000:            sdt_libev:ev_add: (5635e72a5ebd)
> test  2525 [001]     0.000091:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
> test  2525 [001]     1.000051: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
> test  2525 [001]     0.000685:            sdt_libev:ev_add: (5635e72a5ebd)
> test  2525 [001]     0.000048:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
> test  2525 [001]     1.000104: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
> test  2525 [001]     0.003895:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
> test  2525 [001]     0.996034: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
> test  2525 [001]     0.000058:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
> test  2525 [001]     1.000004: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
> test  2525 [001]     0.000064:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
> test  2525 [001]     0.999934: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
> test  2525 [001]     0.000056:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
> test  2525 [001]     0.999930: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1

You forgot to update the man page, I did it, tested and applied, thanks.

- Arnaldo

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index db6a36aac47e..4af255bb0977 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -390,6 +390,9 @@ include::itrace.txt[]
 --reltime::
 	Print time stamps relative to trace start.
 
+--deltatime::
+	Print time stamps relative to previous event.
+
 --per-event-dump::
 	Create per event files with a "perf.data.EVENT.dump" name instead of
         printing to stdout, useful, for instance, for generating flamegraphs.
