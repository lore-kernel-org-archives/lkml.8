Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7AC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D50220753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQEDInAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbgEMAgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgEMAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:36:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C17C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:36:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w10so5055016ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFnha3juNtdQwnlUrwhd49/JpREi0dStok6F90+eN7s=;
        b=nQEDInAFXPsRlX9/jtjvkCM2Ej5QMxbBHmOJ6u7TuJEFEnOZY6l8ggcp2oBE9nojyR
         +mUGlSPaD1N0KRiwOiunygOMYmvbo0VYuvpuDwt+ae5zDFRU1320yC0EC82SiSa2dDeU
         GF/DbPR2wE4+cqGQsOafdasBoVH8dUK7fk77Z2UTZ54e65JoLJ9PEg6HMBgtQdHVsSGd
         k3ayduKbTDPdN9Nc8NUtr/oHu5LSfSBWq7AMoUevIg+g1F0NJOoxrhEgJAD9fPf0Un2x
         q3C0KBCOLZd1oYc9IA6k2HF9/JELPJVhB32hWfn5H+fMdKmscpcBbCvqD32Xu/jcthvG
         4bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFnha3juNtdQwnlUrwhd49/JpREi0dStok6F90+eN7s=;
        b=m+Mx8XYYokOeuBytJq56Joh7T/E+xAnAEQUR9j1kRiyp70FFctixaMxBL3ktU9VzEA
         lWdpzO3wm4rU9L9tGOu6aaJDIYkWwseBkXWuyB5+JMvqYDUPF9lq9WrNtukCprxobLyC
         xSlHz8rZ5nr/Hb+JSzP6C3vUnKpHozUshQMIVgk569Vzfr6UgUdL6u4GapcdGR1zDgiK
         EL8B7Cjn9xqqbrK4gDJkQ58B5iPqWGpXpc1atVsDCnVKZuBg6/izF9FiDjOMp1W26vPZ
         vInnXQ6t/BP1uDA2IiZDeO+rLcqVNr65XhC0npTeAPuo/sSG17oy4yv/c7yg6hZsbhR7
         F81A==
X-Gm-Message-State: AOAM530/2RjVBdpv5mCbfrhJMzq2GV9swu1dGXynI8O7kjWB+dATkPRk
        CMwV7EexOP8wvMp74dtrJh8=
X-Google-Smtp-Source: ABdhPJyDEH7lXddkX/hnRUfkHP88S8fhs9kXBQAB0sARubYVVNxL4tH1KDvojJLJUX8cgDgPykTfzA==
X-Received: by 2002:a2e:584a:: with SMTP id x10mr5412633ljd.181.1589330210801;
        Tue, 12 May 2020 17:36:50 -0700 (PDT)
Received: from EPUAKYIW2556.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id q7sm14216786ljp.20.2020.05.12.17.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:36:50 -0700 (PDT)
From:   Volodymyr Babchuk <vlad.babchuk@gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Subject: [PATCH] optee: don't fail on unsuccessful device enumeration
Date:   Wed, 13 May 2020 03:36:25 +0300
Message-Id: <20200513003625.651340-1-vlad.babchuk@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513003430.651232-1-vlad.babchuk@gmail.com>
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

optee_enumerate_devices() can fail for multiple of reasons. For
example, I encountered issue when Xen OP-TEE mediator NACKed
PTA_CMD_GET_DEVICES call. This should not result in driver
initialization error because this is an optional feature.

Thus, it is better to print warning, instead of termination driver
initialization.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---

resend: fixed email in s-o-b tag. Sorry for the noise

drivers/tee/optee/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 34409c916882..a053930032f2 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -728,10 +728,8 @@ static int __init optee_driver_init(void)
 		return PTR_ERR(optee);
 
 	rc = optee_enumerate_devices();
-	if (rc) {
-		optee_remove(optee);
-		return rc;
-	}
+	if (rc)
+		pr_warn("can't enumerate optee devices: %d\n", rc);
 
 	pr_info("initialized driver\n");
 
-- 
2.26.2

