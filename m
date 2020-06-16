Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEEAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0ED82071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322587;
	bh=h117viqMI6tSMFemKRGUcqrURTlQKffWF6U0GKYbEog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n425+jPbQwjfk43oDHD9a+2LuNXSGoKljpVjboufZQVSv+SJ2HuGOlyiXOu6v1eL0
	 6uV07pWFMLOEyFoQYr1DO0ZfcWBQBrvOBtb/ssi59XvbcIB6pZ98f+Tu4pgn/++yJi
	 lg8soBrjmGOYh4kdYCKUpSPgxZykfIiQocMvdGK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbgFPPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732299AbgFPPti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:49:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247F42071A;
        Tue, 16 Jun 2020 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322578;
        bh=h117viqMI6tSMFemKRGUcqrURTlQKffWF6U0GKYbEog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3Cqtrhgnr9WqsATkgW6qtIaaljFW0UIZsSJ2z7pzAJzlMtUPjXYnJ7go/sonIn02
         v+ACdD9V9GmodLC2A2ElgwKLxI5dgJUkjsjsaydoSiMZOCVZptpvHXNSVyaqEdnRlu
         T+IDshehsbuRlcX00F5zYKI1DgXnqSQrZOVzr8Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 022/161] staging: wfx: fix double free
Date:   Tue, 16 Jun 2020 17:33:32 +0200
Message-Id: <20200616153107.452221697@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

[ Upstream commit 832cc98141b4b93acbb9231ca9e36f7fbe347f47 ]

In case of error in wfx_probe(), wdev->hw is freed. Since an error
occurred, wfx_free_common() is called, then wdev->hw is freed again.

Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Fixes: 4033714d6cbe ("staging: wfx: fix init/remove vs IRQ race")
Link: https://lore.kernel.org/r/20200505123757.39506-4-Jerome.Pouiller@silabs.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 76b2ff7fc7fe..2c757b81efa9 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -466,7 +466,6 @@ int wfx_probe(struct wfx_dev *wdev)
 
 err2:
 	ieee80211_unregister_hw(wdev->hw);
-	ieee80211_free_hw(wdev->hw);
 err1:
 	wfx_bh_unregister(wdev);
 	return err;
-- 
2.25.1



