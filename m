Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67045C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3782623B9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrRWZthr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgDFOTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:19:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44596 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgDFOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:19:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so14844874lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i+DHhA4uP4W3/Bd9snVo0MmOnahYMRtQYHM0nrWquWo=;
        b=GrRWZthrMHzdNMiLm0XE2q77/jqHoQHCCD/0kniMqPDFoc4Bx+JZaR8tyQpY4O0Sup
         LuNF0MSg4P290N0C6ujxzGLZHlXdeh0yFAVrFvrC1JBCmzVmnF9FumiVxaINLyS8xPTV
         0D1NoelFqanOXFTKzbMcE+mcZ24W2YbJ3Ij0fPg4D9jfrfI7qCZCmr66flTyrbWukYBp
         aiBIbZ+Q35+rE92EUvee36mq8NoSk5SVHXKzkuA3XfA+qGTRa6Xt7RFwheu1qw2D+pkG
         A7LrLkOGO7xOEdtz2i8Pd4BVKNoMFpfOtzsPcgxg65hpyOKrks2X17GLEsQ/uTE00fNl
         Do6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i+DHhA4uP4W3/Bd9snVo0MmOnahYMRtQYHM0nrWquWo=;
        b=sP36EYuUAIhXXuXvR0JXWvVZBxj5+ywz1kwxeMY0/pksiYaBwo5lWLJtkKynz0pXux
         +dmbVKkHYBwDMlUXnx6HC8WOkGD9AjFWkELReMCj3Z8I3ujxBmvA1Qa28cvhA/MqqUm8
         ckUdSyiwuSdpoCKSuw8ATT50eHJl4flijjxU8PgM+UTdY7uFKcRqL8c/rC8LbnQKE8XO
         OvnRnBTIBOeDILuyufsjUBDtQJcU2odzJ4Ft2MsbmlWtYuG5OEOIP2n/N0vZ9UXehH6c
         mbXESEdMKQE1L/6CezOsOtzJLp7zfG5O6yKDEhzaIHIe/yAo+5jyJvaGi4X9YKDhxx/b
         KvVw==
X-Gm-Message-State: AGi0PuZxlmLmDArDjlNTIeaxlKUYKwFPa4u/3qkTNTGTZ6z3sNEISnng
        uISDbPVTiKNz1ms8zO5z5Z1mjcWoDaW0p6QGAH8cdg==
X-Google-Smtp-Source: APiQypKHvZFc2zRxTevtWy2O4BqKoKo02o0l1T6nAyGK0m4PI7bb+0LjNko3spQ1FV00pxPu0/XgI+30UsR6PKC6mbY=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr11801293ljg.165.1586182745649;
 Mon, 06 Apr 2020 07:19:05 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Apr 2020 19:48:54 +0530
Message-ID: <CA+G9fYtfG4nZs0ON=bBNarPaycNOgGNvhXxcdrGzM1epDDBt7A@mail.gmail.com>
Subject: mm/hugetlb.c:5580:3: error: implicit declaration of function
 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'
To:     Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, andreas.schaufler@gmx.de,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, js1304@gmail.com,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building Linux-next master for arm beagle board x15 the following
build error was noticed.

mm/hugetlb.c: In function 'hugetlb_cma_reserve':
mm/hugetlb.c:5580:3: error: implicit declaration of function
'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'?
[-Werror=implicit-function-declaration]
   for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
   ^~~~~~~~~~~~~~~~~~~~~~
   for_each_mem_range
mm/hugetlb.c:5580:62: error: expected ';' before '{' token
   for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
                                                              ^
Few more details about build test,

CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y

# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CMA is not set

Kernel config link,
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-mainline/2591/config

Build log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/743/consoleText

--
Linaro LKFT
https://lkft.linaro.org
