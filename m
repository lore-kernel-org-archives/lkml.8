Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0CBC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C12070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7PGTt7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgD0VfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:35:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23208 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgD0Veq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588023284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kzHVQ1RNrTy6GimaONMy+YWogsizAFU4Ww/1ICCw9Wc=;
        b=P7PGTt7hDaJkXtyGiERrZx+pq5+oCkdvs7I0SJW27dMKXqCQu47zxy/8x10oo4DkzznGlz
        bX3LoPexSQGYqoSb0FomRTh5i+S3yBQzN9YSr7JENPfTNRjGegaSFWFW9S0ruFO07keTZQ
        L9A5y5IpRWk20S0+etw3BgfPy4X1qv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-6E4XqAfANYKuBZBtLrzL_Q-1; Mon, 27 Apr 2020 17:34:32 -0400
X-MC-Unique: 6E4XqAfANYKuBZBtLrzL_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F26DA835B40;
        Mon, 27 Apr 2020 21:34:30 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-110.rdu2.redhat.com [10.10.113.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 043845D9DD;
        Mon, 27 Apr 2020 21:34:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@redhat.com>,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        "Todd Previte" <tprevite@gmail.com>
Subject: [PATCH 0/1] Backport "drm/dp_mst: Kill the second sideband tx slot, save the world" for drm-fixes
Date:   Mon, 27 Apr 2020 17:34:21 -0400
Message-Id: <20200427213422.1414614-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because this patch will likely end up fixing a lot of MST issues we
either don't know about, or weren't able to figure out a fix for before,
I definitely want to make sure this patch gets cc'd to stable as well.
It doesn't apply cleanly to drm-misc-fixes, so here's a backported
version that does.

Lyude Paul (1):
  drm/dp_mst: Kill the second sideband tx slot, save the world

 drivers/gpu/drm/drm_dp_mst_topology.c | 122 +++++++-------------------
 include/drm/drm_dp_mst_helper.h       |  18 +---
 2 files changed, 33 insertions(+), 107 deletions(-)

--=20
2.25.3

