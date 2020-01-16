Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E01C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E4120661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217931;
	bh=fsw8lL1IWuKn/0gDMrgvzCHQn0ImuNeGrwCeqmtVuMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/2s1VwLIlYYMVCxnvN/aO5mCECVHb9P4+DAjYEKYugDrhkw+Lpxlr11thzW4H8ii
	 aqoM5oaAsVY/9n4vxexhh94/KkG3szLAsFSd91tJUf5ibYnFHJ3HizqNVgDPTpTxex
	 8LZG0MK/tbBowZGYI+0k3dsxpZAWtOxDYSgkpUhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbgAPXiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388441AbgAPX3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:29:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F651206D9;
        Thu, 16 Jan 2020 23:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217340;
        bh=fsw8lL1IWuKn/0gDMrgvzCHQn0ImuNeGrwCeqmtVuMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkSP8SgmgGRzSSi+nyvnofnQA7TPY9AfkfJQnNAIokIujH9kEPOhzTR3w45vzSBVG
         aVp81uNPlz7DNMXS/zBeG/ZVNJ/7zixpja+T0Az0VS+0na21Hn+g3tafAN3IMgnfy7
         RqdHyngmB1N66sO3YaG+DSy/tTfkRf/bB2YOb4m4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 43/84] NFSv2: Fix a typo in encode_sattr()
Date:   Fri, 17 Jan 2020 00:18:17 +0100
Message-Id: <20200116231718.855004434@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit ad97a995d8edff820d4238bd0dfc69f440031ae6 upstream.

Encode the mtime correctly.

Fixes: 95582b0083883 ("vfs: change inode times to use struct timespec64")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs2xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -385,7 +385,7 @@ static void encode_sattr(struct xdr_stre
 	} else
 		p = xdr_time_not_set(p);
 	if (attr->ia_valid & ATTR_MTIME_SET) {
-		ts = timespec64_to_timespec(attr->ia_atime);
+		ts = timespec64_to_timespec(attr->ia_mtime);
 		xdr_encode_time(p, &ts);
 	} else if (attr->ia_valid & ATTR_MTIME) {
 		ts = timespec64_to_timespec(attr->ia_mtime);


