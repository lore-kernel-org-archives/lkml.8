Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD538C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A02F207CD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIcmqzOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHXSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:36:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EAC061573;
        Mon, 24 Aug 2020 11:36:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so5284409pfb.10;
        Mon, 24 Aug 2020 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0q3yj900uh0Ob40g7BB3IvyNcAY/lFT70Br/QukZZGg=;
        b=LIcmqzOCVpHqgmI9hDZEPhZLds5gQ4yk7wpmblvSuMH+QIlzN6CvpZLKjD946EM0Kz
         8ytEwHFIDk7EZWA787zBoGrCx495LTEFwHXz+wZnIncHiGZ2pmZeY47eTvTD9y8IImRh
         ivApC4OJX47d24kn8Kli+TT7ZEl5/VURAcARcGKTHo2LcaGXHzZIBZGZiwuGAQDZUXqE
         6Nyn6HgeGCFCzvM93jhXGGrGM1iOSszQqXq0mgrG2ZsI8hHs376aG1uLx1SxZzBLarhT
         dAgZxDkrIKGByzlhcYU8tdR+CYvq9zs5Ghjf/qh3Y5Rh6yhBr0y7lFe+Ue5zjQIqPshw
         yrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0q3yj900uh0Ob40g7BB3IvyNcAY/lFT70Br/QukZZGg=;
        b=Tb3MOdPNXR8UERglXyEoCj3BAj2+gzudLfnluSt2ScxwDpE/cXolMRUWdFNEunyhTg
         Jfb7qYB4prRyJv7NvXEcyrGDMt4G6zbdMKjbFIsAsUULaUHEQ1Ed6sJ1/IYxUUJke2x5
         /xU4x7laXPzJgZsYNJPCyhrJJ8MlY0QiurOS/AT0Zg9wSKN1n6mX0ToT7/VzYV3OXTa+
         I5cZhxKtk/+7eR3SdeUB53eBuEZaP5XZkJWSIHcAbo/recWbPjsVz/vcjXLypdCY6y+M
         TU4JXn8uWm5rvElLwHMtgR2SXdh+nHEfhGIBcLjIhOonCodUx7iSrvvAo/qo/kAdQbfX
         MqBw==
X-Gm-Message-State: AOAM530hLvXblBTbfs4fa60NsaCHi9o7wjDxIM2p74bu5gYDFPRhlArm
        hmgD2X5DqAIfLzhljMDHkis3las66hE=
X-Google-Smtp-Source: ABdhPJwBGdPN9kSlUa5MQoEYHoyE/DxDybs19vVY2S9ykx0HiGZwuaZLpKa7AiNCvrpGrhFFDoq6vw==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr4557058plo.336.1598294160989;
        Mon, 24 Aug 2020 11:36:00 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j10sm12167900pff.171.2020.08.24.11.35.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:36:00 -0700 (PDT)
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
Subject: [PATCH stable 4.19 v2 0/2] arm64: entry: Place an SB sequence following an ERET instruction
Date:   Mon, 24 Aug 2020 11:35:10 -0700
Message-Id: <1598294112-19197-1-git-send-email-f.fainelli@gmail.com>
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
 arch/arm64/kvm/hyp/entry.S          |  1 +
 arch/arm64/kvm/hyp/hyp-entry.S      |  4 ++++
 11 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.7.4

