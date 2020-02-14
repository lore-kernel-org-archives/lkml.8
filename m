Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60B5C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EAE222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBNGaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:30:16 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:54036 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgBNGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:30:15 -0500
Received: from localhost.localdomain ([93.22.37.15])
        by mwinf5d17 with ME
        id 2WWB220080KcLDH03WWBpd; Fri, 14 Feb 2020 07:30:13 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 14 Feb 2020 07:30:13 +0100
X-ME-IP: 93.22.37.15
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ACPICA: Fix a typo in acuuid.h
Date:   Fri, 14 Feb 2020 07:30:03 +0100
Message-Id: <20200214063003.29741-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment related to the ending of the include guard should be related to
__ACUUID_H__, not __AUUID_H__ (i.e. 'C' is missing).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/acpi/acuuid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 9dd4689a39cf..9e1367b19069 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -57,4 +57,4 @@
 #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-7cb7b9f4e500"
 #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-bc9bbf4aa301"
 
-#endif				/* __AUUID_H__ */
+#endif				/* __ACUUID_H__ */
-- 
2.20.1

