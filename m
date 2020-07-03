Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CD62100A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtiiMTj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGCRYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGCRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:24:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CBC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:24:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t25so33239591lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0m/WnflXUtqMe2LlYe5Q/lJZbxP3+0PbCBQFE408oM=;
        b=UtiiMTj20+O4Gm8B4qFya+91EHiKSOIFYa1Bn6p0LEGsHLXSz2WTgv86sY6RHY6MpJ
         HgV0YHuiTDfEYqvVRTyq6rTn+V78jFQHQwS75DpYZ6QK6+aaGy0XZmYFTtLgKAxK9Qy0
         O/0CHtw96yhCQn7fuYzuThoavDcn65jAg/RAR5eyxZXGyj5lXG6Tjk+5v8rqYIWxLDYn
         rjEv2IbEZ99IFicttcZQ2UG6mrfrYjgxYBiy1rq1R8GzfDNfmSFhsRWF0fPf6tTaLXVi
         9nuKWjMC2vuXtRnJZlIGA1kJ9waXe43bVBcnbAyNWDaVKh2lGMvPGfegIQEhaBqyUcVO
         OXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0m/WnflXUtqMe2LlYe5Q/lJZbxP3+0PbCBQFE408oM=;
        b=ZUTjhuicabFjb4NaQIi69cwygXzDaZwbCKggFxGES1tVTYF8v6kr1Hr+4Ak8SApi5X
         YlNRwBdNLEZFXIOdVMaG9kM7PXFoznT0gLNGejPIpI8wjrTjMoCjKn2uNE35V5/QyaGu
         t2cepm7a3kubxviiY/nKpHRJE91amfyPioWjydomB06sNi3dRYSmje6KJqWX1nB4Nf9H
         n026z4fO6KYw6VUwL+akzLyHg+csomDMfE8xuj7PWEVbIyaksWbJcN3Ce4yBLgjuBFyy
         +QkSkwC5zW/G14Gh1zv6W8+3oEb5w2Mbg7koNKsZ6/pskW8lp6YBenJeRNsox0tikHlX
         LejQ==
X-Gm-Message-State: AOAM532OgjwjmPxhy5rRGjKgFDSVaiVU5XlXZ8zAMAmO1BatvI1y1dfT
        t4uJn/cPOtAoYi8i22fiE+wCtOH23zRiOg==
X-Google-Smtp-Source: ABdhPJyWXeQlDf8x2WW9gu+kNwpc0tMMA9+cBa+Mp8VX3gBuxeRcCJKAQPfv3GJM9A+kGC0J1tVgEA==
X-Received: by 2002:a2e:3111:: with SMTP id x17mr18889387ljx.33.1593797062759;
        Fri, 03 Jul 2020 10:24:22 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w19sm1586315ljh.106.2020.07.03.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:24:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Jul 2020 19:24:18 +0200
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703172418.GA4500@pc636>
References: <20200703155749.GA6255@pc636>
 <CAEJqkgiFFh8CvXkM4ZzXxNQmOJLL7WcgDL6rM83safNgEewZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgiFFh8CvXkM4ZzXxNQmOJLL7WcgDL6rM83safNgEewZ9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I have a system based on AMD 3970x CPUs. It has 32 physical cores
> > and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> > set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
> >
> > <snip>
> > urezki@pc638:~$ sudo dmesg | grep 128
> > [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> > [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> > [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:128 nr_node_ids:1
> > ...
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128, Nodes=1
> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=128.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
> > urezki@pc638:~$
> > <snip>
> >
> > For example SLUB thinks that it deals with 128 CPUs in the system what is
> > wrong if i do not miss something. Since nr_cpu_ids is broken(?), thus the
> > "cpu_possible_mask" does not correspond to reality as well.
> >
> > Any thoughts?
> 
> This is not a 5.8-rc3 problem. Almost all AMD CPUs and APUs are
> looking like this.
> The only CPUs I own are getting that right is a dual EPYC box,
> everything else is broken
> regarding the right C/T & socket(s) count, and that probably bc is
> using NUAM code
> to have the info.
> 
> I reported that a while back and no-one ever cared.
> 
> There is even a comment in the hotplug code saying setting the wrong CPU count
> is a waste of resources.
> 
> I have a 2200G is reporting 48Cores.
> 
> AMD Ryzen 7 3750H reporting twice the cores and twice the socket.
> 
> ...
> 
> [    0.040578] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
> ...
> [    0.382122] smpboot: Max logical packages: 2
> ..
> 
> I boot all the boxes restricting the cores to the correct count on the
> command line.
> 
> Wasted resource or not, this is still a bug IMO.
> 
I suspect that DEFINE_PER_CPU variables can be twice as big,
but i have not checked it actually. So, if the code needs to
identify real number of CPUs it can be a challenge :)

Thanks.

--
Vlad Rezki
