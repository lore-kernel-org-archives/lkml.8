Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB07C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066212067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmhVGqKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgF3EuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgF3Et4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:49:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEFC03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:49:56 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e6so12719367qtb.19
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1pgr6KaNRkuRhLLKbqD3ulE84r9BXBrKXG+wTgasJBs=;
        b=EmhVGqKj1hxcynFazVyM9BBAatcEV5Glfv6IolcJAU+WZt80BhCC7S95uetkKS69rG
         moLJ6mFVxETH0uu9E5a71IdGi1EO4Jhlu5hsB7433iTczY02C02gemnhGbY2HbNsmeK9
         p89uUnKxxwP9D13BCKNLWLjQu3I1+cvnyQpwfOIonoAfzeqNwq8mWanYN1hfu7UVEnqu
         7AVkwFxIC+IhNltLvEX3U89fGJ3pMmvPsScLgILybybvho+KO8QYE5NqN/pAWR+OXe8w
         GvuFxrbWomAp5dLYDnySp6VAEjs1FyccCG1hfRZ3TOXSnaYyLVsaVOXiMQes4cgLhzF1
         WihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1pgr6KaNRkuRhLLKbqD3ulE84r9BXBrKXG+wTgasJBs=;
        b=QpBUytT0EQHyoCPnAwOONzjvvSq0lIGnscWMTjX/LwFHVsQ9hHO1f+P4xnxMfnrDNM
         l3CyFA7oWgTwmmlTObQAWbAkjxujnZwOkBBVvS7aGkeIAGeSDOoBQ0yZk3Z93rifHopc
         hQk18gsGJgjfWmJ9NtnHTExB1z99f8Q2QGZgcsIwkwcb7sozA8n0GhCkFGmGQCE2S+pA
         VJt4xrRRamucI43o8c+MZMPLOZ8GayhmajCBeMXM8GVR+zi/T5mAdJl/oARAh8B4/bGa
         2MNoYnET/GCJ4hh25hUSjzFmyLTscmxj83Wwa9E3JPq3H8kWe/oZ/15ttE0LNZ9oeLl7
         hX9g==
X-Gm-Message-State: AOAM530gXI4A7NyJ9baa9DVOjV6EeYsP/zNgKQC1/TphxGM8Swp5zo1c
        q4oYCWKdsq0XFzKxmF2+1aFpe1nw2iyf
X-Google-Smtp-Source: ABdhPJxPqRsEUkTJy7xBvIqn4j64tLwwndWDL29Mu8/+Z31HqzfgXJZ/paNZUVBIuCrmANpGN0BjB5/3u/Zp
X-Received: by 2002:a05:6214:18f2:: with SMTP id ep18mr7665592qvb.96.1593492595480;
 Mon, 29 Jun 2020 21:49:55 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:40 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 4/7] PCI: Add device even if driver attach failed
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_attach() returning failure indicates a driver error while trying to
probe the device. In such a scenario, the PCI device should still be added
in the system and be visible to the user.

This patch partially reverts:
commit ab1a187bba5c ("PCI: Check device_attach() return value always")

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Cosmetic change in commit log.
    Add Greg's "reviewed-by"

 drivers/pci/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e6da77d..3cef835b375fd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER) {
+	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		return;
-	}
 
 	pci_dev_assign_added(dev, true);
 }
-- 
2.27.0.212.ge8ba1cc988-goog

