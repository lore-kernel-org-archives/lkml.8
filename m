Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE6FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7FF206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976215;
	bh=raewuoMFNE7kx+5yn2JFZxyUHqYNFqxdXjV56LuMEc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0jnBQY1KW5jF7jefHspwGeuUukcT6RFuTHgIbjxPR4V9OCP5CtREMIQ2sp5Kyxbf
	 6i8yKSaGgcYrEFa5b2p5Q3RAXVZBHW38ZO8pzLLRhIRIEwkTnEGo2lI/9VFxVoXwS5
	 ZBeNSxlwBHmInrj73vEhFfz6MBk1hQOdHWUjyWI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgIAPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgIAPkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:40:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11647205F4;
        Tue,  1 Sep 2020 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974811;
        bh=raewuoMFNE7kx+5yn2JFZxyUHqYNFqxdXjV56LuMEc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDo+zrkmBYChKmpq3vmzhA5NZMmJP1JaTVIAoLWONFPT5hGB4/zlUTqln+f9V3jS/
         UgOH9A5HyGaOfuo9W2N7H9qsoog9ruX/1RoXFj6yM19+ti5CCxmqYZTcoBZGR17bgE
         Lodx33WA8rzPWrJQYkEWeXPXlcVE4NtY2JtTPNoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 100/255] i2c: core: Dont fail PRP0001 enumeration when no ID table exist
Date:   Tue,  1 Sep 2020 17:09:16 +0200
Message-Id: <20200901151005.506490372@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit e3cb82c6d6f6c27ab754e13ae29bdd6b949982e2 ]

When commit c64ffff7a9d1 ("i2c: core: Allow empty id_table in ACPI case
as well") fixed the enumeration of I²C devices on ACPI enabled platforms
when driver has no ID table, it missed the PRP0001 support.

i2c_device_match() and i2c_acpi_match_device() differently match
driver against given device. Use acpi_driver_match_device(), that is used
in the former, in i2c_device_probe() and don't fail PRP0001 enumeration
when no ID table exist.

Fixes: c64ffff7a9d1 ("i2c: core: Allow empty id_table in ACPI case as well")
BugLink: https://stackoverflow.com/q/63519678/2511795
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 26f03a14a4781..4f09d4c318287 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -354,7 +354,7 @@ static int i2c_device_probe(struct device *dev)
 	 * or ACPI ID table is supplied for the probing device.
 	 */
 	if (!driver->id_table &&
-	    !i2c_acpi_match_device(dev->driver->acpi_match_table, client) &&
+	    !acpi_driver_match_device(dev, dev->driver) &&
 	    !i2c_of_match_device(dev->driver->of_match_table, client)) {
 		status = -ENODEV;
 		goto put_sync_adapter;
-- 
2.25.1



