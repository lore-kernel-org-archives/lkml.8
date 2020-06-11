Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E14F206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu6Ko60G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFKWtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFKWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:49:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:49:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so8872785ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oZz4Kx4San+/C3xZHFDOh06j3X07sR49zOOViMY8pNY=;
        b=Qu6Ko60GtYwxe10GyVE0B3zOM0FY4oYGLYqqY9ggoIhFeONimPFed3eHImN+Nyw5et
         b3Sg0Uc0tND60uWSleH/sfpcz/gQowNVnvIjmzqHxdnpJI9BZbqe3/FBHDpcwbj9Hgch
         aXPMPWbA/tUAt2UsYEmwABgmb/tP/1UwJ6ODEhahCS4DqzluL8AwjH8NBkhrEdlZG1pK
         5r9pKghrnu0nDCsScxsVBgD+x8P+QF2G7nif8yPMsG7EhsoZFqzMkQQzpcjPv0b+xINM
         dfI/U3F8KhB9nWWibplZggS+Bwgk8iP51DqotfpobqLvCqefK7nOEPVES65kIkT5woYN
         RX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oZz4Kx4San+/C3xZHFDOh06j3X07sR49zOOViMY8pNY=;
        b=W7yV2PODnagnu/DXJG7BcLTGuHE3Sjej0doMTGu2TjIr8rBI+MSagLbYuaNSouBNkt
         odGSxqtaJ/kJW7dLziFmeKO34ozqCjDj5mL+2rEQYfq+/fuPeNxa/sVmIjQDnTi5sXy9
         kvpSdqnBLClxZLhZNfhX6BJmFnqr7wvWxw+Vm13MSwaX7QxtQTvrHirsrsjMHi0BwJcv
         pYD0K/UDiL2e3YONb8rlWhgNZNegLkI0Gve72Nm7nCx74wuaHbbk8ogN6Vp8Ez/ow6yq
         3UNXoJX5bfOizsCkejtquTTuxyQYiModjtYAONaGLFAWxkuRq0sE9NYQus6kMowMR/5d
         Haiw==
X-Gm-Message-State: AOAM533gNV7L98mjDnE4Gai7DSRvbY0yTgZSwY9Y/3da0+kte8ok5ibO
        PVEAVDRqrQUNmjczO+huMGlxSVXLCE5ygy6fnTs=
X-Google-Smtp-Source: ABdhPJxotYa08x+IXQk//DpZvBytYpY74otnzwBVCWx2x1BiGgFN0nOGmdF1b/UgAwnCb8RcTKF8c5onJyU5yCjs1+A=
X-Received: by 2002:a2e:8107:: with SMTP id d7mr5712031ljg.363.1591915763067;
 Thu, 11 Jun 2020 15:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200611031652.200401-1-daeho43@gmail.com> <20200611162721.GB1152@sol.localdomain>
In-Reply-To: <20200611162721.GB1152@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 12 Jun 2020 07:49:12 +0900
Message-ID: <CACOAw_zKC24BhNOF2BpuRfuYzBEsis82MafU9HqXwLj2sZ3Azg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:27, E=
ric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jun 11, 2020 at 12:16:52PM +0900, Daeho Jeong wrote:
> > +     for (index =3D pg_start; index < pg_end;) {
> > +             struct dnode_of_data dn;
> > +             unsigned int end_offset;
> > +
> > +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> > +             ret =3D f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             end_offset =3D ADDRS_PER_PAGE(dn.node_page, inode);
> > +             if (pg_end < end_offset + index)
> > +                     end_offset =3D pg_end - index;
> > +
> > +             for (; dn.ofs_in_node < end_offset;
> > +                             dn.ofs_in_node++, index++) {
> > +                     struct block_device *cur_bdev;
> > +                     block_t blkaddr =3D f2fs_data_blkaddr(&dn);
> > +
> > +                     if (__is_valid_data_blkaddr(blkaddr)) {
> > +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inod=
e),
> > +                                     blkaddr, DATA_GENERIC_ENHANCE)) {
> > +                                     ret =3D -EFSCORRUPTED;
> > +                                     goto out;
> > +                             }
> > +                     } else
> > +                             continue;
> > +
> > +                     cur_bdev =3D f2fs_target_device(sbi, blkaddr, NUL=
L);
> > +                     if (f2fs_is_multi_device(sbi)) {
> > +                             int i =3D f2fs_target_device_index(sbi, b=
lkaddr);
> > +
> > +                             blkaddr -=3D FDEV(i).start_blk;
> > +                     }
> > +
> > +                     if (len) {
> > +                             if (prev_bdev =3D=3D cur_bdev &&
> > +                                     blkaddr =3D=3D prev_block + len) =
{
> > +                                     len++;
> > +                             } else {
> > +                                     ret =3D f2fs_secure_erase(prev_bd=
ev,
> > +                                                     prev_block, len, =
flags);
> > +                                     if (ret)
> > +                                             goto out;
> > +
> > +                                     len =3D 0;
> > +                             }
> > +                     }
> > +
> > +                     if (!len) {
> > +                             prev_bdev =3D cur_bdev;
> > +                             prev_block =3D blkaddr;
> > +                             len =3D 1;
> > +                     }
> > +             }
> > +
> > +             f2fs_put_dnode(&dn);
> > +     }
>
> This loop processes the entire file, which may be very large.  So it coul=
d take
> a very long time to execute.
>
> It should at least use the following to make the task killable and preemp=
tible:
>
>                 if (fatal_signal_pending(current)) {
>                         err =3D -EINTR;
>                         goto out;
>                 }
>                 cond_resched();
>

Good point!

> Also, perhaps this ioctl should be made incremental, i.e. take in an
> (offset, length) like pwrite()?
>
> - Eric

Discard and Zeroing will be treated in a unit of block, which is 4KB
in F2FS case.
Do you really need the (offset, length) option here even if the unit
is a 4KB block? I guess this option might make the user even
inconvenienced to use this ioctl, because they have to bear 4KB
alignment in mind.
