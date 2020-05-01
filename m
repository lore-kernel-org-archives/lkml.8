Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D8C4725E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ABB24958
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347489;
	bh=mr9BujB/0oWLVW8A8/50Ti1fIWRy7AxgBrcsaWb66j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fo8bA6KijLLzzLmssJvrb/GdIYBnlKneDM/J7MrJ4rlBV32h2MNGVVkDtF6qJo4m3
	 xByncC0VRtmUqIeFmhYsDy7nFU9Y8fIxaSk9fp+wJmMbQcf0iSTJz619ULTfk+dgwz
	 7W7mTP4nXNPLNIrwE0+PhVDz2FzyRjBfLzhhrlNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgEAPiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgEAPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4E92495B;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=mr9BujB/0oWLVW8A8/50Ti1fIWRy7AxgBrcsaWb66j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qd5S61WIWGRVdD2IBwMHwX8RewcB5eIAdJSBcLz8rFQMQ4Mm1vbwOnG0MZSQq+iOx
         mrWz37A+2chs0aWJ0ma4pBbk0+21yFHeRlKVT/eVscX8A5vX7lPddXEJeh/S3GR2/8
         TTOpqV1XDQ/QNYABHzO0qmFkOPeMEbCR4ZPCLvkY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE4i-2o; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH 05/14] docs: fix references for ipmi.rst file
Date:   Fri,  1 May 2020 17:37:49 +0200
Message-Id: <b6c1ded590f27198de15b16237509128e55fa810.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this file got moved, fix references for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS                        | 2 +-
 drivers/char/ipmi/Kconfig          | 2 +-
 drivers/char/ipmi/ipmi_si_hotmod.c | 2 +-
 drivers/char/ipmi/ipmi_si_intf.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0cf6c358136..a1d7af532950 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8932,7 +8932,7 @@ M:	Corey Minyard <minyard@acm.org>
 L:	openipmi-developer@lists.sourceforge.net (moderated for non-subscribers)
 S:	Supported
 W:	http://openipmi.sourceforge.net/
-F:	Documentation/IPMI.txt
+F:	Documentation/driver-api/ipmi.rst
 F:	Documentation/devicetree/bindings/ipmi/
 F:	drivers/char/ipmi/
 F:	include/linux/ipmi*
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 7dc2c3ec4051..07847d9a459a 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -14,7 +14,7 @@ menuconfig IPMI_HANDLER
 	  IPMI is a standard for managing sensors (temperature,
 	  voltage, etc.) in a system.
 
-	  See <file:Documentation/IPMI.txt> for more details on the driver.
+	  See <file:Documentation/driver-api/ipmi.rst> for more details on the driver.
 
 	  If unsure, say N.
 
diff --git a/drivers/char/ipmi/ipmi_si_hotmod.c b/drivers/char/ipmi/ipmi_si_hotmod.c
index 42a925f8cf69..4fbb4e18bae2 100644
--- a/drivers/char/ipmi/ipmi_si_hotmod.c
+++ b/drivers/char/ipmi/ipmi_si_hotmod.c
@@ -18,7 +18,7 @@ static int hotmod_handler(const char *val, const struct kernel_param *kp);
 
 module_param_call(hotmod, hotmod_handler, NULL, NULL, 0200);
 MODULE_PARM_DESC(hotmod, "Add and remove interfaces.  See"
-		 " Documentation/IPMI.txt in the kernel sources for the"
+		 " Documentation/driver-api/ipmi.rst in the kernel sources for the"
 		 " gory details.");
 
 /*
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index c7cc8538b84a..77b8d551ae7f 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -968,7 +968,7 @@ static inline bool ipmi_thread_busy_wait(enum si_sm_result smi_result,
  * that are not BT and do not have interrupts.  It starts spinning
  * when an operation is complete or until max_busy tells it to stop
  * (if that is enabled).  See the paragraph on kimid_max_busy_us in
- * Documentation/IPMI.txt for details.
+ * Documentation/driver-api/ipmi.rst for details.
  */
 static int ipmi_thread(void *data)
 {
-- 
2.25.4

