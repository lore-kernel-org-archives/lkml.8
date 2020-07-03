Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B068B20760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEMP61SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGCRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgGCRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:09:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7ADC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:09:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so24551577ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oeo5CXQ+MIvI9X/KqYCM4k7p1aIl5c+gDkE9upkp9MI=;
        b=mEMP61SIuM9rZ2VcziXZ8sjhv97O3D7uYgQPh2Um702rlJHdKNixH5LCCtCg7ma1SK
         Oe3zPfpvFhu+Cv5ZqvWjOFV1uDqzLNg+ExJq9hU+m79YCWUBEO64+s/hZbtTAGAay2oy
         2PGSxpKM2IxdqnGoKcoavB3H6rZ32aXaoy7w5/+ySMDQtaBV5sgGj/4gGfzGBNkF0v5+
         bRmWBs95NGoUhvstuU11hyiken5HwroxhW/l/LpNc6YF8VVKFwOhXitXHD0w6xj6XPGg
         yUOOP27qkxFgSt0TZzbuvc5QvfVS492+FwDJEy/+qPGacBpDJU+wBLco5cAe3glwyJbb
         tYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeo5CXQ+MIvI9X/KqYCM4k7p1aIl5c+gDkE9upkp9MI=;
        b=pAxqEI/FUGCasfa2aXpOGfb3HPwbe8UJdnWH5SECC1KzZtP1qQYaDXgWTUH9XLC6Wf
         +dBeY1D/TBp4bKgKO8/3rAbtbdem0uZP/ehgli6Js1zWQh+tv6eo0SQdALca8SiLhvoJ
         NSh/lntUahDmFpc01RydWMHjbxhcIOjlcxPwB4fmk3rHTc5eaymrKkQ53WXAs8llEU56
         6gZYl0SGPp+lWe7ekW/E846jTbo576Ijsk2HYFp47jAj74PM94QwlkezRpkzgF0h4uA4
         jqseikhOvxF/ycXBT6bg7t+UorvFrlnIMUMT5h7JUBQu7AJGGWQ6OFHrp3eG3q03NS2+
         WZ4w==
X-Gm-Message-State: AOAM530eZIkUrg87le7ES8+ookAfRO9lKjV7L9j3C8bkJMxgpBTfrcG2
        3btWcB6sKgSqoFiAa0G5lYo=
X-Google-Smtp-Source: ABdhPJyXTQqlj63BdRU2H9md2eokHCqmuSThuy9TKjGvOrn+N7DeTicfXle4wTxt2PfQ0sRv7GPMeg==
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr15444314ljp.47.1593796185996;
        Fri, 03 Jul 2020 10:09:45 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a22sm4842885lfg.96.2020.07.03.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:09:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Jul 2020 19:09:41 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703170941.GA4372@pc636>
References: <20200703155749.GA6255@pc636>
 <20200703165627.GG4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703165627.GG4781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 06:56:27PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2020 at 05:57:49PM +0200, Uladzislau Rezki wrote:
> > Hello, folk.
> > 
> > I have a system based on AMD 3970x CPUs. It has 32 physical cores
> > and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> > set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
> > 
> > <snip>
> > urezki@pc638:~$ sudo dmesg | grep 128
> > [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> > [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> 
> This is your BIOS saying it needs 128 ids, 64 of which are 'empty'.
> 
> I have a box like that as well, if it bothers you boot with:
> "possible_cpus=64" or something.
>
OK, i got it. I thought that "cpu_possible_mask" strictly follows
the rule: the number of CPUs in a system that physically are present.

Thanks, Peter!

--
Vlad Rezki
