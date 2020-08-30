Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DFC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 05:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B4D204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 05:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAHkbTWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgH3Fpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 01:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgH3Fpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 01:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598766342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZTIyDWwB1xP2mlWOHAKgKgz8364nJ/gpT2y8y73sUK8=;
        b=EAHkbTWuEFMIfrl0E+5BVUCa9oKKwHpNvU5bBew11ROKIS92zjEJU6yqmOckHlaTrIbnjA
        gWuIREfZNIsbMb3ou3ubFgEuo6apOc6EN3nvf112ibmjIDxhUAJloT6HU5XkhP02bf0nFJ
        lxBisOQhtrGlMjzKBK8kMgTlSUlVfCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Lxj-a1CiO726VBx_g6LU9w-1; Sun, 30 Aug 2020 01:45:38 -0400
X-MC-Unique: Lxj-a1CiO726VBx_g6LU9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28625189E61D;
        Sun, 30 Aug 2020 05:45:37 +0000 (UTC)
Received: from wolverine.usersys.redhat.com (unknown [10.35.206.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2952A80DF2;
        Sun, 30 Aug 2020 05:45:33 +0000 (UTC)
From:   Gal Hammer <ghammer@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Marcel Apfelbaum <mapfelba@redhat.com>,
        Gal Hammer <ghammer@redhat.com>
Subject: [PATCH] igb: read PBA number from flash
Date:   Sun, 30 Aug 2020 08:45:29 +0300
Message-Id: <20200830054529.3980-1-ghammer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed flash presence check for 82576 controllers so the part
number string is read and displayed correctly.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d9c3a6b169f9..245e62b0a97e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3388,7 +3388,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			  "Width x1" : "unknown"), netdev->dev_addr);
 	}
 
-	if ((hw->mac.type >= e1000_i210 ||
+	if ((hw->mac.type == e1000_82576 &&
+	     rd32(E1000_EECD) & E1000_EECD_PRES) ||
+	    (hw->mac.type >= e1000_i210 ||
 	     igb_get_flash_presence_i210(hw))) {
 		ret_val = igb_read_part_string(hw, part_str,
 					       E1000_PBANUM_LENGTH);
-- 
2.26.2

