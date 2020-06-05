Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684852070B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFMi8QjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFEPND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:13:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726601AbgFEPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591369981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CBCbgdlUb3ZI6Os4sqF1Nk3yry15HNXsqzRa5MBaYn8=;
        b=bFMi8QjLWVwh/8MMqNl/sW3Mcckq5NNMhWlXapZTAbRTqk0a6uyU9BhprTbQS/rdT2LHVt
        dg4fF3ePIs94gm+I5a8LKVMJsJvXzNcuhIZYqflzd4pXt/xqEvHbllNYunsY5adCL04DvP
        lhj70Mccvey0cD1pIitK11ttg0Id9Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-zf-xYbqNPg-NokeOSQVPZQ-1; Fri, 05 Jun 2020 11:12:59 -0400
X-MC-Unique: zf-xYbqNPg-NokeOSQVPZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD1A102C8A0;
        Fri,  5 Jun 2020 15:12:44 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-69.ams2.redhat.com [10.36.114.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02D2D10016DA;
        Fri,  5 Jun 2020 15:12:42 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        netdev@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] vsock/vmci: make vmci_vsock_transport_cb() static
Date:   Fri,  5 Jun 2020 17:12:41 +0200
Message-Id: <20200605151241.468292-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc-9.3 warning when building with 'make W=1':
    net/vmw_vsock/vmci_transport.c:2058:6: warning: no previous prototype
        for ‘vmci_vsock_transport_cb’ [-Wmissing-prototypes]
     2058 | void vmci_vsock_transport_cb(bool is_host)
          |      ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI guest/host are active")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4b8b1150a738..8b65323207db 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2055,7 +2055,7 @@ static bool vmci_check_transport(struct vsock_sock *vsk)
 	return vsk->transport == &vmci_transport;
 }
 
-void vmci_vsock_transport_cb(bool is_host)
+static void vmci_vsock_transport_cb(bool is_host)
 {
 	int features;
 
-- 
2.25.4

