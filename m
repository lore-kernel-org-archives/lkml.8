Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD1F2220B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445753;
	bh=0hZx3zP10Ds1j10gCx37S3rT5JDXBnvUZQIeZ4Q/Jbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hm1mdlssXiu0h018M0uL7ASK8YyrZ1WpSygXLDHNdt4l3/TdD0LeVmzGOCvWCIRoZ
	 LaeaindOQAIDW1A6pVWhbJmXX4CcYheiIjESbgw9ZQqFji/Md94dW+wWCyG77p+2VZ
	 oTs699JNH1ZPlvzn+KrDQltvN7+CprL3qtXkAumo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgFRBXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbgFRBUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BECDD21974;
        Thu, 18 Jun 2020 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443230;
        bh=0hZx3zP10Ds1j10gCx37S3rT5JDXBnvUZQIeZ4Q/Jbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6An+V2WzScB8tRPFKpyL8841YglJoYFv07iMRt4Ho5axJ2or6Nr/eKS+riiYayCG
         cXsuL9Oeos9TF8rzG0Rf95DvL3bEDTr23Y3ziOx7taUD3a/YlYAD2xxxUfHMrC3Sns
         MudC5JloeVVOApqPqa2DrFriKnt60KCoCSIhW8bQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 183/266] scripts: headers_install: Exit with error on config leak
Date:   Wed, 17 Jun 2020 21:15:08 -0400
Message-Id: <20200618011631.604574-183-sashal@kernel.org>
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

From: Siddharth Gupta <sidgup@codeaurora.org>

[ Upstream commit 5967577231f9b19acd5a59485e9075964065bbe3 ]

Misuse of CONFIG_* in UAPI headers should result in an error. These config
options can be set in userspace by the user application which includes
these headers to control the APIs and structures being used in a kernel
which supports multiple targets.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/headers_install.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a5c36b..94a833597a88 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -64,7 +64,7 @@ configs=$(sed -e '
 	d
 ' $OUTFILE)
 
-# The entries in the following list are not warned.
+# The entries in the following list do not result in an error.
 # Please do not add a new entry. This list is only for existing ones.
 # The list will be reduced gradually, and deleted eventually. (hopefully)
 #
@@ -98,18 +98,19 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
 
 for c in $configs
 do
-	warn=1
+	leak_error=1
 
 	for ignore in $config_leak_ignores
 	do
 		if echo "$INFILE:$c" | grep -q "$ignore$"; then
-			warn=
+			leak_error=
 			break
 		fi
 	done
 
-	if [ "$warn" = 1 ]; then
-		echo "warning: $INFILE: leak $c to user-space" >&2
+	if [ "$leak_error" = 1 ]; then
+		echo "error: $INFILE: leak $c to user-space" >&2
+		exit 1
 	fi
 done
 
-- 
2.25.1

