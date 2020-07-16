Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD38C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125382065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z3YpDI8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGPNFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgGPNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:05:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C173C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so3656203pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHe4h5tXPNZHs87zVRoJ5H1MBCfFmTXIJuQzb/CTGuc=;
        b=Z3YpDI8xL98JLZJH9yVrpL7//a1wAQAdhcDOchyJO6Kq5DeVT3kv/JUvnoCy3SOGE+
         EOdqTWprjhYeoCedKBw7VLDXvMGA79WxdZVhOmXT0I6bctYg7ejnGIs0jm1PgeabTw7H
         xjm2+kTIUV7P1JrwJoBEPT/l4qnf8EGE3Jm/JDN3WXzAc2yS7ou8nUSulYEM3gKx3TiW
         tK2burAVyccTy7qFpcCzu8K7t+aVMZeVYDfrCutPhLRbbqqbr4pWFUwyxati0UUgFFuj
         PWeT2N8xFwypdvPHh34XmwVeBzwhXnIuShzMXZpttyYmzjXSgTVEDs8dtZ9oOWuzIljg
         Fs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHe4h5tXPNZHs87zVRoJ5H1MBCfFmTXIJuQzb/CTGuc=;
        b=iTqeGLCEFJM1L9u1x+g5yNfi2N5eu+gCyCxSFbIEFkqDGyaK+7wJtp7dfbyVpgOubl
         Zdr20znD62DGOkiZM6ixOyNHU2wpNMt/T2WqfGAwhFSxZrCRtY21EYEs0GZXfy3s32WC
         IVnWeNE2rnaaRpeWp8TjXYHanP3tr9iEhjbFtl9vgGM5geMsykfBdUPpp0+2Ib1LPDFL
         B0gquipHoBrkPlEI436bAZwlxmDZ3YndRKnWKj7ZMSI5C1SoMJWdUSAIC/R/DAg3gBjI
         U2jDXdkRyJ/z4bAP3cjObWFcQOeL7S/7n5Hgz6ptQGdjCVnH5hxRMGtmGWmX6KxoNeMV
         OYtw==
X-Gm-Message-State: AOAM530bNCuh8kKpTF9R7jd1Y3m9HOLykmaOCSyviBzKKywFDaV3cGIk
        eYJo6xwC4t9KpGTFwDjkQZ44kg==
X-Google-Smtp-Source: ABdhPJx3LQGxUAT58kn+mBWd710J1coFKijbw42x0J/6OYn3EfVPcgv0cOrwVGj7YyiOkTcHGtuCkA==
X-Received: by 2002:a63:3d01:: with SMTP id k1mr4025292pga.71.1594904750647;
        Thu, 16 Jul 2020 06:05:50 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id c134sm4770203pfc.115.2020.07.16.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:05:49 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] Fix some build warnings when W=1
Date:   Thu, 16 Jul 2020 21:05:44 +0800
Message-Id: <cover.1594886530.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix some build warnings when W=1, the most of warnings are
missing prototype as follows:

arch/riscv/mm/init.c:520:13: warning: no previous prototype for 'resource_init' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:130:5: warning: no previous prototype for 'set_memory_ro' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:136:5: warning: no previous prototype for 'set_memory_rw' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:142:5: warning: no previous prototype for 'set_memory_x' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:147:5: warning: no previous prototype for 'set_memory_nx' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:152:5: warning: no previous prototype for 'set_direct_map_invalid_noflush' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:169:5: warning: no previous prototype for 'set_direct_map_default_noflush' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:97:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

Changed in v2:
 - Modify the patch description

Zong Li (2):
  riscv: Fix build warning for mm/init
  riscv: Fix build warning for mm/pageattr

 arch/riscv/mm/init.c     | 2 +-
 arch/riscv/mm/pageattr.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.27.0

