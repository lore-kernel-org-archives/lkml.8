Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FCEC433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743342240B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753539;
	bh=H6E1ErTHKdU8VDL/lt494z9m+g1stL2ziOwVXwpMVPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fqw8RZaII+gVR6s1IkFqAyvUShYVT6IpInLCm5OFmH9UJmQtSycFfFAo5NPY1F6aU
	 NOp/HXRAzP5NIYfiILiQ1e4sm+LaXXBU9LFWnO+RAAyR9yZROyrzLEhh2TC30eFgYV
	 YW/i4U6BthmS6vFib6btrqEUeknfHv/hhpxr8MtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgGNSy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730724AbgGNSyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE7622B45;
        Tue, 14 Jul 2020 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752846;
        bh=H6E1ErTHKdU8VDL/lt494z9m+g1stL2ziOwVXwpMVPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irydP5Gq1mJxIVMoiNV6MAXLD6/eaA/63CHhir88Yqg9S/bDh4giPD0hI9PU6lS/d
         tLwzKDt0Hq48A8Nr4NRNGJuA3X0OT3t/0xeUlUT7MHpnyomQHFhKdvFzompIqDRVry
         5LrYE2AVeW+u+I4D6g2EnTKjyp+s6h1JjjKYNCKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 008/166] drm/ttm: Fix dma_fence refcnt leak in ttm_bo_vm_fault_reserved
Date:   Tue, 14 Jul 2020 20:42:53 +0200
Message-Id: <20200714184116.280848018@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 37cc4b95d13f311c04aa8e9daacca3905ad45ca7 ]

ttm_bo_vm_fault_reserved() invokes dma_fence_get(), which returns a
reference of the specified dma_fence object to "moving" with increased
refcnt.

When ttm_bo_vm_fault_reserved() returns, local variable "moving" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in several exception handling paths
of ttm_bo_vm_fault_reserved(). When those error scenarios occur such as
"err" equals to -EBUSY, the function forgets to decrease the refcnt
increased by dma_fence_get(), causing a refcnt leak.

Fix this issue by calling dma_fence_put() when no_wait_gpu flag is
equals to true.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/370219/
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 0ad30b1129821..72100b84c7a90 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -300,8 +300,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 			break;
 		case -EBUSY:
 		case -ERESTARTSYS:
+			dma_fence_put(moving);
 			return VM_FAULT_NOPAGE;
 		default:
+			dma_fence_put(moving);
 			return VM_FAULT_SIGBUS;
 		}
 
-- 
2.25.1



