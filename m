Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF15CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898E8206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgENMI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:08:58 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:40704 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgENMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:08:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 99D5A18224D7E;
        Thu, 14 May 2020 12:08:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: taste99_13733fd571143
X-Filterd-Recvd-Size: 2031
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 May 2020 12:08:53 +0000 (UTC)
Message-ID: <c44df8c581014158b7b2753f446ea27741f40c94.camel@perches.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive
 data objects
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Balbir Singh <bsingharora@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Date:   Thu, 14 May 2020 05:08:52 -0700
In-Reply-To: <20200514120018.GA16070@bombadil.infradead.org>
References: <20200407200318.11711-1-longman@redhat.com>
         <1158ff38-c65d-379f-8ae7-6f507d9fc8dd@gmail.com>
         <20200514120018.GA16070@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-14 at 05:00 -0700, Matthew Wilcox wrote:
> On Thu, May 14, 2020 at 09:00:40PM +1000, Balbir Singh wrote:
> > I wonder if the right thing to do is also to disable pre-emption, just so that the thread does not linger on with sensitive data.
> > 
> > void kvfree_sensitive(const void *addr, size_t len)
> > {
> > 	preempt_disable();
> > 	if (likely(!ZERO_OR_NULL_PTR(addr))) {
> > 		memzero_explicit((void *)addr, len);
> > 		kvfree(addr);
> > 	}
> > 	preempt_enable();
> > }
> > EXPORT_SYMBOL(kvfree_sensitive);
> 
> If it's _that_ sensitive then the caller should have disabled preemption.
> Because preemption could otherwise have occurred immediately before
> kvfree_sensitive() was called.

static inline ?

