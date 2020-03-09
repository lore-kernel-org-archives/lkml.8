Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BBC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BDC20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPBlxr6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgCINbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:31:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42984 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgCINbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:31:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so9112186qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6XoxJQMVL3p8wdS2Ew5v812zn19DVoEQr35exngzuA=;
        b=rPBlxr6Dpa68FX+LWFqy32K6Y9WRXzVWuTzTkkCTkKm7q/wctlCYUDJlg1Y52jklbk
         7cEmCb5pF4DU3qMZXmKdohW8RrZAxqqh5YcEgVAeK3b4JTQf0qLcrQvFtoKIXlI8UWiG
         MN/Bsg2hxAy4gfNlFV+wELZXYnHx8B7vGjhgaRTdA8okD4u6nDfWVTPf8VpT5JwlbJlS
         1uPKVUPjbQM6mSuWqFozdP/ptU+rIQS9nrasX8LQsBarXdhupnil71jxlG76d81bRhcv
         mNcetHft5M2ZN35ZvyUnqyVOnzxVeTWM2HNlz68JMxKvHl34xeuYgJjxoXbVIYgHdJRa
         37LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6XoxJQMVL3p8wdS2Ew5v812zn19DVoEQr35exngzuA=;
        b=CdgklLOlBsLGbIqq78NyQ+REgAmtzsC5JIuSDSicavR+x2DnV1gWnma3S3HRKF8rHI
         XREajJVnA5xiGOiSedDAUWKZnMrxqEhZzHFUVi/eO+RynazXaMFDTo76zmGu59W+IIzZ
         Yz/2QUaW2KrF3RxgDuJm4aJJ7Z0diaB36K+6cKo6GcretMjiHLb/loGX5Z4YF6rYDqJx
         ta50zBu+JN+yJstxXz6dFVQkwxEcVecpWPWVpF+mDRHrYjefeTxA07XT/NvdFFzdugjC
         6UzPO+NCXFSvAp5pe0onIYkrzprGBqoyv5cuKzNFovg66RsB943ukzn30w3nlMNwwikI
         12Ew==
X-Gm-Message-State: ANhLgQ2Ctt/HXcHKrljm8b/s4OwyWxzLOt7pBtLRqFYmeen3J6oVYum/
        eGnipzDwnWsRH+kP0lIaNY4=
X-Google-Smtp-Source: ADFU+vuhbcQL0w+/96VAmg9Hv0GGmOUwgOBtIq1EL0ACTbszfPyZQ8Ku7TLdEsA1JKIsHbOOpRnJXQ==
X-Received: by 2002:a37:8e45:: with SMTP id q66mr15221915qkd.129.1583760673926;
        Mon, 09 Mar 2020 06:31:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p16sm970542qkj.5.2020.03.09.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:31:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 598D940009; Mon,  9 Mar 2020 10:31:11 -0300 (-03)
Date:   Mon, 9 Mar 2020 10:31:11 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/1] perf/tool: fix read in event parsing
Message-ID: <20200309133111.GB477@kernel.org>
References: <20200307073121.203816-1-irogers@google.com>
 <20200307104501.GA311316@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307104501.GA311316@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 07, 2020 at 11:45:01AM +0100, Jiri Olsa escreveu:
> On Fri, Mar 06, 2020 at 11:31:21PM -0800, Ian Rogers wrote:
> > ADD_CONFIG_TERM accesses term->weak, however, in get_config_chgs this
> > value is accessed outside of the list_for_each_entry and references
> > invalid memory. Add an argument for ADD_CONFIG_TERM for weak and set it
> > to false in the get_config_chgs case.
> > This bug was cause by clang's address sanitizer and libfuzzer. It can be
> > reproduced with a command line of:
> >   perf stat -a -e i/bs,tsc,L2/o
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> nice catch
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo
