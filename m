Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24977C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51592073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="c4McV3RO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBLFrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:47:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45157 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgBLFra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so645682pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 21:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HBUqCa4lDkvWVMth98gkOfMDQFMmsNejhaPRJd9h6k=;
        b=c4McV3ROy7K7TcNJZ6glqfJoozIqu3Imhuvwv+E6LR3U+3mruX/liResbEQ0Rlql4u
         VWt/THID8qk44T1vtXxAeK9ZFTX//XLXm6d7Cp9EITy49LHRunvA8LWxXvjSCzqFbF4d
         FtmE8q1jB13au00SutLTdNFEIpG6jEAQqbEF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HBUqCa4lDkvWVMth98gkOfMDQFMmsNejhaPRJd9h6k=;
        b=i7x8C4DAW1Q3ooy/6RQ3ldgfUK6p47A2/LSaVgg2HStHpP6pgoIktCtfNo8lECVHeF
         nD3ZZdMxUBoVCJ5Mg3HJV3jZOeAPOXIk13EC0C4gP9Iignrnq2UtajTC6tu4gkmLyisN
         uUUd3f7QOsTMldGpmeW8wgcb0o3eLmuMJnxuM/N0b3UpNPIp8guBoSKc4het6aJqsf1N
         vFbNfte18uEk1za5cr9dMFU72tYe5SkVd+7Y5VEHOpwwyoYYzz4sEFhBjA4LxAApTtKw
         wFab+phSCHQQHCeI2S69objRy562P6iLMceU8JTN66c7aAHqnxa0J+Oj34D5vkPe1t+B
         T/ow==
X-Gm-Message-State: APjAAAVAT1/NmZPPdmKP9aJAMWeV1exU9tWdHdks77D3sDfTzzVXzKN5
        //wCqo2GqwYWZ0GczQAB+cebsYhfJdM=
X-Google-Smtp-Source: APXvYqw/DN/0FTA1ZksYApAufAix2IStZs/anNdGfJUJ6f2vgfIGbcrigIYK8wZ/9ZVCpNCvP/aFbg==
X-Received: by 2002:a63:5826:: with SMTP id m38mr10924864pgb.191.1581486449779;
        Tue, 11 Feb 2020 21:47:29 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-65dc-9b98-63a7-c7a4.static.ipv6.internode.on.net. [2001:44b8:1113:6700:65dc:9b98:63a7:c7a4])
        by smtp.gmail.com with ESMTPSA id l69sm5969652pgd.1.2020.02.11.21.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 21:47:28 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 0/4] KASAN for powerpc64 radix
Date:   Wed, 12 Feb 2020 16:47:20 +1100
Message-Id: <20200212054724.7708-1-dja@axtens.net>
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

