Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC691C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1A4206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944396;
	bh=WVZRPf304XDTXTsxZtHmCIrnuF/WwjdfFiKYz5fD9Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NI3XUyrcn38GjpKLpSDzPfEhzjwuJKIUJlOnt7y9tWInaPRaNACW2rT5hiJ+Dqxcu
	 jS/+/n8o1PTvnXg3zIkOvYMl6ItJjPCdN4J94+Adie0H2Br0DAW/Q6XyrMMewDBRh5
	 orEfSLbsM62TNbSwx8O6MCrtG1G951ZRlTTiQj2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbgFWUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391390AbgFWUdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011552072E;
        Tue, 23 Jun 2020 20:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944389;
        bh=WVZRPf304XDTXTsxZtHmCIrnuF/WwjdfFiKYz5fD9Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VncUxsEFqHePjn7f5dUKXLu2PLwUlSMsudJc2ZmEMMG8/XVrguEb1U28cV3R3oBP/
         Ti+IhZpI/jf36JhltpGQmJUYH4iphHDNLRz1iHzvgpgGPhSquBNmSdjdYKtb1ERd3+
         b5vDG+l1dZgYSYP+mUII6JsksCvSX8mnULQN5c0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandeep Raghuraman <sandy.8925@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 285/314] drm/amdgpu: Replace invalid device ID with a valid device ID
Date:   Tue, 23 Jun 2020 21:58:00 +0200
Message-Id: <20200623195352.576945071@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Raghuraman <sandy.8925@gmail.com>

commit 790243d3bf78f9830a3b2ffbca1ed0f528295d48 upstream.

Initializes Powertune data for a specific Hawaii card by fixing what
looks like a typo in the code. The device ID 66B1 is not a supported
device ID for this driver, and is not mentioned elsewhere. 67B1 is a
valid device ID, and is a Hawaii Pro GPU.

I have tested on my R9 390 which has device ID 67B1, and it works
fine without problems.

Signed-off-by: Sandeep Raghuraman <sandy.8925@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -239,7 +239,7 @@ static void ci_initialize_power_tune_def
 
 	switch (dev_id) {
 	case 0x67BA:
-	case 0x66B1:
+	case 0x67B1:
 		smu_data->power_tune_defaults = &defaults_hawaii_pro;
 		break;
 	case 0x67B8:


