Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C7C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C592084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550525;
	bh=1ftGPW7s24C2jbr6ck2vAVvoAxyuPjtTL4lXJBW5RAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3Vxe7rsin3eIj7b+6ZPVooajgMTZ9XZn2SFtEYdm4QXwiXstMX7sA8D1Lg4lVRjb
	 VJLwMf6Jclumd/a0z9zVQVG/EWSLp3SD+QtAWbhpRYJwierZkis2lWCeAKqkM9nWcN
	 eG6dqdCANs866vUQ6o0GgI5bMtwmYx/kz1S5/uIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgDVKPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgDVKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:15:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EA120575;
        Wed, 22 Apr 2020 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550509;
        bh=1ftGPW7s24C2jbr6ck2vAVvoAxyuPjtTL4lXJBW5RAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nZLzrlj6R1RuE4Py8w7AyuBZ95dcFr2so/Ab8LXZJ4I6RtOriR0wOmN6EuOPNyvC
         J6WWouWjGQYdYLOWiYvLEOIgJGdLGb5oDySqTz7es/O5W9txt0Yq561aDgzBD+dCYQ
         mJvGg32JeK7SWO6GeTOAKCbk1uJp2tvSjddgNHGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Zhang <Jack.Zhang1@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/64] drm/amdkfd: kfree the wrong pointer
Date:   Wed, 22 Apr 2020 11:57:28 +0200
Message-Id: <20200422095020.704513606@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Zhang <Jack.Zhang1@amd.com>

[ Upstream commit 3148a6a0ef3cf93570f30a477292768f7eb5d3c3 ]

Originally, it kfrees the wrong pointer for mem_obj.
It would cause memory leak under stress test.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
Acked-by: Nirmoy Das <nirmoy.das@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 938d0053a8208..28022d1cb0f07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -921,9 +921,9 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 	return 0;
 
 kfd_gtt_no_free_chunk:
-	pr_debug("Allocation failed with mem_obj = %p\n", mem_obj);
+	pr_debug("Allocation failed with mem_obj = %p\n", *mem_obj);
 	mutex_unlock(&kfd->gtt_sa_lock);
-	kfree(mem_obj);
+	kfree(*mem_obj);
 	return -ENOMEM;
 }
 
-- 
2.20.1



