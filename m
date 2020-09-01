Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6FEC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C2206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975875;
	bh=U26BGF1LP6XxV91bp/jQ9jZcEPUYtMpftQQ+qc+8KOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gccp0g4kBALFiIH2irpZN829swopDP+tHk73N2sEFOe9gwigAu+FcrDweSFHRF5b6
	 /QMrbQ2Ujo7ccDVa8OUeJ0bY2FrFU6uW8abY3Su+PkTOhzeoS8iEmylqMjQy2yowKU
	 HTWKZkgzZQtC5CfKoCP/Y4Ea7LDiWxXg1HTwURY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgIAP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbgIAPoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:44:20 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95098206EB;
        Tue,  1 Sep 2020 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975057;
        bh=U26BGF1LP6XxV91bp/jQ9jZcEPUYtMpftQQ+qc+8KOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzuG1gEAvZcSwQTbi1C2YpU3fQwGkFwTlQQ8JAJIvvxdY3K1p1l599AAAfWBW/8bP
         Zg46XVbBjehcbViOjHke/3YqmoVZZ4ua8tkcDpq0H/Zc9Q3nwUbPF+e6Dnh2nj+daD
         0AHTzLastQFDX7yRV//8ZwiUaRGEDQXnJ5WDkp84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 5.8 193/255] usb: host: xhci-tegra: fix tegra_xusb_get_phy()
Date:   Tue,  1 Sep 2020 17:10:49 +0200
Message-Id: <20200901151009.935550326@linuxfoundation.org>
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

From: JC Kuo <jckuo@nvidia.com>

commit d54343a87732726b04ac5af873916b5ed4f52932 upstream.

tegra_xusb_get_phy() should take input argument "name".

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200811092553.657762-1-jckuo@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1136,7 +1136,7 @@ static struct phy *tegra_xusb_get_phy(st
 	unsigned int i, phy_count = 0;
 
 	for (i = 0; i < tegra->soc->num_types; i++) {
-		if (!strncmp(tegra->soc->phy_types[i].name, "usb2",
+		if (!strncmp(tegra->soc->phy_types[i].name, name,
 							    strlen(name)))
 			return tegra->phys[phy_count+port];
 


