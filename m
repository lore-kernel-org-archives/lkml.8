Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C2722B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f1/fcUj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgH0IWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0IWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:22:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7DFC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so2919660pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftNSmWyY4DXtAPMFhhFUNPxTBnM04m1o45AJFNQ6MLU=;
        b=f1/fcUj8AvfqkfH010tjpwC1yboh98LK+9rN+VdhHx+mC465aqaRLgs2Xp/b0XfS5Z
         i58biRjeJurZN7B+F416ZZEITKOAhGBNOmF4ZcmQylcjF/2LjMpkiKppo1cpvxDCZN/X
         bZYIa6IeHL6sAsykwiWlHnN4rjxBjDVv3123g8Dg5Qu82mxGILpLxiJmVny7LHmWAC1S
         SVumcEUWVlL5i0gDzfRgNWm63EUNe88FH5jHN5bRxorYTyIR1aiW+C7oqiv9QZP+XPcU
         +7g7LKNdqr7WyQoITO1mJ9t2VEZEcz5ahiV+zqUbfYc0nU/d0HMFc1fJ7KxkpDYZ3D1z
         xxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftNSmWyY4DXtAPMFhhFUNPxTBnM04m1o45AJFNQ6MLU=;
        b=V303xoffOVZaX6GgV9d+gOoCJbca3JFSGKv1XPDx2IQf3EEWDffgl3460c0E8tdCfe
         +S7mQ+0gaPJlxKGMfnrz0YtyjrXHQimHw3/Oy8Znsa/nhYNwinKzNIpWq/kz8ek8LM8I
         h8mvTYMEgDHCyyzszllFRjkE94SBseGqOxVWfWjKtaT2e238xGRQphoo8fb51KKvJKIc
         7x0fwQ9s/CZOGBXUSNLJYn4ETmCbiNbNLENF63wX/HfFbIvnMXHOxav0QSzKGEYT5bJ3
         ZeNTru6LJ4qOXWha3hpqVJBYeyOuJdrq3k7vs1B7qXrFqeSkAswVEfSKzeUbDIkEWdLC
         iPGg==
X-Gm-Message-State: AOAM533102YzMWbCWTDAg5ngN+QYfNUTjJgTD9zPoh3NQMTbSCdifguW
        jaU0a1CbZNsllgsgVKAgD6looA==
X-Google-Smtp-Source: ABdhPJxJUcigDvDepGZN4aYbKgKPsbbPdwFaGloGOvO+/FBaOs+rqTuBr6qf1OkUW9FDlWEEoBbCSA==
X-Received: by 2002:aa7:80d6:: with SMTP id a22mr15738360pfn.275.1598516553111;
        Thu, 27 Aug 2020 01:22:33 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 124sm1828351pfb.19.2020.08.27.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:22:32 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/3] Get cache information from userland
Date:   Thu, 27 Aug 2020 16:22:25 +0800
Message-Id: <cover.1598515355.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no standard CSR registers to provide cache information, the
way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
could use them to get information of cache through AUX vector. We
exploit 'struct cacheinfo' to obtain the information of cache, then we
don't need additional variable or data structure to record it.

We also need some works in glibc, but we have to support the function in
kernel first by rule of glibc, then post the patch to glibc site.

The result of 'getconf -a' as follows:

LEVEL1_ICACHE_SIZE                 32768
LEVEL1_ICACHE_ASSOC                8
LEVEL1_ICACHE_LINESIZE             64
LEVEL1_DCACHE_SIZE                 32768
LEVEL1_DCACHE_ASSOC                8
LEVEL1_DCACHE_LINESIZE             64
LEVEL2_CACHE_SIZE                  2097152
LEVEL2_CACHE_ASSOC                 32
LEVEL2_CACHE_LINESIZE              64

Changed in v2:
  - Add error checking for parsing cache properties.

Zong Li (3):
  riscv: Set more data to cacheinfo
  riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  riscv: Add cache information in AUX vector

 arch/riscv/include/asm/cacheinfo.h   |  5 ++
 arch/riscv/include/asm/elf.h         | 13 ++++
 arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
 arch/riscv/kernel/cacheinfo.c        | 91 +++++++++++++++++++++++-----
 4 files changed, 117 insertions(+), 16 deletions(-)

-- 
2.28.0

