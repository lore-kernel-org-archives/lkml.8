Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D908206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135323;
	bh=PP4vPcVc6oKV+IVd3pArqrJqOU60eDtrGsLUGpLvx6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9qffZXGOeRj4fRfW14U1OQ+WxoMzLVI1cqQWcwnO1JCQd4sP6QcbRyj4hBhiwmaK
	 0ZabSQqEgklJl7OkmGZRwyyqDrYffK/skM7ErIQBSZ7+kVEcZbPOPm8Bes1NSC6QO1
	 WbdYmgT8itqpgqWfK+MVhPPy6O4ksROTGYBVqJwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgGGPWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgGGPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:21:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CEC2065D;
        Tue,  7 Jul 2020 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135317;
        bh=PP4vPcVc6oKV+IVd3pArqrJqOU60eDtrGsLUGpLvx6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppWo/wF8sJcyAuHz3Q7QgSWP4HYWnuc/7sl/mthi8FxpCicUXuu9nJgSfIH/7REyM
         Wy281Crw4mKcbKWSboRD7WJiiaP2CU0PLO0gUEoooYuExSyUFtSxfnmuv39BSwuQ39
         8vVWvy8P3iBcjsltpKbagdcvy3NNH5+PJQcco8tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 58/65] drm/amdgpu/atomfirmware: fix vram_info fetching for renoir
Date:   Tue,  7 Jul 2020 17:17:37 +0200
Message-Id: <20200707145755.269878178@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit d7a6634a4cfba073ff6a526cb4265d6e58ece234 upstream.

Renoir uses integrated_system_info table v12.  The table
has the same layout as v11 with respect to this data.  Just
reuse the existing code for v12 for stable.

Fixes incorrectly reported vram info in the driver output.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -150,6 +150,7 @@ int amdgpu_atomfirmware_get_vram_width(s
 				(mode_info->atom_context->bios + data_offset);
 			switch (crev) {
 			case 11:
+			case 12:
 				mem_channel_number = igp_info->v11.umachannelnumber;
 				/* channel width is 64 */
 				return mem_channel_number * 64;


