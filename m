Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62776C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6F0222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLH+hf7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgBNUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32857 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so2848552wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NHqXF7AadRU7wUdLkOKBHBOCySRsYlkKATIhNJ851A=;
        b=MLH+hf7QplJ9x8Raq8JauGtYPuGulBIZG8bvx3uyZFenvmXkYFqIMqqpA5lq63tJkC
         LV6iETRQ7bGgGVR1i4xuHGKz0fEL0yjEilDqKjNNCOuKCFowjyptB3ebg+hLWzi7d80d
         oVPFeH2G7RC/7Is+Xp1tgl/rzXGrhSPBdCsxAM+8x54RXp41sGDIuntUU11YrN10Km3Z
         quDZgsI0RE0bklps2LjMfLpFMoTZY69XYLR4u6vLCqpVlgH8U5ooKlGQZxLuGSGXUJ1b
         ksnlKPOGq1Ze837p4K20Ayh+xkvfoQioe04fOSIRRgRVSWfl3TcTlhk1wfvk6JMWp2fQ
         fE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NHqXF7AadRU7wUdLkOKBHBOCySRsYlkKATIhNJ851A=;
        b=caVQeQFjJPCejsB2K9geZssMOI3o0r04cnE5DSfD9BvN/HLJllX8UMaQjHO0ue//Ib
         LkaqGzqsh6+AJS+JWoIgvIpOAivBmFu+f77KIPfeMRNYdyRR5xc5zHTSJXthfEMMbXZx
         vNs3Izqa44Dq/ZbZbp89jq2YtHipKNxhJoqR1pO6cMzdsPpLtRMFEj+SjJfeTLFv4FtB
         QdlxCS3Xh2ZC4saMROftorxyeE1JtXkt3A/GVhomDcQ6NhclNyFXYUuhJAWHnZLr2K5v
         tjxhyaVh3goSPeHrkvkAt8oskPoSst4DTvzURDE9qNo4bR3rmuKto9aYLWyep6J4Wr7o
         OrhA==
X-Gm-Message-State: APjAAAXLlnXnbFnlXXzAt85UIReRS+A27yFyaSm0cR5jhN/ljqNedT4p
        EfnyKlUiICTDwlnCwSlGZsEQa21itw==
X-Google-Smtp-Source: APXvYqxSFvSflnMJyBLfl0sN/oHmDgfUUfsqO71Uz3lPBgPGXDKf00Jh6D/o1hx0V6WAaGSv8XtWmg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6456924wmi.0.1581713299504;
        Fri, 14 Feb 2020 12:48:19 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:19 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 00/30] Lock warning cleanup
Date:   Fri, 14 Feb 2020 20:47:11 +0000
Message-Id: <20200214204741.94112-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/30>
References: <0/30>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to various functions  that register warnings of context imbalance when built with Sparse tool. The adds fix the warnings and give better insight or directive on what the function are actually doing. 

Jules Irenge (30):
  x86/apic/vector: Add missing annotation to lock_vector_lock(void)
  x86/apic/vector: Add missing annotation to lock_vector_lock(void)
  mm/memcontrol: Add missing annotation for unlock_page_lru()
  mm/memcontrol: Add missing annotation for lock_page_lru()
  mm/compaction: Add missing annotation for compact_lock_irqsave
  mm/hugetlb: Add missing annotation for gather_surplus_pages()
  mm/mempolicy: Add missing annotation for queue_pages_pmd()
  mm/slub: Add missing annotation for get_map()
  mm/slub: Add missing annotation for put_map()
  mm/zsmalloc: Add missing annotation for migrate_read_lock()
  mm/zsmalloc: Add missing annotation for migrate_read_unlock()
  mm/zsmalloc: Add missing annotation for pin_tag()
  mm/zsmalloc: Add missing annotation for unpin_tag()
  x86/xen: Add missing annotation for xen_pte_lock()
  x86/xen: Add missing annotation for xen_pte_unlock()
  drm/vkms: Add missing annotation for vkms_crtc_atomic_begin()
  drm/vkms: Add missing annotation for vkms_crtc_atomic_flush()
  driver core: Add missing annotation for device_links_write_lock()
  driver core: Add missing annotation for device_links_read_lock()
  pcnet32: Add missing annotation for pcnet32_suspend()
  sfc: Add missing annotation for efx_ef10_try_update_nic_stats_vf()
  xhci: Add missing annotation for xhci_set_port_power()
  xhci: Add missing annotation for xhci_enter_test_mode
  tipc: Add missing annotation for tipc_node_read_lock()
  tipc: Add missing annotation for tipc_node_read_unlock()
  tipc: Add missing annotation for tipc_node_write_lock()
  tipc: Add missing annotation for tipc_node_write_unlock_fast()
  tipc: Add missing annotation for tipc_node_write_unlock()
  net: Add missing annotation for netlink_walk_start()
  net: Add missing annotation for netlink_walk_stop()

 arch/x86/kernel/apic/vector.c      | 4 ++--
 arch/x86/xen/mmu_pv.c              | 3 ++-
 drivers/base/core.c                | 4 ++--
 drivers/gpu/drm/vkms/vkms_crtc.c   | 2 ++
 drivers/net/ethernet/amd/pcnet32.c | 2 +-
 drivers/net/ethernet/sfc/ef10.c    | 1 +
 drivers/usb/host/xhci-hub.c        | 2 ++
 mm/compaction.c                    | 1 +
 mm/hugetlb.c                       | 1 +
 mm/memcontrol.c                    | 2 ++
 mm/mempolicy.c                     | 1 +
 mm/slub.c                          | 3 ++-
 mm/zsmalloc.c                      | 8 ++++----
 net/netlink/af_netlink.c           | 4 ++--
 net/tipc/node.c                    | 9 +++++----
 15 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.24.1

