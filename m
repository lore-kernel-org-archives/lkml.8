Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77655C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B9520409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbgCPQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:39:13 -0400
Received: from sauhun.de ([88.99.104.3]:54440 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbgCPQjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:39:12 -0400
Received: from localhost (p54B334BA.dip0.t-ipconnect.de [84.179.52.186])
        by pokefinder.org (Postfix) with ESMTPSA id 3535D2C0887;
        Mon, 16 Mar 2020 17:39:11 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dave Airlie <airlied@redhat.com>,
        Francisco Jerez <currojerez@riseup.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm: encoder_slave: some updates
Date:   Mon, 16 Mar 2020 17:39:05 +0100
Message-Id: <20200316163907.13709-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While converting I2C users to new APIs, I found a refcounting problem in
the encoder_slave implementation. This series fixes it and converts to
the new API.

Based on linux-next and only build tested.

Wolfram Sang (2):
  drm: encoder_slave: fix refcouting error for modules
  drm: encoder_slave: use new I2C API

 drivers/gpu/drm/drm_encoder_slave.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.20.1

