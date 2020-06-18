Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB502C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855E82070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChWsS2pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgFRPub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:50:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CDC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=c48CutJv253nONYa7jgn1n1NQC0LmTxC479+1FbSsxU=; b=ChWsS2pGgSMqMU16IY7YahlCii
        tSUQfCR7WvD8kU56LBgwQXLsCgjAFfgNA0R7YMua8n7CpXs+VaTB4hK3Sl14oThocYUkZkIsJf2CH
        jxtfr8VPTcDSxM9PyOInJEY1oJqzGzBzUCpI7Kjl7+xLGmMTmy3+3Xi8qiR1jyj+5opiNDX7/rV1U
        Pvdqj3oSxQ0bpL5xhsz9XdatxI8XB0H7LQxtdshW2bvaIZVvdY85aP1MwBgNu7TT48kqZFb6dVMop
        YVda4AwVvBuivwMrMJ312ae1rqIQzbztDr47A6kzch44QYQsLQYgkF8vR40w6Pl3NxnW6HRIiB1J/
        lOI+4HuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlwnz-0008Ge-Tg; Thu, 18 Jun 2020 15:50:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19E06301A32;
        Thu, 18 Jun 2020 17:50:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B3A82146F52E; Thu, 18 Jun 2020 17:50:17 +0200 (CEST)
Date:   Thu, 18 Jun 2020 17:50:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, dvyukov@google.com, elver@google.com,
        andreyknvl@google.com, Mark.Rutland@arm.com, mhelsley@vmware.com,
        rostedt@goodmis.org, jthierry@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
Message-ID: <20200618155017.GK576905@hirez.programming.kicks-ass.net>
References: <20200618144801.642309720@infradead.org>
 <70455B9B-0952-4E03-B2CE-EEAE1E110C5B@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70455B9B-0952-4E03-B2CE-EEAE1E110C5B@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:57:35AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jun 18, 2020, at 7:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_read() leaves .noinstr.text section
> > 
> > Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
> > Have the bare exception handler do the report_bug() thing.
> 
> I think you should consider inlining or noinstr-ifying report_bug()
> too if you want to make this more bulletproof. I admit the scenario
> where someone instruments it and it goes wrong is farfetched.

How far down that rabbit hole do we go? Because then we need to noinstr
printk, the console drivers, those will very quickly pull in lovely bits
like PCI, USB, DRM :/

At some point we have to just give up.
