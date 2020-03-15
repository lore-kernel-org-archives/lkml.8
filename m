Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E95C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B6720637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTyejLGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCOHV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:21:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34618 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCOHV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:21:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id i24so13962450eds.1;
        Sun, 15 Mar 2020 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uc3tUPFRMKpOBHISvMn5YQ4zt6tuto3i0ER6vMBt8yA=;
        b=kTyejLGY2WPpBLC4/mkBzwppvQ0gbvnKLPnUh4tlFKU7VQNZ4DxfGjB1z2kbyR+o3v
         FN9i9wirp9hu9AeiSwpyqol3haVRchFjCGPvj/se3QmBeTNkJdsi1ut7wabk0dwO+/zH
         EpMCIC0dzNdAvEgY9sLvFUFsxvNAtM85IRnwYsL71ux4lXpY1svBRRaF7WQLBU+/ev+6
         5grnvMsxUxIy/EA22XeXM51LwOnDZztyctSa5fpwi2bLNh6q8xG7c1ZBzmrC3hJj2x3A
         v0iJdE/8/cQuAYHqCKce7CR+wJKHLrH+et1OKbPVIhr4igoZAzRD0IrPqjuhpHf7R71K
         VghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uc3tUPFRMKpOBHISvMn5YQ4zt6tuto3i0ER6vMBt8yA=;
        b=rnxr81lus5fJPHSvcnF8UUy0Wzep6hHQzTFC3XNK0p4xmASTm/KcDfI4vhYmk29E0x
         qYBVwSmxgf5Sasw4K4JP8NsW7pFJyzzi89R0oYtyJShG95H3b65b6LD8DzWPungdJanR
         q+XTPQA2o4xI3siPhAqXoe+j/lD0r0zFcumBSVQIb57EOn6pB+DB/IcWoNv+jj0jzaUw
         jYmxNyEUZcobmUHdiyeILPpq1o4Ih41uge2DqKeG0QHnb/GAMLkRUxDbeSiBIbAV6QU1
         vKcWTgYcV6eK0vhCrfpxUHTiSlbEkD9rkF7126rdE3hkqOubrDgcryL38SiJTdr5r4cy
         oGZQ==
X-Gm-Message-State: ANhLgQ2yq6ncieQnV0ldY6tteJMmGjrkEfGnFLoPhBu7eQ66zgRVCaee
        w9V85thD4BFxvq1BgWC9F9U=
X-Google-Smtp-Source: ADFU+vuNwPtaanANlsW3pFS/owgZW33ZS8LHiCmmEX3cDJcX+ZdUwMopIn2grErjKpqQ6uaVWEE5fg==
X-Received: by 2002:a17:906:7a54:: with SMTP id i20mr18547767ejo.100.1584256884059;
        Sun, 15 Mar 2020 00:21:24 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d6c:6c00:888a:952a:33bc:a081])
        by smtp.gmail.com with ESMTPSA id k8sm119650ejq.36.2020.03.15.00.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 00:21:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to VIVANTE GPU schema conversion
Date:   Sun, 15 Mar 2020 08:21:09 +0100
Message-Id: <20200315072109.6815-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 90aeca875f8a ("dt-bindings: display: Convert etnaviv to
json-schema") missed to adjust the DRM DRIVERS FOR VIVANTE GPU IP entry
in MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches \
  F: Documentation/devicetree/bindings/display/etnaviv/

Update MAINTAINERS entry to location of converted schema.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200313

Benjamin, please ack.
Rob, please pick this patch (it is not urgent, though)


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77eede976d0f..50a7a6d62e06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5766,7 +5766,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	drivers/gpu/drm/etnaviv/
 F:	include/uapi/drm/etnaviv_drm.h
-F:	Documentation/devicetree/bindings/display/etnaviv/
+F:	Documentation/devicetree/bindings/gpu/vivante,gc.yaml
 
 DRM DRIVERS FOR ZTE ZX
 M:	Shawn Guo <shawnguo@kernel.org>
-- 
2.17.1

