Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A83206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jkaecJKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbgF3Ofn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbgF3Ofm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:35:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=msmi1zI7qJmIO1xU9ZUIcrr2D+GhO7V+5RJpm/YLang=; b=jkaecJKRZofrkbCxWq9hxE9DRZ
        n3MUA5fvMNsvXDPWnDT4XugDA1B5p4HLY3LouFyiPGaCUN0BAtz2SUb3d4MnPH9fxi5Lx+I9g8H6C
        5lCJar8YRINo1qhn4AP6ID514IJZiMxnxroOn+5QuU7eQU0CM/oEAjPdgG6PH4nkRLb6mr8EKFtBi
        2IYQU4NRRBoJuEwSkOQV60JT7MfA1B2W6+2bjFPszRZ2KW9HvaLNyfwKEWp4Ta5rDazKuGiJss4wd
        IU+Gtdx+DwKKww4lLqzFR1OTgKFbxtH2LjS9iNiy9GBAhoS0AiZXOdBzg22v3M3guJ7Mbq0z9LuyT
        y654MGTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqHLl-0003Ky-FQ; Tue, 30 Jun 2020 14:35:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F0F6303CE9;
        Tue, 30 Jun 2020 16:35:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72BCE20CF397A; Tue, 30 Jun 2020 16:35:04 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:35:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
Message-ID: <20200630143504.GI117543@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <5b7286c9-ef4f-c1d0-fae3-ebb198aa0742@rasmusvillemoes.dk>
 <20200630140231.GW4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630140231.GW4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:02:31PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 03:55:05PM +0200, Rasmus Villemoes wrote:
> 
> > > Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.
> > 
> > Does that include gcc 4.8, or is it only "anything newer than 4.9"?
> 
> It includes 4.8 :-)
> 
> > so the section it was put in has an alignment of 64. The generated
> > assembly is indeed
> > 
> >         .globl  fair_sched_class
> >         .section        __fair_sched_class,"a",@progbits
> >         .align 64
> > 
> > /me goes brew coffee
> 
> Right.. so I now have the below patch, and with that I get:
> 
> 62931: c1e62c20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
> 65736: c1e62e40   128 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
> 71813: c1e62cc0   128 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
> 78689: c1e62c40   128 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
> 78953: c1e62ec0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
> 79090: c1e62d40   128 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
> 79431: c1e62dc0   128 OBJECT  GLOBAL DEFAULT    2 dl_sched_class
> 
> 
> Which has me stumped on __begin_sched_classes being on a 32byte edge
> (and crashes differently due to that).

OK, when I look at defconfig-build/arch/x86/kernel/vmlinux.lds I get:

. = ALIGN(32); *(__dummy_sched_class) __begin_sched_classes = .;

So I'm thinking the GCC_VERSION thing works for sched.h but not for
arch//x86/kernel/vmlinux.lds.S, lovely. Let me try and figure out why.
