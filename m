Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C6C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FBF22522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579124312;
	bh=cE+xij9LfRwsxyi5KbsdsITMdSbn4+7niQZVZvT3/rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SuVYUAddmYMeiM5gi1IYx0fBl00ubQd9UXV+oV7kqqgaEVtdZN0G86IypG9HcH5Ia
	 wJ+U3eos0VutsFw10Dmz0+AjERuGIBt1KQH7PbjMJ/sA5hFtI5kGw8TpJMUHymIhSw
	 a2mFeCR4u7x1o/IDKPkPedDwoiV6O7N/+1yQT874=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgAOVia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgAOVia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:38:30 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F00222C3;
        Wed, 15 Jan 2020 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579124309;
        bh=cE+xij9LfRwsxyi5KbsdsITMdSbn4+7niQZVZvT3/rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjaFD3REDaQ4JfKXUuA/X1xYF/0xuzV7ZCDHALOjqkhGrcnFKP9Ksq7WdTmCMrxU/
         uiJhD9bWI+1KyuuYuWprDSPiBEyQTUSyP78eE7+po30eam27LfOYlisCTJBKFEIYvB
         El25Z/jPHdYyNslEatfNrUrrpBG9KhflhSRHW6k0=
Date:   Wed, 15 Jan 2020 13:38:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
Message-ID: <20200115213828.GA57854@jaegeuk-macbookpro.roam.corp.google.com>
References: <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
 <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
 <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
 <3776cb0b-4b18-ae0d-16a7-a591bec77a5e@huawei.com>
 <20200111180200.GA36424@jaegeuk-macbookpro.roam.corp.google.com>
 <72418aa5-7d2a-de26-f0b5-9c839f0c3404@huawei.com>
 <20200113161120.GA49290@jaegeuk-macbookpro.roam.corp.google.com>
 <326f0049-936c-7dc4-52c3-aa64e13b2cc6@huawei.com>
 <20200114224837.GB19274@jaegeuk-macbookpro.roam.corp.google.com>
 <d68d27d3-2501-2641-d929-6293dfe683b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68d27d3-2501-2641-d929-6293dfe683b0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15, Chao Yu wrote:
> On 2020/1/15 6:48, Jaegeuk Kim wrote:
> > On 01/14, Chao Yu wrote:
> >> On 2020/1/14 0:11, Jaegeuk Kim wrote:
> >>> On 01/13, Chao Yu wrote:
> >>>> On 2020/1/12 2:02, Jaegeuk Kim wrote:
> >>>>> On 01/11, Chao Yu wrote:
> >>>>>> On 2020/1/11 7:52, Jaegeuk Kim wrote:
> >>>>>>> On 01/06, Jaegeuk Kim wrote:
> >>>>>>>> On 01/06, Chao Yu wrote:
> >>>>>>>>> On 2020/1/3 14:50, Chao Yu wrote:
> >>>>>>>>>> This works to me. Could you run fsstress tests on compressed root directory?
> >>>>>>>>>> It seems still there are some bugs.
> >>>>>>>>>
> >>>>>>>>> Jaegeuk,
> >>>>>>>>>
> >>>>>>>>> Did you mean running por_fsstress testcase?
> >>>>>>>>>
> >>>>>>>>> Now, at least I didn't hit any problem for normal fsstress case.
> >>>>>>>>
> >>>>>>>> Yup. por_fsstress
> >>>>>>>
> >>>>>>> Please check https://github.com/jaegeuk/f2fs/commits/g-dev-test.
> >>>>>>> I've fixed
> >>>>>>> - truncation offset
> >>>>>>> - i_compressed_blocks and its lock coverage
> >>>>>>> - error handling
> >>>>>>> - etc
> >>>>>>
> >>>>>> I changed as below, and por_fsstress stops panic the system.
> >>>>>>
> >>>>>> Could you merge all these fixes into original patch?
> >>>>>
> >>>>> Yup, let m roll up some early patches first once test results become good.
> >>>>
> >>>> I didn't encounter issue any more, how about por_fsstress test result in your
> >>>> enviornment? If there is, please share the call stack with me.
> >>>
> >>> Sure, will do, once I hit an issue. BTW, I'm hitting another unreacheable nat
> >>> entry issue during por_stress without compression. :(
> >>
> >> Did you enable any features during por_fsstress test?
> >>
> >> I only hit below warning during por_fsstress test on image w/o compression.
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 10 PID: 33483 at fs/fs-writeback.c:1448 __writeback_single_inode+0x28c/0x340
> >> Call Trace:
> >>  writeback_single_inode+0xad/0x120
> >>  sync_inode_metadata+0x3d/0x60
> >>  f2fs_sync_inode_meta+0x90/0xe0 [f2fs]
> >>  block_operations+0x17c/0x360 [f2fs]
> >>  f2fs_write_checkpoint+0x101/0xff0 [f2fs]
> >>  f2fs_sync_fs+0xa8/0x130 [f2fs]
> >>  f2fs_do_sync_file+0x19c/0x880 [f2fs]
> >>  do_fsync+0x38/0x60
> >>  __x64_sys_fsync+0x10/0x20
> >>  do_syscall_64+0x5f/0x220
> >>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Does gc_mutex patch fix this?
> 
> No, gc_mutex patch fixes another problem.
> 
> BTW, it looks like a bug of VFS.

One fix below and rerun tests now.

---
 fs/f2fs/compress.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2480bff1e115..45a6f20ceb3e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -556,10 +556,8 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 
 			blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node + i);
-			if (blkaddr != NULL_ADDR) {
+			if (blkaddr != NULL_ADDR)
 				ret++;
-				break;
-			}
 		}
 	}
 fail:
@@ -955,10 +953,14 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 					enum iostat_type io_type)
 {
 	struct address_space *mapping = cc->inode->i_mapping;
-	int i, _submitted, compr_blocks, ret;
-	int err = 0;
+	int _submitted, compr_blocks, ret;
+	int i = -1, err = 0;
 
 	compr_blocks = f2fs_compressed_blocks(cc);
+	if (compr_blocks < 0) {
+		err = compr_blocks;
+		goto out_err;
+	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
@@ -997,7 +999,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 out_fail:
 	/* TODO: revoke partially updated block addresses */
 	BUG_ON(compr_blocks);
-
+out_err:
 	for (++i; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1020,9 +1022,9 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	*submitted = 0;
 	if (cluster_may_compress(cc)) {
 		err = f2fs_compress_pages(cc);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN) {
 			goto write;
-		else if (err) {
+		} else if (err) {
 			f2fs_put_rpages_wbc(cc, wbc, true, 1);
 			goto destroy_out;
 		}
-- 
2.24.0.525.g8f36a354ae-goog

