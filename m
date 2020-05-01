Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE419C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B193B24953
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgEAQoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:44:10 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:34728 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728946AbgEAQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:44:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7A119582B;
        Fri,  1 May 2020 16:44:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown64_41171caf07714
X-Filterd-Recvd-Size: 2755
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 16:44:07 +0000 (UTC)
Message-ID: <4aeb5a976996efb08572f006bb82dc60f97ce73d.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Fri, 01 May 2020 09:44:06 -0700
In-Reply-To: <20200501163440.GA19874@udknight>
References: <20200501154033.GA25730@udknight>
         <3aeb6ab5059ec753d922051d7732e13322188e7c.camel@perches.com>
         <20200501163440.GA19874@udknight>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-02 at 00:34 +0800, Wang YanQing wrote:
> On Fri, May 01, 2020 at 08:57:42AM -0700, Joe Perches wrote:
> > On Fri, 2020-05-01 at 23:40 +0800, Wang YanQing wrote:
> > > According to submitting-patches.rst, 'Fixes:' tag has a little
> > > stricter condition about the one line summary than normal git
> > > commit description:
> > > “...
> > > Do not split the tag across multiple lines, tags are exempt from
> > > the "wrap at 75 columns" rule in order to simplify parsing scripts
> > > ...”
> > > 
> > > And there is no sanity check for 'Fixes:' tag format in checkpatch
> > > the same as GIT_COMMIT_ID for git commit description, so let's expand
> > > the GIT_COMMIT_ID to add 'Fixes:' tag format check support.
> > > 
> > > The check supports below formats:
> > > Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> > > Fixes: 85f7cd3a2aad ("Revert "media: Kconfig: better support hybrid TV devices"")
> > > Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
> > > Fixes: 878520ac45f9 ("ext4: save the error code which triggered")
> > > Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")
> > 
> > Hi again YanQing.
> > 
> > I think all the non-standard and incomplete forms
> > should have a warning emitted.
> 
> Hi Joe Perches

Hi, again. It's just Joe to my friends...

> I am not sure whether I get your words, you mean we need to emit warning
> for incomplete title line format? For example:
> Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")

I think so yes.

It _might_ be useful to show "why" the message is being emitted.
(sha1 too short, no quotes around description, etc...)


