Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB59C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFF920721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NQWyk4a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEFGro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:47:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:47019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgEFGrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588747647;
        bh=hO88QHkEwrRqwifsGMJLO23pyLom4frjxgEUyj9P83s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NQWyk4a22wEfqor3GHw6TNgP35oPNmP+FviFHd39bWVDRjgmrTQW4psPkVfgyHL76
         kOztWkDVJFm5Y++L31zuV7RQ+CjNzIqbxgALvOw1vGLfE3FQgBzN0hd5w6RDofrhne
         fN6c6II4XEmkIv2M6mmfYxKYKbY2JaKsGSxsw3rU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([120.242.76.42]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MZCfJ-1jaqNT0Nnt-00V5nD; Wed, 06 May 2020 08:47:27 +0200
Date:   Wed, 6 May 2020 14:47:19 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200506064709.GA25482@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
 <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200506012428.GG128280@sol.localdomain>
 <20200506015813.GA9256@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506015813.GA9256@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:z6dtdIcZRcSYYph0RGMRdGYvIpDIYF8mz+BYGilcVnLYpEXyg/g
 mFR8hgBLc0U/As4vQQXjMXzV40093msxEuzJUUh8FIhgivuJI9T50alip1rHMHI6VGfOi0w
 5auoIOjOQZbm123Z5TvIA+Lk63KkQ3ai6p+cyDk0MQwedoKnjMp5OTzdMOzO+k9d+YB2Ko0
 uU0i4dijVkg60MGHVFpoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:spzX94Rvc9Y=:Wwm8mk3c5+AdN+K91dNCm9
 /dp58Sb+t6/IYOi1wtRT9WN/nKeLuzqqboXLS/vv6yk90m0vaESkL0mweBW4JyzO7G7RA77tG
 X3Vn4kZ0AOfvheD/63jfo6RzGHHdw6BqYYbUCgcauVVmDckhx2+LeRCO6r2ozabkBpHay7XJp
 BKkrqEFrdXe+hMGBMmgtUZwXgolyrS53FdoLcebX18G//mG2tklxmIz+slXZoR5EJMUkQz3Wh
 d6OYawIFALwHx9omWBJwB/hogCcezV7CIqWLBamcxjHg1ap8bHpjgyrIkG8MkECMImmf76YmY
 S3mY2EwkFGCBaqRf5wEbt8M/06cYZHJRzDwoqpSOF0iJ1WiSwoxOGl85HcJIfe9m+uYxaTOUf
 5T7ps0It5C+fTS7xtqKSwtnagOnPgCfgP4zXLqyYaf8SoU2Dxx8M6Ck32cj/Bsu9mVfYsBLBa
 n/hTY3TLlBW810WpguEYXCmDfikbx7QEDaFaFKPNR1XXAuLV0ncoNDJJPc8zieleT1uEF+SA9
 WlIkeRfqX+2Ll9urFmSAibDl6z4tRhg+2PiHkJ7vtVczxfDpQGCSHyToMqN/7DuGEQZf/iThN
 odgg2Vf6kNxKaXUl2KBZbWullaQ6kEgjGoJlzB2ZIaon4JlcnXKNMUoPn7YYE5rY29baJSNY9
 4iZDI6vTbUDRcecpxrWJxFYB6rCUPGRDGHkHezsxfrIeLH4ep5uv6wdXbUmPWMtS4kaKaWpBq
 TdlbpEOlz7lTEQsuRijSAqrRbs4BuaACbmfp4Jr4nbMCsC3OS8tkBrgWC30J1AaZoMnL+8V3B
 Y2Ygy5w0DzKafUdXr2Xyq4FUpWk72s8hgMfND6QFPDRw20XBMafYCodZdAWXlsc417Fr7roc+
 G5KnwQh+tvP5G/hYYsNozpDqfqb0nUnMr/Q6f5kFfzmKYEvElBhkDpUTu5Rkc4WBTDgqUwym9
 8lOdShEfZGEZ3PDuCRfUk+Yqh2rSICFZ1IPVHM1aHqsikGhVcUoKoyOdhtaZ0HREF/FW2MMSt
 cERaqxV8uSRCTQw/sxkMwuePsA8faxZZK4GXIRwvfxn3APnqRMHAFxJqMvDKZHOmhhHSSLYko
 VTifxOe8wazQWUzkWuQw+1pKojOphgbCITYATckXAWTSgR9HvehSaj+wMeaRoviWLR3P8ue5t
 Yo+IXIZMHsp6QUWZHRg1b6NN3GKv2lfckqFEumXl7DRUnfDRDPXKXqHXdrqLSMj14+4kdo/aw
 nNKZNeOJeTpvtsayc
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 09:58:22AM +0800, Gao Xiang wrote:
> On Tue, May 05, 2020 at 06:24:28PM -0700, Eric Biggers wrote:
> > On Wed, May 06, 2020 at 08:14:07AM +0800, Gao Xiang wrote:
> > > >
> > > > Actually, I think this is wrong because the fsync can be done via =
a file
> > > > descriptor that was opened to a now-deleted link to the file.
> > >
> > > I'm still confused about this...
> > >
> > > I don't know what's wrong with this version from my limited knowledg=
e?
> > >  inode itself is locked when fsyncing, so
> > >
> > >    if the fsync inode->i_nlink =3D=3D 1, this inode has only one har=
d link
> > >    (not deleted yet) and should belong to a single directory; and
> > >
> > >    the only one parent directory would not go away (not deleted as w=
ell)
> > >    since there are some dirents in it (not empty).
> > >
> > > Could kindly explain more so I would learn more about this scenario?
> > > Thanks a lot!
> >
> > i_nlink =3D=3D 1 just means that there is one non-deleted link.  There=
 can be links
> > that have since been deleted, and file descriptors can still be open t=
o them.
>
> Thanks for your inspiration. You are right, thanks.
>
> Correct my words... I didn't check f2fs code just now, it seems f2fs doe=
sn't
> take inode_lock as some other fs like __generic_file_fsync or ubifs_fsyn=
c.
>
> And i_sem locks nlink / try_to_fix_pino similarly in some extent. It see=
ms
> no race by using d_find_alias here. Thanks again.
>

(think more little bit just now...)

 Thread 1:                                           Thread 2 (fsync):
  vfs_unlink                                          try_to_fix_pino
    f2fs_unlink
       f2fs_delete_entry
         f2fs_drop_nlink  (i_sem, inode->i_nlink =3D 1)

  (...   but this dentry still hashed)                  i_sem, check inode=
->i_nlink =3D 1
                                                        i_sem d_find_alias

  d_delete

I'm not sure if fsync could still use some wrong alias by chance..
completely untested, maybe just noise...

Thanks,
Gao Xiang

