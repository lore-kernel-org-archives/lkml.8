Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A257C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68262063A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXIAtmAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHEVHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:07:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F05C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:07:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so5412816pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t32+K6etBUX79TR2T2NSsnsirFvY4dxDRuLsVkhuHkU=;
        b=oXIAtmAYQGlEIRzENScxODCyVYWpsOI8UmcLy2ewaSMVMAsRl/WxzQt7BkbMR01IR0
         HlpVGPpM85H5s2aK38k7QRK9AHyvMT7IZY5Vp82s7xDqBYGmtUbUVI+HbApWYA/WX085
         uGn41RMopWt9EZB0FxkuA4cNKY5D9gXKz/UQQSJNEs01PniJxyHRXyGZdgUmSy62Fsa/
         8Hvn70ClApXaYpk7re2kLbWM/iYkksMPUYzVT2QjOzf20yNFmfgknf6kl9804DHhhQBZ
         tmE92sUtJw84ox2RKvBzMT7t1PXKYjuJMB1STR+9NiCVPVCLv5wtGy277Kiiy1Qo56nm
         q7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t32+K6etBUX79TR2T2NSsnsirFvY4dxDRuLsVkhuHkU=;
        b=O4PVQSXpr/Ks+aq1LPbRkjp4Lq6n9x+Kkd6+m+H4m6HYKmbQAi/vliAqbmZQm47Ajb
         j/D1LziCJxKi27l308aC+kkXohdaUkrSmBbVYBqP+4XDf31Dn5HKl/IjU8CxBwR35voR
         xIuvnFv8b3z40wM7zYk+7EHWAG7ClV01Qpr3S+d49dsxb9Z341Ue/u5jCkWqbfu+ghkn
         u8ajt7VIAUUz3zWz3CBIL/URwohAqCAzWKoa6w9UKQTy3jyBesaFt7P3UfoJXuWBk9kG
         2Ijd5lWrJFTGULmeThAbNOwhCKBjayq+bFGBBOky6r04U27atV7ShtT4c7pcCFeQ/OU7
         5k2w==
X-Gm-Message-State: AOAM532DxnZJpZSTFnfZdayexa77jNZwIrOPZoPcbAGF07XHps+2McGZ
        qhUIVFE6MbGAeQ8q6VqEwvz5NTpQ
X-Google-Smtp-Source: ABdhPJxavelKRsSSNtIeBgcATfztw5zsvv8H/JH4+QBoGNkccGnpfFuLlkhSnSWrROIsYUzr6D0c0g==
X-Received: by 2002:a17:90a:4b8c:: with SMTP id i12mr5352742pjh.83.1596661653120;
        Wed, 05 Aug 2020 14:07:33 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id g12sm4405356pfb.190.2020.08.05.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:07:31 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/6] OpenRISC header and sparse warning fixes for 5.9
Date:   Thu,  6 Aug 2020 06:07:19 +0900
Message-Id: <20200805210725.310301-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes since v1:
 - in "io: Fixup defines and move include to the end" added a linux/types.h
   include as there were compiler failurs pointed out by kbuild.

This a series of fixes for OpenRISC sparse warnings.  The kbuild robots report
many issues related to issues with OpenRISC headers having missing or incorrect
sparse annotations.

Example kdbuild-all report:

  net/ipv4/ip_sockglue.c:1489:13: sparse: sparse: incorrect type in initializer (different address spaces)

  https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/MB6SE7BX425ENFTSIL6KAOB3CVS4WJLH/

Also this includes a few cleanups which I noticed while working on the warning
fixups.

-Stafford

Stafford Horne (6):
  openrisc: io: Fixup defines and move include to the end
  openrisc: uaccess: Fix sparse address space warnings
  openrisc: uaccess: Use static inline function in access_ok
  openrisc: uaccess: Remove unused macro __addr_ok
  openrisc: signal: Fix sparse address space warnings
  openrisc: uaccess: Add user address space check to access_ok

 arch/openrisc/include/asm/io.h      |  9 +++++++--
 arch/openrisc/include/asm/uaccess.h | 21 +++++++++++----------
 arch/openrisc/kernel/signal.c       | 14 +++++++-------
 3 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.26.2

