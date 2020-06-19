Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82376C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6404120773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgFSCVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:21:12 -0400
Received: from mx.wingtech.com ([180.166.216.14]:58313 "EHLO mail.wingtech.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbgFSCVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:21:12 -0400
Received: from mx.wingtech.com ([192.168.2.43])
        by mail.wingtech.com  with SMTP id 05J2L8ju011296-05J2L8jv011296
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:21:08 +0800
Received: from 192.168.51.143 (HELO ZHAOWUYUN); Fri, 19 Jun 2020 10:21:05 +0800
From:   "Zac" <zhaowuyun@wingtech.com>
To:     "'Chao Yu'" <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Cc:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1592484487-12072-1-git-send-email-zhaowuyun@wingtech.com> <4a2d19c4-1ede-0172-fe50-c8464ee341df@huawei.com>
In-Reply-To: <4a2d19c4-1ede-0172-fe50-c8464ee341df@huawei.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBmMmZzLXRvb2xzOiBzZXQgY29sZCBmbGFnIA==?=
        =?gb2312?B?Zm9yIG5vbi1kaXIgbm9kZQ==?=
Date:   Fri, 19 Jun 2020 10:21:07 +0800
Message-ID: <000001d645e0$4aa645d0$dff2d170$@wingtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF0xRpWUfEou3rvdx9uok8+PtRkbQEd45q7qZlDPFA=
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2020/6/18 20:48, zhaowuyun@wingtech.com wrote:
> > From: Wuyun Zhao <zhaowuyun@wingtech.com>
> 
> Thanks for the patch. :)
> 
> Please add commit message here.

OK

> >
> > Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
> > ---
> >  fsck/dir.c  |  1 +
> >  fsck/node.c |  1 +
> >  fsck/node.h | 11 +++++++++++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/fsck/dir.c b/fsck/dir.c
> > index 5f4f75e..dc03c98 100644
> > --- a/fsck/dir.c
> > +++ b/fsck/dir.c
> > @@ -522,6 +522,7 @@ static void init_inode_block(struct f2fs_sb_info
> *sbi,
> >  	node_blk->footer.nid = cpu_to_le32(de->ino);
> >  	node_blk->footer.flag = 0;
> >  	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> > +	set_cold_node(node_blk, S_ISDIR(mode));
> >
> >  	if (S_ISDIR(mode)) {
> >  		make_empty_dir(sbi, node_blk);
> > diff --git a/fsck/node.c b/fsck/node.c
> > index 229a99c..1d291ca 100644
> > --- a/fsck/node.c
> > +++ b/fsck/node.c
> > @@ -79,6 +79,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
> >  	node_blk->footer.ino = f2fs_inode->footer.ino;
> >  	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
> >  	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> > +	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
> 
> How about wrapping these node footer fields assignment into a function?
> then
> we can reuse this in other places.
> 
> void set_node_footer(nid, ino, ofs, ver, is_dir)
> {
> 	node_blk->footer.nid = cpu_to_le32(nid);
> 	node_blk->footer.ino = f2fs_inode->footer.ino;
> 	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
> 	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
> 	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
> }

Ok, That's good.

> >
> >  	type = CURSEG_COLD_NODE;
> >  	if (IS_DNODE(node_blk)) {
> > diff --git a/fsck/node.h b/fsck/node.h
> > index 6bce1fb..99139b1 100644
> > --- a/fsck/node.h
> > +++ b/fsck/node.h
> > @@ -161,6 +161,17 @@ static inline int is_node(struct f2fs_node
> *node_blk, int type)
> >  	return le32_to_cpu(node_blk->footer.flag) & (1 << type);
> >  }
> 
> Beside this, I think we need to use set_node_footer() in:
> - f2fs_write_root_inode
> - f2fs_write_qf_inode
> - f2fs_write_lpf_inode
> 
> as well to fix mkfs bugs.

the root inode and the lpf inode is dir, need to set cold flag? 

> Thanks,
> 
> >
> > +static inline void set_cold_node(struct f2fs_node *rn, bool is_dir)
> > +{
> > +	unsigned int flag = le32_to_cpu(rn->footer.flag);
> > +
> > +	if (is_dir)
> > +		flag &= ~(0x1 << COLD_BIT_SHIFT);
> > +	else
> > +		flag |= (0x1 << COLD_BIT_SHIFT);
> > +	rn->footer.flag = cpu_to_le32(flag);
> > +}
> > +
> >  #define is_fsync_dnode(node_blk)	is_node(node_blk, FSYNC_BIT_SHIFT)
> >  #define is_dent_dnode(node_blk)		is_node(node_blk,
> DENT_BIT_SHIFT)
> >
> >

