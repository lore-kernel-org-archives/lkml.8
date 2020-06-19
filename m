Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAAEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DED20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbgFSThR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:37:17 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:58610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387688AbgFSThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:37:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 928371801E0BD;
        Fri, 19 Jun 2020 19:37:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hot07_310c0a226e1b
X-Filterd-Recvd-Size: 1975
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jun 2020 19:37:14 +0000 (UTC)
Message-ID: <369b8060416ad9507ba1cd1160e20bc2f0ea7e5d.camel@perches.com>
Subject: Re: [PATCH] Documentation: Fix most typos
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Jun 2020 12:37:13 -0700
In-Reply-To: <20200619132045.6120f4eb@lwn.net>
References: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
         <20200619132045.6120f4eb@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-19 at 13:20 -0600, Jonathan Corbet wrote:
> On Wed, 10 Jun 2020 16:07:32 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > These are the typos found in scripts/spelling.txt for
> > most of the Documentation/ tree.
> > 
> > Scripted with:
> > 
> > $ cat scripts/spelling.txt | \
> >   grep -v -P "^\s*\#" | \
> >   while read line ; do \
> >     from=$(echo $line | cut -f1 -d'|'); \
> >     to=$(echo $line | cut -f3 -d'|'); \
> >     echo "from: $from to: $to" ; \
> >     git grep -w --name-only $from | \
> >     xargs sed -i "s/\b$from\b/$to/" ; \
> >     git checkout scripts/spelling.txt ; \
> >   done
> > 
> > And some removal of inappropriate conversions
> > in Documentation/translations and a few files
> > where the conversions were incorrect.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> So this fails badly against current docs-next...any chance of a redo?

This patch still works against current -next.

Maybe your tree should be added to -next so
people don't have to search out specific trees.

git git://git.lwn.net/linux.git docs-next

