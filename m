Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B4BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7562C206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDHAh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:37:26 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:35160 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgDHAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:37:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EC792180240BA;
        Wed,  8 Apr 2020 00:37:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cough31_235fb3002fe5a
X-Filterd-Recvd-Size: 2519
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Apr 2020 00:37:22 +0000 (UTC)
Message-ID: <bc4500becb77f4e6396f69cc354ceb46c2aebb04.camel@perches.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive
 data objects
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Date:   Tue, 07 Apr 2020 17:35:24 -0700
In-Reply-To: <20200407221255.GM21484@bombadil.infradead.org>
References: <20200407200318.11711-1-longman@redhat.com>
         <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
         <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
         <20200407221255.GM21484@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 15:12 -0700, Matthew Wilcox wrote:
> On Tue, Apr 07, 2020 at 04:45:45PM -0400, Waiman Long wrote:
> > On 4/7/20 4:31 PM, Joe Perches wrote:
> > > On Tue, 2020-04-07 at 16:03 -0400, Waiman Long wrote:
> > > > +extern void kvfree_sensitive(const void *addr, size_t len);
> > > Why should size_t len be required?
> > > 
> > > Why not do what kzfree does and memset
> > > the entire allocation? (area->size)
> > 
> > If the memory is really virtually mapped, the only way to find out the
> > size of the object is to use find_vm_area() which can be relatively high
> > cost and no simple helper function is available. On the other hand, the
> > length is readily available in the callers. So passing the length
> > directly to the kvfree_sensitive is simpler.
> 
> Also it lets us zero only the first N bytes of the allocation.  That might
> be good for performance, if only the first N bytes of an M byte allocation
> are actually sensitive.  I don't know if we have any such cases, but
> they could exist.

I would really doubt it as the allocation of
sensitive data should generally be separate.

Also, a similar argument could apply to
kzfree/kfree_sensitive.


