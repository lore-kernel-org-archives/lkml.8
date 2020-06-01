Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31167C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D99D2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591029122;
	bh=/5uqUt/LssN1iTN9u5Bjd4GBUB4u/WYODPKG9oLRy3s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bA/cWSWWiVIDQeA8S7mNOfBLePa26M3jxpXIJK8CdxQfxMJskQFkRJKIzAmzGlGF3
	 gTLxnRNLA9S8cmCsUofNCut8oakdGqeTT3fAVtU5hKdw98dXN21dJTMQcmydcaoVCp
	 LtZjUW72E2yVu4/hdtkh9WB3h/cr5dTk07ZoEZTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgFAQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:32:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:31:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e1so468212wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bdWFPz3iOxRXn3eGzsQ6YlzwM7JNqf8/tZzjsqoyxH8=;
        b=HX4sHnuzkNezGZPbjFwbq2zvE6a47VOOCan/+XW8OLYNPn8zFXdzg3N5VAhaPl2bop
         SwZel/oyhy8KTpb90jA66YsUiHD6UN0M1oIhRREi22d3Ot/dQKGc7x52qAUi/4Fg/tiD
         2Ti8pLbdeIkAnJENf9CfPtYR80B+/U0rgGtBF+QzWEXONZo2jWwM8ntG9fpa6jGl6wbr
         5e69JIzjJdu1YwUStEfjsMISktO7Y426i4xN5rmvV2bzTIBHa5ix3AMT85BWVRZ96mVw
         IdciR5yn9SAaE9rHrMWqS0aWIeDU5qqoh6elEI64ZuddQn+jzuyBTpgN1t/m+/eyB0pb
         udrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=bdWFPz3iOxRXn3eGzsQ6YlzwM7JNqf8/tZzjsqoyxH8=;
        b=ObCRR6YngbwIjsBC+nxla3NQyI5hYwqcwb8pVtqiQTHzITAzovV8bZ6zra3CsV0oDh
         sVVBVOt6P+sqJTrM2RC2OElDvAV4T5/ONqwIAzahZ4bAQVARbXTEEKbPxuF94x/3aR1t
         EUAeRfzw81zs2ueEYJU/h44eRFj7a83wPAc77xvKqyuDlJxZXoBYe3Flg0RqiKoRx+jV
         M147Cv+2Emv1XGfFmtp+pl5fk/4Czb9GI0c3YgOoYBAsrbpOWzI5C1EvQMXxQpWuKY7c
         pUJl5yUBsmlhXlwkSRIjXelwZuKAsQI0Z/C/EIqQu1HCc974eS4OeISHL/Mz5NIOTHKS
         qxbw==
X-Gm-Message-State: AOAM533BxZw8fa8o3pnqGSZFslh6GrjBaEgPOp5S48gL76GhDs/3WcDj
        giHKJQWejIaApmqyD1RmqzA=
X-Google-Smtp-Source: ABdhPJx/w++o4wYt28ro1f1PZGuJghGIkegyWNxXyzMO2nC80b3WSmBKI23vOd7DfVo+OiajmDBCNw==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr22637914wre.421.1591029117574;
        Mon, 01 Jun 2020 09:31:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a126sm117011wme.28.2020.06.01.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:31:56 -0700 (PDT)
Date:   Mon, 1 Jun 2020 18:31:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build for v5.8
Message-ID: <20200601163154.GA1179988@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-06-01

   # HEAD: 38f3e775e9c242f5430a9c08c11be7577f63a41c x86/Kconfig: Update config and kernel doc for MPK feature on AMD

Misc dependency fixes, plus a documentation update about memory protection keys support.

 Thanks,

	Ingo

------------------>
Babu Moger (1):
      x86/Kconfig: Update config and kernel doc for MPK feature on AMD

Fangrui Song (1):
      x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux

Masahiro Yamada (3):
      x86/boot/build: Add cpustr.h to targets and remove clean-files
      x86/boot/build: Make 'make bzlilo' not depend on vmlinux or $(obj)/bzImage
      x86/boot/build: Add phony targets in arch/x86/boot/Makefile to PHONY


 Documentation/core-api/protection-keys.rst | 5 +++--
 arch/x86/Kconfig                           | 4 ++--
 arch/x86/Makefile                          | 6 +++---
 arch/x86/boot/Makefile                     | 7 ++++---
 arch/x86/boot/compressed/vmlinux.lds.S     | 2 ++
 5 files changed, 14 insertions(+), 10 deletions(-)
