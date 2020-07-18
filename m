Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56134C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A93B2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBSz+fT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGROiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGROiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:38:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8ABC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d18so13311986ion.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CZFF+SPnEfHSXiQgUR+BE19nE+BkkIE3L7TpE9V3uc=;
        b=IBSz+fT4JgoTuFrsLgZrNzfmdABix/zmUstvtGPatwiHcGKqFgx/IJEh5UGhBPpaA1
         a0vySOLKu2W5b3ddxJurbxLPsQSZRwuk+DifuxtxrgsBt+vW8kLMrRt6RWHV/CEB46RE
         6GvMAjxbY+DCOG0Zi82HdOL0XZtkyTKHRvhuImRMklw537iEKOGt/YsJkjuiTs7LXNh5
         87reovGvbw6kf3A6uiXG/YMZ6qRuulILzB96WmxpY3IJE7cnf7qBT9L6QeOCc1TzCg+v
         O5tPd06EeaM2y03sgYUWR9hMwa7A7zRQF1u27pa+ulrBoP6cg7CZuZeyhKe3mLSCzYl1
         zLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CZFF+SPnEfHSXiQgUR+BE19nE+BkkIE3L7TpE9V3uc=;
        b=mEuDbTBp+kP2+AIIpkIEM3QU6WK/p8AYvYk/dBcHOIa6pNzraX/92UXDX+inpdsJYF
         Rv4R+RU0MUQSrhfFRG+gPbm6kZ7Q2Vogt3Jl5ngQJq9F9YRm5XNx2pqvHeJ6bJYLd1tL
         g79F9Ef6AR+epojV1vAGPLQi2HlmJjFzGSYLmU7RNaq6PBeFYLKMz7+aIeteabLVLwUh
         qHN+RzAPT/T4DE1o5DqN5E9R+G3dPfd/qLcaIMFzHonKpuXjY1S0nGOXhz0FpxBB8D8S
         p5T+TAJXc3vOrEII94oSdoefkH1IoS3CljO/OmzhenHk6b8GPf4dAF9Ka/OfoaDdaBer
         Atmg==
X-Gm-Message-State: AOAM530N/yZfIz75mVsNcjsK98IYApxZtIckkoZKG78J2cECFtjMQC8f
        eTEtWRk1hwMUWS2yGjP22yldUc4=
X-Google-Smtp-Source: ABdhPJySoFUNKeU1kzzCX2DTnsI9TY1hbtPQgWd+biWv7IxJ9a2wbtQiaoZ4rkMoYOW4Cyz3Q1i/6g==
X-Received: by 2002:a02:c50d:: with SMTP id s13mr15856962jam.109.1595083125320;
        Sat, 18 Jul 2020 07:38:45 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 5sm5888610ion.7.2020.07.18.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 07:38:44 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/3] x86: Clean up SYSRET/SYSEXIT validation
Date:   Sat, 18 Jul 2020 10:38:36 -0400
Message-Id: <20200718143839.194960-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up the tests for using the SYSRET or SYSEXIT
instructions on exit from a syscall, moving some code from assembly to C
and merging native and compat tests.

Brian Gerst (3):
  x86-64: Move SYSRET validation code to C
  x86-32: Remove SEP test for SYSEXIT
  x86: Clean up do_fast_syscall_32() tests

 arch/x86/entry/calling.h         |  10 +--
 arch/x86/entry/common.c          | 142 ++++++++++++++++++++-----------
 arch/x86/entry/entry_32.S        |   6 +-
 arch/x86/entry/entry_64.S        |  71 +---------------
 arch/x86/entry/entry_64_compat.S |  13 +--
 arch/x86/include/asm/segment.h   |   1 +
 arch/x86/include/asm/syscall.h   |   4 +-
 7 files changed, 108 insertions(+), 139 deletions(-)


base-commit: bccf9048549afe54b3c6bc8979ebfddea748da85
-- 
2.26.2

