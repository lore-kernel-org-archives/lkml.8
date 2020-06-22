Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7442C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE30C2541B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LBmdgW+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgFVGdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgFVGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:33:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3637C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:33:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so7942221pfi.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p//jqJrWfVFOjyKLBt7xMkEyxWc/HLDv/7iZQ6ILA7c=;
        b=LBmdgW+ucSprQgGnygP8exzcYQPyLeVoNNyYkgW1XJiOCJ2qG2CZyRabEFA5w5BzHj
         as5md9y9JZpPU7MFmiBberQoMbKPJIS1j+hFYdsIa1tth6Z0bJfjGvQvFDGVTOT6/dyH
         DuV2LPs8t6GG3vAGNbp1Di9e+6eYgV4wBaLYJO8xBrUb/kIJn0UJWm95+zpExLgvJ9Js
         7MOhg5ftRVc5xNLZrvjilQTq5FrsTsraFDYNY7+zw4DOwcqkw8BnhpZI2FnLa2ZGvXY2
         fcG09GNZ23lNPu/pZLsJkGSMIE/WQSWdQsO1IGBgdLloIGV4mNu/UpFJmP/OQoAmrfrE
         HW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p//jqJrWfVFOjyKLBt7xMkEyxWc/HLDv/7iZQ6ILA7c=;
        b=NIUJUDah830N8hkvaRUw1scLHpJa+6XH9/A+Y8JSCvaOnZ7rEDahhskL0PuH3F0qON
         OAnJ0trHcKFt0MSaSUk/MOnHKhwws4vPbV9yAwKRcYrFUsSMq6LUKWUagkwZ0gP8+HNl
         XJFL2db7XpDpaMJdYk+d6vAG0R9YvoIT8NNtCuBRGTbDwHVtYU2gLUTi6MeywuP5wRfv
         wpn8Z8k2RfZ309FZtVXjL2WtHkooyVSZ6O91btUubnvblgYOlgb63XE3Jy8TaU+T9NxH
         gvWX1S/9JSfjAZdzChKFbzA06MgXdx4/OCNzSXrJJ9ctqSbSPBPosu2ra0ZFuPQvmlMc
         fVzw==
X-Gm-Message-State: AOAM530xlnGBv6HpqQZ+MZ9z95MXw7nGp2T1Yrgy8UWHdRaM/kcxlvcf
        d/9iS5jTR7+W9/3zXKsUNLFVEA==
X-Google-Smtp-Source: ABdhPJzbLL1TiAz0zrwctuXkWsQMr7H8MlkqUIheGxkGvgQ1k2bCNKN9rNYemEZnND0fGtEa8UPt7w==
X-Received: by 2002:a63:1502:: with SMTP id v2mr11902989pgl.149.1592807634267;
        Sun, 21 Jun 2020 23:33:54 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w11sm12530999pfi.93.2020.06.21.23.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 23:33:53 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, mick@ics.forth.gr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] Add STRICT_DEVMEM support on RISC-V
Date:   Mon, 22 Jun 2020 14:33:48 +0800
Message-Id: <cover.1592807136.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds devmem_is_allowed to support STRICT_DEVMEM. In
devmem_is_allowed, it invokes page_is_ram to check the specific
address whether registered as System RAM in iomem_resource. The resource
initialization is in kexec/kdump patch series which is reviewing,
page_is_ram checking is no use until it is merged.

Zong Li (2):
  riscv: Support CONFIG_STRICT_DEVMEM
  riscv: mm: refine the Makefile

 arch/riscv/Kconfig          |  1 +
 arch/riscv/include/asm/io.h |  2 ++
 arch/riscv/mm/Makefile      |  5 +----
 arch/riscv/mm/mmap.c        | 24 ++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/mm/mmap.c

-- 
2.27.0

