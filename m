Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1727E20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1TUEkRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgE0G0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgE0G0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:26:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56EDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so812611pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NFiMTgw0ePYgZ5AyHST8V5BcX0V74DYgO0bygQd/V6E=;
        b=W1TUEkRQ5Et/Gi/4hnXRc57eLV8qfnmL/DpnDGe/EEnVdgwb2b4l8jZoerXxO+frUA
         6ElMY5TVa0KQLO045gdJZKmMzZJqqHRNdYMiiPDGkg5A2zwgXl0CrqGAaiMpATKxoLPt
         aYs4H0zLKP5YRKR9sWl6d2HsiXgOjKkFb/521j0ZHSvDIbK61iHeTFkW85nCaO54N1eX
         0OMr55J9Y/oSaNG9vTG0ovEjuU/oYbAY0LFFUF7/N7Xw6TKEFxSz/g0vUl+8OZo6xkCT
         bQ28cMt6uD+F7MqZyTfq2fS3hl5QxXCCuhJWXGjdGyVG6e2Mwa9DNb5w4DpeGE4yRw8V
         U6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFiMTgw0ePYgZ5AyHST8V5BcX0V74DYgO0bygQd/V6E=;
        b=lF4g+VIrs/HElaYXZkoDjs/4nIJykjuVOocpjSVaoLXk/vHsTP6Li9OSMHOGwAEUjX
         4HZmUu6w622eIVgToRYjkd9cBdpV3+u9DPB5XgGBzlm6oo7bhyg13FOZPTXiuPAEYEDR
         8Fz/QT+vCeiLiyhF5TLsXJr/QFpU/VyX90UYEUv4ylH9ua4EmtNZD7FjUxcsysWg2AXG
         uNOKoiV/WG91kVLFusstmiJLo+HhcEPYv8vihyJzJyTIIfVbAFxC2qcrIAifb6OzLvmr
         eQWPMF2U2b7nfm3k+HAkMDoTqAiFH9HqPVLEO8D26D7HfH6lFcVig4XuadHpT6hclz2J
         s74g==
X-Gm-Message-State: AOAM5339BABtZ99zz+uzsjX1q6Uxzxbz8xCiNSEeN5kWOU0INv/Vd8zp
        4yd110ZNP+bk+/WrOWhGd7qE3g==
X-Google-Smtp-Source: ABdhPJyt10+/ExgeuNOKd96RcWJXrRobqoF7VU0IB/YAfA5mguNqVDiqNUr4L69k6MBw6GL7rqEMsw==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr4620273plv.343.1590560794197;
        Tue, 26 May 2020 23:26:34 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id m12sm1239121pjs.41.2020.05.26.23.26.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:26:33 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/4] kdb: Improve console handling
Date:   Wed, 27 May 2020 11:55:55 +0530
Message-Id: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is aimed to improve console handling especially when kdb
operates in NMI context.

Brief description of enhancements:
- Add status check for console prior to invoking corresponding handler.
- Fixup to avoid possible deadlock in NMI context due to usage of locks
  in the console handlers.
- Prefer usage of polling I/O driver mode (lockless APIs) over invocation
  of console handlers.

Changes in v3:
- Split patch to have separate patch for console status check.
- New patch to re-factor kdb message emit code.
- New patch to prefer polling I/O over console mode.
- Add code comments to describe usage of oops_in_progress.

Changes in v2:
- Use oops_in_progress directly instead of bust_spinlocks().

Sumit Garg (4):
  kdb: Re-factor kdb_printf() message write code
  kdb: Check status of console prior to invoking handlers
  kdb: Make kdb_printf robust to run in NMI context
  kdb: Switch kdb_msg_write() to use safer polling I/O

 drivers/tty/serial/kgdboc.c | 17 ++++-----
 include/linux/kgdb.h        |  2 +
 kernel/debug/kdb/kdb_io.c   | 91 ++++++++++++++++++++++++++++++---------------
 3 files changed, 72 insertions(+), 38 deletions(-)

-- 
2.7.4

