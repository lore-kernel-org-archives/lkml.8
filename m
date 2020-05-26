Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A2A2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FFmP067Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbgEZURr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389684AbgEZURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:17:46 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B8C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:17:45 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z1so5202122qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TtkW2GUFnPpiz7qVt/cSaWSJ76KcZz2gc93YfJwXduw=;
        b=FFmP067Z/dKjzMX+2ihP1I79sITHHCno0zw2IhWiXoD204KcJrfB7eO12GKNOTfgp+
         yckSRnXHRTeVSY8D0IMyYeql1tShtI4P6SARzNqI3UKb/53c4NBaEy5PEwJk2Ki5q+8O
         ozzeqkdCvncVAZOlJHS76Ya/EXm7QZia4oAx9Jl95d3Bz0bzree3y/ZBpTsNZAelKSuB
         8BN01nvKpbjenAWnHm09bnxNfpOf2L74PYacN9fIiDKmtZwMmOqUnhO+7u1ycRtWgo0p
         nYnpN4xvgiPRqpxbzO3oTd6zVhXngTd4LkLJ4qxcsCxXjI/2L4cCmaUEc8Fx/dgVLnIg
         JD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtkW2GUFnPpiz7qVt/cSaWSJ76KcZz2gc93YfJwXduw=;
        b=cGwSYw54WX4sRyh7cSBKDOUUjuHrGfugWfGtVDRIHDcIz7t5LMIACBtMtCxG8wXM/s
         GOvfZG4Z95h7lSt7i9emAt6ktOh2EoRHZQCJnn+L8SJsNA9vDGuGB2a9Dg5txatWeDu7
         sJKxfInYuCWtmX6cw89tdgBeIm7EbLyt0N9YZcpoggAWQ0EUz3Vf0Yte+bMES11TYZWu
         rWPsFlosb25L4H13mmGHiGR6EA0JtNha/5yiel7oOWitSF1RoyEi5j7FdqtjD2dml+b9
         aFa0mILIX36ubIgTdNI4n/CoFCbSo1Em0CyMgT74f5P/7X8a1JwqnTNlDt9BCty6e7ga
         GLPg==
X-Gm-Message-State: AOAM530WJxvG/sN0CDgiQa/jbvDzRpFojTHpXjfd/Gct05bvOZuQqWbM
        vWty1QQDZtWE4THvF7cUy+VdOQ==
X-Google-Smtp-Source: ABdhPJwhsVDzO8DaQhS5idIFMXGII+ODR/JGDETK0D2aCahvEUMefu3bNJqlukDBy119VjTp68hR+g==
X-Received: by 2002:ac8:d87:: with SMTP id s7mr621968qti.210.1590524262863;
        Tue, 26 May 2020 13:17:42 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m126sm552618qke.99.2020.05.26.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:17:41 -0700 (PDT)
Date:   Tue, 26 May 2020 16:17:39 -0400
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Message-ID: <20200526201739.GG991@lca.pw>
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
 <20200526195630.GF325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195630.GF325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:56:30PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2020 at 02:58:50PM -0400, Qian Cai wrote:
> 
> > I still don't understand why reading all sysfs files on this system
> > could increase that much, but here is the lockdep file after
> > running sysfs read to see if you could spot anything obviously,
> > 
> > https://cailca.github.io/files/lockdep.txt
> 
> 00000000f011a2a5 OPS:      20 FD:   45 BD:    1 .+.+: kn->active#834
> 
> is that somewhere near the number of CPUs you have?

834? No.

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              128
On-line CPU(s) list: 0-127
Thread(s) per core:  2
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        8
Vendor ID:           AuthenticAMD
CPU family:          23
Model:               1
Model name:          AMD EPYC 7601 32-Core Processor
Stepping:            2
CPU MHz:             2932.801
CPU max MHz:         2200.0000
CPU min MHz:         1200.0000
BogoMIPS:            4391.87
Virtualization:      AMD-V
L1d cache:           32K
L1i cache:           64K
L2 cache:            512K
L3 cache:            8192K
NUMA node0 CPU(s):   0-7,64-71
NUMA node1 CPU(s):   8-15,72-79
NUMA node2 CPU(s):   16-23,80-87
NUMA node3 CPU(s):   24-31,88-95
NUMA node4 CPU(s):   32-39,96-103
NUMA node5 CPU(s):   40-47,104-111
NUMA node6 CPU(s):   48-55,112-119
NUMA node7 CPU(s):   56-63,120-127

> 
> Anyway, there's very long "kn->active#..." chains in there, which seems
> to suggest some annotation is all sorts of buggered.
