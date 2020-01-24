Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C942F2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859487;
	bh=wnjRklRT9QO3ID0lhAhN+Slr5Q2opEtUMhO4dCwSItY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TOKbH/4EdToDD6fuYF9jy03IdZGOuZZSlG9gHvBUZCeS9WDgq+pcZhrzL84cBx8Mv
	 HPCszDZuNB+NXfPqFiWBjGWyyZE6vmSfbVIhbugW35wHqCh4YJFbnp/olImjqM+rZA
	 0OHa5zPSpUWVMktZf63fDs0LKbgVJtCJjC1Dpiqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgAXJv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbgAXJvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:51:24 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA85820709;
        Fri, 24 Jan 2020 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859484;
        bh=wnjRklRT9QO3ID0lhAhN+Slr5Q2opEtUMhO4dCwSItY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWPgySCZ5TSWidFVwn5r1OTFfkIpDGSRP6SjtAeDhEP9//Zz3+WdsEi/vnUmforez
         +8EW0kPyXAJfYqNr6Wm+65C/yN0Ns9c1/wWo6ynkrDBJ2mtbJRKuDf4842CdgN/Mf7
         AAwJWSiOrgsewI151yRtImYJ4pgFjfe5wETNkRc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 127/343] platform/x86: wmi: fix potential null pointer dereference
Date:   Fri, 24 Jan 2020 10:29:05 +0100
Message-Id: <20200124092936.684051170@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index 7f8fa42a10840..a56e997816b23 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -748,6 +748,9 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 	struct wmi_block *wblock = dev_to_wblock(dev);
 	const struct wmi_device_id *id = wmi_driver->id_table;
 
+	if (id == NULL)
+		return 0;
+
 	while (id->guid_string) {
 		uuid_le driver_guid;
 
-- 
2.20.1



