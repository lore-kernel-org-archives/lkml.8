Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F853C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1912C20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582072;
	bh=Hun363eN4I4GDgnv/6/COhdFYcOMePNwa8J/7LCfEME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOue/Ct/QuT2zx4Ferpef9ZH8sFfrL5B4Z2aLg/D8iTStHoy4l9C2k5ENGw7EYcRh
	 jFZ3Lbt5P5bRsWWhNPBFmxCj1XBUeKUI6lwDE1vSh0MbzV9xqSaTeNkcrapltBjirL
	 C0L7YNJWXewVUuiE52ofV9+rtHYBdh1a8ASnBAaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393155AbgFSPy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392920AbgFSPVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7917A21548;
        Fri, 19 Jun 2020 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580114;
        bh=Hun363eN4I4GDgnv/6/COhdFYcOMePNwa8J/7LCfEME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z01ZnaLczavRMRhRgmf3O2hXvvmhQJ3fD3QOUfbt12VjVJ55nfEilTk5S8uVvSmC4
         DdnvjPY3qzeeGi/t4Dw8sOzyVyDzBMbD8lFLFUcaBhRfCBQuOQrJj+L2iZ15Ez/+gf
         3AZjczJIH3e6SgGceIuqyjhqZw1b1cSN1fHVDoG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 128/376] media: m88ds3103: error in set_frontend is swallowed and not reported
Date:   Fri, 19 Jun 2020 16:30:46 +0200
Message-Id: <20200619141716.394867701@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

[ Upstream commit c4ed27cfed45c16c2dd16c9fa3b883e306177e40 ]

Bail out if registers can not be updated.

Addresses-Coverity-ID: 1461655 ("Code maintainability issues")

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Fixes: e6089feca460 ("media: m88ds3103: Add support for ds3103b demod")
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/m88ds3103.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index d2c28dcf6b42..abddab02db9e 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -980,6 +980,8 @@ static int m88ds3103_set_frontend(struct dvb_frontend *fe)
 			goto err;
 
 		ret = m88ds3103_update_bits(dev, 0xc9, 0x08, 0x08);
+		if (ret)
+			goto err;
 	}
 
 	dev_dbg(&client->dev, "carrier offset=%d\n",
-- 
2.25.1



