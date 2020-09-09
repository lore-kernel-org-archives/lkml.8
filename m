Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD9C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230FF20C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670507;
	bh=Zd14/I/2HTfEZYw480nL528DP3panMs1d8VpIAskNf4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvh/i2dFQJPPBh+EWQUvk5H3zSdJWQFsLISi7CfSKWsJjvXvZ8TsU8aymUUu4s/Z2
	 r4gBHVp2A6gn2fjBxYM4VHaDruq3TSMZsAhkIE20EbC7pzrxY7DosAbvymxPnMKAE3
	 PA5QX+zRA57FrYjnyTLO/zjV04BIUgXbtrcD+jD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgIIQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgIIPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:55:49 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8C6221E5;
        Wed,  9 Sep 2020 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599663699;
        bh=Zd14/I/2HTfEZYw480nL528DP3panMs1d8VpIAskNf4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=scQYhzptbM8fkCaKMc9GGTiHm8uOVKCIPbA0hJG5LTe0LdWYicmdp0AW2wTBBKJbx
         qU8dvYWq/WaawRLp6J35iJqlnbUcAiQcolQxuNa8UlF21fTGEha+oLjLiNiG0NKqlj
         ahBQ01OvxrhTUL+RGNIHsGoWADIpt0d6J9zQ8Yhg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] extcon: ptn5150: Do not print error during probe if nothing is attached
Date:   Wed,  9 Sep 2020 17:01:29 +0200
Message-Id: <20200909150129.12476-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909150129.12476-1-krzk@kernel.org>
References: <20200909150129.12476-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit af71b7e384cd ("extcon: ptn5150: Check current USB mode when
probing") reused code for checking CC status register in the probe path
to determine what is initially connected.  However if nothing is
connected, the CC status register will have 0x0 value and print an error
message:

    ptn5150 1-003d: Unknown Port status : 0

This is not an error.  Also any other unknown port status values are not
really errors but unhandled cases.

Fixes: af71b7e384cd ("extcon: ptn5150: Check current USB mode when probing")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 1b68f56d8372..5b9a3cf8df26 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -97,7 +97,6 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, true);
 		break;
 	default:
-		dev_err(info->dev, "Unknown Port status : %x\n", port_status);
 		break;
 	}
 }
-- 
2.17.1

