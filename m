Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056BE207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbUrFpoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEaRuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgEaRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:50:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E3C061A0E;
        Sun, 31 May 2020 10:50:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q9so3903513pjm.2;
        Sun, 31 May 2020 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:to:cc:subject:from:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+QY9ymfl54x1PeSUWPdj+6GZQTSL0jCotmt0Izwc84=;
        b=lbUrFpoByYjwRoN4C7rvZnPos4E2DdE0c533ZcJAT7kAszFRsMC6kNXUvZu2h1+tGk
         QI5TxFS/RUm5q/x1MmjEC4V0X31D0rhRWMJYWPXlyVub5S+IshMmrNmghVcfjFXpLUrC
         98fxpFVKvAplYMBjvEVovWT39g0wN3fAMPGmqXoP8ekPgDqcRTWHLOeUI+hnoTzqSZGL
         h5pb/mxWQ6ckIaSEiYfJF9W6Vu4GkR9VOwtWbjrTVvcYQdfroIUdf6NHuFJuXS9edDq8
         dU9C//Qk2f0lh+SfDrNXewjdNpWxzNNYbq1VpRnz8z5f4IYpy/ot26Kri5Pcu6b2zkhP
         TcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:to:cc:subject:from:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+QY9ymfl54x1PeSUWPdj+6GZQTSL0jCotmt0Izwc84=;
        b=cjHqJoKlTpWGceMefpN2PubLb9l2Hg1+ny/KEuqp93O3LpEycUDCMkdrgiUgOzSfEY
         o97eSLgLOeh2SJt4HsI6KnG9Gu9DCUbZ8A6Ai0xAgowcAdr8Yp8MFjPo9NL0YvWnq3AN
         1hwicQFl7Qc3Pf0keB8mMqsdvPKyFIgil1aXz6V3jpe+PA3Fa0x9koO6WL9nWqJ2vR13
         LxtnoTLoi0e+e8wKf+HFrxMqgxH1OVzAljTGG+X5jSdY1ap1iyI4XQ/VPbjePsRI9esC
         p2e84OTBxqIR2SRsTnYfUni/IeQvAnm++ne+ZDbwNrGLhQiDg+oUc6J1+9JqUaFSobvP
         X8Sw==
X-Gm-Message-State: AOAM532P2tcmeDG1rdyvPBs+2xsct7LiO7Wu3wiwthk2VnJXigGAX4EM
        bSPq/GryWtVquBwsR+uf+ti0YDPZ
X-Google-Smtp-Source: ABdhPJyIiF+0TuQUk7Or+88HkTnZEZRjtqP6CyIbsdM/xn8TGR6YrQ/WKVDEzDCFdvLkJgwNSLJnnA==
X-Received: by 2002:a17:90a:a611:: with SMTP id c17mr5087479pjq.202.1590947400007;
        Sun, 31 May 2020 10:50:00 -0700 (PDT)
Received: from localhost (i60-34-120-79.s42.a014.ap.plala.or.jp. [60.34.120.79])
        by smtp.gmail.com with ESMTPSA id 12sm538460pfb.3.2020.05.31.10.49.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 31 May 2020 10:49:59 -0700 (PDT)
Date:   Mon, 01 Jun 2020 02:49:54 +0900 (JST)
Message-Id: <20200601.024954.19451246896874392.konishi.ryusuke@gmail.com>
To:     hdk1983@gmail.com
Cc:     tommytoad0@gmail.com, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_co
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
In-Reply-To: <ee5677b7-802b-f524-36cc-9d5ae071859b@gmail.com>
References: <20200328.182640.1933740379722138264.hermes@ceres.dti.ne.jp>
        <20200430.213842.00392641.hdk1983@gmail.com>
        <ee5677b7-802b-f524-36cc-9d5ae071859b@gmail.com>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This bug turned out to be caused by set_page_writeback() call for
segment summary buffers and super root buffers at
nilfs_segctor_prepare_write().

set_page_writeback() can call inc_wb_stat(inode_to_wb(inode),
WB_WRIEBACK) where inode_to_wb(inode) is NULL if inode_attach_wb() is
not called in advance.  To ensure inode_attach_wb() is called,
mark_buffer_dirty() should be called for those buffers.

The following patch fixes this issue, but I got another oops at
nilfs_segctor_complete_write() during a stress test.  So, I'm still
investigating.

Regards,
Ryusuke Konishi

===
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 445eef4..f6b5ca8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1650,6 +1650,8 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
@@ -1665,6 +1667,8 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				    b_assoc_buffers) {
 			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				mark_buffer_dirty(bh);
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
 					clear_page_dirty_for_io(bd_page);
===


On Thu, 30 Apr 2020 08:27:47 -0700, Tom <tommytoad0@gmail.com> wrote:
> Thank you!  This is very helpful information, and does seem to be a
> workaround.
> 
> Like you, I have my home directory on a separate NILFS2 filesystem. As
> a temporary solution, I removed the line from /etc/fstab for that
> filesystem and added your dd suggestion along with a manual mount of
> the home filesystem to /etc/rc.local.  /home is now mounted properly
> at boot with any of the newer kernels I tried.
> 
> Thanks,
> Tom
> 
> On 4/30/20 5:38 AM, Hideki EIRAKU wrote:
>>> In Msg <874kuapb2s.fsf@logand.com>;
>>>     Subject "Re: BUG: unable to handle kernel NULL pointer dereference at
>>>     00000000000000a8 in nilfs_segctor_do_construct":
>>>
>>>> Tomas Hlavaty <tom@logand.com> writes:
>>>>>>> 2) Can you mount the corrupted(?) partition from a recent version of
>>>>>>> kernel ?
>>>>
>>>> I tried the following Linux kernel versions:
>>>>
>>>> - v4.19
>>>> - v5.4
>>>> - v5.5.11
>>>>
>>>> and still get the crash
>> I found conditions to reproduce this issue with Linux 5.7-rc3:
>> - CONFIG_MEMCG=y *and* CONFIG_BLK_CGROUP=y
>> - When the NILFS2 file system writes to a device, the device file has
>>    never written by other programs since boot
>> The following is an example with CONFIG_MEMCG=y and
>> CONFIG_BLK_CGROUP=y kernel.  If you do mkfs and mount it, it works
>> because the mkfs command has written data to the device file before
>> mounting:
>> # mkfs -t nilfs2 /dev/sda1
>> mkfs.nilfs2 (nilfs-utils 2.2.7)
>> Start writing file system initial data to the device
>>         Blocksize:4096  Device:/dev/sda1  Device Size:267386880
>> File system initialization succeeded !!
>> # mount /dev/sda1 /mnt
>> # touch /mnt
>> # sync
>> #
>> Loopback mount seems to be the same - if you do losetup, mkfs and
>> mount on a loopback device, it works:
>> # losetup /dev/loop0 foo
>> # mkfs -t nilfs2 /dev/loop0
>> mkfs.nilfs2 (nilfs-utils 2.2.7)
>> Start writing file system initial data to the device
>>         Blocksize:4096  Device:/dev/loop0  Device Size:267386880
>> File system initialization succeeded !!
>> # mount /dev/sda1 /mnt
>> # touch /mnt
>> # sync
>> #
>> But if you do mkfs on a file and use mount -o loop, it may fail,
>> depending on whether the loopback device assigned by the mount command
>> was used or not before mounting:
>> # /sbin/mkfs.nilfs2 ./foo
>> mkfs.nilfs2 (nilfs-utils 2.2.7)
>> Start writing file system initial data to the device
>>         Blocksize:4096  Device:./foo  Device Size:268435456
>> File system initialization succeeded !!
>> # mount -o loop ./foo /mnt
>> [ 36.371331] NILFS (loop0): segctord starting. Construction interval =
>> 5 seconds, CP frequency < 30 seconds
>> # touch /mnt
>> # sync
>> [ 40.252869] BUG: kernel NULL pointer dereference, address:
>> 00000000000000a8
>> (snip)
>> After reboot, it fails:
>> # mount /dev/sda1 /mnt
>> [ 14.021188] NILFS (sda1): segctord starting. Construction interval =
>> 5 seconds, CP frequency < 30 seconds
>> # touch /mnt
>> # sync
>> [ 20.576309] BUG: kernel NULL pointer dereference, address:
>> 00000000000000a8
>> (snip)
>> But if you do dummy write to the device file before mounting, it
>> works:
>> # dd if=/dev/sda1 of=/dev/sda1 count=1
>> 1+0 records in
>> 1+0 records out
>> 512 bytes copied, 0.0135982 s, 37.7 kB/s
>> # mount /dev/sda1 /mnt
>> [   52.604560] NILFS (sda1): mounting unchecked fs
>> [   52.613335] NILFS (sda1): recovery complete
>> [ 52.613877] NILFS (sda1): segctord starting. Construction interval =
>> 5 seconds, CP frequency < 30 seconds
>> # touch /mnt
>> # sync
>> #
>> # losetup /dev/loop0 foo
>> # dd if=/dev/loop0 of=/dev/loop0 count=1
>> 1+0 records in
>> 1+0 records out
>> 512 bytes copied, 0.0243797 s, 21.0 kB/s
>> # mount /dev/loop0 /mnt
>> [  271.915595] NILFS (loop0): mounting unchecked fs
>> [  272.049603] NILFS (loop0): recovery complete
>> [ 272.049724] NILFS (loop0): segctord starting. Construction interval
>> = 5 seconds, CP frequency < 30 seconds
>> # touch /mnt
>> # sync
>> #
>> I think the dummy write is a simple workaround for now, unless
>> mounting NILFS2 at boot time.  But I have been using NILFS2 /home for
>> years, I would like to know better workarounds.
>> 
