Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C2C54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F53720870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEGPJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:09:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:51959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgEGPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:09:12 -0400
IronPort-SDR: k+/CFJE1JrgR8wzC8QxySdj+9LhbVKgkxXdITn5vY0s0pZdTf/jeFoAK62oLbe1fuE3txlJJIA
 l6JRhgVpuyyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 08:09:12 -0700
IronPort-SDR: Kdrobe9NAtsReK2ebrrU91inXeF/GvEXjazQacylEEL53S5oJzHVKS/HvPfU4QqjwViDbiazsE
 Z9Qscr3hT4HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="370143331"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 08:09:10 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Intel PMC mux driver
Date:   Thu,  7 May 2020 18:09:00 +0300
Message-Id: <20200507150900.12102-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will be maintaining the Intel PMC mux control driver.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..5a7b0205397b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17590,6 +17590,13 @@ F:	Documentation/driver-api/usb/typec.rst
 F:	drivers/usb/typec/
 F:	include/linux/usb/typec.h
 
+USB TYPEC INTEL PMC MUX DRIVER
+M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/firmware-guide/acpi/intel-pmc-mux.rst
+F:	drivers/usb/typec/mux/intel_pmc_mux.c
+
 USB TYPEC PI3USB30532 MUX DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-usb@vger.kernel.org
-- 
2.26.2

