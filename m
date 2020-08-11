Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645E520716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsiLhW8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgHKOCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:02:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728757AbgHKOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597154548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SgyJE5z7EIbqui8zp079gmXNR4ujowSS+mR+zDN1ANU=;
        b=QsiLhW8JaxALncazUpZEzs24UZ1oGyLPyNPb2qnO0NwkqRczl2WZrQ2nk0v10VJ+wU5Z04
        lxvZgH4P/qrvzCJIXlHfgetVOFum9BNJGoC0jcidWk5HH5eWyTovQruUU2tvzQbB69Fvaw
        kWQQEBEgcKhRkoVTrpv1p+Y85cexLd4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-j6krsQciMbuwFGkhabdNOg-1; Tue, 11 Aug 2020 10:02:26 -0400
X-MC-Unique: j6krsQciMbuwFGkhabdNOg-1
Received: by mail-qt1-f200.google.com with SMTP id h10so9912133qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SgyJE5z7EIbqui8zp079gmXNR4ujowSS+mR+zDN1ANU=;
        b=TBfUhJfNCzFksm8A7p3w8VUXeYCfYAGwIbuQl+KhDrp7NfTLm9hlKfcoVfPZwVT/IH
         qfGLnksX3fGbDl2sVHH7ZRCzuD9UOT9/a2DugOJ8cNdQlcjNpp6CK04VY7iTSIxugK/1
         rgBc3prwD/8+1GoL5YeNPMPRhngAPif8m1PORwusnLjGqEjHQa/xHFhh9np4xlS7/edF
         4T87UcqjRaqGsAkEiKTO9plMUFHXYeyKNmtQqAC2BhXi22H6zJha0YaijCqGIkvPhXL2
         cpAnn7J+pU/8wWSY1hvl9zoaIKHGMdXUYsfRWIrjJo2h81IX9pSmBF+veBxQWlS7mb/c
         CNjw==
X-Gm-Message-State: AOAM533lgMPJdwPYg4Ewq1jhbBzi0CJ9Ump5lhY2/25QkQoYNOWFofFU
        ofC4LRNrvE7AX7vVjityMG8qKTOBBpf14eoWqGxJhm4qRRb95qxukfsQ+u7xl1rSLmMb5r74o6B
        wAKoLrAgwmkNRWj1ESlWpnH7g
X-Received: by 2002:a37:a7cc:: with SMTP id q195mr1308252qke.110.1597154546451;
        Tue, 11 Aug 2020 07:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw366l3R5s3TvVY4PxkrGfdyG3vc+gh1kf15sl4qCHXt7bTIdrb6+TrU8ogRMSgvCoM/y7eKA==
X-Received: by 2002:a37:a7cc:: with SMTP id q195mr1308207qke.110.1597154545969;
        Tue, 11 Aug 2020 07:02:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y24sm18891721qtv.71.2020.08.11.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 07:02:24 -0700 (PDT)
From:   trix@redhat.com
To:     jussi.kivilinna@iki.fi, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] rndis_wlan: tighten check of rndis_query_oid return
Date:   Tue, 11 Aug 2020 07:02:19 -0700
Message-Id: <20200811140219.8412-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

rndis_wlan.c:3147:25: warning: Assigned value is garbage or undefined
                wiphy->max_num_pmkids = le32_to_cpu(caps.num_pmkids);
                                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The setting of caps happens here, with a call to rndis_query_oid()

	retval = rndis_query_oid(usbdev,
	if (retval >= 0) {

Reviewing rndis_query_oid() shows that on success 0 is returned,
failure is otherwise.  So the retval check is not tight enough.
So tighten the retval check.  Similar problem in
rndis_wlan_get_caps().

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/rndis_wlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index 8852a1832951..75b5d545b49e 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3112,7 +3112,7 @@ static int rndis_wlan_get_caps(struct usbnet *usbdev, struct wiphy *wiphy)
 	retval = rndis_query_oid(usbdev,
 				 RNDIS_OID_802_11_NETWORK_TYPES_SUPPORTED,
 				 &networks_supported, &len);
-	if (retval >= 0) {
+	if (!retval) {
 		n = le32_to_cpu(networks_supported.num_items);
 		if (n > 8)
 			n = 8;
@@ -3137,7 +3137,7 @@ static int rndis_wlan_get_caps(struct usbnet *usbdev, struct wiphy *wiphy)
 	retval = rndis_query_oid(usbdev,
 				 RNDIS_OID_802_11_CAPABILITY,
 				 &caps, &len);
-	if (retval >= 0) {
+	if (!retval) {
 		netdev_dbg(usbdev->net, "RNDIS_OID_802_11_CAPABILITY -> len %d, "
 				"ver %d, pmkids %d, auth-encr-pairs %d\n",
 				le32_to_cpu(caps.length),
-- 
2.18.1

