Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B1EC83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D95C2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1DJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgD1DJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:09:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE5A206B9;
        Tue, 28 Apr 2020 03:09:22 +0000 (UTC)
Date:   Mon, 27 Apr 2020 23:09:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: Reject invalid NUMA option
Message-ID: <20200427230920.3d606a2e@gandalf.local.home>
In-Reply-To: <20200427225944.185d4431@gandalf.local.home>
References: <20200424045314.16017-1-gshan@redhat.com>
        <20200424101132.GC1167@C02TD0UTHF1T.local>
        <f83c0ce1-b1b2-31f4-60c8-15567b87a8ff@redhat.com>
        <20200427225406.7cacc796@gandalf.local.home>
        <20200427225944.185d4431@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 22:59:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 27 Apr 2020 22:54:06 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 28 Apr 2020 10:59:14 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> > > Hi Mark,
> > > 
> > > On 4/24/20 8:11 PM, Mark Rutland wrote:    
> > > > [Adding Steve, who added str_has_prefix()]
> > > > 
> > > > On Fri, Apr 24, 2020 at 02:53:14PM +1000, Gavin Shan wrote:      
> > > >> The NUMA option is parsed by str_has_prefix() and the invalid option
> > > >> like "numa=o" can be regarded as "numa=off" wrongly.      
> > > > 
> > > > Are you certain that can pass? If that can happen, str_has_prefix() is
> > > > misnamed and does not seem to do what its kerneldoc says it does, as
> > > > "off" is not a prefix of "o".
> > > >       
> > > 
> > > Yes, It's possible. str_has_prefix() depends on strncmp(). In this particular
> > > case, it's equal to the snippet of code as below: strncmp() returns zero.
> > > str_has_prefix() returns 3.    
> > 
> > Wait! strncmp("o", "off", 3) returns zero?
> > 
> > That to me looks like a bug!
> > 
> > This means str_has_prefix() is broken in other areas as well.
> > 
> >   
> > > 
> > > int strncmp(const char *cs, const char *ct, size_t count)
> > > {
> > >          unsigned char c1, c2;
> > > 
> > >          while (count) {
> > >                  c1 = *cs++;
> > >                  c2 = *ct++;
> > >                  if (c1 != c2)
> > >                          return c1 < c2 ? -1 : 1;
> > >                  if (!c1)                             /* break after first character is compared */    
> > 
> > Crap! That is totally wrong!  
> 
> Looking at this again, it's not wrong. But how did we get here if c2 isn't
> zero as well?
> 

Could this be a bug in the implementation of strncmp() in
arch/arm64/lib/strncmp.S. As I don't know arm64 assembly, I have no idea
what it is trying to do.

But strncmp("o","off",3) returning zero *is* a bug.

-- Steve

