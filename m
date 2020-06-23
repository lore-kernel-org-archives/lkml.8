Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B0320723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZyUq2l/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbgFWN27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732597AbgFWN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:28:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C872C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:28:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p11so1406524pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVBNJVgIh+vVxMtbdgm71jq0Zz2CQKK6+qEFaR+z8+Y=;
        b=ZyUq2l/xke53S4qo4NAs41PKzd/Bp8m7rpz0UAAWrxACkMQsISpKBy8fmLd9LAlnBA
         kgsU1YCRx8zkIiBCKvXhqQ2D1zcBYdrlSraatfI0WpBHZf0hIGVlowcZMe//Kawo4GYS
         Tb0y0kuRs1ZiyGuRnucAHC7dxPjr85X+IH8+l5XFcnKsScagIBFLR1ChFp3r1u9XqtES
         W+8naG9rsG6gPFeyF7lMqJWlZ4posLIQ01YFC/FImYClSG6GKZGFWcwV1N7NDh6J5UvM
         TdRWq1C6hVwkTQ9zNyqh0WzJPJyshUX7L6fsAz67rpR1BKERMMbnYZRV4MZiaz48u2ww
         gZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVBNJVgIh+vVxMtbdgm71jq0Zz2CQKK6+qEFaR+z8+Y=;
        b=TCbGGwx3qAoLcUJ9Dg6D1Vh0BEDWkM4DdgSQOowiS3PZ6GS0JybV6Swaz5KaPxp5x/
         dr8CFMNLZy6oUdUue+ybfghnoPv7Jn7kdjZNUB2H293GvBhZABLqj7CqH/JXeU4akYdP
         GdmjIYIfWyH4T6zRMWIonEzAOPESh6SFcswFtzS0GrsRMWnz2x3DLTi4vh1Nr38dnOLX
         xLm8UG9wMh+aXhnMr+kLPsCBtkFjQp5zfVmk7trUoiBAE17AYvigDBRJ7gquJ/NSrk5f
         9fe6cE/WLP9C7FD2VyUAJbd4yY0Wq3hpUI053/ZHgLr5ZlLRvjs5vXiu5rjkYjYT6fS4
         sBzg==
X-Gm-Message-State: AOAM533uo1alUhXpMtXOiv17OKqaKgkmr8eAuT7+Aqn7pjRaVAl/TDwt
        yqBHNrVAnDUTRvN+89UBfDefBLeExWU=
X-Google-Smtp-Source: ABdhPJx9DxYGmlD7GXAU2Nu9zoPa8iCEk3MY0Hmdt9TY/NioFmNY2tCNtUaeAhGCNE9Gg+vJ4m+Wbw==
X-Received: by 2002:a05:6a00:807:: with SMTP id m7mr25788176pfk.246.1592918937913;
        Tue, 23 Jun 2020 06:28:57 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id z19sm1670602pjn.55.2020.06.23.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:28:57 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        guoren@linux.alibaba.com
Subject: [PATCH 0/2] riscv: Add context tracker support
Date:   Tue, 23 Jun 2020 21:28:50 +0800
Message-Id: <cover.1592918110.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for irq_work via self IPI and context tracking.
It is tested in qemu-system-riscv64 and SiFive HiFive Unleashed board based
on v5.8-rc2.

Greentime Hu (2):
  riscv: Support irq_work via self IPIs
  riscv: Enable context tracking

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/irq_work.h | 10 ++++++++++
 arch/riscv/kernel/entry.S         | 23 +++++++++++++++++++++++
 arch/riscv/kernel/smp.c           | 15 +++++++++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 arch/riscv/include/asm/irq_work.h

-- 
2.27.0

