Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CFC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4633A249EE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgDFRW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:22:26 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:43238 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728945AbgDFRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:22:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9B0E52C7C;
        Mon,  6 Apr 2020 17:22:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: page92_6c1d39d59a41b
X-Filterd-Recvd-Size: 2829
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Apr 2020 17:22:22 +0000 (UTC)
Message-ID: <7eb36a794df38c885689085618a8a4ff9df3dd2c.camel@perches.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Apr 2020 10:20:24 -0700
In-Reply-To: <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
         <20200406023700.1367-1-longman@redhat.com>
         <319765.1586188840@warthog.procyon.org.uk>
         <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
         <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
         <adc76d7c441e8f10697b61ceaff66207fb219886.camel@perches.com>
         <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 10:11 -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 9:44 AM Joe Perches <joe@perches.com> wrote:
> > Dubious assertion.  Both end up with zeroed memory.
> 
> You don't understand the function.

Another dubious assertion.

> You ignored the part where the zeroed memory isn't even the _point_.
> 
> Yes, for kzalloc() it is.  There the zero is inherent and important.
> People very much depend on it, and it's the whole point of that
> function. The 'z' is not silent.
> 
> But for kzfree() it really really isn't.  There the zeroing is never
> going to be seen by anybody wjho does the right thing, and is not
> important at all - it's purely a "let's make sure old contents don't
> leak".
> 
> The "zero" part is completely immaterial, it could just as well have
> been a "memset(0xaa)" instead.

or memfill(0xdeadbeef).
 
> And you didn't seem to understand that kzfree() shouldn't use memset()
> in the first place, so it's not even using the same operation.
> 
> You really don't seem to get the whole "kzfree() has absolutely
> _nothing_ to do with kzalloc() apart from a dubious implementation
> details".

API function naming symmetry is good.
You ignore or don't quote the kzfree/kfree_sensitive too.

Yet I don't say _you_ don't understand something.


