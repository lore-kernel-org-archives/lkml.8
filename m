Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10919C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5A2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng57rUj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgDUP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgDUP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:59:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86744C061A10;
        Tue, 21 Apr 2020 08:59:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j4so14981545qkc.11;
        Tue, 21 Apr 2020 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2LEPhwH4RpFN5v0e1kCmLkv3DzSN/+rHxkSDgf5nqLw=;
        b=Ng57rUj1VZE7/HCPDAIa5xhqfMdqGUuCXcW6j800BSNrl86b53MK2rH2vy0Z615Ta3
         RVL10KalY/a97OIa/1geTiRpfnLg57YwERVdFp8gsKfQ78G9HUClg+OU9pm3IEwps8S0
         OabqcNU3BdMwll6pQ2FFZLuKjAv4srai6LjiSqx8vZjNMdbfjLxR3qnKontYFAm+oOfQ
         DEoeeBQR99kpIcnUOwEOki3hZmnShN57OH8yblbINcLB5xkt9szKHbo0cy0wxHzVC/UO
         ks3RSJOHHBWxojKhEUrucN9W/vBWb9mDsKHYwQmidV22GM6s2nsU0PKJUBKqqgs1VmNW
         /J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2LEPhwH4RpFN5v0e1kCmLkv3DzSN/+rHxkSDgf5nqLw=;
        b=drfIhmXJKMTXrbiw8/ZtKuvfXg/JXIs2pNelLQSwe7QkerQ/INDeCmP904ciKOHJOw
         qFC+6fLJmTNIP9itnC3vJczFeLl+tC0k5YDID4UJ30osum1mAfixkDmcd+LEgS2FYGWS
         fwcT+XDw8I5xy0R+p1h5Kiz6JJVWgdhu8iNZbSjOc2e649hfjkiOqTxg371IcVmRYPAr
         /B8wjscCGs8Jdg6K7qBkP+MMCB5xlytWNZphxKPe6Mbws9esVEOXLD0iSTC/6vu2hRir
         zEeSoZZmITO/66MshAmFF6LGDheTU2qtrYyJtbOXTH4FmmgiwhORH351hCRYnhCOlfKI
         N8xA==
X-Gm-Message-State: AGi0PuZXAwFPAe5EGRr5TUBT0e+QgYE70dY4HlbsSEvNtrtXttMWf5st
        TYDqrjtFYG/YWcI5RdxRJMSJLfVJiI8=
X-Google-Smtp-Source: APiQypI7qF6GjgRP0edDXyvLh6CXuaqvcdd7B7e+Z+bDFQpVc9NbLrA8ouNCC42mHoF8YSpphfKs2Q==
X-Received: by 2002:a05:620a:252:: with SMTP id q18mr22487211qkn.184.1587484788691;
        Tue, 21 Apr 2020 08:59:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i5sm1977969qki.42.2020.04.21.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:59:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35697409A3; Tue, 21 Apr 2020 12:59:46 -0300 (-03)
Date:   Tue, 21 Apr 2020 12:59:46 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: kernel/perf: Sample data being lost
Message-ID: <20200421155946.GB12295@kernel.org>
References: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 21, 2020 at 05:54:29PM +0200, Thomas Richter escreveu:
> Since a couple of days I see this warning popping up very often:
> 
> [root@m35lp76 perf]# ./perf record --call-graph dwarf -e rb0000 -- find /
> [ perf record: Woken up 282 times to write data ]
> Warning:
> Processed 16999 events and lost 382 chunks!
> 
> Check IO/CPU overload!
> 
> [ perf record: Captured and wrote 125.730 MB perf.data (16219 samples) ]
> [root@m35lp76 perf]#
> 
> The machine is idle, its my development system, so not much going on.
> It also happens using a software event, for example cycles. It shows
> up more often, the larger the sample size is. So for example:
> 
> [root@m35lp76 perf]# pwd
> /root/linux/tools/perf
> [root@m35lp76 perf]#  ./perf record  --call-graph dwarf -- find
> [ perf record: Woken up 2 times to write data ]
> Warning:
> Processed 231 events and lost 7 chunks!
> 
> Check IO/CPU overload!
> 
> [ perf record: Captured and wrote 1.000 MB perf.data (130 samples) ]
> [root@m35lp76 perf]#
> 
> I have very seldom observed this before, only in extremely rare cases with
> a heavily loaded machine. I am wondering what has changed, I haven't
> changed anything in the s390 PMU device drivers.
> It could be
>  - common kernel code when writing into the ringbuffer.
>  - the perf tool too slow to read data from the mapped buffer.
>    However I have not come across changes in this area.
> 
> Has anybody observed similar issue?
> 
> PS: I have added some printk messages into my PMU devices drivers.
> I have seen messages that the 16384 pages for auxilary buffers are full
> and that samples have been dropped.

Can you try to bisect tools/perf?

Something like:

git checkout v5.4

build it, no problems? Use it as the 'git bisect good' starting point.

- Arnaldo
