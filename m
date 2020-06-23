Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30DC20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945639;
	bh=xsEemSVClBSYwMcHKANH8z4YMvLMfn/bGcHs66SH8PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAZDqi/XCZGcdAkv6gt9ttBG4TmeUtXESp94WSljxGFVDncZGgl3hoOpTNni7FAv7
	 oZ17xXoPM1UvWPA2lwnnj66fwE3Mbqc62N2H4B+VYHrZrfNr08j6bzLhfhKn4xEr8+
	 Tbg9qXKRBd2R5odf6GaXtfIhNhop8iej5vns1qnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgFWUx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392814AbgFWUqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AAE2098B;
        Tue, 23 Jun 2020 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945172;
        bh=xsEemSVClBSYwMcHKANH8z4YMvLMfn/bGcHs66SH8PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIMaHRO8sROsbqcxMc7XcXHLlWgAFzynuDrp052PqdGrfuZvx6INFx6wR8Sf9cUdo
         KIiTKkbiNU9azhM5d4Hx1fP/wMCHhyoqjd8tzYAGaqCorM2Vo0ozjXh3up/1V1BQ81
         RdY4CLmPYBugl/pKw8SEE68YhTIsytvU+GGnD6Ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 036/136] staging: greybus: fix a missing-check bug in gb_lights_light_config()
Date:   Tue, 23 Jun 2020 21:58:12 +0200
Message-Id: <20200623195305.452049835@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit 9bb086e5ba9495ac150fbbcc5c8c2bccc06261dd ]

In gb_lights_light_config(), 'light->name' is allocated by kstrndup().
It returns NULL when fails, add check for it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Link: https://lore.kernel.org/r/20200401030017.100274-1-chenzhou10@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 4e7575147775d..9fab0e2751aa6 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1033,7 +1033,8 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
 
 	light->channels_count = conf.channel_count;
 	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
-
+	if (!light->name)
+		return -ENOMEM;
 	light->channels = kcalloc(light->channels_count,
 				  sizeof(struct gb_channel), GFP_KERNEL);
 	if (!light->channels)
-- 
2.25.1



