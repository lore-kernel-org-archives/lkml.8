Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DFCC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487A220776
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623200;
	bh=TwspLGjNyWHPwiiseWYL3giob80lu2Wuvgm/k5C67W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bnCKF8vRp3TOR5HOVsTKwbeMC+31JVSFGOMGWSyvnzyZ/EA9xGHJDe2zAawBUifN4
	 /qfX0Ut6LWr1P9PyVtk8elqVyVNwtRk+EG9HyItg6Q7doLnLrqOLFYXkAEu+DPTvNj
	 k1ILlMpcCRS6G49Knowu7XFCa7frKILeE2NIvXGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCSNGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgCSNGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C1B20739;
        Thu, 19 Mar 2020 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623196;
        bh=TwspLGjNyWHPwiiseWYL3giob80lu2Wuvgm/k5C67W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a05cPPb7NWtnGcLnGfoVJJhV9UBUNU7JylPFw6IRGE/dwiFVslt+SfgcK5IrxtNqj
         kWwkHL+I+tJJ9eX5RcA4YSrpRKHA983OPW9MMugd3hp3oYbE6nNA//2/ffKobXbokO
         mUDsLZFy3D0P1r0YaKKJHGLz0UwsW06r5j8P8ZIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 4.4 23/93] drm/amd/display: remove duplicated assignment to grph_obj_type
Date:   Thu, 19 Mar 2020 13:59:27 +0100
Message-Id: <20200319123932.423300891@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit d785476c608c621b345dd9396e8b21e90375cb0e upstream.

Variable grph_obj_type is being assigned twice, one of these is
redundant so remove it.

Addresses-Coverity: ("Evaluation order violation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -346,8 +346,7 @@ bool amdgpu_atombios_get_connector_info_
 			router.ddc_valid = false;
 			router.cd_valid = false;
 			for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
-				uint8_t grph_obj_type=
-				grph_obj_type =
+				uint8_t grph_obj_type =
 				    (le16_to_cpu(path->usGraphicObjIds[j]) &
 				     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
 


