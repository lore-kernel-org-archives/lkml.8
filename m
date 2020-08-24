Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC94F2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8uWuE3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHXSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHXSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:36:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6FC061573;
        Mon, 24 Aug 2020 11:36:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t9so1128287pfq.8;
        Mon, 24 Aug 2020 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mgi/edooXghW4Zd3yyd7WPGuqwOMM4D+bYL209pO5J4=;
        b=p8uWuE3fPiZ0Pp9qw8tSQq7BTjAxEiI1WOb832pnYuHQt7KTp8jjD0cPiATO1Q5lNy
         bpQPk+tTF+nqLEesz9eWpZEU4/iy3M3FHb2rOUmUEsOKwqtH+ZYeXYNFMzNdfZj2o+o5
         7Fr3ad+9k73160OYspVSgPMHaCzaPBba5hhqQijOWqYeMjFXkGaZIag5juiW6mWyILz9
         bY0ffb8W7J6eCap6bY1ocxGZ43DFGGcuo/Eb+vk+TfGlrKavIa3uhGyGj1eo7y0HuDxQ
         H0LrTuxO1PPSLwsISrcLe37NQ6KVgigfKjasCIs/cxNoIRgz2+OsO5agYDgDmGt01oem
         2DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mgi/edooXghW4Zd3yyd7WPGuqwOMM4D+bYL209pO5J4=;
        b=LGzv/EDpJR3M8Z8u2OhG2hzhHVER9sULAUnnEY5n5ZxoCRICHYlKgYDh3tseIVuGhm
         US0jG6n/WW9Eci+TwRjENb0q16oqddF88/qWqyUshcw0X0Fp6DoxBZ0MqgAUTd2vA6Xr
         ki62GGcgH5mlltFNzEfmolTlRZgGy+vbWK8+7+fRvX6pGnRpgHkbm0ElJxZOC96Hwdfi
         L/azPtuqXQYlljtKOnbTFl0XQA6eyUm2n3sEeQEpyaZ17L6wpymb4FHS4qeyQy3OaXbR
         h4Pe6j0m6g/3hUzbNrsyq5Hs8ImclFED5pcVu0JHFH8hWAgIhKaViARZOXG5Wa7jPc89
         +TVg==
X-Gm-Message-State: AOAM532kL92td9HRRkYaZg3k3kcygaNQtJvH9Ikmp78i7cUYmBZO7dXI
        d6gYrMTrVWUYOeLDb0e9LjM=
X-Google-Smtp-Source: ABdhPJwrIQSp72HY9BabcaRIpogAc40IuObj3piSlJR2SSB27J8pMVUHLXVwMPG0jF+LjKVPvA+O5w==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr4540232pli.265.1598294173294;
        Mon, 24 Aug 2020 11:36:13 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n5sm10523099pgt.24.2020.08.24.11.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:36:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH stable 4.14 v2 0/2] arm64: entry: Place an SB sequence following an ERET instruction
Date:   Mon, 24 Aug 2020 11:36:08 -0700
Message-Id: <1598294170-24345-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:

- included missing preliminary patch to define the SB barrier instruction

Will Deacon (2):
  arm64: Add support for SB barrier and patch in over DSB; ISB sequences
  arm64: entry: Place an SB sequence following an ERET instruction

 arch/arm64/include/asm/assembler.h  | 13 +++++++++++++
 arch/arm64/include/asm/barrier.h    |  4 ++++
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/sysreg.h     |  6 ++++++
 arch/arm64/include/asm/uaccess.h    |  3 +--
 arch/arm64/include/uapi/asm/hwcap.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 12 ++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  1 +
 arch/arm64/kernel/entry.S           |  2 ++
 arch/arm64/kvm/hyp/entry.S          |  2 ++
 arch/arm64/kvm/hyp/hyp-entry.S      |  4 ++++
 11 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.7.4

