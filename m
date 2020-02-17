Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB27C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E377820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzw4zFZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgBQOpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:45:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42344 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgBQOpK (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:45:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id o28so15039868qkj.9
        for <Linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1a2rFESe9BExPsXQ+vpaPrXom2FA2rInGr0xzkq/euE=;
        b=Fzw4zFZCw3Y9FB9HITc56OqUzjzS50GaNzc5O6sFOwBdXqb1ifNAsi3sI6VTtu1JRU
         8SXcS31sTe+irMbppIV0FBB8CVLEBs8nCPwZKiEQxc3IIVslNNRKwfusPMc3p3xxmEgV
         6+AMWBDoz84Rufs9JXAqjMeTcKBBYB7cLbsY5+nA4J/YbpsokfFFSC3tweB+9tOg+SrK
         mM/BzCbBgvID0VNmjBsm9A0xHXyXDzEZBIJU5/uI122wCXg0L5wN4Ke3f47vFscJEknT
         iqUEIVe1SvSnT+gi4NBnKF4xPQZOx5tfa1pqvh0pr0fppevDUdHBC/mn0fxMOVpexo8P
         G50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1a2rFESe9BExPsXQ+vpaPrXom2FA2rInGr0xzkq/euE=;
        b=uYSJXZNeYjC2HJaImMUKj5ThToaoUFsm/FAdBk+ZgFvXsLGf3/8ydkOPelr4naMq2u
         uGCsos1zfTK/PzKxcxlw72nnpBWouXaEtlbF6WNHEJuMqxHu6SyUILLY8jqYlIji4FUY
         sX6K5CMxGvr3cMr7P0FtHWlTLc0wko0kfR2XG9v4oO9afYtERYoc0wV03xN65CT1JPDi
         g1afFaNmeO28daE2JPA/1VTeaIhHUu03npKxxpu32PBiA4qbQZaJIvlrm3lT4XfNb5F8
         dNhlfzWYnC51/cDeLzUhi2BmH9fXlUhka7UWWjGAAooP68akYneYXKcdVeJfeQ1zNP46
         RQsA==
X-Gm-Message-State: APjAAAX/kllXF+LkFV5XBFz/1PlrnhCrrUWcnMHthBs3tG2l2u7EqBzr
        6gsyfTxfXXl0PG3Oqz6qB8JmFMiqkJY=
X-Google-Smtp-Source: APXvYqwvdjIDM07Jgv2o5WgYbrB0hgYB9SPRi0xm3ObvMAy7Hx38Baza9JqagK88BuGdl5w+amMFKw==
X-Received: by 2002:a37:a786:: with SMTP id q128mr13370278qke.448.1581950708107;
        Mon, 17 Feb 2020 06:45:08 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d206sm312281qke.66.2020.02.17.06.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:45:07 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BF94403AD; Mon, 17 Feb 2020 11:45:05 -0300 (-03)
Date:   Mon, 17 Feb 2020 11:45:05 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf stat: Show percore counts in per CPU output
Message-ID: <20200217144505.GC19953@kernel.org>
References: <20200214080452.26402-1-yao.jin@linux.intel.com>
 <20200216225407.GB157041@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216225407.GB157041@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 16, 2020 at 11:54:07PM +0100, Jiri Olsa escreveu:
> On Fri, Feb 14, 2020 at 04:04:52PM +0800, Jin Yao wrote:
> 
> SNIP
> 
> >  CPU1               1,009,312      cpu/event=cpu-cycles,percore/
> >  CPU2               2,784,072      cpu/event=cpu-cycles,percore/
> >  CPU3               2,427,922      cpu/event=cpu-cycles,percore/
> >  CPU4               2,752,148      cpu/event=cpu-cycles,percore/
> >  CPU6               2,784,072      cpu/event=cpu-cycles,percore/
> >  CPU7               2,427,922      cpu/event=cpu-cycles,percore/
> > 
> >         1.001416041 seconds time elapsed
> > 
> >  v4:
> >  ---
> >  Ravi Bangoria reports an issue in v3. Once we offline a CPU,
> >  the output is not correct. The issue is we should use the cpu
> >  idx in print_percore_thread rather than using the cpu value.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied to perf/core

- Arnaldo
 
> btw, there's slight misalignment in -I output, but not due
> to your change, it's there for some time now, and probably
> in other agregation  outputs as well:
> 
> 
>   $ sudo ./perf stat -e cpu/event=cpu-cycles/ -a -A  -I 1000
>   #           time CPU                    counts unit events
>        1.000224464 CPU0               7,251,151      cpu/event=cpu-cycles/                                       
>        1.000224464 CPU1              21,614,946      cpu/event=cpu-cycles/                                       
>        1.000224464 CPU2              30,812,097      cpu/event=cpu-cycles/                                       
> 
> should be (extra space after CPUX):
> 
>        1.000224464 CPU2               30,812,097      cpu/event=cpu-cycles/                                       
> 
> I'll put it on my TODO, but if you're welcome to check on it ;-)
> 
> thanks,
> jirka
> 

-- 

- Arnaldo
