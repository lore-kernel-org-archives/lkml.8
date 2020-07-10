Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8EC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ED620657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMIVw11G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGJXBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGJXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442FC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so3169213pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTTJAkMi8Urf+RzgAFeYH3KuT0KGRsyTs9jUZmrlJzI=;
        b=mMIVw11GqwV00VvK2cnOudPuaUD3ot4X9puGq/kk9mDU/tjVUWuIMp1XOAzCqjQCRW
         e7kbu9n0uviGBe1xiVsrxefVtKvgF/ydYZYvQ6KW5Vvvt38gE9+i+Ss9qnUtSsUPUfdh
         xOR3JmXAOdwNnHObxww7MJ84QXv8+p/KmkgQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTTJAkMi8Urf+RzgAFeYH3KuT0KGRsyTs9jUZmrlJzI=;
        b=obewzCqwZw+E2gwHg6vurjx1g4AZO7GReRI1KZqnGNHJ6sSMFZyn7MK/jceTVM3zbu
         40tT3UoH87TXHYJq7n6ZcZ4oDbLg2srBbCiwNB6VEbK79M/dmqpwTRnuacnCAjRUR/0T
         QToWBrfsHUgn9Yx80o15gIhEM3QPwH5tDL7rPFbWzzgdcSZGk0NrIP74wHlFroz2cbnh
         JjmLUmovS0MjeUzvGccvKaHW1oG4ecZDko9vZUofBQS7gl8O2Lwf9ALsZMmHRhxvvbiK
         ue/EFmXDq4Rpvg2uLU1HBmrq3Co9xKWoJMZxl1LpISz9ThPMaLAdYcpOGQAjlZiEqMGN
         3fLg==
X-Gm-Message-State: AOAM533Xekip4msfJI4oeCPhlWDzv2I6HoXaq8aFu230a4170y4ndzX0
        FsN4ap0wl7njRRE1qZBbr37QKAgatjc=
X-Google-Smtp-Source: ABdhPJwBNyJti+HGPgdEM34452meOElIcXjnX0dfuzNLSi3KpdPIkAL+jBlsKN4oMsrp+pRQIf2uxA==
X-Received: by 2002:aa7:9ec2:: with SMTP id r2mr65599649pfq.265.1594422070813;
        Fri, 10 Jul 2020 16:01:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o128sm6926634pfg.127.2020.07.10.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:01:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp v2 0/2] selftests/seccomp: SKIP tests requiring root
Date:   Fri, 10 Jul 2020 16:01:05 -0700
Message-Id: <20200710230107.2528890-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- check for CONFIG_USER_NS
- add review
- fix Cc list
v1: https://lore.kernel.org/lkml/20200710185156.2437687-1-keescook@chromium.org

Hi,

This fixes the seccomp selftests to pass (with SKIPs) for regular users.

I intend to put this in my for-next/seccomp tree (to avoid further conflicts
with the kselftest tree).

(and for those following along, this is effectively based on the -next tree)

-Kees

Kees Cook (2):
  selftests/seccomp: Add SKIPs for failed unshare()
  selftests/seccomp: Set NNP for TSYNC ESRCH flag test

 tools/testing/selftests/seccomp/config        |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.25.1

