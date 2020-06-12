Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158C02078C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKqqRUn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFLABM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgFLABM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:01:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:01:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so9073653ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=69MnTpFDJK4LtDPAHdkNHQCCDPBuXyYRUZTZxf0W1QA=;
        b=JKqqRUn9urXpgo+mw0qGabqO3diMkUoq6fb8MaF7hRwxtNrUQ3YFkp7m71qOR0xgnq
         vAxB+FD0hTfdvpxj77Y7u9hKh33BmXscgIT6xsrRxRzAPXGgyBpcbLRk+g2KCGWZlVCo
         S32qiOpKaGpAuDLGaXYJjVLGYSJHROWvMFU/sSLWbmMR8et5500nIFLUJmtDGY04kklT
         DQI08qWjfKpJoW6Ovzh4AjK49JwTi4TogwTqTi+zZ5s10F2nmKllNL9eultVp6x/6fl5
         y75H5OBAZ2gvQd0V8+2R9PZ62RbIEmQBUQAxbibUZnAFMyMlEQv4Jbyz/vzxKHnReEqS
         r4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=69MnTpFDJK4LtDPAHdkNHQCCDPBuXyYRUZTZxf0W1QA=;
        b=YdYycefalZiq+2wdq2PzTnUyJgt4h7vSkbzvi120BL+j+NVw3wGqUWpIkMcKDWFP8t
         N5tM0+B/aF6vhWvvtxx0fSYWxObm/QFyDjDpusYi33KhmDtmigTS7GUO1H1tdWj4yq9U
         SGIS4MT77JCdqyoo8D1M37mRyldWVsGa40yDGeyAe16j5ceYS9BENVp/14IxquN+Uk55
         4QvQumhLBcsIyzX/aRg2dUUIWYjWnaDHB5oPV3LX9hRGtT3HAWLf/RmVzyyNxCfR0r8N
         4VBcdLQ5el7xRTMA7zaDfZ0nHbOKlGiRTFpsrWT6T61LDI7brkFlbnZ6uLVI0/zfxnRP
         JPQQ==
X-Gm-Message-State: AOAM530KSrMOQBKYbtkI76DHLTnkW8sIdfBzDJNnn5fYEeOnfhmmxol/
        pyCsRmI2mXjXN8NPkx15PxyngnF+WgAboMYRgKI=
X-Google-Smtp-Source: ABdhPJzrlEajDrnfjNM3TEqVmLY4lQVwpZwf2IKM3U82wD8FutIWkee2t3UponlBZu6OMjSr7pg49nRJ4KR8skeqvso=
X-Received: by 2002:a2e:8107:: with SMTP id d7mr5820605ljg.363.1591920069655;
 Thu, 11 Jun 2020 17:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200611031652.200401-1-daeho43@gmail.com> <20200611162721.GB1152@sol.localdomain>
 <CACOAw_zKC24BhNOF2BpuRfuYzBEsis82MafU9HqXwLj2sZ3Azg@mail.gmail.com> <20200611230043.GA18185@gmail.com>
In-Reply-To: <20200611230043.GA18185@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 12 Jun 2020 09:00:58 +0900
Message-ID: <CACOAw_zZY4W9PYY4VAZ_5tGB5LxCEZKh6Sc523MRzVCvKNhinQ@mail.gmail.com>
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

For the incremental way of erasing, we might as well support the
(offset, length) option in a unit of 4KiB.

So, you might use this ioctl like the below. Does it work for you?
struct f2fs_sec_trim {
        u64 startblk;
        u64 blklen;
        u32 flags;
};

sectrim.startblk =3D 0;
sectrim.blklen =3D 256;     // 1MiB
sectrim.flags =3D F2FS_TRIM_FILE_DISCARD | F2FS_TRIM_FILE_ZEROOUT;
ret =3D ioctl(fd, F2FS_SEC_TRIM_FILE, &sectrim);

2020=EB=85=84 6=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:00, E=
ric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> On Fri, Jun 12, 2020 at 07:49:12AM +0900, Daeho Jeong wrote:
> > 2020=EB=85=84 6=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:2=
7, Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Thu, Jun 11, 2020 at 12:16:52PM +0900, Daeho Jeong wrote:
> > > > +     for (index =3D pg_start; index < pg_end;) {
> > > > +             struct dnode_of_data dn;
> > > > +             unsigned int end_offset;
> > > > +
> > > > +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> > > > +             ret =3D f2fs_get_dnode_of_data(&dn, index, LOOKUP_NOD=
E);
> > > > +             if (ret)
> > > > +                     goto out;
> > > > +
> > > > +             end_offset =3D ADDRS_PER_PAGE(dn.node_page, inode);
> > > > +             if (pg_end < end_offset + index)
> > > > +                     end_offset =3D pg_end - index;
> > > > +
> > > > +             for (; dn.ofs_in_node < end_offset;
> > > > +                             dn.ofs_in_node++, index++) {
> > > > +                     struct block_device *cur_bdev;
> > > > +                     block_t blkaddr =3D f2fs_data_blkaddr(&dn);
> > > > +
> > > > +                     if (__is_valid_data_blkaddr(blkaddr)) {
> > > > +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(=
inode),
> > > > +                                     blkaddr, DATA_GENERIC_ENHANCE=
)) {
> > > > +                                     ret =3D -EFSCORRUPTED;
> > > > +                                     goto out;
> > > > +                             }
> > > > +                     } else
> > > > +                             continue;
> > > > +
> > > > +                     cur_bdev =3D f2fs_target_device(sbi, blkaddr,=
 NULL);
> > > > +                     if (f2fs_is_multi_device(sbi)) {
> > > > +                             int i =3D f2fs_target_device_index(sb=
i, blkaddr);
> > > > +
> > > > +                             blkaddr -=3D FDEV(i).start_blk;
> > > > +                     }
> > > > +
> > > > +                     if (len) {
> > > > +                             if (prev_bdev =3D=3D cur_bdev &&
> > > > +                                     blkaddr =3D=3D prev_block + l=
en) {
> > > > +                                     len++;
> > > > +                             } else {
> > > > +                                     ret =3D f2fs_secure_erase(pre=
v_bdev,
> > > > +                                                     prev_block, l=
en, flags);
> > > > +                                     if (ret)
> > > > +                                             goto out;
> > > > +
> > > > +                                     len =3D 0;
> > > > +                             }
> > > > +                     }
> > > > +
> > > > +                     if (!len) {
> > > > +                             prev_bdev =3D cur_bdev;
> > > > +                             prev_block =3D blkaddr;
> > > > +                             len =3D 1;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +             f2fs_put_dnode(&dn);
> > > > +     }
> > >
> > > This loop processes the entire file, which may be very large.  So it =
could take
> > > a very long time to execute.
> > >
> > > It should at least use the following to make the task killable and pr=
eemptible:
> > >
> > >                 if (fatal_signal_pending(current)) {
> > >                         err =3D -EINTR;
> > >                         goto out;
> > >                 }
> > >                 cond_resched();
> > >
> >
> > Good point!
> >
> > > Also, perhaps this ioctl should be made incremental, i.e. take in an
> > > (offset, length) like pwrite()?
> > >
> > > - Eric
> >
> > Discard and Zeroing will be treated in a unit of block, which is 4KB
> > in F2FS case.
> > Do you really need the (offset, length) option here even if the unit
> > is a 4KB block? I guess this option might make the user even
> > inconvenienced to use this ioctl, because they have to bear 4KB
> > alignment in mind.
>
> The ioctl as currently proposed always erases the entire file, which coul=
d be
> gigabytes.  That could take a very long time.
>
> I'm suggesting considering making it possible to call the ioctl multiple =
times
> to process the file incrementally, like you would do with write() or pwri=
te().
>
> That implies that for each ioctl call, the length would need to be specif=
ied
> unless it's hardcoded to 4KiB which would be very inefficient.  Users wou=
ld
> probably want to process a larger amount at a time, like 1 MiB, right?
>
> Likewise the offset would need to be specified as well, unless it were to=
 be
> taken implicitly from f_pos.
>
> - Eric
