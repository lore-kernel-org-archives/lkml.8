Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F02C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E99C206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591367171;
	bh=i1PfMsBvUSIG0yNBlmGABRb1fF2BKTZp1A1FBnuK4zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdn3RgMgQm/s9azAlXOy6s+M/ts2VNvd9WTkKkdRicLdp91/ZGq9wlbt/VQIAHLzq
	 83AT6I1aSnCSEj7JROOoeKX2VVvbBAq1zLf+e3XsBc23ari/+HdwotL6yALu0YSLHU
	 oR9uT+mIteCn8GFk0y4sTDZWloBjMkBgdkb9OteM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgFEO0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgFEOQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:16:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A28420899;
        Fri,  5 Jun 2020 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366564;
        bh=i1PfMsBvUSIG0yNBlmGABRb1fF2BKTZp1A1FBnuK4zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0Nl/MNcalcFjHNP9pgygrrzgeYv2u7K8KpvZY6NCmrhIC8b2eNW7AJtgthJQO3Gt
         wr9gUJA1wSlzYdJ/8CPzayfl22pmKJxnMm/IsOvRHyJTBzYIIjq9nTO8COl79jjC88
         1gzdJtDaL1JFc/1+w3F/P2udhROsiLBsZVpfENNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Sax <jsbc@gmx.de>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.7 05/14] HID: i2c-hid: add Schneider SCL142ALM to descriptor override
Date:   Fri,  5 Jun 2020 16:14:55 +0200
Message-Id: <20200605135951.340584155@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605135951.018731965@linuxfoundation.org>
References: <20200605135951.018731965@linuxfoundation.org>
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
 


