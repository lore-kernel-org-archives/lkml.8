Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16455C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E4820842
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591031108;
	bh=1/EAMztdxanqMs3Eh0BAwnoiMLmJaGkeR/TWcYCEiqY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bXyMR5G2fW1kL3PUXCcVKZxhbpcboxCOnlhht87UWGEM0zbHWkEdI9+T5tS3VTtHT
	 WXWJKbt6eDxqqRPovgSq/VeOXb7bGXS9afdRflaWKaEVxWsBrCg0mykSWsEwumXyPw
	 riifzq6mSPc5Yo1QBtc016Y71KAHBkD44JWpsuWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFARFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgFARFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:05:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C4C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:05:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so604101wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ELtOegSxIG1w6Oelk1/XRv03+HLjNR/T5/bIqJu8LXE=;
        b=R+OjFU4Lw71CcYolij94VBGfCxmo+R1aB16gdW8MonKhVVcGFGG6dHXRg7ZCrv/kjd
         WEGRL588Gd5hxkR+rc0vJBF/S2FKfPFG7j4H7EvqvTzJonybjGqOx+3Tviz3n6ZA30VP
         mf+RO+RXE2F7CrcKZJs4m7oTHhAEGItd37NJaJL369NbE6GD1lJ2jrOS4ViXoHibzj8w
         1Cj1R9fWr9jZvwRL36BI664C/Wo2QrLIl+CPeiaDlBplEa4EzCsfD43XuSa9udnRl13j
         k6YoDsN5OnN4kZwI5ny5zETMs7P0xRV0Sq2Y4QKju2Gya9yGkvHL1hUlvaIgrw9lowEz
         TgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ELtOegSxIG1w6Oelk1/XRv03+HLjNR/T5/bIqJu8LXE=;
        b=OPF/nMnGyzbFunijIkXFgyE+eCYGJqPjzPwOAAB9xUGXbWj8T7hJG3vaveoWSD0kYN
         x/MNIPaCURfUfAUfVTJgKHlCRT1uTiFNdlV4mrhVCKBqE55TmntHdK8+NOO1lGRKkZ2P
         ouB2fbcyclHhfVTp44eQ6ztrQ/LcOMdKyZkuYR9p+Q5YjvXHPQDbvFImpE+j6Lh/D9zG
         H0d0uyrGOo8cGfImPpM4dtgN9HuppnrEn53T6MnwCfc96Htf7dTtAtg7x3laWyB55Lce
         RZte5m2bAQn7vwscIkbfpv2oLXcgfgtJ0yiSsw83SNW/G7eIFqc43kfbMg6zNwvTGWBN
         W9EQ==
X-Gm-Message-State: AOAM531i7n0h6zsB6GCh0C+q0YFYNUcKzchC6ophMbNrg486SXANY/s0
        pCP02Ab2LaSeEhNS78OIzLk=
X-Google-Smtp-Source: ABdhPJzMOB27YalD30ZwA3WdDv7p1NAHWJUCw887SuMhUqSXUzgVP2S9PoH70DPOpNLvC0QnPq82/g==
X-Received: by 2002:adf:f446:: with SMTP id f6mr22569508wrp.59.1591031102656;
        Mon, 01 Jun 2020 10:05:02 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a1sm288816wmd.28.2020.06.01.10.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:05:02 -0700 (PDT)
Date:   Mon, 1 Jun 2020 19:05:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform updates for v5.8
Message-ID: <20200601170500.GA1392237@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/platform git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2020-06-01

   # HEAD: 33649bf4494c1feaf1956a84895fcc0621aafd90 x86/apic/uv: Remove code for unused distributed GRU mode

This tree cleans up various aspects of the UV platform support code,
it removes unnecessary functions and cleans up the rest.

 Thanks,

	Ingo

------------------>
Christoph Hellwig (11):
      x86/platform/uv: Mark uv_bios_call() and uv_bios_call_irqsave() static
      x86/platform/uv: Remove the uv_partition_coherence_id() macro
      x86/platform/uv: Unexport sn_coherency_id
      x86/platform/uv: Unexport symbols only used by x2apic_uv_x.c
      x86/platform/uv: Remove the UV*_HUB_IS_SUPPORTED macros
      x86/platform/uv: Mark is_uv_hubless() static
      x86/platform/uv: Mark uv_min_hub_revision_id static
      x86/platform/uv: Simplify uv_send_IPI_one()
      x86/platform/uv: Remove _uv_hub_info_check()
      x86/platform/uv: Unexport uv_apicid_hibits
      x86/platform/uv: Remove the unused _uv_cpu_blade_processor_id() macro

Steve Wahl (1):
      x86/apic/uv: Remove code for unused distributed GRU mode


 arch/x86/include/asm/uv/bios.h     |  7 ---
 arch/x86/include/asm/uv/uv.h       |  2 -
 arch/x86/include/asm/uv/uv_hub.h   | 54 ----------------------
 arch/x86/include/asm/uv/uv_mmrs.h  |  7 ---
 arch/x86/kernel/apic/x2apic_uv_x.c | 91 +++++++-------------------------------
 arch/x86/platform/uv/bios_uv.c     | 16 ++-----
 arch/x86/platform/uv/uv_sysfs.c    |  2 +-
 7 files changed, 22 insertions(+), 157 deletions(-)

