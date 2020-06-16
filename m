Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EBBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DCE2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vgcn+56G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFPN1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgFPN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:27:40 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED310C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5RIE+8EpdHjIjWRy7eCN7J3sN/8pSSmTZHYw0/cpfDU=; b=Vgcn+56GvP50cYcunuXQVdBiO7
        fnfxnwyIMROvsDSfTDI4ErZJQ9+vskcr3z3Yk+2eGwbt3Okc5V23CPLcgp15hFAfeL0JljOJcY/UH
        WgWXzpbw+B/Vra96qzLvN6dBNy8C0ag7AcWU8ydnebZu8XKAd05XSrt9FXDqXTuGWC8SJAI3kJvIr
        QP6NYtKBXO8odqOD8p2gwZsyHqqxhd+LlltYsLMJbVD/sK8/RkOOZX+V3RECoPFYvGHvj4yZK35t0
        PAR6XWmUF+WAS4jSk/hQoxCj49XfrJRZujXhSfM8ymHRi115Tr7vNRuQPhIFW1al43R1TvGQH0BIx
        UxcZzATA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlBcK-0002s1-JP; Tue, 16 Jun 2020 13:27:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBE3130018A;
        Tue, 16 Jun 2020 15:27:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8AA1203D48A4; Tue, 16 Jun 2020 15:27:05 +0200 (CEST)
Date:   Tue, 16 Jun 2020 15:27:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it
Subject: Re: [x86/entry] 2bbc68f837: ltp.ptrace08.fail
Message-ID: <20200616132705.GW2531@hirez.programming.kicks-ass.net>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 06:22:10AM -0700, Andy Lutomirski wrote:
> 
> > On Jun 16, 2020, at 1:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > ﻿kernel test robot <rong.a.chen@intel.com> writes:
> >> FYI, we noticed the following commit (built with gcc-9):
> >> 
> >> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > Is the head of linux.git exposing the same problem or is this an
> > intermittent failure, which only affects bisectability?
> 
> It sure looks deterministic:
> 
> ptrace08.c:62: BROK: Cannot find address of kernel symbol "do_debug"

ROFL
