Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E09C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D99B20759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWZq8UqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHHQcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:32:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36239C061756;
        Sat,  8 Aug 2020 09:32:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so4171897wmd.4;
        Sat, 08 Aug 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YY27ejOhWWl0/zCI3UhZ26XB8ZK0g1YDum2gYnBcYs=;
        b=YWZq8UqK9LEB3axsE72yKvgi+/PjU2n+Blkfw910dNDGJVqVSCCXABDqSmfBjZ7lH9
         6rokWdJrCL+LqNFC2Z3b1nD2CLIP+WSMK3zh8ppboK6v3c+1KDkftTANKVaZfHnCiHPW
         EbasExq9b/N5uDL5EIw6ZUMIz15k89gB5BwbGzgsEk8jp0MWyntede+3dxJQFXSoT+iM
         POsdOOI8mXVqqTW2x4hiThzVwzzgotUV5r8Alqx9p4Dzn5s2xZErt1MDceQM0RpIWd9z
         g9sfQ0glXEtXSPpTNmMJo7Hmnnn4FhYvNK60BnYNP5j/+L2Aul7pP/ElL6WWp0zicGE8
         U6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YY27ejOhWWl0/zCI3UhZ26XB8ZK0g1YDum2gYnBcYs=;
        b=QV47w1GHw6KmHednmeS3KpLeSkevNtxmI0F7GMuwJqHlbuF2onI5EADnLYU8te4i0A
         0nEhiZ6vWP0u3pUjxo+e3OhxBo2UzjDGQBd1eYO90aZKuhGbDGGWFUmlYSkc/XBFR0rm
         X8se5ePOzM3cGhq8kW5jCD9aAzZ8PvcAWHL4myrV0l8hrozm2zVAm5Ix7vvvUwIxVuVk
         Qj56SYfnoubpaC2ykCgOqZ8mOjZ5NQfZqvXew7M+NGomBF39KMvmUB0p4WSvCry9v5UQ
         gPvHz5UQfFw+FUnz8h6kJ6h2AQUGRH9czdAvAEg2D5cZwqtddIsN6wKx7UNLPMXg2BZd
         w6sw==
X-Gm-Message-State: AOAM532my52Qvcu34W6lo4iHCjFeW8/to2tmHm8t0+gdiVZzOfHqJ/N6
        sb5VKyw8YntAmN9+AiEpE+4=
X-Google-Smtp-Source: ABdhPJzMQnqPo2oAu9yrRoG/CUFxCneDnin6Q3+yf0iq9KnF5GkNbclvrRLInCj4esI4QUWC9o4Gpg==
X-Received: by 2002:a7b:cb50:: with SMTP id v16mr13429807wmj.11.1596904338870;
        Sat, 08 Aug 2020 09:32:18 -0700 (PDT)
Received: from franz.home (2a01cb000b4dac00dbd2476490a34fd2.ipv6.abo.wanadoo.fr. [2a01:cb00:b4d:ac00:dbd2:4764:90a3:4fd2])
        by smtp.gmail.com with ESMTPSA id j24sm15630450wrb.49.2020.08.08.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:32:18 -0700 (PDT)
From:   Remi Andruccioli <remi.andruccioli@gmail.com>
Cc:     Remi Andruccioli <remi.andruccioli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: cdrom: Fix a typo and rst markup
Date:   Sat,  8 Aug 2020 18:31:23 +0200
Message-Id: <20200808163123.17643-1-remi.andruccioli@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"The capability fags" should be "The capability flags".

In rst markup, a incorrect markup expression is causing bad rendering in
Sphinx output. Replace the erroneous single quote by a backquote.

Signed-off-by: Remi Andruccioli <remi.andruccioli@gmail.com>
---
 Documentation/cdrom/cdrom-standard.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 2de905810590..70500b189cc8 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -557,7 +557,7 @@ phase. Currently, the capabilities are any of::
 	CDC_DRIVE_STATUS	/* driver implements drive status */
 
 The capability flag is declared *const*, to prevent drivers from
-accidentally tampering with the contents. The capability fags actually
+accidentally tampering with the contents. The capability flags actually
 inform `cdrom.c` of what the driver can do. If the drive found
 by the driver does not have the capability, is can be masked out by
 the *cdrom_device_info* variable *mask*. For instance, the SCSI CD-ROM
@@ -736,7 +736,7 @@ Description of routines in `cdrom.c`
 
 Only a few routines in `cdrom.c` are exported to the drivers. In this
 new section we will discuss these, as well as the functions that `take
-over' the CD-ROM interface to the kernel. The header file belonging
+over` the CD-ROM interface to the kernel. The header file belonging
 to `cdrom.c` is called `cdrom.h`. Formerly, some of the contents of this
 file were placed in the file `ucdrom.h`, but this file has now been
 merged back into `cdrom.h`.
-- 
2.26.2

