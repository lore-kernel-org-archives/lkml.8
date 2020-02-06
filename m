Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C12C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2C720720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgBFGsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:48:46 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:42253 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbgBFGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:48:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8AD8818029154;
        Thu,  6 Feb 2020 06:48:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wax40_6955ca1ea6d28
X-Filterd-Recvd-Size: 2208
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Feb 2020 06:48:43 +0000 (UTC)
Message-ID: <973a8964e7d8b8a98ec34c4efa8e2726cd88013a.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Remove uses of P: for maintainer name
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Feb 2020 22:47:32 -0800
In-Reply-To: <CAPcyv4g65_Jxv3GUHsTtH6KmR=AYbx4s+TAC+tLE8YeLNiH8pw@mail.gmail.com>
References: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
         <CAPcyv4g65_Jxv3GUHsTtH6KmR=AYbx4s+TAC+tLE8YeLNiH8pw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 20:14 -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 7:23 PM Joe Perches <joe@perches.com> wrote:
> > commit 1ca84ed6425f ("MAINTAINERS: Reclaim the P: tag for
> > Maintainer Entry Profile") changed the use of the "P:" tag
> > from "Person" to "Profile (ie: special subsystem coding styles
> > and characteristics)"
> > 
> > Change how get_maintainer.pl parses the "P:" tag to match.
> 
> Looks ok to me:
> 
> Acked-by: Dan Williams <dan.j.william@intel.com>
> 
> ...although I was not able to trigger any unexpected results running
> against drivers/nvdimm/.

Because there aren't any entries like

P:	First Last
M:	maintainer@domain.tld

where the name was a P: entry and the
email address was on the next line.

That was the form before 2009, but there
were still a few entries until you changed
them recently.

A long time ago:

commit 8b58be884a9fd650abb7f7adf3f885fb9cecd79d
Author: Joe Perches <joe@perches.com>
Date:   Wed Jul 29 15:04:30 2009 -0700

    MAINTAINERS: coalesce name and email address lines
    
    Switch the MAINTAINERS email address format from
    
    P:      Linus Torvalds
    M:      torvalds@linux-foundation.org
    
    to
    
    M:      Linus Torvalds <torvalds@linux-foundation.org>


