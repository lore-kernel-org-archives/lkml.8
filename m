Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218EFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E958320768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcGp2P7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441667AbgDOTNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416867AbgDOSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:50:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E332BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:50:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so1170697wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=acZ0FR3Ieh7QKceyUMnt7yQIXSOW4wSevSsBNkvC3yY=;
        b=OcGp2P7aJP3bMCEg8pIVH8PXXpdNafa/GJJnSsMtIre5Zx/sQLaHdd/YDq4WnT5UQA
         5pwA3RNANZlGapXagIIipaVuptZfympHucJW00kQOhTTM/EfxkIAvFsmhn/dBPWfYAPt
         gp4Q6slzNzbOWtLTGMZY7mJdTrNVua8+KKfzChDL2JRbqG5FGDJQVGILLwvlP97szInC
         ikjzF76An4mNYrbbq33d63Zh0aFhMXaV1m/Tw18tYaJYFQIMVFWzjCtmioj2TB+8elfs
         47JYSkQhNW8T4DOk0cOIXZ607w/I/yt6E99hkMvllsXavtk/ozMFO7lkUekxJO6lIu4D
         KuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=acZ0FR3Ieh7QKceyUMnt7yQIXSOW4wSevSsBNkvC3yY=;
        b=UiL3Z2LhF5NmPI6r0aBJPZINYWU0ME1QMJcCfQwyVzGSAYrZ5fzTcj4ofHRTuBu59c
         kRmkt+rr8SL1TUeRypQ/e2d+LZh07b3ANqIMkPKUzCR6fXGpExOmEUjKjCXoXTT7r+U8
         ueQHa6Y7dGpuyfQuXB/leU38D7ry5ISNd6FpYz5mOixY0kOcW/NxKW9gYXRTW97riroz
         qqcRV/QbJjESybR+sC6VK02BgoQywnS9GaOVgupFHDSGeH8jWhgqM4lA/UlpXXxlmikS
         cAwkovbha8v+OH7LfGmKKf7uGEBfnX4VX4oVmDIpLW6KyatP01xnt70vYnjIFtgMZmLY
         BaqA==
X-Gm-Message-State: AGi0PuZSW/+EmHlNKLhQyvU2veJkyfSUYqhMQvW2ziZTpcwKuyuyqzZe
        YpbcmiezRyo9LQu0mt1FolmJSIspbA==
X-Google-Smtp-Source: APiQypKdTZhSOVjVZwstgDXNkZTCcnf/4giguNoRyBNh+AZzAJe9kqU6nTqImQRQuLgld/qeEI585Q==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr25631800wrp.275.1586976613385;
        Wed, 15 Apr 2020 11:50:13 -0700 (PDT)
Received: from ninjahost.lan (79-73-33-244.dynamic.dsl.as9105.com. [79.73.33.244])
        by smtp.gmail.com with ESMTPSA id w7sm24757618wrr.60.2020.04.15.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:50:12 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com
Subject: [PATCH 0/1] Fix context imbalance warning
Date:   Wed, 15 Apr 2020 19:49:36 +0100
Message-Id: <20200415184937.32373-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds an annotations to clear_tasks_mm_cpumask(),
the function registers a  warning of context imbalance when built with Sparse tool.
The adds fix the warning.

I also tested it and I think it is working fine.

I will appreciate any comment if possible.

Jules Irenge (1):
  cpu: Add annotation inside clear_tasks_mm_cpumask()

 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.24.1

