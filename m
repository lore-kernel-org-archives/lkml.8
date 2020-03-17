Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834D520658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443449;
	bh=TZzdiRnPo1IpWNQTesJXuKMNzVAP31ydc9OdMaEiuUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vIuBDDmZVQTvLbZ0GCEb1WhOV3EQXl9EeX/4wiw5R6HTIo4vMDBkRpjZor7uzU6v8
	 X+3A/hSYBeI0KYIrUC7Wj79sTSsAlhjEyovN/IbrROtKoajiJRPwX/tMBVeDcCcJSa
	 oXF2QsQNiwT5PWUR5znaizqAS5rlaah3CsPmmJJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgCQLKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbgCQLKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE8520658;
        Tue, 17 Mar 2020 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443445;
        bh=TZzdiRnPo1IpWNQTesJXuKMNzVAP31ydc9OdMaEiuUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRI3ogLj7D3V1dlSHgX4BytfO8b31DEMv106XrJW110nWwgGdhJIIjsxGmmodWnR4
         vaCj8b8qdewPH69x3ORHpU18xEcMH+u7pNKVvDBUk7MSEwJrOE1QVI7eqR2roNFA4F
         bUvwEQTUAM4uccA8O2/Ro8zEJfTQjFhQntOzeVpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 5.5 084/151] drm/amd/display: remove duplicated assignment to grph_obj_type
Date:   Tue, 17 Mar 2020 11:54:54 +0100
Message-Id: <20200317103332.422238328@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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
@@ -365,8 +365,7 @@ bool amdgpu_atombios_get_connector_info_
 			router.ddc_valid = false;
 			router.cd_valid = false;
 			for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
-				uint8_t grph_obj_type=
-				grph_obj_type =
+				uint8_t grph_obj_type =
 				    (le16_to_cpu(path->usGraphicObjIds[j]) &
 				     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
 


