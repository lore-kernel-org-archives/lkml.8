Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E15E206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ykZQ+w8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGCRpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGCRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:45:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A872C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fy9p+5xA2GSj8G8sVCzaAqMHkAqlb228bxWXUoSUq0M=; b=ykZQ+w8sIHhism7zhf1uA+HXo9
        FpE4c6YQPCvHHvlAiI58nPwFLQ7ZrOPbSD0vTloNUOC/03sf+CKniufA6F9Wmae8H3pC1bvRyBJIG
        9TC2oH5MyZqkWCD8yNjc+VjoFVoA3b8wg9iVRFKLX6PNSVtvefu9pbFagAOuprqr/EViOmAXrDYTy
        SxqDrZfFxrM83ZK4myjYncQ0Cc7LCs0ABQzfUKgHNFA4st0OZXWMPGwry80j+2jrZvfdHDMonkRSA
        ET5KUc585SpYebEYwOn8IjAKDpR1NgxuAgADbX3korWWBPP8F6cZ9oQGqNBWKXxguauvqEr9X6YTM
        pSPncrrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrPkr-0004B4-SP; Fri, 03 Jul 2020 17:45:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60EA9304BAE;
        Fri,  3 Jul 2020 19:45:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EE3520078FE1; Fri,  3 Jul 2020 19:45:39 +0200 (CEST)
Date:   Fri, 3 Jul 2020 19:45:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703174539.GA4800@hirez.programming.kicks-ass.net>
References: <20200703155749.GA6255@pc636>
 <CAEJqkgiFFh8CvXkM4ZzXxNQmOJLL7WcgDL6rM83safNgEewZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgiFFh8CvXkM4ZzXxNQmOJLL7WcgDL6rM83safNgEewZ9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 07:07:39PM +0200, Gabriel C wrote:

> I boot all the boxes restricting the cores to the correct count on the
> command line.

This, because you're right about the wasted memory.

> Wasted resource or not, this is still a bug IMO.

Yeah, but not one we can do much about I think. It is the BIOS saying it
wants more because it expects someone to come along and stick another
CPU in.

Possible we could say that for single socket machines overprovisioning
is 'silly', but then, I've no idea how to detect that. You'll need to
find an ACPI person.
