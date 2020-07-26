Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC7D2053B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="gRKxJbXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgGZEj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGZEj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:39:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735BC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:39:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s189so7540365pgc.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0JPK7sI7sXFOZVB0qjVRqNGXUj8GQ0OLMfabN0aZ8g=;
        b=gRKxJbXv0ehorkaBGtjLwvM4IJUqreQDjrxDdqzx5HXOhKbdgTfqYIKJ/ii538j0cw
         nT1BgFGptxzSc5Iolm84LjSL2NYOIXwfD0XuA93CDK0QiK/YSLMZub9TNIMQ5FKOnIiN
         UYR2ZiCj/E6XkANf1WWQyhZK/P7GMruDTKxVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0JPK7sI7sXFOZVB0qjVRqNGXUj8GQ0OLMfabN0aZ8g=;
        b=eduZw6FitVhotkyXgzqJ6Fiju/VSY2rLKUcs1zSdRJJtYac/DEe6abllNEq5UeGxNh
         Z0qHZ1GC6GGiuOtJxXy+KYgxMJTeWM9zI4JBX0DcpaJdm+ciL/Haz4m1BVZ34MM2ouot
         V7zjjx2XQ7vTXsANU8jhrs98h1lNFgdGpHjdnDsxc8w8SJIRHH5RRf2hR0RndQP9xDrP
         JVwzfBL2f7kvBhmOZtYq6F4SXgYaC7Q+vlOKOuiZScwUEbjpjB2P6R68CEz6tws3vSQI
         bxJzK7wtzVwxm7D/AuXoRzWovBp9GRjDtDfp+wp25GSGtOS4+AtMNwARomqhtAWPWLJF
         G2lw==
X-Gm-Message-State: AOAM531LjrIjhvTjlP1HaLIttMJfzW5W8YWS6jrDFUORv/n6HIvm2a/y
        c8KOGCDpaLPUvVv39pa5dicTLQ==
X-Google-Smtp-Source: ABdhPJyv73YVKcV0xX7Ar4iuNYP6XaTJD5KbQTRxTHBLYr4qztA4cY9wzfCYgP2z1VRv9lIaYl2OHw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr14700543pgc.166.1595738395952;
        Sat, 25 Jul 2020 21:39:55 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:39:55 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/7] ARM:mstar: DT filling out
Date:   Sun, 26 Jul 2020 13:39:41 +0900
Message-Id: <20200726043948.1357573-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a few low hanging fruit that are purely DT changes to
keep the ball rolling while I work on series for more complicated things
like the interrupt controllers.

Summary of changes:

- Adds the IMI SRAM region and sets the right size for each family
- Adds the ARM PMU
- Adds a syscon for a lump of registers called "pmsleep"
- Uses the pmsleep syscon to enable reboot

Daniel Palmer (7):
  ARM:mstar: Add IMI SRAM region
  ARM:mstar: Adjust IMI size of infinity
  ARM:mstar: Adjust IMI size for mercury5
  ARM:mstar: Adjust IMI size for infinity3
  ARM:mstar: Add PMU
  ARM:mstar: Add syscon node for "pmsleep" area
  ARM:mstar: Add reboot support

 arch/arm/boot/dts/infinity.dtsi  |  4 ++++
 arch/arm/boot/dts/infinity3.dtsi |  4 ++++
 arch/arm/boot/dts/mercury5.dtsi  |  4 ++++
 arch/arm/boot/dts/mstar-v7.dtsi  | 26 +++++++++++++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.27.0

