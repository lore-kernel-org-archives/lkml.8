Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9940BC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C6B222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="ZJ4W3Xco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgBYMIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:08:17 -0500
Received: from vps.xff.cz ([195.181.215.36]:44954 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbgBYMIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1582632494; bh=aFCyi3mPQcM8lA4HBXgAPMKi4L5mrY+6Az98qx6fEfc=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=ZJ4W3Xcorqp3xobCQUxe72FPFduLW1+KMHQDGLHfKpwtg9MxRuKebkGO6HXVGbw7c
         5BPa4nfebHcKCv/jSPRWkKX4zm9BzD0zSzbu4nG14vPcC+CHveE4NKEAzahoUZkuRo
         7o96RtDT1r3+XJNwBIgRbHZ3pvZ33hM43mXsm+Os=
Date:   Tue, 25 Feb 2020 13:08:14 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
Message-ID: <20200225120814.gjm4dby24cs22lux@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20200222044617.pfrhnz2iavkrtdn6@core.my.home>
 <20200222181721.tzrrohep5l3yklpf@core.my.home>
 <bec3798b-f861-b132-9138-221027bb5195@huawei.com>
 <b1eb9b22-b570-41ab-5177-2c89105428a2@huawei.com>
 <20200224135837.k54ke4ppca26ibec@core.my.home>
 <20200224140349.74yagjdwewmclx4v@core.my.home>
 <20200224143149.au6hvmmfw4ajsq2g@core.my.home>
 <39712bf4-210b-d7b6-cbb1-eb57585d991a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39712bf4-210b-d7b6-cbb1-eb57585d991a@huawei.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 25, 2020 at 07:24:12PM +0800, Chao Yu wrote:
> On 2020/2/24 22:31, Ondřej Jirman wrote:
> >> Just by a looks of it:
> >>
> >> root@tbs2[/proc/sys/kernel] # dmesg | grep up_write | wc -l
> >> 324
> >> root@tbs2[/proc/sys/kernel] # dmesg | grep down_write | wc -l
> >> 347
> >>
> >> there seems to be a mismatch of lock/unlock counts.
> >  
> > Sorry, a wrong grep expression.
> > 
> > root@tbs2[~] # dmesg | grep inode_down_write | wc -l
> > 357
> > root@tbs2[~] # dmesg | grep inode_up_write | wc -l
> > 357
> > root@tbs2[~] # dmesg | grep inode_up_read | wc -l
> > 16
> > root@tbs2[~] # dmesg | grep inode_down_read | wc -l
> > 16
> 
> I don't know why we have consistent down/up pair, but through disassembled
> code, I doubt it's the f2fs_inode->i_sem.

Because we were counting attempts, and not a successful lock. ;)

> c0435d7c:       ebf54af8        bl      c0188964 <printk>
> c0435d80:       e1a00006        mov     r0, r6
> c0435d84:       eb138135        bl      c0916260 <down_write>
> 
> inode_down_write()
> 
> c0435d88:       e284ce1d        add     ip, r4, #464    ; 0x1d0
> 
> We are stuck here.
> 
> [  430.675754] [<c0916260>] (down_write) from [<c0435d88>] (f2fs_write_single_data_page+0x600/0x7d8)
>                                                 ^^^^^^^^^
> [  430.675764] [<c0435788>] (f2fs_write_single_data_page) from [<c0436214>] (f2fs_write_cache_pages+0x2b4/0x7c4)
> 
> 
> c0435d8c:       e14b0ad4        ldrd    r0, [fp, #-164] ; 0xffffff5c
> c0435d90:       e1cc20d0        ldrd    r2, [ip]
> c0435d94:       e1520000        cmp     r2, r0
> c0435d98:       e0d33001        sbcs    r3, r3, r1
> c0435d9c:       b1cc00f0        strdlt  r0, [ip]
> c0435da0:       e1a00006        mov     r0, r6
> c0435da4:       ebf52227        bl      c017e648 <up_write>
> c0435da8:       e51b2098        ldr     r2, [fp, #-152] ; 0xffffff68
> c0435dac:       e30c0730        movw    r0, #50992      ; 0xc730
> c0435db0:       e59f11a4        ldr     r1, [pc, #420]  ; c0435f5c <f2fs_write_single_data_page+0x7d4>
> c0435db4:       e34c00b6        movt    r0, #49334      ; 0xc0b6
> c0435db8:       ebf54ae9        bl      c0188964 <printk>
> 
> inode_up_write()

The patch you sent helped so far. I'll keep the tablet running for a while,
but so far the issue did not reappear within a few minutes after boot as
usual.

thank you and regards,
	o.

> Thanks,
> 
> > 
> > So it's probably not inode locking.
> > 
> >> root@tbs2[/proc/sys/kernel] # dmesg | grep down_read | wc -l
> >> 16
> >> root@tbs2[/proc/sys/kernel] # dmesg | grep up_read | wc -l
> >> 16
> >>
> >> regards,
> >> 	o.
> >>
> >>> thank you,
> >>> 	o.
> >>>
> >>>>> Thanks,
> >>>>>
> >>>>>> [  246.758190]  r5:eff213b0 r4:da283c60
> >>>>>> [  246.758198] [<c0435578>] (f2fs_write_single_data_page) from [<c0435fd8>] (f2fs_write_cache_pages+0x2b4/0x7c4)
> >>>>>> [  246.758204]  r10:da645c28 r9:da283d60 r8:da283c60 r7:0000000f r6:da645d80 r5:00000001
> >>>>>> [  246.758206]  r4:eff213b0
> >>>>>> [  246.758214] [<c0435d24>] (f2fs_write_cache_pages) from [<c043682c>] (f2fs_write_data_pages+0x344/0x35c)
> >>>>>> [  246.758220]  r10:00000000 r9:d9ed002c r8:d9ed0000 r7:00000004 r6:da283d60 r5:da283c60
> >>>>>> [  246.758223]  r4:da645d80
> >>>>>> [  246.758238] [<c04364e8>] (f2fs_write_data_pages) from [<c0267ee8>] (do_writepages+0x3c/0xd4)
> >>>>>> [  246.758244]  r10:0000000a r9:c0e03d00 r8:00000c00 r7:c0264ddc r6:da645d80 r5:da283d60
> >>>>>> [  246.758246]  r4:da283c60
> >>>>>> [  246.758254] [<c0267eac>] (do_writepages) from [<c0310cbc>] (__writeback_single_inode+0x44/0x454)
> >>>>>> [  246.758259]  r7:da283d60 r6:da645eac r5:da645d80 r4:da283c60
> >>>>>> [  246.758266] [<c0310c78>] (__writeback_single_inode) from [<c03112d0>] (writeback_sb_inodes+0x204/0x4b0)
> >>>>>> [  246.758272]  r10:0000000a r9:c0e03d00 r8:da283cc8 r7:da283c60 r6:da645eac r5:da283d08
> >>>>>> [  246.758274]  r4:d9dc9848
> >>>>>> [  246.758281] [<c03110cc>] (writeback_sb_inodes) from [<c03115cc>] (__writeback_inodes_wb+0x50/0xe4)
> >>>>>> [  246.758287]  r10:da3797a8 r9:c0e03d00 r8:d9dc985c r7:da645eac r6:00000000 r5:d9dc9848
> >>>>>> [  246.758289]  r4:da5a8800
> >>>>>> [  246.758296] [<c031157c>] (__writeback_inodes_wb) from [<c03118f4>] (wb_writeback+0x294/0x338)
> >>>>>> [  246.758302]  r10:fffbf200 r9:da644000 r8:c0e04e64 r7:d9dc9848 r6:d9dc9874 r5:da645eac
> >>>>>> [  246.758305]  r4:d9dc9848
> >>>>>> [  246.758312] [<c0311660>] (wb_writeback) from [<c0312dac>] (wb_workfn+0x35c/0x54c)
> >>>>>> [  246.758318]  r10:da5f2005 r9:d9dc984c r8:d9dc9948 r7:d9dc9848 r6:00000000 r5:d9dc9954
> >>>>>> [  246.758321]  r4:000031e6
> >>>>>> [  246.758334] [<c0312a50>] (wb_workfn) from [<c014f2b8>] (process_one_work+0x214/0x544)
> >>>>>> [  246.758340]  r10:da5f2005 r9:00000200 r8:00000000 r7:da5f2000 r6:ef044400 r5:da5eb000
> >>>>>> [  246.758343]  r4:d9dc9954
> >>>>>> [  246.758350] [<c014f0a4>] (process_one_work) from [<c014f634>] (worker_thread+0x4c/0x574)
> >>>>>> [  246.758357]  r10:ef044400 r9:c0e03d00 r8:ef044418 r7:00000088 r6:ef044400 r5:da5eb014
> >>>>>> [  246.758359]  r4:da5eb000
> >>>>>> [  246.758368] [<c014f5e8>] (worker_thread) from [<c01564fc>] (kthread+0x144/0x170)
> >>>>>> [  246.758374]  r10:ec9e5e90 r9:dabf325c r8:da5eb000 r7:da644000 r6:00000000 r5:da5fe000
> >>>>>> [  246.758377]  r4:dabf3240
> >>>>>> [  246.758386] [<c01563b8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> >>>>>> [  246.758391] Exception stack(0xda645fb0 to 0xda645ff8)
> >>>>>> [  246.758397] 5fa0:                                     00000000 00000000 00000000 00000000
> >>>>>> [  246.758402] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> >>>>>> [  246.758407] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> >>>>>> [  246.758413]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01563b8
> >>>>>> [  246.758416]  r4:da5fe000
> >>>>>> .
> >>>>>>
> >>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> Linux-f2fs-devel mailing list
> >>>>> Linux-f2fs-devel@lists.sourceforge.net
> >>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>>>>
> > .
> > 
