Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B23FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1559A207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqVjp535"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgETLMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:12:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:12:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so192150plv.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=05sWOFK6tuBIdg0teEFyYCPt+cVyW+PqgkCyuRv1w18=;
        b=TqVjp5354l9g1YsMnmiLHIjXurzKyt9dZu9rMhX+qNabLlTNIE6ll/SK69p9ELSwHb
         HuIDMQdB8adG6bsECZCVjF6ESjyXInN9zVRWoK7m76v6WmBTs2VR4Ky643jLAM6gh8Q9
         vJZzAU8MIsFMiG+WKtswEPNgfgeXmkv2k31LT6AXPJobmw8gSC4EGJXHXV/zZLSc7kjQ
         j9M5acva6zU2GvPjWKZiCWaPnNNwDNV79FzECZ+56c5USFDAg0hizjdw23llsucwhdRY
         o5Tg2VeRzxBngmGYQOCf9DrCKdUGxO6/Bu5iH1ApiTirZU7ZQ1blBuRj4Wi/anElVBX/
         BidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=05sWOFK6tuBIdg0teEFyYCPt+cVyW+PqgkCyuRv1w18=;
        b=T41ExoBlw1LbajZzgbjl8OwH9hx2e6aUpfvKm6i1ebqfsDRuBvrk4bFcbaaHNOxrn2
         361oIQCakRMLMCB1TKBw/MsiJUVGaLkp+qrxOeXpcRFmdZ96WJ/deYUugtFRU5qbjraq
         66d6fc7yrsfn0NBhl025sg4gLjVfsEqacF4RS6L0CPI4QQS8SDxq/YfSFrb3pZXHNxcp
         gEXkDKdw12/5QzHkuU0Rxu+96UDEPX64BKsRDCw95xeFriqDfWI66Sswtc+Q7fgk0I+j
         Ksc1oD2y87ArvLsN3J5Bvemvs5/eks3CRDU61gv+Rhh0+dhiYr3gwu2aZ8dn/9WRmxci
         JpIA==
X-Gm-Message-State: AOAM531hO4dUX2wlGi8/OmrsPQhit75SqZAHRo4LPQZF27RGS/+a3eix
        aQFpC6mEJv67ABXHH9Sj+RrH5g==
X-Google-Smtp-Source: ABdhPJyaLwGf8TIiu+2wsx2Qxt0RIooE9jEihzhPvu8Fjah7GhQsku+h9APnrXOZSyeJeeClHe/oVQ==
X-Received: by 2002:a17:90a:4d4a:: with SMTP id l10mr4851457pjh.0.1589973161858;
        Wed, 20 May 2020 04:12:41 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id q134sm2044974pfc.143.2020.05.20.04.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 04:12:40 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/4] arm64: Introduce new IPI as IPI_CALL_NMI_FUNC
Date:   Wed, 20 May 2020 16:41:51 +0530
Message-Id: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pseudo NMIs support available its possible to configure SGIs to be
triggered as pseudo NMIs running in NMI context. And kernel features
such as kgdb relies on NMI support to round up CPUs which are stuck in
hard lockup state with interrupts disabled.

This patch-set adds support for IPI_CALL_NMI_FUNC which can be triggered
as a pseudo NMI which in turn is leveraged via kgdb to round up CPUs.

After this patch-set we should be able to get a backtrace for a CPU
stuck in HARDLOCKUP. Have a look at an example below from a testcase run
on Developerbox:

$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

# Enter kdb via Magic SysRq

[11]kdb> btc
btc: cpu status: Currently on cpu 10
Available cpus: 0-7(I), 8, 9(I), 10, 11-23(I)
<snip>
Stack traceback for pid 619
0xffff000871bc9c00      619      618  1    8   R  0xffff000871bca5c0  bash
CPU: 8 PID: 619 Comm: bash Not tainted 5.7.0-rc6-00762-g3804420 #77
Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x18/0x28
 dump_stack+0xb8/0x100
 kgdb_cpu_enter+0x5c0/0x5f8
 kgdb_nmicallback+0xa0/0xa8
 ipi_kgdb_nmicallback+0x24/0x30
 ipi_handler+0x160/0x1b8
 handle_percpu_devid_fasteoi_ipi+0x44/0x58
 generic_handle_irq+0x30/0x48
 handle_domain_nmi+0x44/0x80
 gic_handle_irq+0x140/0x2a0
 el1_irq+0xcc/0x180
 lkdtm_HARDLOCKUP+0x10/0x18
 direct_entry+0x124/0x1c0
 full_proxy_write+0x60/0xb0
 __vfs_write+0x1c/0x48
 vfs_write+0xe4/0x1d0
 ksys_write+0x6c/0xf8
 __arm64_sys_write+0x1c/0x28
 el0_svc_common.constprop.0+0x74/0x1f0
 do_el0_svc+0x24/0x90
 el0_sync_handler+0x178/0x2b8
 el0_sync+0x158/0x180
<snip>

Changes since RFC version [1]:
- Switch to use generic interrupt framework to turn an IPI as NMI.
- Dependent on Marc's patch-set [2] which turns IPIs into normal
  interrupts.
- Addressed misc. comments from Doug on patch #4.
- Posted kgdb NMI printk() fixup separately which has evolved since
  to be solved using different approach via changing kgdb interception
  of printk() in common printk() code (see patch [3]).

[1] https://lkml.org/lkml/2020/4/24/328
[2] https://lkml.org/lkml/2020/5/19/710
[3] https://lkml.org/lkml/2020/5/20/418

Sumit Garg (4):
  arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: smp: Setup IPI_CALL_NMI_FUNC as a pseudo NMI
  arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC

 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/kgdb.h    |  8 +++++++
 arch/arm64/include/asm/smp.h     |  1 +
 arch/arm64/kernel/kgdb.c         | 21 +++++++++++++++++
 arch/arm64/kernel/smp.c          | 49 ++++++++++++++++++++++++++++++++--------
 drivers/irqchip/irq-gic-v3.c     | 13 +++++++++--
 6 files changed, 81 insertions(+), 13 deletions(-)

-- 
2.7.4

