Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6194C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AAA206D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMe3M8hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgHHXG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:06:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F0C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:06:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so2884280pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NUym8HD4rAkVe/v6ICYggV0BsxvR+hENFSjlluLvaE=;
        b=aMe3M8hq1N8mSUWwNNNa+BFs1vz/wV1RLDQ3aKe9dZ8lrmuGinl6xfAIrLq3fOeTkM
         N3hc8QFBrDaE9dWn6pWlRyvETXwdC3fhaRu2/ZRMAWqsmI5Bxp51/jIMQHk4CziXULNG
         iMpcZsTC9xPGbT2FfPSknpiztvVPl8ImdyfFVrFYfndNhvZ0COftp3gaFTzT3RIwBwWU
         vxKkzM6ntX9xp+kCCblvztnqRMerEjPHEWkwq385lhwxDIY/fEOAug5BiyDMEo42du2l
         CwGKLVjj3Ep2kKJSISgg7NonFFF2F2CLM8VRmTqippaF0oA+tTPSUSOlcgabpLSYnbyO
         kVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NUym8HD4rAkVe/v6ICYggV0BsxvR+hENFSjlluLvaE=;
        b=k/+y0RSG1pn4X1dej3ZFu1zBBxwTgImQhPRCAC5z456nLJ1069hEbpzEyqrmsb4rxj
         lN7uRHH1JBa9+wRSzChgsWR2odDpgkleUWE6ntlGoLa2cg8dtGo7spdEfYBoKVDBfPA+
         r9BRCXnuFGr7/pQqLI2ywvMPts8yMB9Pjyt10R0tB9qGQviCl8mVjAitqbfm0z7U1Fe/
         1XGpXanJjkkCo+JsZ2PlhikD2EWIjJltfdP15NDzDOh0Y1kjZB7lywXSzp2twWZOhPUF
         GvZrl6vcAhQ7DN/F7AyaRR1ODtX2WGt9DNGv5xatmkv7kpyEMkz2NzznMmV2VEuBTHjU
         1SDA==
X-Gm-Message-State: AOAM530N8mQGSPeM1SMqrUhwYiH/PJk9ZRbnAC7geqnbutSTDrVBuhlW
        GkLQZGfwnWv5ZUK9OKCo6hamwSHM
X-Google-Smtp-Source: ABdhPJwwUYqdXxqG539lrx1ReHEixuDRGFYbsDQfr8IEltHrrz02kEUzxyXgd03Qyt12lwEO9U2jzw==
X-Received: by 2002:a63:31d1:: with SMTP id x200mr16735498pgx.209.1596928015829;
        Sat, 08 Aug 2020 16:06:55 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id t69sm5919679pgd.66.2020.08.08.16.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:06:55 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/6] OpenRISC header and sparse warning fixes for 5.9
Date:   Sun,  9 Aug 2020 08:06:41 +0900
Message-Id: <20200808230647.833047-1-shorne@gmail.com>
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
 - Remove some __force's suggested by Luc Van Oostenryck


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

