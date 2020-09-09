Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5218C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8943D21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670617;
	bh=jxKgwQpqmG7edKBQ2bcpJ5DtU3FDZhmfZZD+7bojMRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPHchukBXM5JFQ5TltBargnTdlLakR8RcJ2ERCqqhw30g8klkX2yDw88UJ4CioWQH
	 UgoZCVSKThEP4pAM+d3uJf5/GTOCztTRlrTukrpfkjU+rLOzaji43XHzydfJctpo6y
	 uNPTzVJDj0XNANlZ+L/9o/Fz0aCtXuREOZ0oIh00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgIIQ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbgIIPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:21 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B46C2220E;
        Wed,  9 Sep 2020 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660666;
        bh=jxKgwQpqmG7edKBQ2bcpJ5DtU3FDZhmfZZD+7bojMRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXacDaM2whN7FBONgUiOH/cyb6MusHSSDspyzdw3fL8sNs+V5AqMNH5naKdtbCXFy
         FnRXU5pfdyR1R0OIFnuJ8sV7TvFdQkAazNvLoR0m7+eKtTU9r+3FtVXxqlHiHw0FAf
         voeH/R0HfAl2SRPaNC0oflBUn2UyH8+AJ0g4BshY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWe-3j; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] docs: hwmon: adm1266.rst: fix a broken reference
Date:   Wed,  9 Sep 2020 16:10:35 +0200
Message-Id: <abe1086e03d5a288f858d25092e5fc0620096db0.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference was missing the extension, causing the
check script to complain.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/adm1266.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
index 9257f8a48650..2b877011cfdf 100644
--- a/Documentation/hwmon/adm1266.rst
+++ b/Documentation/hwmon/adm1266.rst
@@ -20,7 +20,7 @@ ADM1266 is a sequencer that features voltage readback from 17 channels via an
 integrated 12 bit SAR ADC, accessed using a PMBus interface.
 
 The driver is a client driver to the core PMBus driver. Please see
-Documentation/hwmon/pmbus for details on PMBus client drivers.
+Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
 
 
 Sysfs entries
-- 
2.26.2

