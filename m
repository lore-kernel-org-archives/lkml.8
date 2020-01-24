Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9853AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641C120709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860107;
	bh=n6sUB4XDMloqjG4MA8tnmABkCdwSClofin62r6/qRHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1Uwxulajs6S2Omaqv73PdjSuW5ktzI/qIX6grBiKsK9U8RTB0dMeUzkZNc7wfCTY
	 X4ZTquJXs2qVZAZ8aHPv7JT+lzkAPg1GbAyMcgxmqi8guB75G/0cTxa2nPpBYTk9qe
	 UX8MsT6YP/zAe4/6EKpEadIK35Y7GsXl+YiKeEFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbgAXKBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733077AbgAXKBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:01:44 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525B2206D5;
        Fri, 24 Jan 2020 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860103;
        bh=n6sUB4XDMloqjG4MA8tnmABkCdwSClofin62r6/qRHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHy9SwJNLSYSItcZ3gw0SANqQFYk17Y2baCRBR9+sYIiPP9LMRui1jdGy3S+7Oell
         1i40zEkpTG1s/2Pqr8BkUnyS7NdgNzZizmpq6+o8ELF+7Ik9GI3k3D1b3mnIG5AV24
         deY56OhqVwE8J+cKicwOnzd3RWiucmfLJMHUK00U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 259/343] usb: host: xhci-hub: fix extra endianness conversion
Date:   Fri, 24 Jan 2020 10:31:17 +0100
Message-Id: <20200124092954.121408780@linuxfoundation.org>
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

From: Ruslan Bilovol <ruslan.bilovol@gmail.com>

[ Upstream commit 6269e4c76eacabaea0d0099200ae1a455768d208 ]

Don't do extra cpu_to_le32 conversion for
put_unaligned_le32 because it is already implemented
in this function.

Fixes sparse error:
xhci-hub.c:1152:44: warning: incorrect type in argument 1 (different base types)
xhci-hub.c:1152:44:    expected unsigned int [usertype] val
xhci-hub.c:1152:44:    got restricted __le32 [usertype]

Fixes: 395f540 "xhci: support new USB 3.1 hub request to get extended port status"
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Link: https://lore.kernel.org/r/1562501839-26522-1-git-send-email-ruslan.bilovol@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index d1363f3fabfa6..3bb38d9dc45bf 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1118,7 +1118,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			port_li = readl(port_array[wIndex] + PORTLI);
 			status = xhci_get_ext_port_status(temp, port_li);
-			put_unaligned_le32(cpu_to_le32(status), &buf[4]);
+			put_unaligned_le32(status, &buf[4]);
 		}
 		break;
 	case SetPortFeature:
-- 
2.20.1



