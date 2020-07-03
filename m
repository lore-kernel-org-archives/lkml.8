Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FAA20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TENBVCQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGCRiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:38:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE88C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7zBZdw0QR2xfUPWBNQtxUbIiIrWFdv5YEeUMRjjrapc=; b=TENBVCQQRI54fD+psbQeLLNlsh
        GhgVFcg5FbiTISM7Xuog1ddJVpIgCYZbmcFPXbNnKE6iVANKMtXytuHbz4560E342/HYbuNgH4QfR
        7Rq4VRIqRQ8aJN6i0MlwodA56iTubtD0SozAOwXTsYeAfzuEtbUJLWjS639gFxdj3/hdi1+C4vctb
        mPNOTim5jElQLayTQQOu/sIkX8sXGiGvA5tV2sIOMW6nBrcVcM/dUNdujb9wqiKMG1Gozp6geHA3h
        X0xllgFuf2Vg59KbEVScSQJZSEgMGyIZRQUcXOaGSbn5qWDac48iCisp99iBDZ+X96xv8NIxx9rfP
        l5SMbJqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrPdf-0001Nq-Ej; Fri, 03 Jul 2020 17:38:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40EEA304BAE;
        Fri,  3 Jul 2020 19:38:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EA862217205D; Fri,  3 Jul 2020 19:38:14 +0200 (CEST)
Date:   Fri, 3 Jul 2020 19:38:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703173814.GZ4800@hirez.programming.kicks-ass.net>
References: <20200703155749.GA6255@pc636>
 <20200703165627.GG4781@hirez.programming.kicks-ass.net>
 <20200703170941.GA4372@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703170941.GA4372@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 07:09:41PM +0200, Uladzislau Rezki wrote:
> On Fri, Jul 03, 2020 at 06:56:27PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 03, 2020 at 05:57:49PM +0200, Uladzislau Rezki wrote:
> > > Hello, folk.
> > > 
> > > I have a system based on AMD 3970x CPUs. It has 32 physical cores
> > > and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> > > set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
> > > 
> > > <snip>
> > > urezki@pc638:~$ sudo dmesg | grep 128
> > > [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> > > [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> > 
> > This is your BIOS saying it needs 128 ids, 64 of which are 'empty'.
> > 
> > I have a box like that as well, if it bothers you boot with:
> > "possible_cpus=64" or something.
> >
> OK, i got it. I thought that "cpu_possible_mask" strictly follows
> the rule: the number of CPUs in a system that physically are present.

Nah, it's based on ACPI (SRAT IIRC) tables. The case of
over-provisioning is useful for systems that support physical hotplug,
but I've seen boards without that capability do it too.

Just chalk it up to the foibles of BIOS.
