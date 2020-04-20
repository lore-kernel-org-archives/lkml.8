Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5152C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0219206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387312;
	bh=bbRjPx1l8zYLS8ZjOXl1hmhn4EhtfYc4TTol1ueqNpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v477i0p/IDrMGg7X1bHGY3sGTxFhMq5znuBBFQZ2gOQrOBoNIojS9sY/eAh3Krl+X
	 h+V1H+s6b8cx07w3c5b5YE5CL30sR7NTMmbDqJuRGgZZ6kVGXiMVm2GgH3+3HZzRKY
	 YnQwqLN6fRLr59K9zR0QsbgQP8uKiEU3lfri7rkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgDTMzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgDTMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A84E2072B;
        Mon, 20 Apr 2020 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386755;
        bh=bbRjPx1l8zYLS8ZjOXl1hmhn4EhtfYc4TTol1ueqNpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnKh0fZ8ArI05gJxcYK7sLbFognsYTv5qDCXzy/x+Iq2hmhkU0zu7GIJ1+NAfZeDc
         bmwclHERV/JIZacoHu5bGYlyvUDgg6Do5DjCW+ySnOz23lhLsC6yA0Kug6cP4BMAs9
         nAKH7FgooHYi80Vsh2yimbYPtLRSDYRthu78a+IY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 14/60] net/mlx5e: Add missing release firmware call
Date:   Mon, 20 Apr 2020 14:38:52 +0200
Message-Id: <20200420121505.245092312@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit d19987ccf57501894fdd8fadc2e55e4a3dd57239 ]

Once driver finishes flashing the firmware image, it should release it.

Fixes: 9c8bca2637b8 ("mlx5: Move firmware flash implementation to devlink")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -23,7 +23,10 @@ static int mlx5_devlink_flash_update(str
 	if (err)
 		return err;
 
-	return mlx5_firmware_flash(dev, fw, extack);
+	err = mlx5_firmware_flash(dev, fw, extack);
+	release_firmware(fw);
+
+	return err;
 }
 
 static u8 mlx5_fw_ver_major(u32 version)


