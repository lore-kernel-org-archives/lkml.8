Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94204206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581181;
	bh=xwksin7kz1AKu1fmQXMrhEaDDAygzDT86oLp9iMnLtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RNKgvZ99LF7RdxEpylWbjXeJttP+9nwtRsi3giwXUeSv8DtBqwkSbOuRVGAWsLLDA
	 fbVSvS5yV/OQ/+StwTR892YJRmPYdFuqkk+O50EgsJH5o/oaQozvWI9P+iZKq+sCpk
	 XCQWXrp4ACB2FaQQYlP3meJYa9skGfz2L5XDDsPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393335AbgFSPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393674AbgFSP3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D8521941;
        Fri, 19 Jun 2020 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580544;
        bh=xwksin7kz1AKu1fmQXMrhEaDDAygzDT86oLp9iMnLtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrwAiAqf4IpIH/LVcvO3KLJO4HNpnNr6pmgz6WcxNLt3Nk8jt4AameNz4MZYeM7oO
         FKV6geR/UI7coEQdpIshbRxLYlNIexWikp47PCClynfNAmYJBRDm6GgpwXgo5kmVro
         5zXWAiPv9PCwt1qg4GnRG7TOT1mFC7rEKjm2Joyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 291/376] ima: Set again build_ima_appraise variable
Date:   Fri, 19 Jun 2020 16:33:29 +0200
Message-Id: <20200619141724.115890770@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

[ Upstream commit b59fda449cf07f2db3be3a67142e6c000f5e8d79 ]

After adding the new add_rule() function in commit c52657d93b05
("ima: refactor ima_init_policy()"), all appraisal flags are added to the
temp_ima_appraise variable. Revert to the previous behavior instead of
removing build_ima_appraise, to benefit from the protection offered by
__ro_after_init.

The mentioned commit introduced a bug, as it makes all the flags
modifiable, while build_ima_appraise flags can be protected with
__ro_after_init.

Cc: stable@vger.kernel.org # 5.0.x
Fixes: c52657d93b05 ("ima: refactor ima_init_policy()")
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_policy.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7414443c19bf..e493063a3c34 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -643,8 +643,14 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 
 			list_add_tail(&entry->list, &ima_policy_rules);
 		}
-		if (entries[i].action == APPRAISE)
-			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
+		if (entries[i].action == APPRAISE) {
+			if (entries != build_appraise_rules)
+				temp_ima_appraise |=
+					ima_appraise_flag(entries[i].func);
+			else
+				build_ima_appraise |=
+					ima_appraise_flag(entries[i].func);
+		}
 	}
 }
 
-- 
2.25.1



