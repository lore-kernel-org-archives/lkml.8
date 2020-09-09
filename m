Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A060EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6BD21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670925;
	bh=BXGjvj2YrbZhIVzM1s1K593e8KBsZNVDOudP8Rkf7D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iq08ZBj9l0pzJ26a7n+Fhgw92AciVaIXWsqDrayAWC5W0Hgwx6CPTt0Li0jJuIOS4
	 FcSzPhuvzIT00PINoffH7mZIp15b6eq3Qq9Tyw1+zG3BAK4/AtXQwyAm8LG7fXR5LU
	 vW6rS8Mn1DdVoGzQZmjPvhsX70zPDntsdQYJTh0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgIIRBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730618AbgIIPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:50 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2771521D90;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=BXGjvj2YrbZhIVzM1s1K593e8KBsZNVDOudP8Rkf7D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s++gI9Y5dTeU0fUdujBwujgaoO3+iTJEyjoxvvPFJ5D4ixZfFohMpgZi/VRCWVGo3
         nuWN1Zw0Ecz7xisr6b96su6Ej74sNkvqMN0w8EnIKuDuwtfe+YflMx3fO+EEHh/m4Z
         F5BIALU56oDWEd9H9PbpUXiuQtpLLoKdBuKQw/LA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWu-9l; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] net: appletalk: Kconfig: Fix docs location
Date:   Wed,  9 Sep 2020 16:10:40 +0200
Message-Id: <0950e82d510349d5513967057fff4be10dbf3b82.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of ltpc.rst changed. Update it at Kconfig.

Fixes: 4daedf7abb41 ("docs: networking: move AppleTalk / LocalTalk drivers to the hw driver section")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/net/appletalk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
index d4f22a2e5be4..43918398f0d3 100644
--- a/drivers/net/appletalk/Kconfig
+++ b/drivers/net/appletalk/Kconfig
@@ -48,7 +48,7 @@ config LTPC
 	  If you are in doubt, this card is the one with the 65C02 chip on it.
 	  You also need version 1.3.3 or later of the netatalk package.
 	  This driver is experimental, which means that it may not work.
-	  See the file <file:Documentation/networking/ltpc.rst>.
+	  See the file <file:Documentation/networking/device_drivers/appletalk/ltpc.rst>.
 
 config COPS
 	tristate "COPS LocalTalk PC support"
-- 
2.26.2

