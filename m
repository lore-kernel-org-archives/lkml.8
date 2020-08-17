Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D114C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3A02311E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678394;
	bh=byHwtIwlZgL0WdEMuf+rCeZTZK2eJE6pssQD0B2LeE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QelWxdNTSQk2EvBjrp56VFj0VGSqE+9EH9hzL0o8RGBxry2aVrqmrIoS9CPxI2d5k
	 T78N+CWOke25QwU6Inayw26+1iN2lcGUjzMRPQE5sFMMCXqOU8Zd9VB3NrODbadFv7
	 XefpE+xXomfT8nJR+d/Wpxslj3DrYjA5IZEonYnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgHQPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbgHQP3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:29:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8548D23C32;
        Mon, 17 Aug 2020 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678177;
        bh=byHwtIwlZgL0WdEMuf+rCeZTZK2eJE6pssQD0B2LeE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3I6CmBDJ3l4L4NjNHEEWxCOvCBldf9PcktTOmNzoR7RxE7vKTtsTcR8xawnXgsnN
         VpBSf9zrdkhPo1Zfvg6sbacezUKTbskDMGj8KannDjWWE8eW8RBn0zkJGdEy7gGFU5
         E2fuxJ8CrqykRD74n3XWb5dIIbvq3CODuvQ0kjjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 244/464] ima: Fail rule parsing when the KEY_CHECK hook is combined with an invalid cond
Date:   Mon, 17 Aug 2020 17:13:17 +0200
Message-Id: <20200817143845.485575843@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@linux.microsoft.com>

[ Upstream commit eb624fe214a2e156ddafd9868377cf91499f789d ]

The KEY_CHECK function only supports the uid, pcr, and keyrings
conditionals. Make this clear at policy load so that IMA policy authors
don't assume that other conditionals are supported.

Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_policy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a77e0b34e72f7..3e3e568c81309 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1023,6 +1023,13 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
 
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+				     IMA_KEYRINGS))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
-- 
2.25.1



