Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7106C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3394206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596470534;
	bh=nCKl5B9v2QlQw1GF+aOJgLpbgKeoEsGixJkB5xtvar4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aDeI4CD9ZmsFvbVk8Z70u51rKci63brveqfPlaQhQtUw4U3z5+/tE5RRLytJBEM5h
	 JrS6MaVwGA8aWv66ynWgd4W2cNoH9tW6Luw01Uud2FfMV1KaVtm43LOT2A61QPRP0P
	 FdfaBgoY6UsnC0hYuZm3keuVM2yuuAFTAjw0fAsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHCQCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHCQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:02:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3BFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:02:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so39174334ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3FW/dpxAfEKZpL0xjWaEKw/4/9pI2Bu081UuCQ4WirE=;
        b=QPfV4CBkY+p/V39IZokYjfpuwObnv6Fh7idcr2RvXtII1eDyCFv3BUGY9/p50x+1jY
         Y6sIAXdghfllwIYbh9NrO/iFyKMBpTDfb5bJgw9Mrg1k+MXBMhJJQdsYoZjo20sd+lXZ
         Mj34J0td2FE8xl45eGVVUNFgQVpXzx7d3IgC6EUbIV9uqpYOXAsCaM/JvwjaKbW8QWzh
         OMZo46gM5+6K9sA4eEU/WPOP+SIBRyl0ccL2KbFHF6Jf1I6Wvj/+7+kj8rSXkzfAP+mP
         YfFGE/hL7FgoMaYNeexi4n1hLWcKnGsyjIiUrGUZOF5zUYb869I2yxgnlz1LWEfLllC/
         YtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=3FW/dpxAfEKZpL0xjWaEKw/4/9pI2Bu081UuCQ4WirE=;
        b=YzkCAT2HjvyIVNfOBLOsLsgsNQ+3a18fmNzB9L+rUk21cfRnCncb+lkv9T7vHNQO2c
         OPDIfleOALXMCXx6dVVowIQqznyLbuHJOmYcZzzF6n+xiTnYVbHSjR/t3tXWWZpuKguf
         Aotkb2p2L+VtXlFIwYwpIqcmccg18j8BoedcGrR0KEggFuGLHuGra3Vpg2pq9yw7wuOI
         eK4jxe4PpmKISkhFfNW+956AG0qhycMdfNWlSHd45Loc1nvaunIke0Y2tTHt4Ld017re
         EouOIr6ziCxkKyFp+3jxs6qsZP2lTJDIRH8cAwNVnAKN3B4JclY/Akb2n47i1DIVJcHp
         bBSQ==
X-Gm-Message-State: AOAM533Kmy22Bg0dCpSM7C3jyMnLCxBDknfq9+/wLbrWj6dCnE/ffsbo
        6VzifpuO/yI/2TRNi73/mqZ+PTlG
X-Google-Smtp-Source: ABdhPJyMqn0ZdNFbiWuqRbsi8skuD0GUtoQTqpOnh4yfGb23DwPwwNmih7p9e6MGDTrbVPL9vEnd7Q==
X-Received: by 2002:a17:906:4356:: with SMTP id z22mr17958871ejm.414.1596470532511;
        Mon, 03 Aug 2020 09:02:12 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x10sm3318558eds.21.2020.08.03.09.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:02:11 -0700 (PDT)
Date:   Mon, 3 Aug 2020 18:02:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.9
Message-ID: <20200803160210.GA760622@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/asm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2020-08-03

   # HEAD: 158807de5822d1079e162a3762956fd743dd483e x86/uaccess: Make __get_user_size() Clang compliant on 32-bit

A couple of changes, concentrated into the percpu code, to enable
Clang support on i386 kernels too.

 Thanks,

	Ingo

------------------>
Brian Gerst (10):
      x86/percpu: Introduce size abstraction macros
      x86/percpu: Clean up percpu_to_op()
      x86/percpu: Clean up percpu_from_op()
      x86/percpu: Clean up percpu_add_op()
      x86/percpu: Remove "e" constraint from XADD
      x86/percpu: Clean up percpu_add_return_op()
      x86/percpu: Clean up percpu_xchg_op()
      x86/percpu: Clean up percpu_cmpxchg_op()
      x86/percpu: Clean up percpu_stable_op()
      x86/percpu: Remove unused PER_CPU() macro

Nick Desaulniers (1):
      x86/uaccess: Make __get_user_size() Clang compliant on 32-bit


 arch/x86/include/asm/percpu.h  | 510 ++++++++++++++---------------------------
 arch/x86/include/asm/uaccess.h |   5 +-
 2 files changed, 176 insertions(+), 339 deletions(-)
