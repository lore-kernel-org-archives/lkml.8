Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A025C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51720757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="S+1CRQjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCQNta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:49:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33932 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgCQNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:49:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id i24so22705410eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmNKybmelgBHykhp4MQGXO2cWeb6EPOmoPyYNqmZcy8=;
        b=S+1CRQjkz63ZdDzkP7oBw1SRer0hN06iqZyM6hfijjKRoTsYMxHIVPTQhgAkPVKEVu
         jGQz1spcj0+B39kABkpKgyd2ENtsZY7HFM50i1rJ/KvMrk4t8nAdLD0HEsPZysyahwv2
         KdfiKWj5TAgnUKqVIteB9x2lYiGSkuDVofvtWIyuB4Mr91m+nyQ3J30ltjf6QV/Cst4P
         j4p+0xYM6HLc5KzYF5ESLT02M+YiqV8lODr3l9LbtV2wB6PSjMuST6h+CGZUK8cO4tar
         z7yZO37Ax7/Jm4sokUeymCDjUombPFuxLUnNgspvGJleSlEFvSIkC6P1pXggWv+39nPx
         ha3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmNKybmelgBHykhp4MQGXO2cWeb6EPOmoPyYNqmZcy8=;
        b=VDWnJZQlsyJS0+7mm0xL1rfqa2hnkMSNx2NMEdOBf/9ZG8KwWooenflYU1Uyxoa5py
         CAguaKWgc0s+ZYWbyZF+nY5a2QqG+ZJPpveltwjeaEd3qIK3e/Hmlm8AHTXI1GrE9Xf9
         wdvdjAWungirpiztBJsWjQv9NKdmYR6evIAc1PlhaBHgJ9Y+X4ceBn29tK0aGvTNbjCl
         bQy/G9dUzECvva0hGCG4otTHLX/+xQtB4qF+CB9M+sMyLaE84GHf7gi3ValFNAwFTVw/
         1Pv1b0IEnPK1+0f09BMXO5j3R0EHMJi6A2opNES+fqk1yoxD/CRvWfoxP6Qj1+hHtIub
         ABKQ==
X-Gm-Message-State: ANhLgQ2M2VkXavJuFb+oFwBzS5Ixh5mCAep4uotSkBwS7aNlpt4TsL77
        6h4iXH6wwG7fL1U9JCGDOte/b8QvC08289M6NXiO
X-Google-Smtp-Source: ADFU+vvuhgAfsTftvVLtuZdAWVwrplj3L4fhzKjJbzp4/GZPeRPk2j/mWtfOrmdYunmZb3BFH1dgvXifxwmD6cvLEk8=
X-Received: by 2002:aa7:cf93:: with SMTP id z19mr5414868edx.12.1584452967726;
 Tue, 17 Mar 2020 06:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200317133117.4569cc6a@canb.auug.org.au> <bb623275e936c026cc425904e6c1cee0cbe85f28.camel@hammerspace.com>
In-Reply-To: <bb623275e936c026cc425904e6c1cee0cbe85f28.camel@hammerspace.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Mar 2020 09:49:16 -0400
Message-ID: <CAHC9VhT04gBL3yAxdtKMkZSTEoauT4G7tayg7u3Tp9GQcVEBtA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the nfs tree
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 9:33 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
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
> intention Scott? Given that it didn't touch anything outside NFS and
> had been acked by the Selinux folks, but had not been acked by the NFS
> maintainers, I was assuming it was waiting to be applied here.

FYI, archive link below, but the short version is that the patch fixed
a problem seen with SELinux/labeled-NFS and after not hearing anything
from the NFS folks for over a week I went ahead and merged it into the
SELinux tree.  With everything going on in the world at the moment I
didn't want this fix to get lost.  I have no problem reverting the
patch in the SELinux -next branch if you guys would prefer to push
this up to Linus via the NFS tree; I just want to make sure we get
this fixed.

https://lore.kernel.org/selinux/CAHC9VhThqgv_QzCyeVYkBASVmNg2qZGxHwcxXL7KN84kR7+XUQ@mail.gmail.com/

-- 
paul moore
www.paul-moore.com
