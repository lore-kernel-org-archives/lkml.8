Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4183020728
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRg8LUg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgAOUgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:36:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39101 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgAOUgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:36:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so7316797plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=1Kq7E7yB24oMF+8U5r1ALJcHmpKEZz9xaZhS6OI6Yd4=;
        b=ZRg8LUg4vdi4RxUvpoJXMnuBXx2F26/54JF3ieqqhSeu7kjxGyhT3/oddQU+q8Z7s7
         lPZa8OTSazVRRzSMR8O5oJUem5OpTjPZ8TBG8fqQlAxUi80tRp1f9DnexBuFtgR9j1Jp
         +hjK5uojBbqE0LgCgcb3JBW37j3ksV4VrI1nWftapInUH+PU/aHhvgspg9Q9rMFpCDVD
         g3+S9ykt3mK73wKLYpHXFBFszLEYgx+/tDIubNkMAhVmrkHyNo33UZs5HnaxiFNcDGMS
         aj6mybsFjceeC42Co5zGOEz3owBKFRAiHwkJRGDKX6+uBP/spgAmYSGlcUZ7lGeJUpe0
         Iyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=1Kq7E7yB24oMF+8U5r1ALJcHmpKEZz9xaZhS6OI6Yd4=;
        b=GngD7uORvhAdPuS9UrsLSlVSQjaaAdNHti9ZgFv5fdjEx0XPTNx393wfsNC4OI6DqZ
         FJuDXhN0ScLonUkjWRBFC+wlNjCrb3mAy1jHDoEHQBfUbpjzNcDRjviaC+3bnM+VNy6J
         M+yHij5e5JwprZc27Wq3gmx4+wbB4gZR5D9SV+tzfLRfDyVwe7hq5druFeAVtsE29/UQ
         b/tvn5QFUgKu+CTCwi5zaxWraOW6b82nl/B8RuUXmxyl0CErFovpdZTTKTlTE4LQxVgh
         iL72JA+sZ+x0rh4pW4ix6lmJiS22wjnG88Cak3KUkwCBUCmTgTti/iq6JBcE/R5W1bXr
         /cpg==
X-Gm-Message-State: APjAAAXRVVEeERIHr5DW7xvuqtHPntGtxfV5MRaznIjOoW5P+/2/BLAL
        DFPVDdhnno7jrddKL/6ooOqG/CLzTz8=
X-Google-Smtp-Source: APXvYqxwjKrQRKb5VvbIT0wsat36G6HJjkLFrgS7bVZJZ0KZ6aWzfUG3AL9YY+kuQq+0Qh+1xnNlIQ==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr28095711plp.217.1579120563073;
        Wed, 15 Jan 2020 12:36:03 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id h11sm21070101pgv.38.2020.01.15.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:36:02 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:36:02 -0800 (PST)
X-Google-Original-Date: Wed, 15 Jan 2020 12:35:41 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v6 0/5] Add support for SBI v0.2 
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-riscv@lists.infradead.org, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        atishp@atishpatra.org
To:     Atish Patra <Atish.Patra@wdc.com>
In-Reply-To: <20191218213918.16676-1-atish.patra@wdc.com>
References: <20191218213918.16676-1-atish.patra@wdc.com>
Message-ID: <mhng-9ed825c6-0972-46ac-aeac-89a57bf73cac@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 13:39:13 PST (-0800), Atish Patra wrote:
> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.
>
>
> This series adds support v0.2 and a unified calling convention
> implementation between 0.1 and 0.2. It also add other SBI v0.2
> functionality defined in [2]. The base support for SBI v0.2 is already
> available in OpenSBI v0.5. This series needs additional patches[3] in
> OpenSBI.
>
> Tested on both BBL, OpenSBI with/without the above patch series.
>
> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2] https://github.com/riscv/riscv-sbi-doc/pull/27
> [3] http://lists.infradead.org/pipermail/opensbi/2019-November/000738.html
>
> Changes from v5->v6
> 1. Fixed few compilation issues around config.
> 2. Fixed hart mask generation issues for RFENCE & IPI extensions.
>
> Changes from v4->v5
> 1. Fixed few minor comments related to static & inline.
> 2. Make sure that every patch is boot tested individually.
>
> Changes from v3->v4.
> 1. Rebased on for-next.
> 2. Fixed issuses with checkpatch --strict.
> 3. Unfied all IPI/fence related functions.
> 4. Added Hfence related SBI calls.
>
> Changes from v2->v3.
> 1. Moved v0.1 extensions to a new config.
> 2. Added support for relacement extensions of v0.1 extensions.
>
> Changes from v1->v2
> 1. Removed the legacy calling convention.
> 2. Moved all SBI related calls to sbi.c.
> 3. Moved all SBI related macros to uapi.
>
> Atish Patra (5):
> RISC-V: Mark existing SBI as 0.1 SBI.
> RISC-V: Add basic support for SBI v0.2
> RISC-V: Add SBI v0.2 extension definitions
> RISC-V: Introduce a new config for SBI v0.1
> RISC-V: Implement new SBI v0.2 extensions
>
> arch/riscv/Kconfig           |   6 +
> arch/riscv/include/asm/sbi.h | 178 +++++++-----
> arch/riscv/kernel/sbi.c      | 522 ++++++++++++++++++++++++++++++++++-
> arch/riscv/kernel/setup.c    |   2 +
> 4 files changed, 635 insertions(+), 73 deletions(-)

Thanks.  I had a few comments on the spec, but this looks good given what's in
the draft.
