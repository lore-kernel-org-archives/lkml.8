Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB6CC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADB920644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgDGGnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:43:25 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:39070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726865AbgDGGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:43:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6F365838437C;
        Tue,  7 Apr 2020 06:43:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bell44_74a655a6ef330
X-Filterd-Recvd-Size: 2602
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 06:43:21 +0000 (UTC)
Message-ID: <07e49a285eff9a22476c6b1c396485f6d5d39002.camel@perches.com>
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive
 data objects
From:   Joe Perches <joe@perches.com>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-mm@kvack.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Date:   Mon, 06 Apr 2020 23:41:23 -0700
In-Reply-To: <1e4a6174-04be-6c05-fd6e-b43fefd317fc@redhat.com>
References: <20200406185827.22249-1-longman@redhat.com>
         <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
         <1e4a6174-04be-6c05-fd6e-b43fefd317fc@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 22:16 -0400, Waiman Long wrote:
> On 4/6/20 3:38 PM, Joe Perches wrote:
> > On Mon, 2020-04-06 at 14:58 -0400, Waiman Long wrote:
> > > For kvmalloc'ed data object that contains sensitive information like
> > > cryptographic key, we need to make sure that the buffer is always
> > > cleared before freeing it. Using memset() alone for buffer clearing may
> > > not provide certainty as the compiler may compile it away. To be sure,
> > > the special memzero_explicit() has to be used.
> > [] 
> > >  extern void kvfree(const void *addr);
> > > +extern void kvfree_sensitive(const void *addr, size_t len);
> > Question: why should this be const?
> > 
> > 2.1.44 changed kfree(void *) to kfree(const void *) but
> > I didn't find a particular reason why.
> 
> I am just following the function prototype used by kvfree(). Even
> kzfree(const void *) use const. I can remove "const" if others agree.

No worries.  Nevermind me...

Lots of warnings if allocated pointers are const, so const is necessary
in the definition and declaration.

struct foo {
	...
};

struct bar {
	const struct foo *baz;
	...
};

some_func(void)
{
	bar.baz = kvalloc(...);
}

kvfree can't free bar.baz if it's defined with void * without warning,
so it must be const void *.

Apologies for the noise.


