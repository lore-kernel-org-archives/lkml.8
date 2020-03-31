Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8EB206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDR5MYxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgCaVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:22:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37486 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728245AbgCaVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585689761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sRghnZUn1Lcn59VJ6DHkKSsIh20b4joSKzig4G3pSxY=;
        b=DDR5MYxpWr81cXS1sW+8E2JWp+7owe0jClZWjZ9T1ZWCJa+fI8EN76wk57ccKSdBb8He+e
        0yxtJLFvWPA4B7VGcUT0IgAM6MRp9HJthpdDTyD70GF28MxzK9UxVAuVNcdTUQlx7hEtZo
        D62TSdCpdNQt8K85l8PPjgekLPwhScY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-DoS_cMkSNTCtHaVJt4nPDw-1; Tue, 31 Mar 2020 17:22:38 -0400
X-MC-Unique: DoS_cMkSNTCtHaVJt4nPDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4AF8017CE;
        Tue, 31 Mar 2020 21:22:35 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 476C65C1BB;
        Tue, 31 Mar 2020 21:22:33 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     "Pankaj Bharadiya" <pankaj.laxminarayan.bharadiya@intel.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Mikita Lipski" <mikita.lipski@amd.com>,
        "David Airlie" <airlied@linux.ie>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David Francis" <david.francis@amd.com>,
        linux-kernel@vger.kernel.org,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        dri-devel@lists.freedesktop.org,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Wenjing Liu" <wenjing.liu@amd.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Rodrigo Siqueira" <rodrigo.siqueira@amd.com>,
        "Anthony Koo" <anthony.koo@amd.com>,
        "Wyatt Wood" <wyatt.wood@amd.com>, "Aric Cyr" <aric.cyr@amd.com>
Subject: [PATCH 0/2] drm/amdgpu: Remove duplicated DPCD logging
Date:   Tue, 31 Mar 2020 17:22:22 -0400
Message-Id: <20200331212228.139219-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bunch of messy DPCD tracing code in amdgpu that isn't needed
since we already support this in DRM. Plus, it's really spammy. So, just
get rid of it.

Lyude Paul (2):
  drm/amd/amdgpu_dm/mst: Remove useless sideband tracing
  drm/amd/dc: Kill dc_conn_log_hex_linux()

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 43 -------------------
 .../gpu/drm/amd/display/dc/basics/Makefile    |  3 +-
 .../drm/amd/display/dc/basics/log_helpers.c   | 39 -----------------
 .../amd/display/include/logger_interface.h    |  4 --
 4 files changed, 1 insertion(+), 88 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/basics/log_helpers.c

--=20
2.25.1

