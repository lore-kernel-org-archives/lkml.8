Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15102067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="elXDlvbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgAaOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:37:48 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:37344 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgAaOhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:37:47 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580481445;
        bh=bJgEuisyk6F4q2o0zelYg072No9f9ecc5qp9+z7E1BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elXDlvbmwTuyVCKpkm7gs+TriHixDjltXBmwm4BtaqQzq3FlMujws/e76qWG3+lVk
         wt5hrtp2qxkVCqA/Jzb3keBGQtaqd0lGcXCw28X+H7+Q+1lXY6RbarUgZqmeffg/DF
         LqPGwz7Fg+IQsOkyMe4nnEBj3VbKql86QaVgYvyk=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] platform/x86: thinkpad_acpi: use standard charge control attribute names
Date:   Fri, 31 Jan 2020 15:36:47 +0100
Message-Id: <20200131143650.4149-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129204338.4055-1-linux@weissschuh.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series switches the battery control sysfs attributes to their
standard names as documented in Documentation/ABI/testing/sysfs-class-power.

If backwards compatability is not required please drop patch 3 of this series.
The old names were not documented explicitly and new generic software should
automatically use the new attributes, which may allow to drop the old names.

Changes since v1:
  * Corrected charge_control_stop_threshold to charge_control_end_threshold.

Thomas Weißschuh (3):
  platform/x86: thinkpad_acpi: remove unused defines
  platform/x86: thinkpad_acpi: use standard charge control attribute
    names
  platform/x86: thinkpad_acpi: restore old battery charge attributes

 drivers/platform/x86/thinkpad_acpi.c | 29 +++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.0

