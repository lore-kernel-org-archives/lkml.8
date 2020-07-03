Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F000C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C494208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTezh7T9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGCT04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgGCT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:26:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E23C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:26:55 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so19077802lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TFEfiy66+qRWsLsntclApDgr6Ih073UgX0yhLBJbpPE=;
        b=DTezh7T9i7T1nJ9vxpuTWQ5Yw6f3b3R4iTKe2K6vZSF8fB7h/2T/6XyxWyoMfLNzYO
         enRFytmWltC1st1TdHBORE6GfESIFbeCeEsGE1/qDoMkox9GFe+ow5K4yznFWqDHAB0j
         p6GHV2uOUX+EmJgOC8vXj8z6gayEglapPbbFm/MnBCshl6mj0v1jz8D+AVLgD1B3FhfP
         RkKBHf0qs3b2l8ovtCb7HuixNn1GbD/J9ysMWvI3wanqVxA0LU5Rhg2wjo8ZKRRHLhyB
         tN0lOtmlR31lb6bsqtNCMBvqIP4O5K94ThMmKA9ioSj8/oD78kYtLNypTOMxYCLkaJID
         Uq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFEfiy66+qRWsLsntclApDgr6Ih073UgX0yhLBJbpPE=;
        b=iYX3yoCQmrwIDE0r77Y3tIU4qw9UYURvOD44xP/n1mFQwrMM02HXe2xbml1prYGWiC
         4pA4cPaE+udpCsRSdmMaa1XEmF+Oc1DOO88Fg3UTICxpSI2326xA2lBylOj1WRBIM7f/
         vovZeG/6CvH9MkiCZSCmHwghzkPlrxemuZJsLT9oNU4YFII5otlnoN+l3C4lZ6xsoawy
         DDlq2e+gqzufytlWw+BgJt3G/mEsBH6YilhsKY1lU8vSCcJ0s+FhAdKlVF9A+X6+jGg0
         r3OeRcrFRbGeE1u4EbYpfRkSsKSknpnkNzSeAcSMLnvI+d/OZR8klnNr71/gq6s/of5q
         hxgQ==
X-Gm-Message-State: AOAM5305tDGZlORq2IlfEGgaJIvZVYUNZg4ICbkF92+tyc4BgfDG1Gn6
        G4n1zPPlIox6BTt5k0wZF/Q=
X-Google-Smtp-Source: ABdhPJxZiKFIICmpLaQFVTOj7TfuIfYukFzNM377zLlXwPShBXpQXy70R20rrZ0fLXxyhNYckk4JsA==
X-Received: by 2002:a19:4247:: with SMTP id p68mr22908812lfa.22.1593804414237;
        Fri, 03 Jul 2020 12:26:54 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d6sm4418606lja.77.2020.07.03.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 12:26:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Jul 2020 21:26:51 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703192651.GA5207@pc636>
References: <20200703155749.GA6255@pc636>
 <20200703165627.GG4781@hirez.programming.kicks-ass.net>
 <20200703170941.GA4372@pc636>
 <20200703173814.GZ4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703173814.GZ4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 07:38:14PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2020 at 07:09:41PM +0200, Uladzislau Rezki wrote:
> > On Fri, Jul 03, 2020 at 06:56:27PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 03, 2020 at 05:57:49PM +0200, Uladzislau Rezki wrote:
> > > > Hello, folk.
> > > > 
> > > > I have a system based on AMD 3970x CPUs. It has 32 physical cores
> > > > and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> > > > set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
> > > > 
> > > > <snip>
> > > > urezki@pc638:~$ sudo dmesg | grep 128
> > > > [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> > > > [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> > > 
> > > This is your BIOS saying it needs 128 ids, 64 of which are 'empty'.
> > > 
> > > I have a box like that as well, if it bothers you boot with:
> > > "possible_cpus=64" or something.
> > >
> > OK, i got it. I thought that "cpu_possible_mask" strictly follows
> > the rule: the number of CPUs in a system that physically are present.
> 
> Nah, it's based on ACPI (SRAT IIRC) tables. The case of
> over-provisioning is useful for systems that support physical hotplug,
> but I've seen boards without that capability do it too.
> 
> Just chalk it up to the foibles of BIOS.
>
Yes, i see that such information is propagated by the BIOS to
the kernel, at least for x86 systems. Thad sad if i have single
socket system then we do not have any physical hotplug ability,
thus there is no need in over-provisioning.

Agree that it can be hard to fix, since all that depends on ACPI
interface. Like you stated in another mail. 

--
Vlad Rezki
