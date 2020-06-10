Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E179AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B026D20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XIHket2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgFJMBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:01:41 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:50350 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgFJMBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:01:40 -0400
IronPort-SDR: 1Rp13Orzu9AkysPtmbTcoOYtVN7x3s/0GS/3ljm5zTIhfgmbW39D9yxCeohrmPVI30aiWJ2PgR
 AL9oiNmXSPQr/QlA/Z1GfizXWmcIZfhBJ6vqco9DXs4NSrbTIGkRE2YmVb04TtjXuhOMMPcj/V
 SEq+I54YSK32T7nsGEzJonwhmqY7kOIY6uhrFjEwrgET7Nd8bzDy0nPcm9VFei6esRnH1nrdbv
 77RnFMrCp1zKFA8z++njbXBKV7ikvdhu79JIGsHlz2mVCQrUTRbvWA0GREBtclrSbNqUQAjlhn
 8hA=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636785"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Jun 2020 14:01:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 Jun 2020 14:01:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 Jun 2020 14:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591790499; x=1623326499;
  h=from:to:cc:subject:date:message-id;
  bh=7AcpqJKc86SppmzVr64WnlcpnqLCocCqsJRXvSyZdzg=;
  b=XIHket2DlrfM8Mzw7OkCY8y4ntRp7UL5JR9dncAZzvwWeMUkC1PQCk4V
   nyjtQE8bQ7Yvs8ziXh02y2NC6IiHNqp2WWx7O/JFv1AWrui6mxsHuL7Cn
   Kjh9jAQsVZGq+LJLGsxbiV/f0th63CCUIK1IkNANibacSMc8/tpzoIqae
   vilR1Yjs70N278jJ+lCQN/DtppgVm9vKVjmt5i8N5P6BwJDuBlO3ulxtf
   LBqGO5Rhy2m9xKMfvCP95umTQdI+CKd8EpFEEEWiwFEO9b0Gk6AEKouGN
   n0Xc5cLE8wwirc0yAgliJDR++YRuyspM5/JPHBayOBfKtLMw8+KUNSD0u
   A==;
IronPort-SDR: Vli/mF82dxPHyOLH3/SUfKgCRCOxw5Ac369gCfB7TSkLIf/QqsFM9hdd1jiOUFY1dEu4ZAswFh
 H/8IEl5X1haTt+cGP0pSxqeKyWKwTHer/Qv5VwwJz7b7h0SE9U8J5N6C7ZvJFvzReA2yAwMW5v
 ZHyAY9YJQRc27iMsLCXKKu27cXtL8pyFiTjtOGjlqiuCupgLSU3mY9CnX74MgrgZHall2XS2BQ
 5otTSF8B/eNPy4VFQi0yfHi9L3IC2whcJELEqf1pn6cr3cNyaqa38F+EkLOppsl4nUB7s0YHNN
 jOQ=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636784"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jun 2020 14:01:39 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 308B7280065;
        Wed, 10 Jun 2020 14:01:39 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 0/4] panel-simple: CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44, Tianma TM070JVHG33
Date:   Wed, 10 Jun 2020 14:01:27 +0200
Message-Id: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

This adds a few panels TQ-Systems uses with various starterkit
mainboards. Device trees actually using these panels will be added with
a later submission.


Matthias Schiffer (2):
  dt-bindings: display: simple: add CDTech S070PWS19HP-FC21 and
    S070SWV29HG-DC44
  dt-bindings: display: simple: add Tianma TM070JVHG33

Max Merchel (1):
  drm/panel: simple: add Tianma TM070JVHG33

Michael Krummsdorf (1):
  drm/panel: simple: add CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44

 .../bindings/display/panel/panel-simple.yaml  |  6 ++
 drivers/gpu/drm/panel/panel-simple.c          | 74 +++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.17.1

