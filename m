Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DB4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C40E522B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596479581;
	bh=7hu3yublc+ONVpbI8MLmqzAhCY2mR7MMmJL7HhW65E4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=J4gncjssxYhmkk3Uyn/3LFZD2UbKLtv/EmpSukr+AXujGv9jLTW4IrPLtNaa6KSvH
	 x6STS8tP0q1RhU36afpviVkXFDet9lf1LWIUWi5+AUmX48iZ/2QonV+NtZeG1mvFtH
	 NOBIvr1nT5Lt540enwV/Ggz3WjJxmtBLYcm/5YWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHCSdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgHCSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:33:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FC2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:33:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so13121627ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZL3aNxKN4cfSc47WZeqZMRGsiUlOPUvtTQ37Z9Wj7Ck=;
        b=QpodYvR4A8hQ7JVSHZ3UQW2TtgJgtixRV6kxmoZ/mXnFE/q5o3Mml/2OhCZVmHefpH
         SgjYcjVlFXVrp00l7IaedD0eCT11RcKW3zkE70qiE6sMVMN62DFpPvmboehbJDy3oUD9
         9v3Iwrh8kTdAKplijWkTG2+fh2HCOh9dUKtiMEqFAc+cMcw9GGRDR6C2hKndpRJZ6BsZ
         svmAaEA2fIWBo64isyH7cTXcHDWwkBjaPOTqixFatFyAGwxGdageY+M7wkZBtqs2DW51
         La8iXw4yX/KKLhKhtpLznBGlpR4P8i6IPkmI6GawGyPH7LQcHYkyuIDyy/OylEwU9ovs
         bQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ZL3aNxKN4cfSc47WZeqZMRGsiUlOPUvtTQ37Z9Wj7Ck=;
        b=HlRFp96om2iIP3LmDwjHbTWR6zQdqWRVeQg0iwdQU+41wrwxY28EuXRR0eXSZ04KJ/
         RYSKeCF31B6EajKwPKtsonYgQBvxEDqAhusK74FJAV4m4P2nIe8DYiojcbjymntX/2uo
         Jwp1hxadZGRR9pxv8Idk9Ker9qtBDm48yNft5vmQywPS2t/WLmKhndaEdcCRTHnJSLbd
         0FzJLy9mKDL5rh+KaARxB17+whZpJ+DYP8TYebOr2ZtEZeex/aGKSWkcNcaS6pcVgDQN
         BlyByssRSIDKTIpYrSVxoG1bKh86ccjzV31uJKVL1NhecMe2/nlGCehB28ECNqc6ZmOF
         s69A==
X-Gm-Message-State: AOAM533LcHFrpClSpIHu+l0jVSvOwPdJlaVtQsbK3+CUj2WxudMXgdO+
        fWSXoFEMn+fuPn1HM1+y3GE=
X-Google-Smtp-Source: ABdhPJwZWIz35e31CyNmRf6T3r02A6GbATn6rgCQMQbexCiM7T+PmOWrJs9ppxyWmJqjQ+eKUQ+93g==
X-Received: by 2002:a17:906:6a84:: with SMTP id p4mr18695057ejr.374.1596479579194;
        Mon, 03 Aug 2020 11:32:59 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c20sm4734110edy.40.2020.08.03.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:32:58 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:32:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/microcode change for v5.9
Message-ID: <20200803183256.GA1167269@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/microcode git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-2020-08-03

   # HEAD: c8a59a4d8e3c9e609fa915e39c3628c6dd08aeea x86/microcode: Do not select FW_LOADER

A single commit that removes the microcode loader's FW_LOADER coupling.

 Thanks,

	Ingo

------------------>
Herbert Xu (1):
      x86/microcode: Do not select FW_LOADER


 arch/x86/Kconfig                     | 3 ---
 arch/x86/kernel/cpu/microcode/core.c | 2 --
 2 files changed, 5 deletions(-)
