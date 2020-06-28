Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F420772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="y6ehqLHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgF1Lwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 07:52:54 -0400
Received: from www.zeus03.de ([194.117.254.33]:42014 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgF1Lwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=n5hj1Lv2JEhpllD+hIE9/Kp9E7T
        O5CNDhsNkcJIrI5Q=; b=y6ehqLHwzhYEkhBdEBNU1OvY6p/I11OUcb1pa33GYFL
        NGxsRJrCjQ5aOIxIOkXHfTpEve4QUU0Aq6MLSO9JPCpuQBDUca05nAjmSs9cXdo6
        bkPAAHKJdHLjantwHCGtr13MlgettTHVG/PRimOl6CAby8ultlmyvMgBPy7op6DU
        =
Received: (qmail 1708523 invoked from network); 28 Jun 2020 13:52:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Jun 2020 13:52:51 +0200
X-UD-Smtp-Session: l3s3148p1@vyHxlCOp6MogAwDPXykLAJ34nb66bSnN
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [RFC PATCH 0/2] i2c: check correct size of maximum RECV_LEN packet
Date:   Sun, 28 Jun 2020 13:52:43 +0200
Message-Id: <20200628115245.9638-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am preparing to add RECV_LEN support to Renesas I2C drivers. On my
way, I found these two peculiarities. Let's discuss them.

Wolfram Sang (2):
  i2c: mlxcpld: check correct size of maximum RECV_LEN packet
  i2c: octeon: check correct size of maximum RECV_LEN packet

 drivers/i2c/busses/i2c-mlxcpld.c     | 4 ++--
 drivers/i2c/busses/i2c-octeon-core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1

