Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB44C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A122054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458657;
	bh=8dsC/cTUUWFMRDDnC5VWZkXw703a+7EhD/xyNN/90Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=II5luawnoHwgrVhPaYlsJ3HCD/9qO7fFt/1dP5y92UiDlwqFDTO5LhGFIpsbpRhLa
	 PjdvIawl9eX+KlmcWbTHaHNPqXrYeaKeoGjOCWARfMoft96LBhPm/dro6GSxfeHdy5
	 I/h7o6MRd85NuVQk34feI7zA003jUPp3eBjUf6pQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgHCMoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgHCM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6E9207DF;
        Mon,  3 Aug 2020 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457705;
        bh=8dsC/cTUUWFMRDDnC5VWZkXw703a+7EhD/xyNN/90Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BH7PDv+AnkxRaQrxojDCMNI47PdvEyBmclEMkG674W3jo9uiBwZhLs1e+NFTdoptV
         /M2V5rk1HPD4zoABJ/ikHHApnIkLrmIsOW+QshEMkBcHdXAH71hzeq031geKKhgQiX
         V/epuJiAl0Vb51ZCeYYPN2b0nXlj7oye+hO4Db60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 5.4 27/90] drm/dbi: Fix SPI Type 1 (9-bit) transfer
Date:   Mon,  3 Aug 2020 14:18:49 +0200
Message-Id: <20200803121858.938327468@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 900ab59e2621053b009f707f80b2c19ce0af5dee upstream.

The function mipi_dbi_spi1_transfer() will transfer its payload as 9-bit
data, the 9th (MSB) bit being the data/command bit. In order to do that,
it unpacks the 8-bit values into 16-bit values, then sets the 9th bit if
the byte corresponds to data, clears it otherwise. The 7 MSB are
padding. The array of now 16-bit values is then passed to the SPI core
for transfer.

This function was broken since its introduction, as the length of the
SPI transfer was set to the payload size before its conversion, but the
payload doubled in size due to the 8-bit -> 16-bit conversion.

Fixes: 02dd95fe3169 ("drm/tinydrm: Add MIPI DBI support")
Cc: <stable@vger.kernel.org> # 5.4+
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200703141341.1266263-1-paul@crapouillou.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_mipi_dbi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -937,7 +937,7 @@ static int mipi_dbi_spi1_transfer(struct
 			}
 		}
 
-		tr.len = chunk;
+		tr.len = chunk * 2;
 		len -= chunk;
 
 		ret = spi_sync(spi, &m);


