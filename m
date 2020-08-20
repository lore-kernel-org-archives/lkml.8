Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B667CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978252173E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918815;
	bh=KEAipvMjfEorrai6eNDNy7y7VZLzrF8oFi2wdwB+n6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uy9vZW6j0ZvggRWG14LKulwDHHnjWjfuV8ttkCcJpljlt//IZ9cgEgw91cA+FhxzX
	 XpIpBincuSsKMSMHs4YE6feGCbw573Yh+v/mLtz8bDYCGY5AaALgkops09at//nONW
	 7+XD7NDctJi6K0qtrWbzO/tnLmVPLRfeH/HspInA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgHTKUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgHTKUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49435206DA;
        Thu, 20 Aug 2020 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918798;
        bh=KEAipvMjfEorrai6eNDNy7y7VZLzrF8oFi2wdwB+n6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTUwy/gRBlqe9JtWTyVPOxCihFDNO8TIKzRZSRAJHfXHxdI25+L1/y0aDP3fS0Evm
         ghIRx8jdqQqr79+wycXYxH0MDAZ3I081LEYJPItpgJ5YXXUrSdYtR2qb2v5xR1Uza7
         I4R2HbmF+ZWpnWD6YPTkrw7JZIXMQUQGFNLPnTN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 041/149] drm/nouveau/fbcon: fix module unload when fbcon init has failed for some reason
Date:   Thu, 20 Aug 2020 11:21:58 +0200
Message-Id: <20200820092127.725934128@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 498595abf5bd51f0ae074cec565d888778ea558f ]

Stale pointer was tripping up the unload path.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 343476d157266..edb3a23ded5d5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -566,6 +566,7 @@ fini:
 	drm_fb_helper_fini(&fbcon->helper);
 free:
 	kfree(fbcon);
+	drm->fbcon = NULL;
 	return ret;
 }
 
-- 
2.25.1



