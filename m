Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6962C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C4121D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048290;
	bh=cj9k2hAYAxhpwnoNJGeoddNVllBSWZVfbFc0dQYDt/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfLyr0qE9eVqzLIH8OBQ6bS4U1VCDkdMsriMmC/D7YmVBx5knXP9cq1YgyD6OhnUU
	 FXhwUWRTdocVfijdtutjYT/FMYu3BKZqcN8spCScK7xIu5JmOaB62klZeA376rdI7w
	 JTz3lHn3jl95wi4upNkWGWepvWkKrPQgniH6nHnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDPOos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409410AbgDPN7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBC620732;
        Thu, 16 Apr 2020 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045593;
        bh=cj9k2hAYAxhpwnoNJGeoddNVllBSWZVfbFc0dQYDt/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G46y9i9XJdHSRKhj2oVXdE0zecB5UxNL7H6Qd7MWg2fjk8aL2I0l92EGru7A2KgEb
         wTCQqJ5DC8BJYQqY0/q48sCNdGFvWDOq6Mai7Y4cbO8aGJFi0CokeTlK5dg1M2Rkuo
         UgQniDSSBPwzf4j1SAzPg+lggsbUyX1f343s3tOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 5.6 199/254] vfio: platform: Switch to platform_get_irq_optional()
Date:   Thu, 16 Apr 2020 15:24:48 +0200
Message-Id: <20200416131351.026993633@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Auger <eric.auger@redhat.com>

commit 723fe298ad85ad1278bd2312469ad14738953cc6 upstream.

Since commit 7723f4c5ecdb ("driver core: platform: Add an error
message to platform_get_irq*()"), platform_get_irq() calls dev_err()
on an error. As we enumerate all interrupts until platform_get_irq()
fails, we now systematically get a message such as:
"vfio-platform fff51000.ethernet: IRQ index 3 not found" which is
a false positive.

Let's use platform_get_irq_optional() instead.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Cc: stable@vger.kernel.org # v5.3+
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/platform/vfio_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -44,7 +44,7 @@ static int get_platform_irq(struct vfio_
 {
 	struct platform_device *pdev = (struct platform_device *) vdev->opaque;
 
-	return platform_get_irq(pdev, i);
+	return platform_get_irq_optional(pdev, i);
 }
 
 static int vfio_platform_probe(struct platform_device *pdev)


