Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64202C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25ABB208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbdiHqhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgIJXjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:39:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB21C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:39:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so5915834pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5AL/OPQQe9dWzVvwrAJGPP4hz5LhsheYdKhBidfR6f8=;
        b=fbdiHqhnLIXTdtLgLlVcM9dUBO6dxxa615Tulri2ejhxS941i1iR/XRNxBxMbyKp/e
         j32oY2EQDv1l2r5m8t/bfoud5CQfl1xoxIoXT6VL+LwqPuX+G18C9YedEnt4h1TA3CGc
         F+/d/cxPglycMJ3Qm0EjLbisfje/d5cC30BZXt0+d4bV7DSVqLcduYGjxfDbn4LXl8Hy
         u9QMn/aZ5mdXWuMWED5+t3DBY1FwQvAPXWuPQOvLfig5h2VIwULeRLltazsrrQgF7m1o
         VD7Hlq1c9kUEXdw+WAtZOoCsceOKps4oeVDe3ED3rwjg6Pb4Q/0QV5fr7LogsIG5k5wc
         bp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5AL/OPQQe9dWzVvwrAJGPP4hz5LhsheYdKhBidfR6f8=;
        b=hsphydNuLXPKb1L/7TCBJG2lT5DmfawG3kxarWdOfKyPVbURKNDywqqF9AKsyDowZ+
         Pm7F6eKTGFYmgYMdh96DTAxaeNaBXgBvDqT1lTSAHjmBImvKMsVlIkgAQsW2P3eTcAZ6
         mCB5BUFfqyBMfYk0K22dKG5nKsnwC0sOUOixRYsPs3akelxA7LjJyG43NCqF2HHk3Wnr
         3fWixZcmdTVaF6TyXyspH8O9/qoH4EbvfN4ORQjIbrpVpGQM6pnv8d948qRN+K3K/M+M
         grAD0g78G2Il4trroVuvIxUExg7wBh3fLK9xJSOkNIi2rnLBeJI5N13nrfyzqyESSVbz
         3r8A==
X-Gm-Message-State: AOAM530ISkfPDVo525qpEsP9kH5CC1nHree5BIDeaM4z0/sBGiPsYS1I
        vVU6JID5aDFOvkbluOJvtZYwv1NZQ5s=
X-Google-Smtp-Source: ABdhPJzPWanWT25B2ZfANItduBKWgIqHVglcAYM2EOWr1VNv+0opbyZhEfFKCn3tl1FZy5cm0yzzjA==
X-Received: by 2002:a63:1a46:: with SMTP id a6mr6414993pgm.110.1599781190983;
        Thu, 10 Sep 2020 16:39:50 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id y13sm93769pgs.53.2020.09.10.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:39:50 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/3] OpenRISC fixes for 5.9-rc4
Date:   Fri, 11 Sep 2020 08:39:37 +0900
Message-Id: <20200910233940.2132107-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 - Update the uaccess.h to address issues pointed out by Luc

Changes since v1:

 - Now a series, v1 was only the "Reserve memblock for initrd" patch
 - Added fixes for compiler issues pointed out by the kbuild robot
 - Updated "Reserve memblock for initrd", as per Mike's comments

This is a few fixes found during testing 5.9.


Stafford Horne (3):
  openrisc: Reserve memblock for initrd
  openrisc: Fix cache API compile issue when not inlining
  openrisc: Fix issue with get_user for 64-bit values

 arch/openrisc/include/asm/uaccess.h | 33 ++++++++++++++++++-----------
 arch/openrisc/kernel/setup.c        | 10 +++++++++
 arch/openrisc/mm/cache.c            |  2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.26.2

