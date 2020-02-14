Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DD9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4957220873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702367;
	bh=XVGy6iK7CadxPsP1+MFoAhGr6E5YoTKUWdF1RoQobYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fb9noXZjJaLC/Bi4y4t69QwyO6PavDpyFyKSrdAMz0JUSJwG2KU1kJYykxWYlQeTi
	 uRVvkdQHmvDTMTjZ38FDpTQrNjVER7jTs3JjPeCGq2UqEkRhv5UnDeZGkSNWB91TvX
	 2YMiRWlv4lMYsAom4RlfyrD9hg/uMeyoTVNZgSBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgBNRqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389383AbgBNQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8F12067D;
        Fri, 14 Feb 2020 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696151;
        bh=XVGy6iK7CadxPsP1+MFoAhGr6E5YoTKUWdF1RoQobYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqmTaKr/UTGz7pKqAeYzoqg+Y922tMLLqhYDwp9I+A+/C4mNYslLifUqfEDNBmucH
         Wtn6uTI1BxI0WlkTPrbYl4b2/hKG7Ft/Xe+ovuUUsbKy0YqO/9ofP6d0MmY7h4KE4N
         gutnu0hEgS1eoswg8h6Zm5K7zbwcWCLXxu9Jl+RQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 031/459] drm/mipi_dbi: Fix off-by-one bugs in mipi_dbi_blank()
Date:   Fri, 14 Feb 2020 10:54:41 -0500
Message-Id: <20200214160149.11681-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2ce18249af5a28031b3f909cfafccc88ea966c9d ]

When configuring the frame memory window, the last column and row
numbers are written to the column resp. page address registers.  These
numbers are thus one less than the actual window width resp. height.

While this is handled correctly in mipi_dbi_fb_dirty() since commit
03ceb1c8dfd1e293 ("drm/tinydrm: Fix setting of the column/page end
addresses."), it is not in mipi_dbi_blank().  The latter still forgets
to subtract one when calculating the most significant bytes of the
column and row numbers, thus programming wrong values when the display
width or height is a multiple of 256.

Fixes: 02dd95fe31693626 ("drm/tinydrm: Add MIPI DBI support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20191230130604.31006-1-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index f8154316a3b0d..a05e64e3d80bb 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -367,9 +367,9 @@ static void mipi_dbi_blank(struct mipi_dbi_dev *dbidev)
 	memset(dbidev->tx_buf, 0, len);
 
 	mipi_dbi_command(dbi, MIPI_DCS_SET_COLUMN_ADDRESS, 0, 0,
-			 (width >> 8) & 0xFF, (width - 1) & 0xFF);
+			 ((width - 1) >> 8) & 0xFF, (width - 1) & 0xFF);
 	mipi_dbi_command(dbi, MIPI_DCS_SET_PAGE_ADDRESS, 0, 0,
-			 (height >> 8) & 0xFF, (height - 1) & 0xFF);
+			 ((height - 1) >> 8) & 0xFF, (height - 1) & 0xFF);
 	mipi_dbi_command_buf(dbi, MIPI_DCS_WRITE_MEMORY_START,
 			     (u8 *)dbidev->tx_buf, len);
 
-- 
2.20.1

