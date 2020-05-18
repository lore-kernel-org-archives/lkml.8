Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B858C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3308720853
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825166;
	bh=p5LJN2BL+X8BsZ7djLn9xQKn454AbYO/tQ1JYNNEhuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPX8eCGvYfe62bi3IGOCWMC5PAz8LYSfTCz3ypYuvKqtOxgmtQTdk5jmW6fvkRaF2
	 o6Boj+mj9ORSg0+Ykh2LADZ0Qyd2+SYuV9BSK4pNMvh6TaPZpuzvBCKB210fxPwopo
	 J8myzePI5btldHX1sSJTF+VLzrAztFwqid8+M+sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbgERSGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733094AbgERSGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC8D20671;
        Mon, 18 May 2020 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825160;
        bh=p5LJN2BL+X8BsZ7djLn9xQKn454AbYO/tQ1JYNNEhuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zu5ZZ1Tmj9xukLgjTq+lSvaPkwMJD4tsvKeJBl0Vj4s+yyRqujyvqxhrOjyD4k8aN
         GnNarVwtWEhLEKUo85BTgID/v/8/plbe/6HuEn3XnX7x1Ih6T51YlZY/VSfI5MTICr
         GLeOlD2EmC2gayW48vF2XaeSmMncI1DOIWthBKsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom St Denis <tom.stdenis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.6 152/194] drm/amd/amdgpu: add raven1 part to the gfxoff quirk list
Date:   Mon, 18 May 2020 19:37:22 +0200
Message-Id: <20200518173543.902086334@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom St Denis <tom.stdenis@amd.com>

commit 975f543e7522e17b8a4bf34d7daeac44819aee5a upstream.

On my raven1 system (rev c6) with VBIOS 113-RAVEN-114 GFXOFF is
not stable (resulting in large block tiling noise in some applications).

Disabling GFXOFF via the quirk list fixes the problems for me.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1177,6 +1177,8 @@ static const struct amdgpu_gfxoff_quirk
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=207171 */
 	{ 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
+	/* GFXOFF is unstable on C6 parts with a VBIOS 113-RAVEN-114 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	{ 0, 0, 0, 0, 0 },
 };
 


