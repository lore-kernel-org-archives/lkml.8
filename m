Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE60C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E11924672
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271812;
	bh=BOAuucgOG9GcK1LGryZaUi2poccOqBLsVdu3ZCwoLF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dSbx9R2Psul86mIhyQL46ecUj9T4AyrBx+qKD4TQmQIhgqFa8r7PiCtvhTKjbvzqP
	 ZzGM1ga2asaQIWX4VW4edCH7qzY7CPH97W7A+cttBCZ2GXURTGGN3KmOEB1R+M7ot1
	 UT8sYCOz+KTzk/Bx+HIE5tH38WyDJI9FlN6WK0EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgBUH4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730519AbgBUH4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:56:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636A4222C4;
        Fri, 21 Feb 2020 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271805;
        bh=BOAuucgOG9GcK1LGryZaUi2poccOqBLsVdu3ZCwoLF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GiWET3qvNhHJEduv7U1Sgq00ScuBrrWX4Ptx5fsVjGj9SmePSQGEz5Lc4kUXQZVB
         U4Z0wPNiTSwwosYwd5CMHQTeaGcaG7d11G6fQtdXiK5p3HR0UZrn1uYtjF3DcbdYVI
         csFuJH9Fzg4AehBLaNbNuIN9ysBQ7sOmmgl4sYsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 304/399] cmd64x: potential buffer overflow in cmd64x_program_timings()
Date:   Fri, 21 Feb 2020 08:40:29 +0100
Message-Id: <20200221072431.207475068@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 117fcc3053606d8db5cef8821dca15022ae578bb ]

The "drive->dn" value is a u8 and it is controlled by root only, but
it could be out of bounds here so let's check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/cmd64x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index a1898e11b04e6..943bf944bf722 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -66,6 +66,9 @@ static void cmd64x_program_timings(ide_drive_t *drive, u8 mode)
 	struct ide_timing t;
 	u8 arttim = 0;
 
+	if (drive->dn >= ARRAY_SIZE(drwtim_regs))
+		return;
+
 	ide_timing_compute(drive, mode, &t, T, 0);
 
 	/*
-- 
2.20.1



