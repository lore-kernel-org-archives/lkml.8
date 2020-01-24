Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC12C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFB220708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864410;
	bh=B2vmsTBKpvoAqNMkcTnWn3fggVW2VM0yv9v+TYBNCdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gDrg78otOSex162x+DnmvN6wK3JbCX2FHqgJp8UoOZtqpTmagTWEod1FM8A1uK/Pf
	 UmCLtYGhsoI9P5RmRz6y468Qx0lkn1KrIPMlh8Kcc5JD7u5DWCgypeURV7P4aPGD5o
	 hTjjDi5Ly6JG1U/FMz33VsRyWoOXDqW1/27COzrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbgAXLN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390047AbgAXLNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:13:24 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E53920708;
        Fri, 24 Jan 2020 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864404;
        bh=B2vmsTBKpvoAqNMkcTnWn3fggVW2VM0yv9v+TYBNCdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpSN+mohGPBELEQn/HkvDQqriKqlNu0ZxTJWWJblzP0u/n6AM9leRXYuq6zXvsPqp
         KQYpVOcxkppsdnOs/S9NL9SJBSTSQ+j+FJsHx9YNue4tmQrqGN9q7EsTE+edi+SaFp
         hLlxcwnERVC0Q5o2sE6t6QtU7u1WU4eHH269ShVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 232/639] platform/x86: wmi: fix potential null pointer dereference
Date:   Fri, 24 Jan 2020 10:26:42 +0100
Message-Id: <20200124093115.912225311@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattias Jacobsson <2pi@mok.nu>

[ Upstream commit c355ec651a8941864549f2586f969d0eb7bf499a ]

In the function wmi_dev_match() the variable id is dereferenced without
first performing a NULL check. The variable can for example be NULL if
a WMI driver is registered without specifying the id_table field in
struct wmi_driver.

Add a NULL check and return that the driver can't handle the device if
the variable is NULL.

Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 04791ea5d97b6..35cdc3998eb59 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -768,6 +768,9 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 	struct wmi_block *wblock = dev_to_wblock(dev);
 	const struct wmi_device_id *id = wmi_driver->id_table;
 
+	if (id == NULL)
+		return 0;
+
 	while (id->guid_string) {
 		uuid_le driver_guid;
 
-- 
2.20.1



