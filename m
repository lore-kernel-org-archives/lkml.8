Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87416C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5000A208B8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366643;
	bh=i1PfMsBvUSIG0yNBlmGABRb1fF2BKTZp1A1FBnuK4zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kQ4VbkbzaHqcHVZFenvlEPJEviXstKhdTkRnEwrxhb1oKo9W+uxl1MNCotUVoe1pm
	 D4CHaQ85R4nEFkmvjGDbQFIJGMrjovQ6TBxMTU03i0cPgt8sUKLGvkqVcALN4YV/Dx
	 yGO9n2NzOcXBJ97cPpa0TKBdL5tfTqLle/2MSFq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFEORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgFEORU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:17:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B5E208B8;
        Fri,  5 Jun 2020 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366639;
        bh=i1PfMsBvUSIG0yNBlmGABRb1fF2BKTZp1A1FBnuK4zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niX2zfWvcmGfTtXaobrOrPpMEeBTdeP2URIv0MuvIsBnNWQywmd+i//FvvmVfJXiD
         q1Gj/nnn/zU0/eM9vkuu3P3t/4Q5ifWs+S2urze1SVeOwioxCEMKAr1ksZdVREO0yh
         2N3869iBadqwaQzdfzOhKowXeONB06ydlfI6uIp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Sax <jsbc@gmx.de>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.6 34/43] HID: i2c-hid: add Schneider SCL142ALM to descriptor override
Date:   Fri,  5 Jun 2020 16:15:04 +0200
Message-Id: <20200605140154.309733128@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Sax <jsbc@gmx.de>

commit 6507ef10660efdfee93f0f3b9fac24b5e4d83e56 upstream.

This device uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override list.

Cc: stable@vger.kernel.org
Signed-off-by: Julian Sax <jsbc@gmx.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -389,6 +389,14 @@ static const struct dmi_system_id i2c_hi
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Schneider SCL142ALM",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SCHNEIDER"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SCL142ALM"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{ }	/* Terminate list */
 };
 


