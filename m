Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD6FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA2F20842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="azyMhcdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGKD7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGKD7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:59:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F77C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u18so3391175pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=nQXgV8O4lRQb70P/o8i8sx1P/L77B4PEEmlWpSmoN9o=;
        b=azyMhcdNhgsabVX8AGiA4NE5+4GW+gtnYaTOcJBLfMD4YqA8nd/JT1USO5UC0nU65r
         g0tXbqAy2ljCnhdn3OTOWNrznl5QSu36Np4TULfJQ5Qx0D3KELVDXAWNgZftpuYgkOnV
         A+RFADNJ3kM1mzjcPDwoBHeo2SPVmNPLfTB5OC2dc9pbBbcbyDm70Zyl8egXkAV2VKd6
         /9ykt6Ke74BE99AaAXy/cZDbwKyB7Gx1SkKpenyXP2WJMGU0zHub3/4XGHVw5maFexPN
         VUd49BQ9OSFIJCLfwG2B2Mc7Ky8K+Z+chMp18ibg8P4eoAKnr4wmaFDNb9VG96GJ3jKL
         uwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=nQXgV8O4lRQb70P/o8i8sx1P/L77B4PEEmlWpSmoN9o=;
        b=WBcP99hSviiWdsVxtr4CZJNRrWopqwXCWy9XCzhy6vNf+PcftzKn8IiGaihT4BZdZl
         Tiukri4dN2/l93LaWpMxgM6CX9ukZQRR5+H9CMHXmV0mNcJaD9ahqTZjAamxQlR/SDGc
         JMFbvh8CvEw1zAkmcdTWgq+BS/lPh6/5zSwe6GRqAR7bbw4lwHWLkoSl7VknmKVb9OUC
         9gvxpP9xjQ0npw+iF8MDgCQDG9/h4CzZ0QJDMXR0gpt15dHKZ8KfQnhLfPWTpgcxOHf2
         PUhwbMiZVoYCTmkH6JaM6L/Isk9B8pDV5blo+PPBWNX0F5G5cRIO4PGcB5g/CvIcmRB2
         vgLw==
X-Gm-Message-State: AOAM532hazbovZjVi70iruWbaAjLZlWqbhqTUwIk4cff67/Pc5pxkAKv
        kxKVlY5CbBJZ6vZSYO0z7l7Y+Q==
X-Google-Smtp-Source: ABdhPJywguU/IUhSzuP2RbS+qrBucQmxKH10+Ix1vOfHoCo7H+QXwLlRxZcK3x5u5q2cLOVKIx7zrA==
X-Received: by 2002:a63:210c:: with SMTP id h12mr41776995pgh.152.1594439958721;
        Fri, 10 Jul 2020 20:59:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g19sm7436820pfb.152.2020.07.10.20.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 20:59:17 -0700 (PDT)
Subject: Add and use a generic copy_oldmem_page()
Date:   Fri, 10 Jul 2020 20:55:41 -0700
Message-Id: <20200711035544.2832154-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rppt@linux.ibm.com,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com,
        Palmer Dabbelt <palmerdabbelt@google.com>, mingo@kernel.org,
        ben-linux@fluff.org, peterz@infradead.org, broonie@kernel.org,
        davem@davemloft.net, rdunlap@infradead.org, uwe@kleine-koenig.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        willy@infradead.org, krzk@kernel.org, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, keescook@chromium.org,
        glider@google.com, elver@google.com, davidgow@google.com,
        mark.rutland@arm.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While adding support for kexec, Nick recently copied the arm64
copy_oldmem_page() into the RISC-V port.  Since this is shared verbatim with
arm and arm64 already, I'd like to add a generic version and so we can use it
instead.  I haven't converted over the MIPS, PPC, or SH ports: while I think we
could figure out how to share a version, they're not exactly the same right
now.  S/390 and x86 are definitely meaningfully different.

Unless there are any objections I'll include the first patch along with the
RISC-V kexec support, which I'm hoping to have for 5.9.  The code, based on
5.8-rc4, is at
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
copy_oldmem_page .


