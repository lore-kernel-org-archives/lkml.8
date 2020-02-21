Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68869C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AC524697
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273346;
	bh=YIGZT7Mw55e964DtErPouRe21GxqEoy89dkTezE1Oy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqXXZfV+asAPtey9mmv+ZkuIZxI1bFKMvxxomChibll+FAfpHervVsdcfBjGyzptN
	 NpWs+TbYNMHbr0TkBeo5FI7sZVX8TQVDi75IWz0S2oy25ZDNdI41PkFNnSydVSY14f
	 p6RGyle68DcQN9sy9X9SYpRGCypGM1MzDOxLojfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgBUIWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbgBUIWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:22:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9668206ED;
        Fri, 21 Feb 2020 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273340;
        bh=YIGZT7Mw55e964DtErPouRe21GxqEoy89dkTezE1Oy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhVICAlalTpaWpfL1Q6nWT+pL85nf2eNmAW/WujH8qB/Eq5JJpKtBKpm5osMtnf0B
         ApWO6uVOYPRr31QOQo/WkeX7P561gQQa8npGWZMYAx1EJq9vFpxOBtEgaq2F9Vyajn
         VXKJRjYmi542Gx09DSk+qlvNSYhmBjibwO+xjoQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/191] drm/nouveau/fault/gv100-: fix memory leak on module unload
Date:   Fri, 21 Feb 2020 08:41:40 +0100
Message-Id: <20200221072306.171221239@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 633cc9beeb6f9b5fa2f17a2a9d0e2790cb6c3de7 ]

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
index 16ad91c91a7be..f18ce6ff5b7ed 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
@@ -150,6 +150,7 @@ nvkm_fault_dtor(struct nvkm_subdev *subdev)
 	struct nvkm_fault *fault = nvkm_fault(subdev);
 	int i;
 
+	nvkm_notify_fini(&fault->nrpfb);
 	nvkm_event_fini(&fault->event);
 
 	for (i = 0; i < fault->buffer_nr; i++) {
-- 
2.20.1



