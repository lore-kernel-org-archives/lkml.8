Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF5DC3B18E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15375217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBMVtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:49:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgBMVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:49:10 -0500
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.work.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tyhicks@canonical.com>)
        id 1j2MM2-0004dO-Rc; Thu, 13 Feb 2020 21:49:03 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH] Documentation/process: Swap out the ambassador for Canonical
Date:   Thu, 13 Feb 2020 21:48:42 +0000
Message-Id: <20200213214842.21312-1-tyhicks@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Johansen will take over as the process ambassador for Canonical
when dealing with embargoed hardware issues.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 Documentation/process/embargoed-hardware-issues.rst             | 2 +-
 .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 33edae654599..31963e68601b 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -254,7 +254,7 @@ an involved disclosed party. The current ambassadors list:
   VMware
   Xen		Andrew Cooper <andrew.cooper3@citrix.com>
 
-  Canonical	Tyler Hicks <tyhicks@canonical.com>
+  Canonical	John Johansen <john.johansen@canonical.com>
   Debian	Ben Hutchings <ben@decadent.org.uk>
   Oracle	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
   Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
index b93f1af68261..88273ebe7823 100644
--- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
@@ -183,7 +183,7 @@ CVE分配
   VMware
   Xen		Andrew Cooper <andrew.cooper3@citrix.com>
 
-  Canonical	Tyler Hicks <tyhicks@canonical.com>
+  Canonical	John Johansen <john.johansen@canonical.com>
   Debian	Ben Hutchings <ben@decadent.org.uk>
   Oracle	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
   Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
-- 
2.17.1

