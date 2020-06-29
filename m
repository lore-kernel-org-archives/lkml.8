Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7357C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A912E20760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaJzgVdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgF2UFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbgF2UFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:05:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2325C061755;
        Mon, 29 Jun 2020 13:05:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so19652998ljg.13;
        Mon, 29 Jun 2020 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+CNAZ3y5IAzA+T1hadUTboHpdjBaonxunr0d//76ia0=;
        b=uaJzgVdBmCQn+kTrWjonbLQ45J0ZDHhNEAyQOlP1OOPXR+i3hcyT34b+v9V0iu/2db
         WJVBJoxl4Vqb0moox/paal5+4fPmjSiyNOiTca9VLTZ4pLzNKkb4WXoKpfeH5IBQoS2g
         U/PREcwFwW+uHBsUp/jQCQN1Q53G2sxopjbYSoteneUcq4z0TQes3KQCoijnEEotORsU
         Ey+NZjBLOOkc92KsNF7dFRx62Iy6YULEcy7x+YhaS251rfAMJeLdfEgsFCHY8Ghpc+QG
         kzK2j/lQqIAkVt8WQP/YQpqyGxgktv8nHZH2/Mt7il2wSR3rQAzaM+zIEejydk81ZOzy
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+CNAZ3y5IAzA+T1hadUTboHpdjBaonxunr0d//76ia0=;
        b=bovBoRqjzieIMQq/mXr1Q/lH/N+/3tVH0aEgGvujCSj1LR+teWgjky3/3VQubATKe4
         chnqGtgRetVqNIRwJWKDWNjGZawEOES6Qo+ERTaVnWhB8nkfF10P4RBtzjZlmd5FlCxa
         KfResMKm1KWESWDmANnNFhfUrYmcpRNIEYmMNHgx/2uo0tkoUMjSITGaYVZDKMVCAd4H
         Ajku1cFC/HiZEMT21k3/REY1e1E0G+4vyXElK8Db7yceF4AlBHrse7DiG4wCfVPeTBNm
         bcEv4FYyq9MVlwzIC7vCCKfjtsMdfai8j0Vd5HaFTjzqcd9OHvypGCf8z0afgOFUH9+T
         5qyA==
X-Gm-Message-State: AOAM531R0FsKh73eRkQ+KKv6uuwx4DTgG/r7ohbDTeMbETGsJ83CDfoo
        6BpddwOPOzt8PQLKarnejgQ=
X-Google-Smtp-Source: ABdhPJytixeb2Sm4/OSsi8RJU0prbBFmaHuogWZM0zBRDGJfIsONHorDjVIYxvsixBlBfNFwaNMs9g==
X-Received: by 2002:a2e:9c4b:: with SMTP id t11mr8284918ljj.412.1593461143194;
        Mon, 29 Jun 2020 13:05:43 -0700 (PDT)
Received: from localhost ([80.64.86.170])
        by smtp.gmail.com with ESMTPSA id q11sm145044lfe.34.2020.06.29.13.05.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 13:05:42 -0700 (PDT)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: epautoconf: claim smallest endpoints first
Date:   Mon, 29 Jun 2020 23:05:51 +0300
Message-Id: <20200629200551.27040-1-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UDC hardware may have endpoints with different maxpacket
size. Current endpoint matching code takes first matching
endpoint from the list.

It's always possible that gadget allocates endpoints for
small transfers (maxpacket size) first, then larger ones.
That works fine if all matching UDC endpoints have same
maxpacket size or are big enough to serve that allocation.

However, some UDCs have first endpoints in the list with
bigger maxpacket size, whereas last endpoints are much
smaller. In this case endpoint allocation will fail for
the gadget (which allocates smaller endpoints first) on
final endpoint allocations.

To make endpoint allocation fair, pick up smallest
matching endpoints first, leaving bigger ones for
heavier applications.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 71b15c65b90f..1814a760ce48 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	struct usb_ep	*ep;
+	struct usb_ep	*ep, *ep_min = NULL;
 	u8		type;
 
 	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
@@ -77,14 +77,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
 			goto found_ep;
 	}
 
-	/* Second, look at endpoints until an unclaimed one looks usable */
+	/*
+	 * Second, look at endpoints until an unclaimed one looks usable.
+	 * Try to find one with smallest maxpacket limit, leaving larger
+	 * endpoints for heavier applications
+	 */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
+			if (desc->wMaxPacketSize == 0)
+				goto found_ep;
+			else if (!ep_min)
+				ep_min = ep;
+			else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
+				ep_min = ep;
+		}
 	}
 
 	/* Fail */
-	return NULL;
+	if (!ep_min)
+		return NULL;
+
+	ep = ep_min;
 found_ep:
 
 	/*
-- 
2.17.1

