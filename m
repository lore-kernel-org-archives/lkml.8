Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0DC352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12CE20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="QwUP5Ymp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgBMAsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:48:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45963 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgBMAr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:47:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so1600151pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jh/fY28bFcd7/L9cFsQkhcdCpmkjY9Ls0EJJsmxHbno=;
        b=QwUP5YmpF0cywwIr+qqbXA8X8QjSa5/SMryDRo1Jmcg58ari7q9lz42nXW6NmnSWb0
         AXCu4fiU33C4y8T28zSV0Qmm1knIZnwmQqe7wJ5n4BeCkX8RDy+wtRfO9RQhv0y+nsbZ
         29TRSP46434x8xNKLi22b57LNpH44rIGdMKSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jh/fY28bFcd7/L9cFsQkhcdCpmkjY9Ls0EJJsmxHbno=;
        b=BpgLoKGY3OW7bcuTqakojmvi2FmLS4+Y0qy99TV2t8SX2vKcja/EE9sCbvPO1h3En0
         o7cvraQdg0pxIFRHvSEavEz+qHWRK7hfC6LS75SZvov4CyftB7aP42OYWqcVZYlR5ekP
         zz1dyGjZqTA7+kQHAgPz0uWnHykXBA6kL3g6yBpvT6KrnO3G9Ln6h3r+GMSoCSURzKFd
         wW0LpgXvXQ6pzrsNiDRb9+JcBLh7E0Vue80jXqYHX2vvAm3+LeJoKmfvz2jOEn5LtRai
         DSTek9E4uSAU/+vBdbPJZ/qatpChR5KcET38TE0ICmD/VAUjFhoT26uWPU6LnRBmQRB/
         9CVw==
X-Gm-Message-State: APjAAAUdrzDMUoa4b+uYU81t/IiIz33FYqTsVUJsTGnN72gf6YyFCuD4
        wsocj3W6wHp4Irsu0+ESn7cLd4LPmdw=
X-Google-Smtp-Source: APXvYqzTc2qiS1kuq5ADzvkss9L6yK8qP1IIPA8eq7f36ELS9X5Fs2jbKo2Gb97ZIjxebSzszwP4Qg==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr1992942pjn.117.1581554878778;
        Wed, 12 Feb 2020 16:47:58 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-f1ea-0ab5-027b-8841.static.ipv6.internode.on.net. [2001:44b8:1113:6700:f1ea:ab5:27b:8841])
        by smtp.gmail.com with ESMTPSA id u126sm399077pfu.182.2020.02.12.16.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 16:47:58 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v7 0/4] KASAN for powerpc64 radix
Date:   Thu, 13 Feb 2020 11:47:48 +1100
Message-Id: <20200213004752.11019-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

v7: Tweaks from Christophe, fix issues detected by snowpatch.

v6: Rebase on the latest changes in powerpc/merge. Minor tweaks
      to the documentation. Small tweaks to the header to work
      with the kasan_late_init() function that Christophe added
      for 32-bit kasan-vmalloc support.
    No functional change.

v5: ptdump support. More cleanups, tweaks and fixes, thanks
    Christophe. Details in patch 4.

    I have seen another stack walk splat, but I don't think it's
    related to the patch set, I think there's a bug somewhere else,
    probably in stack frame manipulation in the kernel or (more
    unlikely) in the compiler.

v4: More cleanups, split renaming out, clarify bits and bobs.
    Drop the stack walk disablement, that isn't needed. No other
    functional change.

v3: Reduce the overly ambitious scope of the MAX_PTRS change.
    Document more things, including around why some of the
    restrictions apply.
    Clean up the code more, thanks Christophe.

v2: The big change is the introduction of tree-wide(ish)
    MAX_PTRS_PER_{PTE,PMD,PUD} macros in preference to the previous
    approach, which was for the arch to override the page table array
    definitions with their own. (And I squashed the annoying
    intermittent crash!)

    Apart from that there's just a lot of cleanup. Christophe, I've
    addressed most of what you asked for and I will reply to your v1
    emails to clarify what remains unchanged.

