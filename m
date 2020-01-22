Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D642465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnlVw13T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAVTns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:43:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728842AbgAVTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579722222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2H99dtIPzD+2bfpOZRc5f1le1Dolfc3F7B556CU3yGI=;
        b=FnlVw13T3WGHIZE1UT/lH9SW17gFVt8Ehe6+2VoBOMItRzebnshjoQMjHiqAfN05CZm4Pn
        mzZZk3NcPCYZheDasRT17yRbS/O3r6BIUkC0wAh9kj9WwAA7S6+jh5us1e7hHP35oUs3u+
        a06l1eHSHyQNCTENOwCVFl75acwfSl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-NQLconojOpKT2sJLDngfkQ-1; Wed, 22 Jan 2020 14:43:38 -0500
X-MC-Unique: NQLconojOpKT2sJLDngfkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64BB138191;
        Wed, 22 Jan 2020 19:43:36 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E9C28D10;
        Wed, 22 Jan 2020 19:43:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/dp_mst: Mention max_payloads in proposed_vcpis/payloads docs
Date:   Wed, 22 Jan 2020 14:43:21 -0500
Message-Id: <20200122194321.14953-2-lyude@redhat.com>
In-Reply-To: <20200122194321.14953-1-lyude@redhat.com>
References: <20200122194321.14953-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention that the size of these two structs is determined by
max_payloads. Suggested by Ville Syrj=C3=A4l=C3=A4.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
---
 include/drm/drm_dp_mst_helper.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_hel=
per.h
index bcb39da9adb4..5483f888712a 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -635,11 +635,13 @@ struct drm_dp_mst_topology_mgr {
 	struct mutex payload_lock;
 	/**
 	 * @proposed_vcpis: Array of pointers for the new VCPI allocation. The
-	 * VCPI structure itself is &drm_dp_mst_port.vcpi.
+	 * VCPI structure itself is &drm_dp_mst_port.vcpi, and the size of
+	 * this array is determined by @max_payloads.
 	 */
 	struct drm_dp_vcpi **proposed_vcpis;
 	/**
-	 * @payloads: Array of payloads.
+	 * @payloads: Array of payloads. The size of this array is determined
+	 * by @max_payloads.
 	 */
 	struct drm_dp_payload *payloads;
 	/**
--=20
2.24.1

