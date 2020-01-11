Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1A6C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F92082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736871;
	bh=CJ9r3J8vA2Z0KxY4AMcc8usw0Wmaqp5e6LI5Hy2xaeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DnquGvSoIKWfMMUUklehAxhx7b7cEubTafyD/6W18rsm+Y5qJ9Qo27ENFsRYWvGgF
	 tpVtlbtWraruEbR0GCDCIrICG/pymwavJZLHm69MD728IS96nGnDVXSjScJSaKrxr5
	 L0Os1FyN1upBZTb9XLCpHyVcFmppJ6Xu3xFH2IGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgAKKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgAKKBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:01:05 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 294F72077C;
        Sat, 11 Jan 2020 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736865;
        bh=CJ9r3J8vA2Z0KxY4AMcc8usw0Wmaqp5e6LI5Hy2xaeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRXTkwFWlupU5Mz/vMgN11+w6eBnEBd1AZYTlHYnbyXXyyXI+NKuB6AMRcgC6oQlv
         dtmopJ5GEICbHy8kHQvE3abCaOJaKBJGdxPZ7LgkFOhgEphA4Hc7o6ChJCrzg6NJ+y
         q6g1u5iHOHuto2QjjLWBbtfOSJiRqwHNCt61j72g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 39/91] Bluetooth: Fix memory leak in hci_connect_le_scan
Date:   Sat, 11 Jan 2020 10:49:32 +0100
Message-Id: <20200111094859.807807687@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit d088337c38a5cd8f0230fbf2d514ff7672f9d0d3 upstream.

In the implementation of hci_connect_le_scan() when conn is added via
hci_conn_add(), if hci_explicit_conn_params_set() fails the allocated
memory for conn is leaked. Use hci_conn_del() to release it.

Fixes: f75113a26008 ("Bluetooth: add hci_connect_le_scan")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_conn.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1054,8 +1054,10 @@ struct hci_conn *hci_connect_le_scan(str
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0)
+	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0) {
+		hci_conn_del(conn);
 		return ERR_PTR(-EBUSY);
+	}
 
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);


