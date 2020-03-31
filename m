Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E48207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1uS6vRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgCaU54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:57:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728893AbgCaU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585688274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RT7YcYvPXgQSj7BD5jsv2sgp21ReQU5d7+m4XV0mPYY=;
        b=B1uS6vRb8jIt19lmseS0VLDunPKStFk/jeuPlYbV04/agoi1SRgeRtAKG7lC2w1cZUKgaN
        amD6+r06Q4lXP+OnuCJNCyuzkYt0CgO6mhMxcLLpC15/IoscAFVQiaMdeKZVbE422+oL5O
        75SgXHWRFoHG+yMd6p6NtjOYcHiXih8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-wJmpsAMgPYy-FzNIsGhyfA-1; Tue, 31 Mar 2020 16:57:52 -0400
X-MC-Unique: wJmpsAMgPYy-FzNIsGhyfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 288B010CE78F;
        Tue, 31 Mar 2020 20:57:50 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 247B097B19;
        Tue, 31 Mar 2020 20:57:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        David Francis <David.Francis@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/amd/amdgpu_dm/mst: Remove unneeded edid assignment when destroying connectors
Date:   Tue, 31 Mar 2020 16:57:34 -0400
Message-Id: <20200331205740.135525-2-lyude@redhat.com>
In-Reply-To: <20200331205740.135525-1-lyude@redhat.com>
References: <20200331205740.135525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't do anything, noticed this while cleaning up some unrelated
stuff.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e8208df420d9..7b3303efb1ff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -140,7 +140,6 @@ dm_dp_mst_connector_destroy(struct drm_connector *con=
nector)
 	struct amdgpu_encoder *amdgpu_encoder =3D amdgpu_dm_connector->mst_enco=
der;
=20
 	kfree(amdgpu_dm_connector->edid);
-	amdgpu_dm_connector->edid =3D NULL;
=20
 	drm_encoder_cleanup(&amdgpu_encoder->base);
 	kfree(amdgpu_encoder);
--=20
2.25.1

