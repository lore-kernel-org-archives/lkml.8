Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDFFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3E620737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8YSI/EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGCP5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgGCP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:57:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE4C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 08:57:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t74so18795080lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nJfTZsg6zGpN4LZZod8fa0dun7XM75S7cDWAFPDQlzE=;
        b=a8YSI/EHpQyrMqboBcug3Bi3PbNtG8hdkBOtonmFDp4/WYV51C1PhyeogwwCZXzQPv
         fCyNJn/rKxuxBw1gO8DoX1c1Hui8hifWeN59qkQcvQl+/mNEcW1bTOhZQsxa23bsGlVC
         cXdLXnsSRmQMuhgUxL9X9ct9jUmCEMDDpan0PjAWmSViLTMrx0YFVU5se+lxFN0M+wQ4
         JJlJvpmsOTnSQVm65C5nxQK/LE7Hdhq5+gz/4MStKuNKu7dsmRqW+7zBrdUN308AeN6L
         z7q7HNRNg/eIiZCCry8hx8kvN5wou4DlQPtFgUnmnBGaxU6GFM7BHacn+clwgHFb9MZB
         0Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nJfTZsg6zGpN4LZZod8fa0dun7XM75S7cDWAFPDQlzE=;
        b=S4hmXAU9J/MI3SQSM14JFA4diRLcE9J3n/C0I7TgJShPrps6pak5wGD4s1hs4ws2Qa
         X0VLGelmGWocH900Jz9QqqUgvBvXeo9zzQo216GMrDu9SSlEbrO7XXpQLzWpSHBjNMbq
         yxMvo2DI2KlJ6LMVvwhW/DiUyUXsHM3RhklWM08XZrwZL43XqwH+wudo+YPpoJPRzfAN
         9bH2K9LcBqCXdjiQ6gHFwC+MWCQuTWCiSnXDKaystKWF9ThcS/lAWDaRvqMwBBo8jS4Z
         frFdr1+HJDKU4fiGaaNnWxH49PoPfcKqMGZV01nUmK3kPWViL3zbdiMTTsC/LZxk2UrR
         6tsw==
X-Gm-Message-State: AOAM533UmGr2EgXGcZSUv1z1slXBgwXt8NOiVsOka+WPUDe1lcxKJZ8Y
        9RM5fuPb5i8i9u3cJqZf9YmK/opb03/aaA==
X-Google-Smtp-Source: ABdhPJz+VDfZjsli5UxFGTdOGf24yXTHZox6rW9tCpirhNrxUNQKHIiy+mmSmxF/RWSNOhzpLh4wSQ==
X-Received: by 2002:a19:8608:: with SMTP id i8mr9811691lfd.54.1593791871508;
        Fri, 03 Jul 2020 08:57:51 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q2sm4901973ljp.135.2020.07.03.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:57:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Jul 2020 17:57:49 +0200
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org, peterz@infradead.org
Subject: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703155749.GA6255@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folk.

I have a system based on AMD 3970x CPUs. It has 32 physical cores
and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:

<snip>
urezki@pc638:~$ sudo dmesg | grep 128
[    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
[    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:128 nr_node_ids:1
...
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128, Nodes=1
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=128.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
urezki@pc638:~$
<snip>

For example SLUB thinks that it deals with 128 CPUs in the system what is
wrong if i do not miss something. Since nr_cpu_ids is broken(?), thus the
"cpu_possible_mask" does not correspond to reality as well.

Any thoughts?

Thanks!

--
Vlad Rezki
