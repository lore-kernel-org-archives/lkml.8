Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95C120789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="viEDkJie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHRJz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:55:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20937 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgHRJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:55:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597744557; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=bLs033Cf2/mJGpTvLPVlFB0f5XmNRv8j2fi6jDDqEvQ=; b=viEDkJieACeljqyPaO1yhxeN0lT4Ta4pHsSd0J7SmgejHdc8PIro3rXCUOQ65j9TsLHClYfY
 VXAHrfUKlAKl3Kjn34o67dXBR0WwaQGXODVNnnjvZKkw96uHXty8aktO3ZyfzjtsbHltlXT/
 uY/702GA54AOxl7yapBUHQ6JK3Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f3ba5a91e4d3989d41c8e04 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:55:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8352C4339C; Tue, 18 Aug 2020 09:55:53 +0000 (UTC)
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22F6DC433C6;
        Tue, 18 Aug 2020 09:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22F6DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 18 Aug 2020 15:25:47 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: fix indefinite loop scanning for free nid
Message-ID: <20200818095547.GA5062@codeaurora.org>
References: <1597392335-4998-1-git-send-email-stummala@codeaurora.org>
 <e1251327-bd48-215d-e558-08780474bddb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1251327-bd48-215d-e558-08780474bddb@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:29:05PM +0800, Chao Yu wrote:
> On 2020/8/14 16:05, Sahitya Tummala wrote:
> >If the sbi->ckpt->next_free_nid is not NAT block aligned and if there
> >are free nids in that NAT block between the start of the block and
> >next_free_nid, then those free nids will not be scanned in scan_nat_page().
> >This results into mismatch between nm_i->available_nids and the sum of
> >nm_i->free_nid_count of all NAT blocks scanned. And nm_i->available_nids
> >will always be greater than the sum of free nids in all the blocks.
> >Under this condition, if we use all the currently scanned free nids,
> >then it will loop forever in f2fs_alloc_nid() as nm_i->available_nids
> >is still not zero but nm_i->free_nid_count of that partially scanned
> >NAT block is zero.
> >
> >Fix this to align the nm_i->next_scan_nid to the first nid of the
> >corresponding NAT block.
> >
> >Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >---
> >  fs/f2fs/node.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> >diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >index 9bbaa26..d615e59 100644
> >--- a/fs/f2fs/node.c
> >+++ b/fs/f2fs/node.c
> >@@ -2402,6 +2402,8 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
> >  			if (IS_ERR(page)) {
> >  				ret = PTR_ERR(page);
> >  			} else {
> >+				if (nid % NAT_ENTRY_PER_BLOCK)
> >+					nid = NAT_BLOCK_OFFSET(nid) * NAT_ENTRY_PER_BLOCK;
> 
> How about moving this logic to the beginning of __f2fs_build_free_nids(),
> after nid reset?
> 

Sure, I will move it.

> BTW, it looks we can add unlikely in this judgment condition?

But it may not be an unlikely as it can happen whenever checkpoint is done,
based on the next available free nid in function next_free_nid(), which can happen
quite a few times, right?

Hitting the loop forever issue condition due to this could be a rare/difficult to
reproduce but this check itself may not be unlikely in my opinion.

Thanks,

> 
> Thanks,
> 
> >  				ret = scan_nat_page(sbi, page, nid);
> >  				f2fs_put_page(page, 1);
> >  			}
> >

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
