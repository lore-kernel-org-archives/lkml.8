Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5332C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FEF20774
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597074069;
	bh=SBJBhjEf5WQoaV758p8LTeeZcqluZ9Hz0KwBVAwXsxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UKBh+mlSI/4DFxINjJr0oyv7Jl0m5OJTdJ/KXHEoaCruCHOID3Yb9xuC95FCGnEbV
	 RHXCitQIOqXpCgZXrxiBpxBvh+VmfBd01uvA2l1nODuXhVZalYcXgkDVgQdy/joXZT
	 8K5g3ru8W+rTpoNB/zZhxfnL4xrjnW3SzMjqUinw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHJPlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgHJPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:23:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F93D207FF;
        Mon, 10 Aug 2020 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073011;
        bh=SBJBhjEf5WQoaV758p8LTeeZcqluZ9Hz0KwBVAwXsxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NqTudXEdJYRqrlq3TektEpETKYx4teslX0hg4C5ZjHmMs7sbBeB8Nb6goinR/qxp
         Ka4HsCwVhzDtiyS7lw7Zfsk8Qvg392XBXIGGiYZPkJ0iCU/dATrBmJHDtrsw8EVxnV
         x/ZoRSh0IGtPhtAkoiVj0brW/FTZaYvinXwUz+aQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 34/79] drm/nouveau/fbcon: fix module unload when fbcon init has failed for some reason
Date:   Mon, 10 Aug 2020 17:20:53 +0200
Message-Id: <20200810151813.967903895@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
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
index 24d543a01f435..e42100a2425fd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -588,6 +588,7 @@ fini:
 	drm_fb_helper_fini(&fbcon->helper);
 free:
 	kfree(fbcon);
+	drm->fbcon = NULL;
 	return ret;
 }
 
-- 
2.25.1



