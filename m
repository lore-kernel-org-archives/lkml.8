Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E070DC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE2624673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272761;
	bh=sMUNR4yGWZ+2fKyLeI7Zo66jkrR7W2W8hwkVr/geNGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yvbv1xYTm2Y1bLDcYTMnkHcfJ6xCQTAKpBHgr6myfmxJv9rTrUYDc7eIlub03QL1n
	 dCVl37cOqJJAoxAT7n/vaWc3Sv4MUGxmSBPAe3QCWfhZsWr6LmkGP5FCiVZFdZt3Uu
	 zscSXX620CH3WMmtPdOcyz55J2fZ0ETvHh58OA6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbgBUIMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732638AbgBUIMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:12:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7185E20722;
        Fri, 21 Feb 2020 08:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272758;
        bh=sMUNR4yGWZ+2fKyLeI7Zo66jkrR7W2W8hwkVr/geNGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATxkbCzTKi4vzb06LhCIlkM4CcV9JMIKmWhsiy4833L30CwvIEAkJhUcz2YggK3+W
         Biyh5vIdBfyRnh48USHTPP1VotOCfonzKQaHDh1Ztc1aCLgeZk5rXpbx7T48lLOiA5
         aYB1R93iEgmxjw8pPjcIIar6eZORC2SuWywzJ5cI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 227/344] drm/nouveau/fault/gv100-: fix memory leak on module unload
Date:   Fri, 21 Feb 2020 08:40:26 +0100
Message-Id: <20200221072409.856239311@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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
index ca251560d3e09..bb4a4266897c3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c
@@ -146,6 +146,7 @@ nvkm_fault_dtor(struct nvkm_subdev *subdev)
 	struct nvkm_fault *fault = nvkm_fault(subdev);
 	int i;
 
+	nvkm_notify_fini(&fault->nrpfb);
 	nvkm_event_fini(&fault->event);
 
 	for (i = 0; i < fault->buffer_nr; i++) {
-- 
2.20.1



