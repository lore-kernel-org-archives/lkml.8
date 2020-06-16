Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F418EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55BA20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9mKx0XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgFPE2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPE2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:28:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114CC05BD1E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 21:28:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s135so7977903pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YaFHme5I+vEiE9uZgkx1lHevUOVlBP99z4TPAG/B6Js=;
        b=n9mKx0XLblljfU1/2otAMQ6pOQK99gXRz18ZgUZanhinH4owiDvYtypcf6Sqq8gdZG
         Yb2CBv7G7K2Yb6rXbPVUvT3oyqsRA3u/c8QRqvJ/zi8KD0E0RBo4aBUCBPJVrq3dWApo
         j0tAWc8e3IDgc89c+TIzduQ0sDiDTd9muFhIdDU7HsJCvRhJhGGGEz4h6378+1ZpL+Es
         GxLDhhajfiVsOIZH15jDXXb767tbDzuQjAvSief8u3zUyPKP6XHCtCKkyf4iewHo9Odl
         Q9KvqSKO8336D8/ZgFsKI6z6gXxnfqM7P3IC/gngXLggYeSojKqsQNto+keFGVdQGGCF
         b5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YaFHme5I+vEiE9uZgkx1lHevUOVlBP99z4TPAG/B6Js=;
        b=tt9IM1QsNTI49RJmlKPYdvZ4h6k1WGF7BUNZdcbrT6/qFSSJWEZGSyFlRyDzlPvtd4
         qtJR5pIB5PGzwPONi+fXG3kLim+UAtLiGt3QBX3/TvQCog/NTYgxHYbubWPoQB1/u5th
         L8rrARZ10V9Nxtxk+8QMN/uKQDakbbIS6x7olzT0sLLYQXI4jyqq2XHNZWJx2TDOLWLY
         L/bCP+UzvNaLXZ1CWmXJNbtxq1ORwBLh99angF0EI5JzVbjZbHMg+amFMYK2sTBiYKKm
         jXq4LRUwphKxGnzUuughMoRi3yvxjysAkyBxOnUA4FxQYiBseFcwRWEPaqRLcJ7WUxm2
         2Jow==
X-Gm-Message-State: AOAM531CIp/IqUVsky6H+ZPngYQ9Z1wAtiEurDlhxK500bS2Ky9/quLk
        Bd4XvPKxSv6vtvtoigdbzGrBPg==
X-Google-Smtp-Source: ABdhPJxpnwaDV/9AKfcTr2LjEIIk4xAPjUH6jqsguih+3J5o67WPw9vRcApVwL9o95WNsa02ug5U5Q==
X-Received: by 2002:a62:7bcd:: with SMTP id w196mr433531pfc.73.1592281715522;
        Mon, 15 Jun 2020 21:28:35 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id q10sm16272276pfk.86.2020.06.15.21.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 21:28:34 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:58:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 1/2] cpufreq: Register governors at core_initcall
Message-ID: <20200616042831.3kazrpvvjhbahoaj@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615165554.228063-2-qperret@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-20, 17:55, Quentin Perret wrote:
> Currently, most CPUFreq governors are registered at core_initcall time
> when used as default, and module_init otherwise. In preparation for
> letting users specify the default governor on the kernel command line,
> change all of them to use core_initcall unconditionally, as is already
> the case for schedutil and performance. This will enable us to assume
> builtin governors have been registered before the builtin CPUFreq
> drivers probe.
> 
> And since all governors now have similar init/exit patterns, introduce
> two new macros cpufreq_governor_{init,exit}() to factorize the code.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
> Note: I couldn't boot-test the change to spudemand, by lack of hardware.
> But I can confirm cell_defconfig compiles just fine.
> ---
>  .../platforms/cell/cpufreq_spudemand.c        | 26 ++-----------------
>  drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
>  drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
>  drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
>  drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
>  drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
>  include/linux/cpufreq.h                       | 14 ++++++++++
>  kernel/sched/cpufreq_schedutil.c              |  6 +----
>  8 files changed, 36 insertions(+), 106 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
