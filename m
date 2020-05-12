Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89871CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E47620661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgELQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:23:49 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:35566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgELQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:23:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5274B180A9553;
        Tue, 12 May 2020 16:23:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ice59_5b42530d4ca5b
X-Filterd-Recvd-Size: 2966
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 May 2020 16:23:46 +0000 (UTC)
Message-ID: <80146d5713f8579a92b4da1e2b7d7626999dd9be.camel@perches.com>
Subject: Re: MAINTAINERS: Wrong ordering in VIRTIO BALLOON
From:   Joe Perches <joe@perches.com>
To:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 May 2020 09:23:45 -0700
In-Reply-To: <bb2eea77-72df-6c53-5397-de057ffc9dd8@redhat.com>
References: <alpine.DEB.2.21.2005120717260.3701@felia>
         <bb2eea77-72df-6c53-5397-de057ffc9dd8@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-12 at 08:38 +0200, David Hildenbrand wrote:
> On 12.05.20 07:21, Lukas Bulwahn wrote:
> > Hi David,
> > 
> > with your commit 6d6b93b9afd8 ("MAINTAINERS: Add myself as virtio-balloon 
> > co-maintainer"), visible on next-20200508, ./scripts/checkpatch.pl -f 
> > MAINTAINERS complains:
> > 
> > WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> > #17982: FILE: MAINTAINERS:17982:
> > +F:	include/uapi/linux/virtio_balloon.h
> > +F:	include/linux/balloon_compaction.h
> > 
> > This is due to wrong ordering of the entries in your submission. If you 
> > would like me to send you a patch fixing that, please just let me know.
> > 
> > It is a recent addition to checkpatch.pl to report ordering problems in 
> > MAINTAINERS, so you might have not seen that at submission time.
> 
> Thanks for the notification Lukas,
> 
> b962ee8622d0 ("checkpatch: additional MAINTAINER section entry ordering
> checks") is not in Linus' tree yet AFAIKS.
> 
> I can see that 3b50142d8528 ("MAINTAINERS: sort field names for all
> entries") is upstream. I do wonder if we should just do another batch
> update after the checkpatch patch is upstream instead, I guess more will
> pile up?
> 
> @mst, joe, what do you prefer?
> 
> 1. I can resend the original patch.
> 2. Lukas can send a fixup that we might want to squash.
> 3. We wait until the checkpatch change goes upstream and to a final
> batch update.

A fixup patch would work.

I think if Linus every once in awhile just before an -rc1 runs
scripts/parse-maintainers like:

commit 3b50142d8528 ("MAINTAINERS: sort field names for all entries")

then these sorts of individual patches would not matter much.

This first time the script was run, I think there was just 1 patch
conflict from -next to Linus' tree, and that scripted change was
fairly large.

As the changes will generally be smaller in the future, it's unlikely
there will be a significant number of conflicts.


