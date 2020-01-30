Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1AFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9785A20674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410034;
	bh=ftI8eDVrvC2aJUG7JBr0DZAnlyra1cmDYbWgTZ5JY3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xFYnWDc1PVJlUqpZPP2QDDi/B/bDulvrDnpf/K1T/SVYbaS5kzc5kqwhMzVHmd9/I
	 GBGl8eRxYVmcD2Q9lmawI5WzlErb6HTqEIg5+TLHQTgDcgk9fOwcIoscxxjdRRN5Ye
	 lAPIr1Cu3DzObIFhK2Ds6GhTn3/EayJwniDaNG6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgA3SrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbgA3SrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:47:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12D0520674;
        Thu, 30 Jan 2020 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410020;
        bh=ftI8eDVrvC2aJUG7JBr0DZAnlyra1cmDYbWgTZ5JY3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHWJrexvyhnbv5ABv4k31lExx88F6H7/ncG+c4njBCyuF+WVColIFq8HX+VKzb3S2
         AZChzo052wnQTM2xIAbFXS6rcJ68T8A2VuISKQ8MJajPG9UqQqQ/pKZf7ELx6hHDWT
         KTklHRHxqC/i794zbMWiAtrFILadU44pc08PYSks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.19 07/55] usb: dwc3: turn off VBUS when leaving host mode
Date:   Thu, 30 Jan 2020 19:38:48 +0100
Message-Id: <20200130183610.083422589@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Liu <b-liu@ti.com>

commit 09ed259fac621634d51cd986aa8d65f035662658 upstream.

VBUS should be turned off when leaving the host mode.
Set GCTL_PRTCAP to device mode in teardown to de-assert DRVVBUS pin to
turn off VBUS power.

Fixes: 5f94adfeed97 ("usb: dwc3: core: refactor mode initialization to its own function")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1199,6 +1199,9 @@ static void dwc3_core_exit_mode(struct d
 		/* do nothing */
 		break;
 	}
+
+	/* de-assert DRVVBUS for HOST and OTG mode */
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 }
 
 static void dwc3_get_properties(struct dwc3 *dwc)


