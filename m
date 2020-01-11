Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED0BC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2659A206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737375;
	bh=Nip9aVX8e8y6eoB1GOjy/sZosxX8qCKCPq23dD8hLSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9N0x6Enpj0HhLqfnxgq767UnzdC/QIqrMfYEK25s73HDIKK6uZjkup4P0cY9/t/f
	 rBkwtmhg6U/KskYao99wrYSjEn+MuH1HI4cP3V1p8QAx3lrmSRIW/t2YvOClRjPI8J
	 4dUlKXTtgeWy5++ElD9i3evyJzcgTr66KpFHxen8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgAKKJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbgAKKJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:09:32 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29DE3206DA;
        Sat, 11 Jan 2020 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737372;
        bh=Nip9aVX8e8y6eoB1GOjy/sZosxX8qCKCPq23dD8hLSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuHx0x50UgiQSl0i7KOwQ7OLjMouYw7E84C6ZyxWNurZOsmPiqXkDk5SgY1NZQVYF
         ndOHk1aYz5J9RkS6px6UvcqMwgZg17wMnMFvTiORh29tPLv7FIH1fKrzaqLXAVzlkz
         cXqCrv1pHW1RAZAPIfoc+/LYxXxlDEjeT2fxruzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 24/62] bnx2x: Fix logic to get total no. of PFs per engine
Date:   Sat, 11 Jan 2020 10:50:06 +0100
Message-Id: <20200111094844.549272785@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094837.425430968@linuxfoundation.org>
References: <20200111094837.425430968@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit ee699f89bdbaa19c399804504241b5c531b48888 ]

Driver doesn't calculate total number of PFs configured on a
given engine correctly which messed up resources in the PFs
loaded on that engine, leading driver to exceed configuration
of resources (like vlan filters etc.) beyond the limit per
engine, which ended up with asserts from the firmware.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 4e091a11daaf..52bce009d096 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1112,7 +1112,7 @@ static inline u8 bnx2x_get_path_func_num(struct bnx2x *bp)
 		for (i = 0; i < E1H_FUNC_MAX / 2; i++) {
 			u32 func_config =
 				MF_CFG_RD(bp,
-					  func_mf_config[BP_PORT(bp) + 2 * i].
+					  func_mf_config[BP_PATH(bp) + 2 * i].
 					  config);
 			func_num +=
 				((func_config & FUNC_MF_CFG_FUNC_HIDE) ? 0 : 1);
-- 
2.20.1



