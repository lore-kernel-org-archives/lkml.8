Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B072C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE342077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197130;
	bh=8Kog/HwWweJAruQTahLvXXinDSbs+edbNmKROmnFBT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eiMBxToXQAXk0NhFEuJXlZ5zSeJTisFMwd7VePN9VpY0N/iwNk7kNp4QtDyQz+gOt
	 qm3CgQhvSi+8yY5PbssPt8xAUed3ptdZA5fWiKDtYDtR6UIgCN5W9d8FUU8gLNAZgM
	 mcP0Q4mnan91rTC64HdqyUxNpfPs58v+hNLm5kMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406350AbgAPRwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406206AbgAPRp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F4D2477F;
        Thu, 16 Jan 2020 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196727;
        bh=8Kog/HwWweJAruQTahLvXXinDSbs+edbNmKROmnFBT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hE4gmjrGfTjCQPuGdI//npecErsiNF7fu22HKWSegUeKjencg9RNtiAFG9e8rVFBF
         nDQpP+p6CeEeZi/lwPZaPtXf7XFec7NgaGKMsIeVH2j8XIsE7Yi7E3KPVxtP+yJNHj
         eebm7aI0ryyEeJX42C2cwvsI1ETni752cob0d5jY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 112/174] usb: host: xhci-hub: fix extra endianness conversion
Date:   Thu, 16 Jan 2020 12:41:49 -0500
Message-Id: <20200116174251.24326-112-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 40c95ed6afbf..3ef80c2c0dcc 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -965,7 +965,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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

