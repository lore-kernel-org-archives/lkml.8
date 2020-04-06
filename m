Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C40EC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A5D249CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgDFRMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:12:23 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:55862 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729811AbgDFRMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:12:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 452E818015864;
        Mon,  6 Apr 2020 17:12:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rod06_144c12ce97501
X-Filterd-Recvd-Size: 1895
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Apr 2020 17:12:19 +0000 (UTC)
Message-ID: <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 06 Apr 2020 10:10:20 -0700
In-Reply-To: <334933.1586190389@warthog.procyon.org.uk>
References: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
         <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
         <20200406023700.1367-1-longman@redhat.com>
         <319765.1586188840@warthog.procyon.org.uk>
         <334933.1586190389@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 17:26 +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > While I agree with Linus about the __ prefix,
> > the z is pretty common and symmetric to all
> > the <foo>zalloc uses.
> > 
> > And if _sensitive is actually used, it'd be
> > good to do a s/kzfree/kfree_sensitive/ one day
> > sooner than later.
> 
> How much overhead would it be to always use kvfree_sensitive() and never have
> a kfree_sensitive()?

Another possibility:

Add yet another alloc flag like __GFP_SENSITIVE
and have kfree operate on that and not have a
kfree_sensitive at all.



