Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D378C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F92076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047099;
	bh=RAAVtbakcAiahy+srrCgOfI7f6eW0fuhrsak6cFZoZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b7d37/PF+LggCtRipIYqONBEfIWzrZsrPfrxgndZLtckl++naOFHiSRZJOQIchQxA
	 tS79Cuu0OBYdXP32c3/hizvGhyq+KohLq1TCaTOjHRi6Qp/WB3KAxRWGyNSXNSjy/i
	 CxlnM1CrP7bL0EESsS4SmMGUC3ZmKxZb7g+DaW68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409957AbgDPOY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506757AbgDPN5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:57:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B242076D;
        Thu, 16 Apr 2020 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045461;
        bh=RAAVtbakcAiahy+srrCgOfI7f6eW0fuhrsak6cFZoZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcdZFdnnqENohOVUoR0lUUxobGcGkVwHb824io/gRweWdvI3cYsempY0JcZlfbDt0
         2yhjwMkKEVMDK9m3o+eRNwWqEeRA7Vmmz12JSypaSrQaEoziMeT1PKpOLZM1rlYZDK
         BfAc1aSiLLp43tdBjAsQk7wt4wcThP68eAnPHI0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 5.6 104/254] erofs: correct the remaining shrink objects
Date:   Thu, 16 Apr 2020 15:23:13 +0200
Message-Id: <20200416131339.094965325@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

commit 9d5a09c6f3b5fb85af20e3a34827b5d27d152b34 upstream.

The remaining count should not include successful
shrink attempts.

Fixes: e7e9a307be9d ("staging: erofs: introduce workstation for decompression")
Cc: <stable@vger.kernel.org> # 4.19+
Link: https://lore.kernel.org/r/20200226081008.86348-1-gaoxiang25@huawei.com
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/erofs/utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -286,7 +286,7 @@ static unsigned long erofs_shrink_scan(s
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
 
-		freed += erofs_shrink_workstation(sbi, nr);
+		freed += erofs_shrink_workstation(sbi, nr - freed);
 
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */


