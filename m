Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4847C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4320206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bKS0uXY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFPHpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPHpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:45:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3056C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:45:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b5so7877871pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsyEWcYygbhjQ4E/M3Trk0mzbxlIEbyexF/crSFF0iA=;
        b=bKS0uXY1RoPn89ss/zHIQJruMG6Bf8QIqELS9HFq7/KFGcTAE5BzxQ8ZoRK/ux+Rnb
         dYq0ky9nNrTI6Uw/0WVly7OLsjwBHVQx+gYDqM76K0k+7v5ktl7PQqoPENXCqXrrW1gh
         iO9jh6u5ycqQ86AWMcclHfwwmDRuYGN51g+/Wi4nwDBUAhMhkn2VpRJFOC3e6JLKu1s0
         //GRoqEHT2FQbadMA7dtHW2WpZhWvRSMvYwvmOlW6PDOhlrU/IWut4SezBjLqtMxNwj/
         eon5O+Sz79zBN8BGt4SKHqZaeLwiawhvu0rFzHtDyVRztLo9zs7dgipzzcqrZxsN8UnM
         V+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsyEWcYygbhjQ4E/M3Trk0mzbxlIEbyexF/crSFF0iA=;
        b=rHA7FtuVTYvA/cJYnjMzAboVRff2uc4s1/p8f4CkzfkHJs5anG59objm/a1HpwcalJ
         FMrKkowbPtrYyGQPl5mlbaBQcgcNS2WyGtldCr8N0kjJWwiwoGUV0LgikLwHaFQ1A5wy
         7UnV7FcMhS7FuoWVKR+5Cy2p1000HC54WIOkHf2vKn9ywYBzYc7qT3SbRJQ2JY19sZEc
         S0UULH0hbdJ5UgxeQKQ9+rb8BcXFIBcJ5YlhQ/SqgATQfko8ld4A5OSeiSA74au+x8fy
         z9AMbPjkFi9x9x65oEelM6BybU/myGnE0Fg9Gh2lbGQ8/fOej/5wBWDjua97ED44LTRX
         38lA==
X-Gm-Message-State: AOAM530jnz+wgL/0biqcZnRi8GhNFdho8e/FEONLfziAOI5EDIFBjO4x
        rSu0TbzaLM5DazHG54FjDAjXmA==
X-Google-Smtp-Source: ABdhPJxt56goaO/h2Hz84NjfzGjvHSDyvFR6s2yFLty0WmeiD9CrXWjxzh6OlSfuwJbCg4qHFtWGAA==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr1041057pfa.177.1592293552119;
        Tue, 16 Jun 2020 00:45:52 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id i22sm15948250pfo.92.2020.06.16.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:45:51 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] Add STRICT_DEVMEM support on RISC-V
Date:   Tue, 16 Jun 2020 15:45:45 +0800
Message-Id: <cover.1592292685.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset include two parts, the first one is that register System
RAM as iomem resources, it is needed for page_is_ram API which checks
the specified address whether registered as System RAM in iomem_resource
list. The second patch is that add devmem_is_allowed to support
STRICT_DEVMEM, and it would invoke page_is_ram to check the addresses.

Zong Li (2):
  riscv: Register System RAM as iomem resources
  riscv: Support CONFIG_STRICT_DEVMEM

 arch/riscv/Kconfig          |  1 +
 arch/riscv/include/asm/io.h |  2 ++
 arch/riscv/mm/init.c        | 41 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
2.27.0

