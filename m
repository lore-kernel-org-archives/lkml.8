Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8ADC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9577821741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjedPgum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBERRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:17:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33874 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBERRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:17:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so1146711plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fJZwWhExGC98e9aHuYaOiWB7cCCXGncBoKgbfkR3SFw=;
        b=SjedPgumfmxdG2Y8jo8GTe1H24QrbXTwewSQFkh3DXY7OSdTUVzu2vr2ig944LvCKH
         M6eQXMsToWaexKnLctEWeod30iTV7u1aKxTPnfDPtzceRrWorzfxdBkigS1SV6ac3pZ4
         gu2pAm3A8rVVreHk9L1EnmE9YSQOtNguk6jiZh4TCjjAo6qRObJjzn7WIOi5Y0nejZkn
         dr8/itsNpKHdSZ8ehMcwU/4xiOdvyDn6RrdYSKSgrXc6CuajAhT+xBBuFfBDWXMF8u40
         Q6EMqr0ptnj4NAgCoA7jCdeNtQlh++6gy8ef9G2eCRA1hyfb2ng7Npp90bL9YmkX8UOn
         q5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fJZwWhExGC98e9aHuYaOiWB7cCCXGncBoKgbfkR3SFw=;
        b=cG/pC9pdVshnCeE0u9DUujV1/OrW7e0QXmn+MZ73Ww1b+BJxvUNcJeYaIXU3yn3mQ7
         jqU4B43NvpZdAgG72cSfIdZgZEIXPfXZW9kiewKbVPuqGMntbL9h39YUyJlcAkLszF/V
         E7LMq6IkrssL/LnVU/trrCUFJ/4Ivkx5pGYZ/z/Sa68vIYaEJlNT/27uZbbQbcPphflA
         AnM5CKixd944ZRtUs8IJrWc2GtLqGD/OqCNs/zpn8Klo68vwmHfStdg2+S4wPtZ53adu
         05j+cHu8cGqFKjGBGSesQ625i//DIzKSsVwy3Nqs0Kip1jSy9iRa89zKB18k0pVFBiqJ
         rBaQ==
X-Gm-Message-State: APjAAAWN9WHKCM1oc9XQHIzj/8o/ZFLdjy4PFXYqkIb5aFmzfrdctVNI
        gkqDMbzBsfemRRgdr6opsvo=
X-Google-Smtp-Source: APXvYqxH0nJXO08ERyK02TyfPI2orSn+Vdb/KXcqtJdehWeLJ2qvhsg99bhBdNdoC32dm0ash4cqGw==
X-Received: by 2002:a17:902:8682:: with SMTP id g2mr35181161plo.336.1580923058663;
        Wed, 05 Feb 2020 09:17:38 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id l8sm357945pjy.24.2020.02.05.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:17:37 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 0/4] ntb perf and ntb tool improvements
Date:   Wed,  5 Feb 2020 22:46:54 +0530
Message-Id: <cover.1580921119.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series modifies the ntb perf code to
have separate functions for CPU and DMA transfers.
It also adds handling for -EAGAIN error code so
that we re-try sending commands later.

Fixes have been made to ntb_perf and ntb_tool
to use 'struct device' associated with 'struct
pci_dev' rather than 'struct ntb_dev'.

The patches are based on Linus' tree,

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Arindam Nath (2):
  ntb_perf: refactor code for CPU and DMA transfers
  ntb_perf: send command in response to EAGAIN

Sanjay R Mehta (2):
  ntb_perf: pass correct struct device to dma_alloc_coherent
  ntb_tool: pass correct struct device to dma_alloc_coherent

 drivers/ntb/test/ntb_perf.c | 168 ++++++++++++++++++++++++++----------
 drivers/ntb/test/ntb_tool.c |   6 +-
 2 files changed, 126 insertions(+), 48 deletions(-)

-- 
2.17.1

