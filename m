Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42489C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FF9206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595668829;
	bh=aeRAG/kC/0aysNZX224jUCtpgyUhp0Sa47ca5zqm1xM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W7siUmK+JYuoODW03jG3v4h35isUqlHKevvAz1/531zPO+diQnT+v8mGnXy9nK3ht
	 mWxmTD1iP5Wy0CXoTi2zo0sm4wO8tmQeEKB/BmLzrfxKMMmYB6tQoDd0IFLlPGjFzq
	 mS3fgZrHMQ6xRTCb0neMuNq8JTnI2OlN8xgE99FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGYJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGYJU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 05:20:27 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E5EC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:20:26 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id di22so1486340edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k252SMWwDEnogS2pDzYz7A7UwtSezqAXG+jZEu5O+U=;
        b=NxELK9ZSTI48B0wjJLslFpd8DbETOvSwPPIgG680IcvVQBQ7UqPKSgaeRlS4YvJizQ
         99CK7yB4uAzZS1h1o8StkhQAYHzqpG3/UVKlOnRYQAEAGfkQwt7el+xz9FdZZteiyihJ
         6/XqpmGgJmneG9ZOLSpbgUM2DsQMTLnocpLpsPUfivwlkcHyit2/BR6jVle3FREl0zqJ
         kcIKt89rzJB81FZp11Bl/pl+DUUK6LHHWazzFtIj2DybyoTDWwFSIDTu4CAlOP439FOS
         SysyhrikgsyQbHnFbk5gjEIvnhJku0O9C6dLKbx4INU3MFfOm1R9pJFfF8VKcEdvc2hX
         +VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+k252SMWwDEnogS2pDzYz7A7UwtSezqAXG+jZEu5O+U=;
        b=QBvJz6f2OyPUU/Zp1aerxUFn4B3el5793M85YlmRc1UE1/qVU3+Dnwm2OqdvuTZuKG
         +15Gwp/TrdoWBRLxsipa8XhX9583vi9XYD3PqIc752abXGqG2ACg1pAEtd/DhD6PsVxi
         PAnba3y8HA6CYnRT4y+woTLY/HprBxDAaB6PADQncR/ytnFsMIEr6qFAl2GgozaHTQiM
         oZQGchJER52VShib3ZGd8b/L318GTJ6dPqcdOKhc3hZVOP/0Y5ykXapLUaSB438Hn6qQ
         2OZcUqnYKYzqmtthjiLwjFNvIrZygG1HkaeoLdfb6vM58M6BrhOUD7tCFF3/j3agcd94
         QWZA==
X-Gm-Message-State: AOAM531Wvoq6Lu7hB6FDCrVSvFP3CYRvI08FpXTi0XU/ysjAH6bdVbO0
        ArKVr+O0IYxtPVHJn4BxvM+6nXrI
X-Google-Smtp-Source: ABdhPJwS4VvJIrkoM/042G6AfxnBqtOPKTeCbC3ecv+x4DYxlJL8lIjm6zIkaM9cde4y42BKV2nM2Q==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr9484661edt.333.1595668825145;
        Sat, 25 Jul 2020 02:20:25 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e1sm2549140edn.16.2020.07.25.02.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 02:20:24 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 0/2] Fixes for the generic entry/exit framework
Date:   Sat, 25 Jul 2020 11:19:49 +0200
Message-Id: <20200725091951.744848-1-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a !CONFIG_SECCOMP build bug found during CI testing,
plus adds a couple of 'noinstr' attribute ordering corrections
similar to 7f6fa101dfac and previous commits.

I resolved the CONFIG_SECCOMP problem by also making GENERIC_ENTRY
depend on HAVE_ARCH_SECCOMP_FILTER. This dependency was implicit
in the new code by virtue of x86 being a modern seccomp-filter
architecture.

The patch makes this explicit. I think it's reasonable to assume
any architecture that wants to make use of the generic code to
have modern seccomp framework. If they don't they'd have to
port it to the old secure_computing_strict() API anyway.

It's on top of the latest tip:x86/entry.

Thanks,

	Ingo

Ingo Molnar (2):
  entry: Fix CONFIG_SECCOMP assumption
  entry: Correct 'noinstr' attributes

 arch/Kconfig          | 6 ++++--
 kernel/entry/common.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.25.1

