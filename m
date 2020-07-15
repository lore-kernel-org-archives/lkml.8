Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D3D2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="g5wHa9b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGOUMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOUMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:12:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:12:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so4172291wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKQNjZzmCPBtKyAhLJMmus5XdLv4tDXCgTh+A5rB4FM=;
        b=g5wHa9b7UMgWKsb3tbxt/L23NnqlQ39S51PcxKKi38gTxycgyknCz6KTCapqh9awVw
         ZERpcqMurWsLpCum2BfTffpqzX1iCWkrr7d7iJr1IRA8K0Br5h3dMuLi7eCjZ1hoNE66
         xQ8SZiBOzaODrW96/4u61CNXA+pSeM46SHpVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKQNjZzmCPBtKyAhLJMmus5XdLv4tDXCgTh+A5rB4FM=;
        b=SM17fdYK6P6ndVZxAvxKZn/eJOWFXONbbazw2+WcvsnnCr9y+RIyJjdY4ciq+wp91H
         OmbnkLa/gFkZtwchnbStqqesaSbri8yUCNNIi+LWYYoWSzeJqgQcwI29ArhQSWAlTBJy
         W+j0OJ3SiofzH8AnJC+Hwv/eVB+3Vm1zBo3o9xWwxC1yQbB2qLyoi/a35NycAES8mcoJ
         sxyyo4j6g6YpGnq7Yy6CPSzyKyT3SZoOWOieMWbDohY9xiS9IBJIG7NGUdGWzr4+VIaJ
         jp8GpST3DBdsd+Ysy9EhbcUScAihmYQD5P7YnhtfwQH2PZ1vggSSHk72rPVbDaTUvXDg
         amzg==
X-Gm-Message-State: AOAM5319l3mmUbMBNWMOCgJ+AvRiUZPLxVFx+or42qse/Fu6bYrYHx7d
        ASVMUJqJG06uscS8NQ8uM1DxNw==
X-Google-Smtp-Source: ABdhPJznKAiXOJvXcBqbRplHMKOjWUQQ2SvughtssvksMnraFKMCly+xId/MqKF6rstpuHSYtoEAHw==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr1121479wrx.44.1594843936956;
        Wed, 15 Jul 2020 13:12:16 -0700 (PDT)
Received: from dev.cfops.net (88-144-169-51.host.pobb.as13285.net. [88.144.169.51])
        by smtp.gmail.com with ESMTPSA id p4sm4765528wrx.63.2020.07.15.13.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:12:16 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v3 0/3] um: allow static linking for non-glibc libc implementations
Date:   Wed, 15 Jul 2020 21:11:56 +0100
Message-Id: <20200715201159.54166-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
  * rebased to accomodate b816b3db15f68690ee72a4a414624f8e82942b25 ("kbuild: fix CONFIG_CC_CAN_LINK(_STATIC) for cross-compilation with Clang")
  * removed unused FORBID_STATIC_LINK config option
  * cc-ed Masahiro Yamada <masahiroy@kernel.org> for can-link.sh approve

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

 arch/um/Kconfig               |  5 +----
 arch/um/drivers/Kconfig       |  3 ---
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++++------
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_user.c |  4 +---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/user-offsets.c    |  2 +-
 init/Kconfig                  |  6 ++++++
 scripts/cc-can-link.sh        |  5 +++--
 10 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.20.1

