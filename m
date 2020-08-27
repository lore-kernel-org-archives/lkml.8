Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E36F2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598552438;
	bh=JhM6FPCbA4g1z4X4hZMMnSc4eTsjqr+y2d9PBalJfoE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BeqUwU6d1vw2ai7iN35IcYWj5XgyppJD1JZMV5BdkkDr67/2HZOH8qaT/Q4q9oNMX
	 b36aNkoMpmJYUMpAcRomet61/IOoiKsf3beN/i7vsXMUllUklvGAsOR+kMQJbMfIjI
	 HMsIb9735CFfMvvh+cW0Fb9INJrawme4gHskmqTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgH0SUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgH0SUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:20:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406372087C;
        Thu, 27 Aug 2020 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598552435;
        bh=JhM6FPCbA4g1z4X4hZMMnSc4eTsjqr+y2d9PBalJfoE=;
        h=From:To:Cc:Subject:Date:From;
        b=GHiQMeaIk65r2UV1/jqLWfcHN5K9tNcqt6fAMkuc9mFSQl+EGf4OFMw3jAVFMN3SG
         PgVJXu0JZnQWMMJqw8v3gG3uiKGm9V/aSMoGc4FcdEiSe3cupExXE6OtX8ewMYIdPf
         Nelj9ozSWjzGKjfjtlHpKgOG1epskzT92/jwKXN4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Security Officers <security@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] MAINTAINERS: Add the security document to SECURITY CONTACT
Date:   Thu, 27 Aug 2020 20:20:29 +0200
Message-Id: <20200827182029.3458-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing the document related to kernel security workflow, notify
the security mailing list as its concerned by this.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <security@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Changed order - F: go to end of entry,
2. Remove embargoed-hardware-issues
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8107b3d5d6df..19064a4ae9b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15621,6 +15621,7 @@ F:	include/uapi/linux/sed*
 SECURITY CONTACT
 M:	Security Officers <security@kernel.org>
 S:	Supported
+F:	Documentation/admin-guide/security-bugs.rst
 
 SECURITY SUBSYSTEM
 M:	James Morris <jmorris@namei.org>
-- 
2.17.1

