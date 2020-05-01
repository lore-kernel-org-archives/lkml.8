Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A208DC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B72495F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="puZHq1iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgEAVzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:55:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58310 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgEAVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:54:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588370099; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AQ70akaLPnIqMlM4CmJJfg3Ty/uXQB6hVv/IyZfwri4=; b=puZHq1iHgFyM/8BXyXTTlRnFLtvdplFxBhrcg/86dNIwFKeBIcKo6+idq8aAPjKq/D3V77mE
 CLqVS7vzfKomiWkXAA7qnR1BXaZeyawb64SX3ZaqEsBfvY/7Nvx8UexKgH7qGrzCCR9C31Jl
 oXeFERr/w8dEwIlXDIEufYOM3MY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eac9a9d.7f3115b200a0-smtp-out-n01;
 Fri, 01 May 2020 21:54:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39FE3C43637; Fri,  1 May 2020 21:54:37 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86360C433F2;
        Fri,  1 May 2020 21:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86360C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: headers_install: Exit with error on config leak
Date:   Fri,  1 May 2020 14:54:25 -0700
Message-Id: <1588370065-30312-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misuse of CONFIG_* in UAPI headers should result in an error as it exposes
configuration of different targets to userspace.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 scripts/headers_install.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a..bd6c93a 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -109,7 +109,8 @@ do
 	done
 
 	if [ "$warn" = 1 ]; then
-		echo "warning: $INFILE: leak $c to user-space" >&2
+		echo "error: $INFILE: leak $c to user-space" >&2
+		exit 1
 	fi
 done
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
