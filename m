Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F2C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1055D208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCRV2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:28:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:51382 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgCRV2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:28:01 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02ILRRa8012989;
        Wed, 18 Mar 2020 16:27:28 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 02ILRQ0s012988;
        Wed, 18 Mar 2020 16:27:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 18 Mar 2020 16:27:26 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org,
        apopple@linux.ibm.com, peterz@infradead.org, fweisbec@gmail.com,
        oleg@redhat.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        paulus@samba.org, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        mingo@kernel.org
Subject: Re: [PATCH 12/15] powerpc/watchpoint: Prepare handler to handle more than one watcnhpoint
Message-ID: <20200318212726.GN22482@gate.crashing.org>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com> <20200309085806.155823-13-ravi.bangoria@linux.ibm.com> <3ba94856-0d87-5046-eca9-b5c3d99ec654@c-s.fr> <87zhcdevz7.fsf@mpe.ellerman.id.au> <a7829a23-9b4d-0248-415e-85409f17dd77@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7829a23-9b4d-0248-415e-85409f17dd77@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:44:52PM +0100, Christophe Leroy wrote:
> Le 18/03/2020 à 12:35, Michael Ellerman a écrit :
> >Christophe Leroy <christophe.leroy@c-s.fr> writes:
> >>Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
> >>>Currently we assume that we have only one watchpoint supported by hw.
> >>>Get rid of that assumption and use dynamic loop instead. This should
> >>>make supporting more watchpoints very easy.
> >>
> >>I think using 'we' is to be avoided in commit message.
> >
> >Hmm, is it?
> >
> >I use 'we' all the time. Which doesn't mean it's correct, but I think it
> >reads OK.
> >
> >cheers
> 
> From 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html :
> 
> Describe your changes in imperative mood, e.g. “make xyzzy do frotz” 
> instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy 
> to do frotz”, as if you are giving orders to the codebase to change its 
> behaviour.

That is what is there already?  "Get rid of ...".

You cannot describe the current situation with an imperative.


Segher
