Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF9C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC43206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624105;
	bh=f4ILGXd3AahYpDxTsi3kCJTRTaAOwBuxdxpiOz51kJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+A28lo7KWa2OBTJxzkrr9au37ao7yC8C7xhn5fnMFBpuGfO+4GaG59QNbIRQZf95
	 yW5dv7EsGMUDCrWwgl2iYxCIN7EQw3vBvsomOgnfYMUdrUfaTvXXYmtxzHAgCMuf4n
	 nUZ4PB3Hz3Kg1sEZycSumTAWxCaXso5w+Znc0NOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgCSNVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbgCSNVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:21:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13033206D7;
        Thu, 19 Mar 2020 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624096;
        bh=f4ILGXd3AahYpDxTsi3kCJTRTaAOwBuxdxpiOz51kJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3mvu30lIJ7+czHXR017f16mKID2J6+SVYlowm97udqcN9CRDZREHQcNGt4Y7VC91
         pDJ8Bv6qjopXbmhKCceD+d2h1bEUSSVLWu1wGXhKU1gVwbEeHgs+tjENhODq3d1Nkw
         +6P+n/kNUHHQdmGD1KT9vpYDm1dWKBHBfG/1Cwx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yong Wu <yong.wu@mediatek.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 4.19 36/48] driver core: Remove the link if there is no driver with AUTO flag
Date:   Thu, 19 Mar 2020 14:04:18 +0100
Message-Id: <20200319123914.271629274@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

commit 0fe6f7874d467456da6f6a221dd92499a3ab1780 upstream.

DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
automatically on consumer/supplier driver unbind", that means we should
remove whole the device_link when there is no this driver no matter what
the ref_count of the link is.

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -546,7 +546,7 @@ static void __device_links_no_driver(str
 			continue;
 
 		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
-			kref_put(&link->kref, __device_link_del);
+			__device_link_del(&link->kref);
 		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 	}
@@ -591,7 +591,7 @@ void device_links_driver_cleanup(struct
 		 */
 		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
 		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
-			kref_put(&link->kref, __device_link_del);
+			__device_link_del(&link->kref);
 
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}


