Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01FE21548
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbgE1MGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389059AbgE1MG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:06:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB29C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:06:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeHIg-0006Uf-J5; Thu, 28 May 2020 14:06:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 09E65100D01; Thu, 28 May 2020 14:06:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC problems with Acer TravelMate 5735Z
In-Reply-To: <20200524185800.GV325280@hirez.programming.kicks-ass.net>
References: <a8c0c572-6dba-8d35-69bd-5e7b19bf6aba@molgen.mpg.de> <20200524185800.GV325280@hirez.programming.kicks-ass.net>
Date:   Thu, 28 May 2020 14:06:17 +0200
Message-ID: <874ks0p8li.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Sun, May 24, 2020 at 07:09:18PM +0200, Paul Menzel wrote:
>> Dear Linux folks,
>> 
>> 
>> I got my hands on an old Acer TravelMate 5735Z (Intel GM45/Cantiga) and
>> installed Debian Sid/unstable with Linux 5.6.7 on it.
>> 
>> Booting the system it takes a long time, and the systemd units fail to
>> start. The logs contain that the TSC is unstable. Adding `tsc=unstable` to
>> the Linux kernel command line fixes this.
>
> It fixes nothing; it just doesn't get you the warning because you told
> it upfront.

Well, it prevents the kernel to use TSC upfront and not wait until it's
discovered to be crap. That might make a difference.

Thanks,

        tglx
