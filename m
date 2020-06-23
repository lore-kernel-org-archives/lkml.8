Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C020702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944354;
	bh=UspmksUqoXOIL+nAPinhkqVy33/sWDzn1uG6kgBkli4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRs9ici42lWsIjh4TvcvPoSTmE9ixe9VQVk4oen+rJr59KJmtu8uAfk9G2zEjODyt
	 /NhMUiUiHDB0g0i2nv4BK1VxaRPqDD/Kr+6G1sDDiuk2EzUYJmFzvjkAWUKCw67Tsm
	 rmctRp4C4WQ1Dz2YQAgK4JusKD6EhfTqcVzerruk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391326AbgFWUcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391304AbgFWUcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:32:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97277206C3;
        Tue, 23 Jun 2020 20:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944343;
        bh=UspmksUqoXOIL+nAPinhkqVy33/sWDzn1uG6kgBkli4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrO8eEZ1XyMxBCiGB01DdZDrky5QelEHyjhnqinuqoUiLlOj9CUNbEC5ybh88uY7E
         AHJiO4vF6bt6ouIg48b4JYHk/fggHm7hAyaBqmwUcoKvr5WsOKlbQUVUQ8nC32S0N+
         1KvYlgHJZ9buFBtdVxw/pgVG1UjBXCFRMm9yc8e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 237/314] NTB: ntb_test: Fix bug when counting remote files
Date:   Tue, 23 Jun 2020 21:57:12 +0200
Message-Id: <20200623195350.264387393@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 9c60337317c60..020137b614079 100755
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



