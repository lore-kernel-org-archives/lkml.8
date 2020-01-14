Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB78C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F65A2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996782;
	bh=3jVM3h6LTqfuKy2l8oK+jeAcAegMVD9D42+Lcw17tHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U1ODRwIQBa+PxjdK5etp1/TovmAkdVlsSUK3ZQuwJR1DdGasx3ywGWlOh0OMApyhE
	 x2w3AXS0Ppq+U80ECtTiwXSW+wZs1uyb+gbJTHtpSqKRr2O6PbcENt76Z+jiLLttSY
	 7sdFyABDHEWmoj5GTyX6hOc0V6wsPmfW3qLq5a9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbgANKNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732558AbgANKM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:12:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACDA24679;
        Tue, 14 Jan 2020 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996778;
        bh=3jVM3h6LTqfuKy2l8oK+jeAcAegMVD9D42+Lcw17tHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHdl7ijbDCPMsFNMkzAZD3bGVz+y8Hv0C+EEC+iKRVnxDd6s1jNbC7uYjNAEMfoYf
         vizu6IAMP8rFO35nZP3tsvHUiNQOcZlopi97cuSZHxqCZ4hZVaz+Vev0AX37ZO9U2g
         d71nXAzP3a4a4bnZ5xTxyeXc3DWOADeglDce4bko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huangwen <huangwenabc@gmail.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 22/28] mwifiex: fix possible heap overflow in mwifiex_process_country_ie()
Date:   Tue, 14 Jan 2020 11:02:24 +0100
Message-Id: <20200114094343.972568076@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.845958665@linuxfoundation.org>
References: <20200114094336.845958665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapathi Bhat <gbhat@marvell.com>

commit 3d94a4a8373bf5f45cf5f939e88b8354dbf2311b upstream.

mwifiex_process_country_ie() function parse elements of bss
descriptor in beacon packet. When processing WLAN_EID_COUNTRY
element, there is no upper limit check for country_ie_len before
calling memcpy. The destination buffer domain_info->triplet is an
array of length MWIFIEX_MAX_TRIPLET_802_11D(83). The remote
attacker can build a fake AP with the same ssid as real AP, and
send malicous beacon packet with long WLAN_EID_COUNTRY elemen
(country_ie_len > 83). Attacker can  force STA connect to fake AP
on a different channel. When the victim STA connects to fake AP,
will trigger the heap buffer overflow. Fix this by checking for
length and if found invalid, don not connect to the AP.

This fix addresses CVE-2019-14895.

Reported-by: huangwen <huangwenabc@gmail.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mwifiex/sta_ioctl.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/mwifiex/sta_ioctl.c
@@ -229,6 +229,14 @@ static int mwifiex_process_country_ie(st
 			    "11D: skip setting domain info in FW\n");
 		return 0;
 	}
+
+	if (country_ie_len >
+	    (IEEE80211_COUNTRY_STRING_LEN + MWIFIEX_MAX_TRIPLET_802_11D)) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "11D: country_ie_len overflow!, deauth AP\n");
+		return -EINVAL;
+	}
+
 	memcpy(priv->adapter->country_code, &country_ie[2], 2);
 
 	domain_info->country_code[0] = country_ie[2];
@@ -272,7 +280,8 @@ int mwifiex_bss_start(struct mwifiex_pri
 	priv->scan_block = false;
 
 	if (bss) {
-		mwifiex_process_country_ie(priv, bss);
+		if (mwifiex_process_country_ie(priv, bss))
+			return -EINVAL;
 
 		/* Allocate and fill new bss descriptor */
 		bss_desc = kzalloc(sizeof(struct mwifiex_bssdescriptor),


