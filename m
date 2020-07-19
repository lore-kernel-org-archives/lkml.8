Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC3EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E0320B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="q9GZby6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgGSVCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:02:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB292C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:02:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so23231548wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BtSnXzObHS7H0mF3gfdZucE+NMpIQEtRNBuHfbTl7Q=;
        b=q9GZby6YyyttYIWNMiifECfdIe8+moDkGFlUrpBan3fS5CN5ogFBNrHoU1AW9DQj+t
         nfMoEJeAMTEUj3EP+Bnj0LqTF8qCq6B6WUahOophP6zidyFMloXfTH9S0EQ8iTbpcers
         BnT3GOM5iHRFAtGsW48SV64D4KwaTT0rZiu6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BtSnXzObHS7H0mF3gfdZucE+NMpIQEtRNBuHfbTl7Q=;
        b=IHeVY8AdfSpLS5UrM5mVj2ccHrtE+Qvwhbf1Ix6bF9SzmpUmKIo9is121SzKz8xt9j
         UsSpGQM6K2LsIbZ+isnXhYNBf0oFWjXShW4D++W4cFERni+ST+0hV56ZXCJSkN4+9mGd
         hhZLnx1PEhsb9W4czA32gVrqmAlGselSLVX1lVSp+OjSib0hHirdrj7vB1a6vsLM8RrO
         sIlKI9dwyt42aRoP3q1q15A0DoiiBI9WW4OEqec6NXgjwnEyDSWwKXytpfYRgaK0NJVA
         qChr7e1Z0hW2mkr2RTXSDGDKG5LQpsTThotCv2dFH5FOJoAPp2RAjcKzHH7RM+bHQMC2
         Lhiw==
X-Gm-Message-State: AOAM533+wBn0tDHUH336HT5NqNmNeNIWBg1d1+QvXFpo3sW3LWcrs9yS
        S/7/jsMowhR0g/vkpIAybruGGA==
X-Google-Smtp-Source: ABdhPJywjdmjFnCD1Fy5nwpLU09A+7NmBmjrP/iPuMN/Fcvq5e4vZvTEpJjtSpH4geBLJS94ZONuzg==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr17687424wmh.166.1595192556402;
        Sun, 19 Jul 2020 14:02:36 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.224])
        by smtp.gmail.com with ESMTPSA id l15sm27408453wro.33.2020.07.19.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 14:02:35 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v4 0/3] um: allow static linking for non-glibc libc implementations
Date:   Sun, 19 Jul 2020 22:02:19 +0100
Message-Id: <20200719210222.2811-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3:
  * restored FORBID_STATIC_LINK and renamed it to MAY_HAVE_RUNTIME_DEPS, so we
    don't have to maintain a static list of options, which may produce runtime
    dependencies

This is a continuation of [1]. Since I was able to produce a working UML binary
with UML_NET_VECTOR linked with musl with the changes included in the patches
here. I was compiling on Arch Linux, so hopefully all the latest versions of
the compiler, libraries and binutils.

I also tested allyesconfig with both musl and glibc. The compilation succeeds
with both, however both binaries (glibc one being dynamically linked) segfault
on start. This is probably of some incompatible config option/module being
included and not related to musl/glibc.

[1]: https://patchwork.ozlabs.org/project/linux-um/patch/20200624212319.403689-1-ignat@cloudflare.com/

Ignat Korchagin (3):
  um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
  um: some fixes to build UML with musl
  um: allow static linking for non-glibc implementations

 arch/um/Kconfig               |  6 +++---
 arch/um/drivers/Kconfig       |  6 +++---
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++++------
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_user.c |  4 +---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/user-offsets.c    |  2 +-
 init/Kconfig                  |  6 ++++++
 scripts/cc-can-link.sh        |  5 +++--
 10 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.20.1

