Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDDBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D630C21556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5a+MLnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIGHEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgIGHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:04:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4398AC061573;
        Mon,  7 Sep 2020 00:04:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c3so3798943plz.5;
        Mon, 07 Sep 2020 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxdgRFlQigk4lLEnKCMOhpL5rmLS0bgdeVzH2zzhbYk=;
        b=M5a+MLnV7m4BYslTgTXLbVYvDCJ2QB7MC9Se+kNZ7FNpVHy7lHDPtsKHEFFti0QN9k
         PWOhVugkp82UCARsJ6e5aHJE/eeezbYXjCv3lokjUauh6ayjQo7iY7mOl+D6HJIyj9GM
         xCvcxP81rQzAbPFVvVpFfBkw9QB1MZ8sWTKw2oksX253tgDfHVpIZzGAC6CqhYL91IqE
         ErH43LJwV53Kwfp/kElozpKW0tdOH+QtM+XUGtVBYpvRupAR6s993NNAZB+LZtxvzZUL
         UJdOzeDkCzG/eZNgTwGcuLSvg8aIZA61IfPdA6xL1DknoDpu8fy0JYIfVPpXMUYwinuu
         xqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxdgRFlQigk4lLEnKCMOhpL5rmLS0bgdeVzH2zzhbYk=;
        b=biZPDfS+BwZSERqadFUG9HWHgFufDPmCmDWenkX3lO3Plpp7VladkKDYXDX2viEo3i
         KAf9iVM/iacYplCpvJZfKyyYtg7n31X8M+TLCf/0IFnjeqOYAEQ6sBxjA5nabPFH1LDH
         wiNwOOsKYyU4+3Zb2NfmUf2PdPxH6jvg+Aqv5EWWJsQnwiKNAvKGmBIk+AylLEDaUPDT
         lPEVtUgpz13kBfoQsiaztrwgBxy92Wu7yE5CQSJqC9DMe8qgeGXRKVtSo6kFrgvM4cCa
         K7FpniWFgavVaX1sRqsisjVJiMf+3ZbCjHMLO50M+ShE1/RbTRpIG7ITh9sGgNpovJ95
         35NA==
X-Gm-Message-State: AOAM533kVcR6ReOYFG+ubkGpeEuiea7lEyVGtThg7HKo9YThM9fkSk/N
        EaYRGF+kxRMvY+GLXEKEd5c=
X-Google-Smtp-Source: ABdhPJxzXrszn/nMlQPgA3dIh74jqZ12lEEdIGvXDzYX2rnrX6ut7BBU2gmf7rUzqk3t1RGZMtWKzw==
X-Received: by 2002:a17:90a:bc08:: with SMTP id w8mr19016149pjr.168.1599462267567;
        Mon, 07 Sep 2020 00:04:27 -0700 (PDT)
Received: from varodek.localdomain ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id 204sm6804733pfc.200.2020.09.07.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:04:27 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 0/2] video: fbdev: radeonfb: PCI PM framework upgrade and fix-ups.
Date:   Mon,  7 Sep 2020 12:32:19 +0530
Message-Id: <20200907070221.29938-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management. 

The original goal of the patch series is to upgrade the power management
framework of radeonfb fbdev driver. This has been done by upgrading .suspend()
and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

During this process, it was found that "#if defined(CONFIG_PM)" at line 1434 is
redundant. This was introduced in the commit
42ddb453a0cd ("radeon: Conditionally compile PM code").

------------

Before 42ddb453a0cd:
$ git show 65122f7e80b5:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"

Based on output in terminal:

547:#ifdef CONFIG_PM
       |-- 959:#ifdef CONFIG_PPC_PMAC
       |-- 972:#endif
       |-- 1291:#ifdef CONFIG_PPC_OF
       |-- 1301:#endif /* CONFIG_PPC_OF */
       |-- 1943:#ifdef CONFIG_PPC_OF
                   |-- 2206:#if 0 /* Not ready yet */
                   |-- 2508:#endif /* 0 */
       |-- 2510:#endif /* CONFIG_PPC_OF */
       |-- 2648:#ifdef CONFIG_PPC_PMAC
       |-- 2654:#endif /* CONFIG_PPC_PMAC */
       |-- 2768:#ifdef CONFIG_PPC_PMAC
       |-- 2774:#endif /* CONFIG_PPC_PMAC */
       |-- 2791:#ifdef CONFIG_PPC_OF__disabled
       |-- 2801:#endif /* CONFIG_PPC_OF */
2803:#endif /* CONFIG_PM */

------------

After 42ddb453a0cd:
$ git show 42ddb453a0cd:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"

Based on output in terminal:

547:#ifdef CONFIG_PM
       |-- 959:#ifdef CONFIG_PPC_PMAC
       |-- 972:#endif
       |-- 1291:#ifdef CONFIG_PPC_OF
       |-- 1301:#endif /* CONFIG_PPC_OF */
       |-- 1430:#if defined(CONFIG_PM)
                   |-- 1431:#if defined(CONFIG_X86) || defined(CONFIG_PPC_PMAC)
                   |-- 1944:#endif
                   |-- 1946:#ifdef CONFIG_PPC_OF
                               |-- 1947:#ifdef CONFIG_PPC_PMAC
                               |-- 2208:#endif
                   |-- 2209:#endif
                   |-- 2211:#if 0 /* Not ready yet */
                   |-- 2513:#endif /* 0 */
       |-- 2515:#endif /* CONFIG_PPC_OF */
       |-- 2653:#ifdef CONFIG_PPC_PMAC
       |-- 2659:#endif /* CONFIG_PPC_PMAC */
       |-- 2773:#ifdef CONFIG_PPC_PMAC
       |-- 2779:#endif /* CONFIG_PPC_PMAC */
       |-- 2796:#ifdef CONFIG_PPC_OF__disabled
       |-- 2806:#endif /* CONFIG_PPC_OF */
2808:#endif /* CONFIG_PM */

------------

This also affected the CONFIG_PPC_OF container (line 1943 at commit 65122f7e80b5)

The patch-series fixes it along with PM upgrade.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (2):
  video: fbdev: aty: radeon_pm: remove redundant CONFIG_PM container
  fbdev: radeonfb:use generic power management

 drivers/video/fbdev/aty/radeon_base.c | 10 ++++---
 drivers/video/fbdev/aty/radeon_pm.c   | 38 ++++++++++++++++++++-------
 drivers/video/fbdev/aty/radeonfb.h    |  3 +--
 3 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.27.0

