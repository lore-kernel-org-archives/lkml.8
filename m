Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD68C1975A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 08:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808C220880
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583654961;
	bh=uxxUuyobuFM1LmIEjIDa33YJQIHA/VSsyHgILYAFfl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VrzryQLllkxgi5wqRumSYLWwb27CXFAZjM1bERBEyZ5GZfETEYksNEpQ/T0vkJfLW
	 cyGbuFSm9hcT9dS8MlNjICz7abwECIqXTp1tFDoA55YiUWlVHZjpxqGcZUm8zFOPJo
	 Zeo4Dqs1blzpbSYYI97QQNojp1lgPR4uXScjMhug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgCHIJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 04:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgCHIJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:17 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115262084E;
        Sun,  8 Mar 2020 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654957;
        bh=uxxUuyobuFM1LmIEjIDa33YJQIHA/VSsyHgILYAFfl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLcbgq0hgCgLUVYbe46uUB5726mHuJOh172HAxg5hucu2FdEwz4JD/+i+wW+UsSgw
         JUWnCVpyG4Q8KpwGaF3tKTFTP8iYd9x+kCjYI8UiY5pKjvoisRCf+Y/INxPm6alSXV
         P+GlPFveBvIEHEK1R8B8DuGaCybn+m9+KgOY24J4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 03/28] efi: don't shadow i in efi_config_parse_tables()
Date:   Sun,  8 Mar 2020 09:08:34 +0100
Message-Id: <20200308080859.21568-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

Shadowing variables is generally frowned upon.

Let's simply reuse the existing loop counter i instead of shadowing it.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Link: https://lore.kernel.org/r/20200223221324.156086-1-xypron.glpk@gmx.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5f77cb8756ef..91f546dc13d4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -611,7 +611,6 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		while (prsv) {
 			struct linux_efi_memreserve *rsv;
 			u8 *p;
-			int i;
 
 			/*
 			 * Just map a full page: that is what we will get
-- 
2.17.1

