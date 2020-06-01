Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D08C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F9A20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if9oOwq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFALqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFALqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:46:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB7EC061A0E;
        Mon,  1 Jun 2020 04:46:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so8918312ejb.4;
        Mon, 01 Jun 2020 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjMc3Y/KKBqySLu2r0804q0NcAb9q1eEbdjViCtXYbA=;
        b=if9oOwq9obMzizVVvxdrgs0415uHlLMZZg8rZy1zI86d/5Md3tqInW52EKZyRHPEas
         kX1LRbdf83opAg7siwBI/SjGg3oymciASfXeXoA+uQvKwzHfSigJoop/l1tboQN990E6
         ZUZHd3L8BVD5Go4FjBD6Dw/NspmAiro+KpaLoqduPad4YDkupm+As2q654+/RFlcq3tU
         MOjOlcLfKC4VpnfVA00T7m7bsPN8CK0ZpjJMQhMA68SQzwySgpmErErxVWjfsEyoLnxM
         yJxyYduirgkU3SKXIF/hojGYxbs/Lpcy6i09MTx6soezzwZ19zr3FM+NX13glsYCeY/C
         AboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjMc3Y/KKBqySLu2r0804q0NcAb9q1eEbdjViCtXYbA=;
        b=blr/LFnKFcDcVhlMdK9Ey09WiC3VhC3ogUWCb+9YjUEuj4Sqrp0AhM9I1tgoOaz9lR
         a/duwIongjU8WPoWhPMYRs5CS7MMeriN49kNO+dKTUU96tMrYxPj6iLqJzEU7oww3clc
         LQXOLRjLUDM86V/QgE78DVDToSsV08JEon9b+m+IPmlg9ONPhjhyOqGy0Fl+ST05S1jy
         pxS0COLStmFS/Z0Pggotly9AdIYxYohpUJzYYAv9vmwfMb6XEqCZ4172s6ge7VePeA1e
         0jbgvKDPpYJaqIFCDpkv1ur0zbDQ/PBQe5/ac/Wkf5DjrJyqC5WvfCfFosni/vqZSCLi
         unpg==
X-Gm-Message-State: AOAM530RYvi7xr13MUMufd/pQAtgAvmKEuDj0pQ9Kv/Z1dP0Y68eNEVO
        ahx1As4ItQq8obZKb4SPF3NnZa+i2iKrrjZwnd4kMsOi
X-Google-Smtp-Source: ABdhPJyrdGj8FjOky5Nx6WVErg/OkuvVeoA2bvrP7SbU/cuhYTwz2LD7W1o3pyodwR0iNgB0RF/GdsjVs3TMfPTGCPE=
X-Received: by 2002:a17:906:4c96:: with SMTP id q22mr9763538eju.263.1591011998009;
 Mon, 01 Jun 2020 04:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200328.182640.1933740379722138264.hermes@ceres.dti.ne.jp>
 <20200430.213842.00392641.hdk1983@gmail.com> <ee5677b7-802b-f524-36cc-9d5ae071859b@gmail.com>
 <20200601.024954.19451246896874392.konishi.ryusuke@gmail.com> <20200601024013.1296-1-hdanton@sina.com>
In-Reply-To: <20200601024013.1296-1-hdanton@sina.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 1 Jun 2020 20:46:26 +0900
Message-ID: <CAKFNMo=coUArmbmgqF1rOSG27K8Hxsh6P9oiehD-o76om8t4yA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_co
To:     Hillf Danton <hdanton@sina.com>
Cc:     hdk1983@gmail.com, tommytoad0@gmail.com,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wondering if it can be reproduced on mainline with c3aab9a0bd91
> ("mm/filemap.c: dont initiate writeback if mapping has no dirty pages")
> reverted?

For mainline kernels with that commit reverted, this oops actually
doesn't occur.

Regards,
Ryusuke Konishi

On Mon, Jun 1, 2020 at 11:40 AM Hillf Danton <hdanton@sina.com> wrote:
> On Mon, 01 Jun 2020 02:49:54 Ryusuke Konishi wrote:
> > Hi,
> >
> > This bug turned out to be caused by set_page_writeback() call for
> > segment summary buffers and super root buffers at
> > nilfs_segctor_prepare_write().
> >
> > set_page_writeback() can call inc_wb_stat(inode_to_wb(inode),
> > WB_WRIEBACK) where inode_to_wb(inode) is NULL if inode_attach_wb() is
> > not called in advance.  To ensure inode_attach_wb() is called,
> > mark_buffer_dirty() should be called for those buffers.
> >
> > The following patch fixes this issue,
>
> Thanks for sharing your analysis and patch.
>
> Wondering if it can be reproduced on mainline with c3aab9a0bd91
> ("mm/filemap.c: dont initiate writeback if mapping has no dirty pages")
> reverted? If no then we need to update the stable trees.
>
> Hillf
>
> > but I got another oops at
> > nilfs_segctor_complete_write() during a stress test.  So, I'm still
> > investigating.
> >
> > Regards,
> > Ryusuke Konishi
> >
> > ===
> > diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> > index 445eef4..f6b5ca8 100644
> > --- a/fs/nilfs2/segment.c
> > +++ b/fs/nilfs2/segment.c
> > @@ -1650,6 +1650,8 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
> >
> >               list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
> >                                   b_assoc_buffers) {
> > +                     set_buffer_uptodate(bh);
> > +                     mark_buffer_dirty(bh);
> >                       if (bh->b_page != bd_page) {
> >                               if (bd_page) {
> >                                       lock_page(bd_page);
> > @@ -1665,6 +1667,8 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
> >                                   b_assoc_buffers) {
> >                       set_buffer_async_write(bh);
> >                       if (bh == segbuf->sb_super_root) {
> > +                             set_buffer_uptodate(bh);
> > +                             mark_buffer_dirty(bh);
> >                               if (bh->b_page != bd_page) {
> >                                       lock_page(bd_page);
> >                                       clear_page_dirty_for_io(bd_page);
> > ===
> >
> >
> > On Thu, 30 Apr 2020 08:27:47 -0700, Tom <tommytoad0@gmail.com> wrote:
> > > Thank you!  This is very helpful information, and does seem to be a
> > > workaround.
> > >
> > > Like you, I have my home directory on a separate NILFS2 filesystem. As
> > > a temporary solution, I removed the line from /etc/fstab for that
> > > filesystem and added your dd suggestion along with a manual mount of
> > > the home filesystem to /etc/rc.local.  /home is now mounted properly
> > > at boot with any of the newer kernels I tried.
> > >
> > > Thanks,
> > > Tom
> > >
> > > On 4/30/20 5:38 AM, Hideki EIRAKU wrote:
> > >>> In Msg <874kuapb2s.fsf@logand.com>;
> > >>>     Subject "Re: BUG: unable to handle kernel NULL pointer dereference at
> > >>>     00000000000000a8 in nilfs_segctor_do_construct":
> > >>>
> > >>>> Tomas Hlavaty <tom@logand.com> writes:
> > >>>>>>> 2) Can you mount the corrupted(?) partition from a recent version of
> > >>>>>>> kernel ?
> > >>>>
> > >>>> I tried the following Linux kernel versions:
> > >>>>
> > >>>> - v4.19
> > >>>> - v5.4
> > >>>> - v5.5.11
> > >>>>
> > >>>> and still get the crash
> > >> I found conditions to reproduce this issue with Linux 5.7-rc3:
> > >> - CONFIG_MEMCG=y *and* CONFIG_BLK_CGROUP=y
> > >> - When the NILFS2 file system writes to a device, the device file has
> > >>    never written by other programs since boot
> > >> The following is an example with CONFIG_MEMCG=y and
> > >> CONFIG_BLK_CGROUP=y kernel.  If you do mkfs and mount it, it works
> > >> because the mkfs command has written data to the device file before
> > >> mounting:
> > >> # mkfs -t nilfs2 /dev/sda1
> > >> mkfs.nilfs2 (nilfs-utils 2.2.7)
> > >> Start writing file system initial data to the device
> > >>         Blocksize:4096  Device:/dev/sda1  Device Size:267386880
> > >> File system initialization succeeded !!
> > >> # mount /dev/sda1 /mnt
> > >> # touch /mnt
> > >> # sync
> > >> #
> > >> Loopback mount seems to be the same - if you do losetup, mkfs and
> > >> mount on a loopback device, it works:
> > >> # losetup /dev/loop0 foo
> > >> # mkfs -t nilfs2 /dev/loop0
> > >> mkfs.nilfs2 (nilfs-utils 2.2.7)
> > >> Start writing file system initial data to the device
> > >>         Blocksize:4096  Device:/dev/loop0  Device Size:267386880
> > >> File system initialization succeeded !!
> > >> # mount /dev/sda1 /mnt
> > >> # touch /mnt
> > >> # sync
> > >> #
> > >> But if you do mkfs on a file and use mount -o loop, it may fail,
> > >> depending on whether the loopback device assigned by the mount command
> > >> was used or not before mounting:
> > >> # /sbin/mkfs.nilfs2 ./foo
> > >> mkfs.nilfs2 (nilfs-utils 2.2.7)
> > >> Start writing file system initial data to the device
> > >>         Blocksize:4096  Device:./foo  Device Size:268435456
> > >> File system initialization succeeded !!
> > >> # mount -o loop ./foo /mnt
> > >> [ 36.371331] NILFS (loop0): segctord starting. Construction interval =
> > >> 5 seconds, CP frequency < 30 seconds
> > >> # touch /mnt
> > >> # sync
> > >> [ 40.252869] BUG: kernel NULL pointer dereference, address:
> > >> 00000000000000a8
> > >> (snip)
> > >> After reboot, it fails:
> > >> # mount /dev/sda1 /mnt
> > >> [ 14.021188] NILFS (sda1): segctord starting. Construction interval =
> > >> 5 seconds, CP frequency < 30 seconds
> > >> # touch /mnt
> > >> # sync
> > >> [ 20.576309] BUG: kernel NULL pointer dereference, address:
> > >> 00000000000000a8
> > >> (snip)
> > >> But if you do dummy write to the device file before mounting, it
> > >> works:
> > >> # dd if=/dev/sda1 of=/dev/sda1 count=1
> > >> 1+0 records in
> > >> 1+0 records out
> > >> 512 bytes copied, 0.0135982 s, 37.7 kB/s
> > >> # mount /dev/sda1 /mnt
> > >> [   52.604560] NILFS (sda1): mounting unchecked fs
> > >> [   52.613335] NILFS (sda1): recovery complete
> > >> [ 52.613877] NILFS (sda1): segctord starting. Construction interval =
> > >> 5 seconds, CP frequency < 30 seconds
> > >> # touch /mnt
> > >> # sync
> > >> #
> > >> # losetup /dev/loop0 foo
> > >> # dd if=/dev/loop0 of=/dev/loop0 count=1
> > >> 1+0 records in
> > >> 1+0 records out
> > >> 512 bytes copied, 0.0243797 s, 21.0 kB/s
> > >> # mount /dev/loop0 /mnt
> > >> [  271.915595] NILFS (loop0): mounting unchecked fs
> > >> [  272.049603] NILFS (loop0): recovery complete
> > >> [ 272.049724] NILFS (loop0): segctord starting. Construction interval
> > >> = 5 seconds, CP frequency < 30 seconds
> > >> # touch /mnt
> > >> # sync
> > >> #
> > >> I think the dummy write is a simple workaround for now, unless
> > >> mounting NILFS2 at boot time.  But I have been using NILFS2 /home for
> > >> years, I would like to know better workarounds.
> > >>
> >
>
