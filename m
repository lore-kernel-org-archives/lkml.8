Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C68C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2D020786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581028;
	bh=3InnyeHOfX2HAI/p9Sw6CicKSt7MLeeAttZJ9oB0KQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6rnLBCaSxJNH9Lry4Sywx79gHSv655ZfFw7Wg+MB+FJyomDP8ZaJH1HjfBq28/00
	 09N+kF8g9UcV5VYSHL+ukx6ebL5BMKHNlxdlMqJK5FoppFxIJrZX9rZr+cpTLdiy3T
	 xXM7nzSye1AS2dFQVHHRucKIUqH/ITYK2dIqkQDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405119AbgFSPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393751AbgFSPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C752166E;
        Fri, 19 Jun 2020 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580645;
        bh=3InnyeHOfX2HAI/p9Sw6CicKSt7MLeeAttZJ9oB0KQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSi+w3nfriKAqeUCmGxxhVjCBQvGA4Ya1AbhttyotbzTtecFDKv5u6gp9KxMhIgO+
         IqcF52eYZgVFAOFRS+iR7sfI8gxeg4fO7oZtQQIFLTjgHROY1+ecJK6adpU3ujvZGH
         E9hKoVOnF0ae6YjnaLnhAzRhxDp95khbBKwRwWvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.7 311/376] hwmon: (k10temp) Add AMD family 17h model 60h PCI match
Date:   Fri, 19 Jun 2020 16:33:49 +0200
Message-Id: <20200619141725.056898543@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Monakov <amonakov@ispras.ru>

commit 279f0b3a4b80660fba6faadc2ca2fa426bf3f7e9 upstream.

Add support for retrieving Tdie and Tctl on AMD Renoir (4000-series
Ryzen CPUs).

It appears SMU offsets for reading current/voltage and CCD temperature
have changed for this generation (reads from currently used offsets
yield zeros), so those features cannot be enabled so trivially.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/20200510204842.2603-3-amonakov@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -632,6 +632,7 @@ static const struct pci_device_id k10tem
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}


