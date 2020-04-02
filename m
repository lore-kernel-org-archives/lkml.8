Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9F1206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuydfkPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbgDBOM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:12:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728225AbgDBOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Lsas7jxJ1WMu8rRlGVbgJ8eIsxujsCQQeq8BgBAYBkI=;
        b=QuydfkPkaT5EqKrihALsPA4Hgbm80XmOiuqS+91eEkAr/IFCGIUPoHf1kaHsreszkfn4fd
        HdhRRiQxkLmfdeQ7jALZccT+C3eOmt/YCBYRcLaw5R0J9VOUuYu72U7wn3zVNnFWhBq+vg
        4p5mdQJirngAEwKEI9/463QxlpN0kWo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-vHvmF1P2N4GaPZdFpXvrtA-1; Thu, 02 Apr 2020 10:12:55 -0400
X-MC-Unique: vHvmF1P2N4GaPZdFpXvrtA-1
Received: by mail-qv1-f71.google.com with SMTP id j7so2746896qvy.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Lsas7jxJ1WMu8rRlGVbgJ8eIsxujsCQQeq8BgBAYBkI=;
        b=r0klPNic55RhaKg3bbNpXvK7RsTLsvRXcHbm7aCLk12ndezsoiCBHdKwjxvFqoz5QW
         /4x1nuO5xRSevIyhKzp5BgZdsCKztkjn6tuflcELjJApmt6sI3K+bhBmH/FaQagEdlOT
         cvHZgXYApMZ+lc/bQ0t5ywV1mOqrxMssmbKLlFWpJm6dWoaNrqj4kZIJ3Aj8cJplOeW/
         fAagrnu1na1CNlM+TNEM2SNVlA8ls5hoqLfDE/hXX+w9BCx8JH6t5UGlhBq7/5cKNZxD
         aekY8rXZcEri+glUp9Y5DCeiy4RJlQUUjItImNMM2BAcK+SphI1SB+2wjXUfFHE7guB4
         5AUw==
X-Gm-Message-State: AGi0PubYz412IDgNEv+Uc+vLF+3p7YDyZdGYNcwIVlmUOLpoI8Up9X8Z
        XhjOADP7vZgVOgQFPR/SFQoFgGeNEOzWSq0oEDnTqwFQI+wmNeNIayUOlmG+eOeRxIuUxfPuhiL
        nolCC2q3DGACL6zbqHibjuUaD
X-Received: by 2002:a37:7c81:: with SMTP id x123mr3569407qkc.287.1585836775149;
        Thu, 02 Apr 2020 07:12:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfJWfDXTGKKPJbCvXgetpUrdL/5Wc33Wc2j+KEgqsWojCWykGbIs6gJg6z/V4LYFVIdSjzNQ==
X-Received: by 2002:a37:7c81:: with SMTP id x123mr3569380qkc.287.1585836774834;
        Thu, 02 Apr 2020 07:12:54 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id b7sm3553494qkc.61.2020.04.02.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:12:53 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:12:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] vhost: drop vring dependency on iotlb
Message-ID: <20200402141207.32628-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vringh can now be built without IOTLB.
Select IOTLB directly where it's used.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This is on top of my previous patch (in vhost tree now).

 drivers/vdpa/Kconfig  | 1 +
 drivers/vhost/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 7db1460104b7..08b615f2da39 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -17,6 +17,7 @@ config VDPA_SIM
 	depends on RUNTIME_TESTING_MENU
 	select VDPA
 	select VHOST_RING
+	select VHOST_IOTLB
 	default n
 	help
 	  vDPA networking device simulator which loop TX traffic back
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 21feea0d69c9..bdd270fede26 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -6,7 +6,6 @@ config VHOST_IOTLB
 
 config VHOST_RING
 	tristate
-	select VHOST_IOTLB
 	help
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
-- 
MST

