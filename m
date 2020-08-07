Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC4BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E372075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHGAyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:54:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:22985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgHGAyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:54:46 -0400
IronPort-SDR: EaE+61rVBd/pImZ/W6zxmThbD2tFmeLqTj8s2VueLiphB3gKS+1vJCALGzuKpgGCf/99uw9osP
 5QIaF/Iv3qkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="214500151"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="214500151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 17:54:45 -0700
IronPort-SDR: YT8n0zM8vOxafprYi34N2KanBmdw/Y/hHUMnWg2wFm3IeaQ15CeCGF4tG/fF+roxVVjau0TtGL
 Gu5hp36txPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="275237844"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2020 17:54:43 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3qeh-0001ux-3d; Fri, 07 Aug 2020 00:54:43 +0000
Date:   Fri, 7 Aug 2020 08:53:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_bo0039.c:59:13: warning: Variable
 'page_count' is reassigned a value before the old one has been used.
Message-ID: <202008070848.smbIQF1R%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7b4ea9456dd3f73238408126ab00f1d906963d81
commit: 8b9d5d63a7193156b6b397c4f5078efbc200695f drm/nouveau/bo: split buffer move functions into their own source files
date:   2 weeks ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/nouveau/nouveau_bo0039.c:59:13: warning: Variable 'page_count' is reassigned a value before the old one has been used. [redundantAssignment]
    page_count = new_reg->num_pages;
               ^
   drivers/gpu/drm/nouveau/nouveau_bo0039.c:48:0: note: Variable 'page_count' is reassigned a value before the old one has been used.
    u32 page_count = new_reg->num_pages;
   ^
   drivers/gpu/drm/nouveau/nouveau_bo0039.c:59:13: note: Variable 'page_count' is reassigned a value before the old one has been used.
    page_count = new_reg->num_pages;
               ^
--
>> drivers/gpu/drm/nouveau/nouveau_bo85b5.c:47:13: warning: Variable 'page_count' is reassigned a value before the old one has been used. [redundantAssignment]
    page_count = new_reg->num_pages;
               ^
   drivers/gpu/drm/nouveau/nouveau_bo85b5.c:44:0: note: Variable 'page_count' is reassigned a value before the old one has been used.
    u32 page_count = new_reg->num_pages;
   ^
   drivers/gpu/drm/nouveau/nouveau_bo85b5.c:47:13: note: Variable 'page_count' is reassigned a value before the old one has been used.
    page_count = new_reg->num_pages;
               ^
>> drivers/gpu/drm/nouveau/nouveau_bo9039.c:43:13: warning: Variable 'page_count' is reassigned a value before the old one has been used. [redundantAssignment]
    page_count = new_reg->num_pages;
               ^
   drivers/gpu/drm/nouveau/nouveau_bo9039.c:40:0: note: Variable 'page_count' is reassigned a value before the old one has been used.
    u32 page_count = new_reg->num_pages;
   ^
   drivers/gpu/drm/nouveau/nouveau_bo9039.c:43:13: note: Variable 'page_count' is reassigned a value before the old one has been used.
    page_count = new_reg->num_pages;
               ^
>> drivers/gpu/drm/nouveau/nouveau_bo90b5.c:40:13: warning: Variable 'page_count' is reassigned a value before the old one has been used. [redundantAssignment]
    page_count = new_reg->num_pages;
               ^
   drivers/gpu/drm/nouveau/nouveau_bo90b5.c:37:0: note: Variable 'page_count' is reassigned a value before the old one has been used.
    u32 page_count = new_reg->num_pages;
   ^
   drivers/gpu/drm/nouveau/nouveau_bo90b5.c:40:13: note: Variable 'page_count' is reassigned a value before the old one has been used.
    page_count = new_reg->num_pages;
               ^

vim +/page_count +59 drivers/gpu/drm/nouveau/nouveau_bo0039.c

    41	
    42	int
    43	nv04_bo_move_m2mf(struct nouveau_channel *chan, struct ttm_buffer_object *bo,
    44			  struct ttm_mem_reg *old_reg, struct ttm_mem_reg *new_reg)
    45	{
    46		u32 src_offset = old_reg->start << PAGE_SHIFT;
    47		u32 dst_offset = new_reg->start << PAGE_SHIFT;
    48		u32 page_count = new_reg->num_pages;
    49		int ret;
    50	
    51		ret = RING_SPACE(chan, 3);
    52		if (ret)
    53			return ret;
    54	
    55		BEGIN_NV04(chan, NvSubCopy, NV_MEMORY_TO_MEMORY_FORMAT_DMA_SOURCE, 2);
    56		OUT_RING  (chan, nouveau_bo_mem_ctxdma(bo, chan, old_reg));
    57		OUT_RING  (chan, nouveau_bo_mem_ctxdma(bo, chan, new_reg));
    58	
  > 59		page_count = new_reg->num_pages;
    60		while (page_count) {
    61			int line_count = (page_count > 2047) ? 2047 : page_count;
    62	
    63			ret = RING_SPACE(chan, 11);
    64			if (ret)
    65				return ret;
    66	
    67			BEGIN_NV04(chan, NvSubCopy,
    68					 NV_MEMORY_TO_MEMORY_FORMAT_OFFSET_IN, 8);
    69			OUT_RING  (chan, src_offset);
    70			OUT_RING  (chan, dst_offset);
    71			OUT_RING  (chan, PAGE_SIZE); /* src_pitch */
    72			OUT_RING  (chan, PAGE_SIZE); /* dst_pitch */
    73			OUT_RING  (chan, PAGE_SIZE); /* line_length */
    74			OUT_RING  (chan, line_count);
    75			OUT_RING  (chan, 0x00000101);
    76			OUT_RING  (chan, 0x00000000);
    77			BEGIN_NV04(chan, NvSubCopy, NV_MEMORY_TO_MEMORY_FORMAT_NOP, 1);
    78			OUT_RING  (chan, 0);
    79	
    80			page_count -= line_count;
    81			src_offset += (PAGE_SIZE * line_count);
    82			dst_offset += (PAGE_SIZE * line_count);
    83		}
    84	
    85		return 0;
    86	}
    87	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
