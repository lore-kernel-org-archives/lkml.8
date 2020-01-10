Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05647C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAAA2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MLzAPeFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgAJKqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:46:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36006 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAJKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:46:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so833065pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=grRObLxQC1dul6+pRDryDJ7iJ01KOBHN6lMhZ8cccKs=;
        b=MLzAPeFP7beVrC6x+pwPY1qQC2rVVqzuSTfjc8+bRTihlVcEg7ZwA3MfAslldQG9Cv
         ZyvVEsJl0cgjboyrzSLRjEvV25cTv82M+8Peu2lfgGfk88pKjVnLLx7b3fMJ+RUflfG5
         /YlKW84oVlryTB3jUcIXJaLF56I3ImJ8pkkIQZRjwpljmVY57b6+IHKaT1POBjTkCzjj
         hGBSSqt8We/IlAzqHbJtNpHnCatzdJayrLuLaLHyPz2ELD5jotdxWY3FvMXsN9rbre9h
         i5sj0ECT3wckyK6vKKOiGc8pdUYszh+TOmRBzg2AUEsojNI9t7flYq81e8yUFChvuoMN
         hSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=grRObLxQC1dul6+pRDryDJ7iJ01KOBHN6lMhZ8cccKs=;
        b=jtgXM9QDTXcJQ5BB2r51jEH7GJc0IPYyVpM77AhA2HesZsQwM4KxwzeFkoGUDAan3f
         9yVKIznHWnrfAEIN2+qoRXGbvQtm46aVRLFSMbyIm9j+/Nz9M70lTREq9ZY/LNkEBQP3
         6NDAi46InoDkYQ/J3k7HGXhCMDEEJwZKAc7Aq/w28miwZvIeSLZTKe9CUOrkv2tbr/x7
         qe34A0kaZ8dZ7dj5bXtyHVfE1aj43g2L75tT9AL1HakiOngVEVA39o/Fkc12ZpNvCAz/
         SDUspr75MSWzHerCcC3akdeyaQ2DAsWd6Al5r9GIiDy7uHd6H9tt02/awPMUGsqq+Gwn
         ellA==
X-Gm-Message-State: APjAAAVElHlZxDVN9mtmX55vx6L/yT+GeRiqzoakF7qM7Pf7S5wqc0vo
        G/aTO/gZfwQa5YZ5qPprGHVQ0A==
X-Google-Smtp-Source: APXvYqw7cMaRzsdl58xecnTXyAQj6Du4Yfz9N/+tRgW6t5lhCN16jA9FuUWa+krZ2rl01UgmPMmWqw==
X-Received: by 2002:a17:90a:cc02:: with SMTP id b2mr3771167pju.137.1578653200591;
        Fri, 10 Jan 2020 02:46:40 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id e10sm2590901pfj.7.2020.01.10.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:46:40 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, greentime@kernel.org, anup@brainfault.org,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        gkulkarni@marvell.com, will@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, paul.walmsley@sifive.com, hch@lst.de
Subject: [RFC PATCH v2 2/4] riscv: Move unflatten_device_tree() to paging_init() because riscv_numa_init() needs the dt information.
Date:   Fri, 10 Jan 2020 18:46:25 +0800
Message-Id: <57f7439888a99002285da8114d4a99baa676e865.1577694824.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1577694824.git.greentime.hu@sifive.com>
References: <cover.1577694824.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1577694824.git.greentime.hu@sifive.com>
References: <cover.1577694824.git.greentime.hu@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is moved to paging_init() is because that of_numa_init() will use
of_numa_parse_cpu_nodes() and of_numa_parse_memory_nodes(). We have to
unflatten_device_tree() first then we can call riscv_numa_init(), but
riscv_numa_init() shall be called before memblocks_present() because the
node information will be used in memblocks_present().

So the calling order will be looked like this.
unflatten_device_tree(); //To get dt information for memory and nodes
riscv_numa_init(); //It can use of_numa_parse_* and set the nodes information
memblocks_present(); //The node information can be used now

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/setup.c | 1 -
 arch/riscv/mm/init.c      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 365ff8420bfe..bcd85f502fb2 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -67,7 +67,6 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_bootmem();
 	paging_init();
-	unflatten_device_tree();
 	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 69f6678db7f3..fbe69fe47806 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -491,6 +491,7 @@ static inline void setup_vm_final(void)
 void __init paging_init(void)
 {
 	setup_vm_final();
+	unflatten_device_tree();
 	memblocks_present();
 	sparse_init();
 	setup_zero_page();
-- 
2.17.1

