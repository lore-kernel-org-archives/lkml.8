Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EDBC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE132072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N88l9/kQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgIENUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgIENUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:20:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E9C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:19:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so3978148pfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAw8Sm/IkMvzjBwyktfr8BKCwjcevIKR23o9IKJSixs=;
        b=N88l9/kQJz3e3m+lqb6Iwqb2TOu16918EdsProjfzS7cYu4YMM0RPCfvoEpIKMYhEi
         b3bYKx4otu6ihVZV5uefDZ425frevO2bkaKWItKz9VtZpBiAl+CVo2VGrNZZJd4AbWZW
         FsZnK6/zkQ7pLK86vdaS5EW8248Dx9Xp7X7jZGXQRnHzEX/vJ2givsXZPALv+vAVqsI4
         LIbrxASns7pyYskzDSKDwqc+jY2rrfGg2TocWBhYW0Fi40Hl9jp3atzjf47H9nSIo8yF
         mcH8yoo85Fi1cbnN9MvbpeZqOxIsurylnGETdMMKqkOYbk/M2zQBdN5e77/fv2pAIzKL
         VHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAw8Sm/IkMvzjBwyktfr8BKCwjcevIKR23o9IKJSixs=;
        b=paLNwf1d/dI7mOBFRwxLurh2qxSC3GdCfO7BEMTrM1rdeQNP5CPWQE5sUxa8MS/Zy+
         jW3MmRMURRba7NaAWAVPzV7/PSzxHcrBDU9MiXQXCxfQ11BgT2WdCpZkfIrvqF3KRHyo
         +hfCcJaYh2K7kPMja00xuNKhj0+nI7fwbXAHZzwgOvlHQXD9/TcacTF+GJndY6abiuxR
         rIYIt0A0s9v4HekXWEwmedSbhWtcTDT51fDCu7TdAsCfu1TQhjQo/xxzpyMteoz/9kts
         /5C+kbTLL7f52icQyjNBkCxNS2CDQYYDq5QBPvBYgndq3fnoDe3TUqmI6Exh0CzOmnR7
         INdg==
X-Gm-Message-State: AOAM533L6MAsXtIuD8sSioMXzwokbBlwlXbGGMj+iO58ETntWTGJGxkU
        9Z14gOq7yVr7N3oyfAgIxPf8B+sHTe0=
X-Google-Smtp-Source: ABdhPJwCz1IGuv2sxpK36Q5IqtIQvhUfahJ/kq2FS8B3zRy47H3fH/+zPQqb339Txs3NLDkQ2MnD8g==
X-Received: by 2002:a63:5047:: with SMTP id q7mr9993583pgl.59.1599311997556;
        Sat, 05 Sep 2020 06:19:57 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id t15sm10150569pfl.175.2020.09.05.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:19:56 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/3] OpenRISC fixes for 5.9
Date:   Sat,  5 Sep 2020 22:19:32 +0900
Message-Id: <20200905131935.972386-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

 - Now a series, v1 was only the "Reserve memblock for initrd" patch
 - Added fixes for compiler issues pointed out by the kbuild robot

This is a few fixes found during testing 5.9.

Stafford Horne (3):
  openrisc: Reserve memblock for initrd
  openrisc: Fix cache API compile issue when not inlining
  openrisc: Fix issue with get_user for 64-bit values

 arch/openrisc/include/asm/uaccess.h | 16 ++++++++--------
 arch/openrisc/kernel/setup.c        | 10 ++++++++++
 arch/openrisc/mm/cache.c            |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.26.2

