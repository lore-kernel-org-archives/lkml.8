Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9741EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7191720771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKahYClp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgGUJo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:44:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23749C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:44:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so2171573wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oay/q/Jq6u5HCNMFK6qus7veTfF7oH0EkEyRRbWbBuo=;
        b=pKahYClpT7rbPBcaiNecELPYrFpNr1sOL/KBnAvFlQ/TUhvOxhwaV1ieuOvT9p1us4
         7pAMGHA/F5puU5alUBQzKCc28k+Z7+mKr70H2brQsauG36WtQ6blvcQgr3ZF1Dr6dJaS
         NL9Gt6qiOUhFlbqwCHXnO0ZA2YCc5HCN5QvsQ1TrMrhwSb8hvm+Wwew6xBo0PTh1NWvE
         zM7e0VS6eULENmw536jEVb8MBPO5pzsXLmYGcyVGyt6wLUAOk9SdqPLtQfySwLojPCT1
         RxEs3sxrFuQdRj/H1OeiHeUP39Z3NLk78zuf6JvG/zOh96HuCYNOv3II/OKGccw/SIin
         tgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oay/q/Jq6u5HCNMFK6qus7veTfF7oH0EkEyRRbWbBuo=;
        b=aPOwbjQpLutJqyKmgi3Bd5/jrao2ySysgrjC9M3R8wE65ExMtDEgKaTPiSmUMChQ0V
         1RwoX+r187mjNeZwWj2l2g4Mpvqpe2xx336FZ5ilCNU7AFwQB7zHhCXegDBieBbs0Z5b
         SQnOFazZA5L9kPi9tPhxhdVXEiwnvLBOVSDEydyW2/FfYy9KKe0fO6iS3JmGY6FKM5pG
         XKhPB6sI7xwO68EyZAT7SGOK/HVD0uL7kgUX0OVNlCjbkVuxZzB20KgCRsMME7a15aO8
         0WEOeu7Gv/MSJXgmamKpqwr3DoGudUqkiMNsa5dhBaBebD6iKSgRdRbAJp8mMLX9kbkB
         /gzw==
X-Gm-Message-State: AOAM533VlS6GUecoSurC66xgX1fmlHMYcAaqtm+42v6W/WL0yk+k0j8o
        VHQPyR4PEfCgT1duk4485e+dvA==
X-Google-Smtp-Source: ABdhPJxngyOwJYmlqV/5VQl0CDeLGpyMwcxXJSKOOd8cTePn/msAa3i6Sezc+NNalflZifuYHyrtpQ==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr3007999wmh.143.1595324695605;
        Tue, 21 Jul 2020 02:44:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:cd93:4ca4:af31:19e5])
        by smtp.gmail.com with ESMTPSA id t3sm5442414wre.41.2020.07.21.02.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 02:44:54 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 0/2] Unify non-VHE ASLR features behind CONFIG_RANDOMIZE_BASE
Date:   Tue, 21 Jul 2020 10:44:43 +0100
Message-Id: <20200721094445.82184-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently no way to disable nVHE ASLR, e.g. for debugging, so the
first patch in this series makes it conditional on RANDOMIZE_BASE, same as
KASLR. Note that the 'nokaslr' command line flag has no effect here.

Second patch unifies the HARDEN_EL2_VECTORS errate for A57 and A72 behind
the same Kconfig for simplicity. Happy to make it just depend on
RANDOMIZE_BASE if having an option to keep randomization on but hardenning
off is preferred.

David Brazdil (2):
  KVM: arm64: Make nVHE ASLR conditional on RANDOMIZE_BASE
  KVM: arm64: Substitute RANDOMIZE_BASE for HARDEN_EL2_VECTORS

 arch/arm64/Kconfig             | 16 ----------------
 arch/arm64/include/asm/mmu.h   |  6 ++----
 arch/arm64/kernel/cpu_errata.c |  4 ++--
 arch/arm64/kvm/Kconfig         |  2 +-
 arch/arm64/kvm/va_layout.c     |  2 +-
 5 files changed, 6 insertions(+), 24 deletions(-)

-- 
2.27.0

