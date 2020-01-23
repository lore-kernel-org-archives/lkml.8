Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCCC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D2E21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgAWO6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:58:48 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49857 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729047AbgAWO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:58:11 -0500
Received: from [109.168.11.45] (port=47594 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iudvs-0005F5-PN; Thu, 23 Jan 2020 15:58:08 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/28] docs: i2c: instantiating-devices: fix internal hyperlink
Date:   Thu, 23 Jan 2020 15:56:18 +0100
Message-Id: <20200123145626.8102-7-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123145626.8102-1-luca@lucaceresoli.net>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
 <20200123145626.8102-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ReST syntax so that a proper hyperlink is generated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v2:
 - remove space before dot (Jean Delvare)
---
 Documentation/i2c/instantiating-devices.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/instantiating-devices.rst b/Documentation/i2c/instantiating-devices.rst
index 53244e2f0378..e823c4ad4e7f 100644
--- a/Documentation/i2c/instantiating-devices.rst
+++ b/Documentation/i2c/instantiating-devices.rst
@@ -86,7 +86,7 @@ Method 1c: Declare the I2C devices via ACPI
 -------------------------------------------
 
 ACPI can also describe I2C devices. There is special documentation for this
-which is currently located at Documentation/firmware-guide/acpi/enumeration.rst.
+which is currently located at :doc:`../firmware-guide/acpi/enumeration`.
 
 
 Method 2: Instantiate the devices explicitly
-- 
2.25.0

