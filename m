Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E426820775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596456413;
	bh=7/oL800Z8/vXBnPHpCYKjZ8lyLUTxJLpeZERxjk0gOQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nll0XV4w4+janRD4sZ4jkUN52QK+vLnrrs0WQrMqDxEqIA/MoywOGyRMHgxF+lNPD
	 eTxC6LWJKwE7QIrQU5eDVcTC0lBg1FJXOOmsEfWcnIPd6WxOHm1JB45FDM2vEWjmCx
	 KC7tlxIYXQSUui/NsgBYrrgFLzz7g+UMvsf9SoZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHCMGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgHCMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:06:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8A6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:06:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qc22so23548263ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tLVRbnn39DZ/h/fwOCnkgHLQFEjYDr/OlALd6BU/W2Q=;
        b=Cz2GTN7BZe3pxLW4xdY23o+k7jsD0bv5at3sdTpFs9iNDr926mp3Mj5OnVe1bfWjEJ
         PG0YtzDCmXrvKYfhCOP9nXSGJueHKLM4xqakDYLYdkKr+XsYMQW6TMfC9ziZEUR4glwF
         kcjoQhmtVk4GdNR1gtSRqMPK/G8fL95Y1nNiochI9mCQCvyEJrGT/tNvhZoo6hzebbK4
         VNhnJ3qoHNKE4I2Ac9jfRz8L1pslkP9nSKRiemJT1orudalUuuAdZ8CetMt6jf0BhFYJ
         xOvzcKwdwW7io5PfE2Gb28oFS2oN1P/1j1RLowf89AtCXFtaqa9WlFNFk5y6vLZ/mRot
         pT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=tLVRbnn39DZ/h/fwOCnkgHLQFEjYDr/OlALd6BU/W2Q=;
        b=eh1cKbATxQ0Lrbi1Zmgp+kOVCyqmBVlQWiagMRskEMWBKSPolNuZN2QTkkAQ7qXFP9
         fiaaT5LDyjT8dphUM5jPxX1CfA6owdayeDkmUX94GbD/8n0bk+m6v8vwK2XJFr36SSb6
         pcO4fmL4cWy8MrWzk1E+1qFMOCE1AtSJ/BhOfSeOiHxqdQHOLQJqty9JBDVRtOsSwEpl
         wD8HwOtEKfKoAs0GJezGZnDWkgP+T0iKm3wvRbWhnohvyXaHYILPnhEZmRijgFtXPsdp
         Tq1Xin6yU2HBz+YPvZ/AuItRHK/K18nLxBU50INouqdv8iiVFJJoZU+VelRQh+PH4Edd
         zlmQ==
X-Gm-Message-State: AOAM533ngoai5LSHaKNbeaZeTATTGPFkdtxfLDeDqJlvU4QJJNwqZogy
        qwhxCblwo04Z08hipnxACFs=
X-Google-Smtp-Source: ABdhPJyC00JNGPakg98JcZsZu4+D8OIno31EcIPAGrI9OFJB6TBTWr9mHbb2EyOsFocioliAm7yptw==
X-Received: by 2002:a17:906:7e05:: with SMTP id e5mr17160826ejr.252.1596456364625;
        Mon, 03 Aug 2020 05:06:04 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u4sm8783981edy.18.2020.08.03.05.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:06:03 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:06:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.9
Message-ID: <20200803120602.GA506993@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-08-03

   # HEAD: d832c0051f4e9cc7d26ef3bc6e9b662bc6a90f3a Merge branch 'objtool/urgent' into objtool/core

Misc updates:

- Add support for non-rela relocations, in preparation to merge 'recordmcount'
  functionality into objtool.

- Fix assumption that broke under --ffunction-sections (LTO) builds.

- Misc cleanups.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Kristen Carlson Accardi (1):
      objtool: Do not assume order of parent/child functions

Matt Helsley (2):
      objtool: Rename rela to reloc
      objtool: Add support for relocations without addends

Sami Tolvanen (1):
      objtool: Use sh_info to find the base for .rela sections


 tools/objtool/arch.h            |   2 +-
 tools/objtool/arch/x86/decode.c |   2 +-
 tools/objtool/check.c           | 202 +++++++++++++-------------
 tools/objtool/check.h           |   2 +-
 tools/objtool/elf.c             | 308 ++++++++++++++++++++++++++++------------
 tools/objtool/elf.h             |  29 ++--
 tools/objtool/orc_gen.c         |  46 +++---
 tools/objtool/special.c         |  28 ++--
 8 files changed, 375 insertions(+), 244 deletions(-)
