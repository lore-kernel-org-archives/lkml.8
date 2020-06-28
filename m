Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54F1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C8B206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593369209;
	bh=Em8qFb1eWUlBd7XDjjMCqVVyOy7mJQMWMJmfc5Nenss=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BPtwf01GWZ/i5MguFXUKGwkLY4maAT4krHhFOwaA38mD6gJ8ZCWZ67QnuL0Iw9HQ7
	 O5AkE6llLoHMikESU281p++1ZGGozSSUWJAvBaDOfIG7Uh/3ClYYUJwk8K1MzXcwij
	 EL8Q6mV9iTn2OH1NmF25ivZKkt2ALJDrZ7m2eOoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgF1Sd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgF1Sd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:33:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E74C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:33:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so14433430eje.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=V8HwCRdbsG3FrRlFfydr7sVFRRcJyqLWI9ULgwmDXR4=;
        b=qScgKLf4ul2ZYauW6tofMhpI9JCl0nFYCUssjG53PwhCO+w2J9AImKoZF/WwHvLRRK
         n/Db1ZiaSzBDUFdwJFgMmiG1AugfpJ6VxRpgzlb6EWr/rs7UMrpoNp3IT1C8PkNK9JSa
         Osj9hPFe1Hsd/kjPq92XkwuaOUq8nthbX+b2wAaqDVeYFl69Ew6rp2bD9PCAy4p29dBJ
         GuZKkL1G4VUi40syi/z8g9Vxs6B9vgsp+ZTI2HYySM0NNWzvSHzKmqzXHk+XlCjg5NxV
         GctJsbr8wo8wgUhQZqAun7eHxBYvRPiLZfL3QPgd0YhgWd3OPzv/tmovYUev8oYcCY3x
         c81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=V8HwCRdbsG3FrRlFfydr7sVFRRcJyqLWI9ULgwmDXR4=;
        b=Bnit3Sdq7Fi3RqCfthFQq5BYWgRL+vRH6DZ5JRA53SMf/ou3s+8Q/H46Ex5+5j9gVN
         GNFUrOoLJ4JFAZ6if0hPKlo4IPZ+yzkrPwv0+0BsEEz2bpChdoUQf70i7JV2iEbWGSRU
         Z6F2HsTg4wFzPQTYGRSPvSiYuiTk05h2vPrwfKlI42vxbN4uKj21EvPoCsA8d5IE0QG6
         SGqSl1G70DRuork9CrCby0GEgXLO2V9EtIi/qNXFRQGJ/BxyzKAp77K1a6l/ep92hICm
         Dv0ORWvKrS8j3WlVU95In4ovHy7oyqNCXScnpCCX4QTUN1QPbHyLAkIF7lrzSUz/qOV2
         n8mQ==
X-Gm-Message-State: AOAM532eLmOY0Xyf50joxJGmW6iXYmC+HaLdh7kg4JethgpypVkbBz+X
        SSw9lrIWAJMKEsqrZVZwDVM=
X-Google-Smtp-Source: ABdhPJyce0UbMz+qmgaDTydgwdcyfBpoN0y8tt4h+nxfirUYkYYEVmB64sIQxqSBKs1OQRgtRjeZcQ==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr10724482ejb.552.1593369205609;
        Sun, 28 Jun 2020 11:33:25 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x64sm10897081edc.95.2020.06.28.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:33:25 -0700 (PDT)
Date:   Sun, 28 Jun 2020 20:33:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fix
Message-ID: <20200628183323.GA127831@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-06-28

   # HEAD: 16accae3d97f97d7f61c4ee5d0002bccdef59088 perf/x86/rapl: Fix RAPL config variable bug

A single Kbuild dependency fix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Stephane Eranian (1):
      perf/x86/rapl: Fix RAPL config variable bug


 arch/x86/events/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 12c42eba77ec..9933c0e8e97a 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o
-obj-$(PERF_EVENTS_INTEL_RAPL)		+= rapl.o
+obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
