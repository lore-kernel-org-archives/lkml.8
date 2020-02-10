Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FFCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FF020715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBJPf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:35:56 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:46040 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJPf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:35:56 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 5D07279FF9;
        Mon, 10 Feb 2020 15:35:55 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 48GVNq104Pz4c82;
        Mon, 10 Feb 2020 15:35:55 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from skull.home.blih.net (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 2C20622AE;
        Mon, 10 Feb 2020 15:35:54 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
From:   Emmanuel Vadot <manu@FreeBSD.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@FreeBSD.org>
Subject: [PATCH 0/2] Dual licence some files in GPL-2.0 and MIT
Date:   Mon, 10 Feb 2020 16:35:42 +0100
Message-Id: <20200210153544.24750-1-manu@FreeBSD.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

We had a discussion a while back with Noralf where he said that he wouldn't
mind dual licence his work under GPL-2 and MIT.
Those files are a problem with BSDs as we cannot include them.
For drm_client.c the main contributors are Noralf Trønnes and Thomas
Zimmermann, the other commits are just catch ups from changes elsewhere
(return values, struct member names, function renames etc ...).
For drm_format_helper the main contributors are Noralf Trønnes and
Gerd Hoffmann. Same comment as for drm_client.c for the other commits.

Emmanuel Vadot (2):
  drm/client: Dual licence the file in GPL-2 and MIT
  drm/format_helper: Dual licence the file in GPL 2 and MIT

 drivers/gpu/drm/drm_client.c        | 2 +-
 drivers/gpu/drm/drm_format_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.0

