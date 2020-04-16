Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF321C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B978D22241
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051667;
	bh=x3Qs4aSBXK64Z+K9htOVT9QwK/aJU4j3a0hDBID9p/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OdYtTHdUUp04wA0HIB9LUuwCxmPl82YqNm3i/ZFRyuCtBZDqezS5SDTwciiq85bH2
	 6+UJEOqEKz3bSjuHYEqoxgvMyaERVsAYp+bBiY10EUJn0wh7EEemQ7+OyXes447oj7
	 TBfCk284u5covjxlwPES7fSIdTOGa19x70CuHxLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395501AbgDPPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897470AbgDPNh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D97221EB;
        Thu, 16 Apr 2020 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044249;
        bh=x3Qs4aSBXK64Z+K9htOVT9QwK/aJU4j3a0hDBID9p/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/I0wCTaIAIzQuF4RLi6BuWQ095yviDLN5QiPAUwpefj/fs4wu0FBPKihR4pABj7Y
         OGbbexotFBYziRZxSIUF3NIF4Ktnnx/AdvzqXvMg4YMEy6wlPBbwAYqlGFyGoKVRmH
         9BAspEJFfEwHKhQSa176Apbj/RzOahKPDWmRbEuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.5 141/257] platform/x86: asus-wmi: Support laptops where the first battery is named BATT
Date:   Thu, 16 Apr 2020 15:23:12 +0200
Message-Id: <20200416131344.056757034@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristian Klausen <kristian@klausen.dk>

commit 6b3586d45bba14f6912f37488090c37a3710e7b4 upstream.

The WMI method to set the charge threshold does not provide a
way to specific a battery, so we assume it is the first/primary
battery (by checking if the name is BAT0).
On some newer ASUS laptops (Zenbook UM431DA) though, the
primary/first battery isn't named BAT0 but BATT, so we need
to support that case.

Fixes: 7973353e92ee ("platform/x86: asus-wmi: Refactor charge threshold to use the battery hooking API")
Cc: stable@vger.kernel.org
Signed-off-by: Kristian Klausen <kristian@klausen.dk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/asus-wmi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -418,8 +418,11 @@ static int asus_wmi_battery_add(struct p
 {
 	/* The WMI method does not provide a way to specific a battery, so we
 	 * just assume it is the first battery.
+	 * Note: On some newer ASUS laptops (Zenbook UM431DA), the primary/first
+	 * battery is named BATT.
 	 */
-	if (strcmp(battery->desc->name, "BAT0") != 0)
+	if (strcmp(battery->desc->name, "BAT0") != 0 &&
+	    strcmp(battery->desc->name, "BATT") != 0)
 		return -ENODEV;
 
 	if (device_create_file(&battery->dev,


