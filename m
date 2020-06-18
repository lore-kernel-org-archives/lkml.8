Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B69C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161AF20853
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446244;
	bh=KCnVK+gaeeikLm3JJfgKmPmF/BQMXdMBHmPPaLyIHyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wnhNksTUVHsE0im9/rnv5hBz62FJipIwibAlcHSOUBhytw1QN6TNkdOmB12OUpGz6
	 wMN973XuMc9b6+seSelsw94xQOihH0b8oOnboJL7sCGghhPKGElr764KT3aLosM0aW
	 TEdR9qpFUT7LGUqv5TYvcJAVz7yfXNIAbZCB6KCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgFRCKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgFRBVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654E820FC3;
        Thu, 18 Jun 2020 01:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443306;
        bh=KCnVK+gaeeikLm3JJfgKmPmF/BQMXdMBHmPPaLyIHyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4jWxLmQsnfnPX2hZlzry4J5sPFo/n3MkonqemqV4kSGO1ZXOUq7FMH7siNZ5Dm3l
         b/z1AphlCjOQHk0ZGGPKm2AUBpkfNfGDtWt3Gta15mWyeTrtNGee4Wal6vZmYkbKPD
         NxR4gn7f4OYYU1wMy4EdVlopO30WnaIUAqVQqO4s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 244/266] NTB: ntb_test: Fix bug when counting remote files
Date:   Wed, 17 Jun 2020 21:16:09 -0400
Message-Id: <20200618011631.604574-244-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 2130c0ba69d69bb21f5c52787f2587db00d13d8a ]

When remote files are counted in get_files_count, without using SSH,
the code returns 0 because there is a colon prepended to $LOC. $VPATH
should have been used instead of $LOC.

Fixes: 06bd0407d06c ("NTB: ntb_test: Update ntb_tool Scratchpad tests")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <allenbh@gmail.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ntb/ntb_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 9c60337317c6..020137b61407 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -241,7 +241,7 @@ function get_files_count()
 	split_remote $LOC
 
 	if [[ "$REMOTE" == "" ]]; then
-		echo $(ls -1 "$LOC"/${NAME}* 2>/dev/null | wc -l)
+		echo $(ls -1 "$VPATH"/${NAME}* 2>/dev/null | wc -l)
 	else
 		echo $(ssh "$REMOTE" "ls -1 \"$VPATH\"/${NAME}* | \
 		       wc -l" 2> /dev/null)
-- 
2.25.1

