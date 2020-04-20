Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31357C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B2520735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386523;
	bh=lUtbY+053Ai2lRHwjODFMXVMPnNRWPaJ+7OKN4N2kGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejDvKsAvuBs/+WM8dsxdOHlcVLjNLt2Sc/HiNM1OFQvN3V+Ms3U4ASEVq2tNB5D3l
	 AtAqvhjywuvHFn6LJ5HLSjUTdM/2ryz6PRZ5LVi/FbJnWVK4DwR9k6+pddIW4cu4zo
	 IkLSp7VoAji3/HvlE52tp/iijI+QTxqfwS1NkkrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDTMmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgDTMl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:41:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392ED2072B;
        Mon, 20 Apr 2020 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386518;
        bh=lUtbY+053Ai2lRHwjODFMXVMPnNRWPaJ+7OKN4N2kGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0H2om6vSMlXJfVzjzrQ16BZ0yeYeTZooYZ3cbL8iGu7YmAv7ipqMn4CP1p0KaKO3
         JkUO1Bdn0tlus/w/m2KnK4W+s1HpNh4cXFv1IRhHEP4N2AAM27uwTo/ClYz86z6GJk
         z2o8AYLCZWxLK5KdjqQbnonVIzbbNQOES2hvFCRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>,
        Mengbing Wang <Mengbing.Wang@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 56/65] drm/amdgpu: fix the hw hang during perform system reboot and reset
Date:   Mon, 20 Apr 2020 14:39:00 +0200
Message-Id: <20200420121518.853061544@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prike Liang <Prike.Liang@amd.com>

commit b2a7e9735ab2864330be9d00d7f38c961c28de5d upstream.

The system reboot failed as some IP blocks enter power gate before perform
hw resource destory. Meanwhile use unify interface to set device CGPG to ungate
state can simplify the amdgpu poweroff or reset ungate guard.

Fixes: 487eca11a321ef ("drm/amdgpu: fix gfx hang during suspend with video playback (v2)")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2259,6 +2259,8 @@ static int amdgpu_device_ip_suspend_phas
 {
 	int i, r;
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)


