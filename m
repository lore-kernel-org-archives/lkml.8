Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594BAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283BC206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgEWC6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 22:58:04 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:55848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387481AbgEWC6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:58:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AC0ED837F24C;
        Sat, 23 May 2020 02:58:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: robin60_3f0f18a26d2c
X-Filterd-Recvd-Size: 2777
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 May 2020 02:58:00 +0000 (UTC)
Message-ID: <beb95a8af767ab38d694f59847d2f2f6692e115a.camel@perches.com>
Subject: Re: [PATCH] x86/mm/init: Stop printing pgt_buf addresses
From:   Joe Perches <joe@perches.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 May 2020 19:57:59 -0700
In-Reply-To: <20200523015129.GA717759@rani.riverdale.lan>
References: <20200229231120.1147527-1-nivedita@alum.mit.edu>
         <20200523015129.GA717759@rani.riverdale.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 21:51 -0400, Arvind Sankar wrote:
> On Sat, Feb 29, 2020 at 06:11:20PM -0500, Arvind Sankar wrote:
> > This currently leaks kernel physical addresses into userspace.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/mm/init.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index e7bb483557c9..dc4711f09cdc 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -121,8 +121,6 @@ __ref void *alloc_low_pages(unsigned int num)
> >  	} else {
> >  		pfn = pgt_buf_end;
> >  		pgt_buf_end += num;
> > -		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
> > -			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
> >  	}
> >  
> >  	for (i = 0; i < num; i++) {
> > -- 
> > 2.24.1
> > 
> 
> Ping.
> 
> https://lore.kernel.org/lkml/20200229231120.1147527-1-nivedita@alum.mit.edu/

If this output is at all valuable,
perhaps emit them as hashed pointers?

Maybe:

---
 arch/x86/mm/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1bba16c5742b..44f0d6592c7e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -121,8 +121,9 @@ __ref void *alloc_low_pages(unsigned int num)
 	} else {
 		pfn = pgt_buf_end;
 		pgt_buf_end += num;
-		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
-			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
+		printk(KERN_DEBUG "BRK [0x%8p, 0x%8p] PGTABLE\n",
+		       (void *)(pfn << PAGE_SHIFT),
+		       (void *)((pgt_buf_end << PAGE_SHIFT) - 1));
 	}
 
 	for (i = 0; i < num; i++) {


