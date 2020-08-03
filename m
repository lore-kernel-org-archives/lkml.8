Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95A2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AA022CA1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596479020;
	bh=GzpzpuLJrvtY60GCMHjYy7MtunNTTDlZ1/s87GJPcR0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eri8ngXZtpYlfliSKSx4nNV5lhRkKIhxoI8TZn0knqiVd3D+xisnL3shKREfYAMt8
	 BFIHwOebd8M8dIEQPpznPPymB7wjsFFTmeo+j/h9cJgs+oAXjFVd/Rd6JhkgM1I9Gc
	 g66E+EUsJHrcbVKvMkaWMNe9uRmPnU+GSIM4/E2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgHCSXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCSXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:23:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:23:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so13862558ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2w4g9xyAOAiDlOpqVJOLXl5B5h4orSo7EF6kxm8aP30=;
        b=Z+JWcuFa+TaoY65uBg6UmAyVoF9QXGEkOPxyLamXnR4ws/MWP5fnwdCaB2WHsWPTOt
         2U/tcRygrsPWZEpdbB2iYv+6u26DmcoxO20enYSwactfQSBm/Z8jrk4bvGrK4jQsLwW9
         vVDUJiRFrfiR59sz06fv9HF1f/3US7bVZQuC+/bZYb9J+c5akipHvR/EWpvm5jndzNqe
         sH9MYU8rwLxTlF+J5bzrKitJAtoEIydoqT+TdHmSziRYoSmgo1O7X4MgZ4TDl5k3XuH8
         0+PqGLTQ4n7msjq/QBiJBXopAABr4IfrgYebAUOJFh5InCjU3mYDY3RZDKxppPG1/W5w
         Bwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=2w4g9xyAOAiDlOpqVJOLXl5B5h4orSo7EF6kxm8aP30=;
        b=raClQ+PuDkv/skHzsv4+LKPDxx0BGqkMvOJ6BBlnEN4idb5Jdp84YFpD3tie25UnBk
         bbf3P4wQKqmM1fDMq/VQgj/Bdc2sTlD4AQG+WE7XjVeV9oVFhWhP7hKHVWegy9WUYOch
         VctVIHphK+tsxPgrx5ozkXhenqGj08qRdH0c0HdsA3P+Hcm8rfgK5hZAwDEFHxaa7PJk
         nK7gKLiXW5e1dFopgdpomVGYefLoEBynRUz2VSTEgo2Q55jTj2KGWHkYeseHu5CW1a3l
         CM3aYZ7iVEbw8cYA4pP3Ln06Sw3QDyZoeR78Kk7K080Ka/XA0idOaq1fPc50Q3QAcuSr
         f/Bw==
X-Gm-Message-State: AOAM532GQJ5tuZ1iYlTEUbHlMBJxGQcy5QX1slYx/AL1Hljer9/yHeE3
        l5yGPG4EcIe6sHbaY5+EyU/aDIZT
X-Google-Smtp-Source: ABdhPJyCXYZT9Gwsi7rJrRBUSrwEUxuXynWWEEVE4SBOI2moHSm5MlqG49gqJYbnveUdOGdTb+1UwQ==
X-Received: by 2002:a17:906:b59:: with SMTP id v25mr17545693ejg.436.1596479017453;
        Mon, 03 Aug 2020 11:23:37 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c7sm16616202ejr.77.2020.08.03.11.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:23:36 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:23:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu change for v5.9
Message-ID: <20200803182335.GA1103918@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/fpu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-08-03

   # HEAD: 4185b3b92792eaec5869266e594338343421ffb0 selftests/fpu: Add an FPU selftest

A single commit that adds the /sys/kernel/debug/selftest_helpers/test_fpu FPU self-test.

 Thanks,

	Ingo

------------------>
Petteri Aimonen (1):
      selftests/fpu: Add an FPU selftest


 lib/Kconfig.debug                           | 11 ++++
 lib/Makefile                                | 24 ++++++++
 lib/test_fpu.c                              | 89 +++++++++++++++++++++++++++++
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/fpu/.gitignore      |  2 +
 tools/testing/selftests/fpu/Makefile        |  9 +++
 tools/testing/selftests/fpu/run_test_fpu.sh | 46 +++++++++++++++
 tools/testing/selftests/fpu/test_fpu.c      | 61 ++++++++++++++++++++
 8 files changed, 243 insertions(+)
 create mode 100644 lib/test_fpu.c
 create mode 100644 tools/testing/selftests/fpu/.gitignore
 create mode 100644 tools/testing/selftests/fpu/Makefile
 create mode 100755 tools/testing/selftests/fpu/run_test_fpu.sh
 create mode 100644 tools/testing/selftests/fpu/test_fpu.c
