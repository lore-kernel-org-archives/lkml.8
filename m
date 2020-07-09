Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA952077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="KnIIIqN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGIUIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgGIUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:08:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8DFC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:08:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so1446772pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Q0u+ghHjJat2tciyUX1Wacu6e3RR04dbPYpHQAKH1XE=;
        b=KnIIIqN3s6KhBZh3AyqkGpXYB9BZWlXi1AJ1rxdTymORJaZJnKeaNLDDh1UfPf+E+/
         8Lg6Oi1o2n6rAPZylI6JGSDL+qZayQ3Y3aSQ6hgVeC0qby2lByeu832z1Fg/1aDyzLQf
         kS5n+gwFHS2InuDDWHeiEwVY7ZDiF4yulJv3VwTr3/0aKeFYaW3GHnGxDaYIPwhyCVGS
         4+2BdURZoUMwgPQjUDa/M6gQwwvK70S6JY2EYfIMzfk1UlfORNwLWM6fue8rjuWejkRG
         ZXrVeZFtCVI1+eDl7mN2K5BwHA1kYPj5/40WuAyGPEEDem/jdKOeiLYb84LTKvE+nywh
         emEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Q0u+ghHjJat2tciyUX1Wacu6e3RR04dbPYpHQAKH1XE=;
        b=BW6fhq0fDlt3+cQM+q+S40ulyyG4GwVEKRwJ5qJisPg/At0ScgS3iHi1GVr4L8Z/lx
         Y1m0QcoU0dpE5Qi8AnqctIfW7sw3rsQlwJ/lKjJArFnSOUrBhBEiaO4ykPQO8uTyNdeU
         3ulvUl8wUp/7FK+8D4sXuNR3gRcMHaHDhWNJfzIsqFb2tRmWM8YTAYk8vYMdUPRpJcYF
         iCRGBsAwmFDke8Z2Qf55YjA5lHorDGd9F5iZuK0b0IqOQHa2OUFDRptYIArNH/EDGT7h
         DTLITRn7nmUsDePh3uYus7wK7Vkhtqjdrlbfe8Tee9mYplIVlmt6fijvYaTOv9kORpqG
         djjQ==
X-Gm-Message-State: AOAM533qsErgK/v3Hao8+/R5tEgfDqOy4N2yxDPFRrsxkk5EtspdqjgZ
        z7gBkpiLCRBBkAHX+aJoRlF0yA==
X-Google-Smtp-Source: ABdhPJxOB97sUtsu8ZrmtJokh0OJEA49w3aoCwF7IfEXGT1IwMqiowNcZ7FmHprplX0SXTMGdWA/Lg==
X-Received: by 2002:a63:dd09:: with SMTP id t9mr54505309pgg.41.1594325292249;
        Thu, 09 Jul 2020 13:08:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gx23sm3441387pjb.39.2020.07.09.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:11 -0700 (PDT)
Subject: Add and use a generic version of devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:47 -0700
Message-Id: <20200709200552.1910298-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rppt@linux.ibm.com, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org,
        keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr,
        mark.rutland@arm.com, james.morse@arm.com,
        andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com,
        davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org,
        uwe@kleine-koenig.org, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        krzk@kernel.org, willy@infradead.org, paulmck@kernel.org,
        pmladek@suse.com, glider@google.com, elver@google.com,
        davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org, zong.li@sifive.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
implementation of devmem_is_allowed() that's exactly the same as the version in
a handful of other ports.  Rather than duplicate code, I've put a generic
version of this in lib/ and used it for the RISC-V port.

I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
(though this is the first version, so they're unreviewed).  The other three
obviously depend on the first one going on, but I'm not putting them in the
RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
yours along with the others then please say something, as otherwise I'll
probably forget.

I've put the whole thing at
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
generic-devmem .


