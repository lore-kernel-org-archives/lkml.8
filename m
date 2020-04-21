Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABFAC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F47206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cWWla4YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDUVl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:41:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30ECC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3aJDfem8HcOXCFMg+XNb1qpNzxQmMHRSjAwqO/k6tyQ=; b=cWWla4YWOjna8mXFQgFehxRZDk
        +vU42IyEiGg3xy2Cvlw9RQqLxjmsmffuhYorZSAO3SuT0tIAS2daq+xm+M9/FLhm5nALMpiCvIzxt
        Pts10XRjdudCq0DOtv7vDH1zuwY1vcwef/h8kbsqeQdODTr5EE936AkangiiSeA10258T9ssTln8E
        SY2pk2mimqRljnxbNrl4WrPDc+0JjNvRhOQozni86z160RrffvZRCWSo7eOOXcez6m8v7fR85zSu2
        jGzVVG4GzuMNGuWkmc2xTUBeA1X2CipA3lFGuWUN0zZNqkORHTkEimdCnyR9kn+71PaKtejfJbFQK
        Ai9LgyUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR0e3-0000x2-Kj; Tue, 21 Apr 2020 21:41:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54FE0983ABB; Tue, 21 Apr 2020 23:41:28 +0200 (CEST)
Date:   Tue, 21 Apr 2020 23:41:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
Message-ID: <20200421214128.GW2483@worktop.programming.kicks-ass.net>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
 <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
 <20200421212347.GV2483@worktop.programming.kicks-ass.net>
 <CAHk-=whhpFhUV51jabGEzHN51aKTL5fbQBvNw9=3cXnO8PXs3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhpFhUV51jabGEzHN51aKTL5fbQBvNw9=3cXnO8PXs3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:30:06PM -0700, Linus Torvalds wrote:
> Also, see
> 
>   https://lore.kernel.org/lkml/b90ba443-9b9d-481e-7ecc-d5a25816e02f@oracle.com/
> 
> where Dave Kleikamp seems to say that it happens on his Lenovo T410.
> 
> So I do think it's real, and _not_ virtualization. Please don't
> dismiss it as some vmware artifact. Looks more like it's triggered by
> some Lenovo Thinkpad BIOS setup issue.

Oh, right (I actually saw that email when I picked up the patches, but
clearly instantly forgot about it again). If the BIOS gets the tables
funny we hit the same paths.

Anyway, it would be good if the reporter can confirm, I've also queued
those patches for /urgent, so they should show up soonish.
