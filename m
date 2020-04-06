Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D06C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33AB206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDFSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:48:28 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:35024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgDFSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:48:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 88B618378BB8;
        Mon,  6 Apr 2020 18:48:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: view80_83acc3aa07734
X-Filterd-Recvd-Size: 2764
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Apr 2020 18:48:24 +0000 (UTC)
Message-ID: <fa6260781d8a87ea04ac2014ddabaf7066fcdcec.camel@perches.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Apr 2020 11:46:26 -0700
In-Reply-To: <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
         <20200406023700.1367-1-longman@redhat.com>
         <319765.1586188840@warthog.procyon.org.uk>
         <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
         <19cbf3b1-2c3f-dd0f-a5c6-69ca3f77dd68@redhat.com>
         <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 11:06 -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 10:59 AM Waiman Long <longman@redhat.com> wrote:
> > I have actually been thinking about that. I saw a couple of cases in the
> > crypto code where a memzero_explicit() is followed by kfree(). Those can
> > be replaced by kfree_sensitive.
> 
> Ack.
> 
> Doing that (and renaming kvzfree) should be a fairly straightforward
> coccinelle patch.

Not really as comment and prototype and existing cocci
scripts that contain kzfree are difficult to change.

A sed is straightforward and works well.

$ git grep -w --name-only kzfree | \
  xargs sed -i 's/\bkzfree\b/kfree_sensitive/'

For today's next that's:

$ git diff --shortstat
 116 files changed, 322 insertions(+), 322 deletions(-)

After this change:

The kernel-doc comment in slab_common.c should be
edited from zeroed to something else.

 * kfree_sensitive - like kfree but zero memory
 * @p: object to free memory of
 *
 * The memory of the object @p points to is zeroed before freed.
 * If @p is %NULL, kfree_sensitive() does nothing.
 *
 * Note: this function zeroes the whole allocated buffer which can be a good
 * deal bigger than the requested buffer size passed to kmalloc(). So be
 * careful when using this function in performance sensitive code.
 */


