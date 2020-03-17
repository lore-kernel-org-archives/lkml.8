Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFBBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCQPSg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:18:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51101 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727127AbgCQPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:18:36 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-0m0ADeeiPxyOkHpGz1BdgA-1; Tue, 17 Mar 2020 11:18:31 -0400
X-MC-Unique: 0m0ADeeiPxyOkHpGz1BdgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D568107ACC9;
        Tue, 17 Mar 2020 15:18:30 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-53.rdu2.redhat.com [10.10.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C47EC19C58;
        Tue, 17 Mar 2020 15:18:29 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 11F001A010E; Tue, 17 Mar 2020 11:18:29 -0400 (EDT)
Date:   Tue, 17 Mar 2020 11:18:29 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the selinux tree with the nfs tree
Message-ID: <20200317151829.GA4442@aion.usersys.redhat.com>
References: <20200317133117.4569cc6a@canb.auug.org.au>
 <bb623275e936c026cc425904e6c1cee0cbe85f28.camel@hammerspace.com>
MIME-Version: 1.0
In-Reply-To: <bb623275e936c026cc425904e6c1cee0cbe85f28.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020, Trond Myklebust wrote:

> On Tue, 2020-03-17 at 13:31 +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the selinux tree got a conflict in:
> > 
> >   fs/nfs/getroot.c
> > 
> > between commit:
> > 
> >   e8213ffc2aec ("NFS: Ensure security label is set for root inode")
> > 
> > from the nfs tree and commit:
> > 
> >   28d4d0e16f09 ("When using NFSv4.2, the security label for the root
> > inode should be set via a call to nfs_setsecurity() during the mount
> > process, otherwise the inode will appear as unlabeled for up to
> > acdirmin seconds.  Currently the label for the root inode is
> > allocated, retrieved, and freed entirely witin
> > nfs4_proc_get_root().")
> > 
> > from the selinux tree.
> > 
> > These are basically the same patch with slight formatting
> > differences.
> > 
> > I fixed it up (I used the latter) and can carry the fix as necessary.
> > This is now fixed as far as linux-next is concerned, but any non
> > trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any
> > particularly
> > complex conflicts.
> > 
> OK... Why is this being pushed through the selinux tree? Was that your
> intention Scott?

Not really... I addressed the patch to you and Anna, after all.  On the
other hand, I didn't object when Paul picked up the patch in his tree.
I'm guessing I should have spoken up.  Sorry about that.

-Scott

> Given that it didn't touch anything outside NFS and
> had been acked by the Selinux folks, but had not been acked by the NFS
> maintainers, I was assuming it was waiting to be applied here.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

