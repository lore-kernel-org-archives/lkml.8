Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A502078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KN8SYt5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgFMPYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:24:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6A8C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:24:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n141so11862990qke.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=K+KNXh23H/lYi3GHCxbvjXtlx4d86Mx/AsR2sdZAOx0=;
        b=KN8SYt5YKaqNqaI8I8BRCsYSLFd44YRWoFCOfqY3u1KsCUsqPTuT4emPLZVzjqKSJd
         6D3nfx/cn9lP8EbgVsve8Yv7L3nDiwi7Lg3mxgUgSSjNBtDdPKttDakVJ0wrYDs0UkMz
         x8HjuELz0V6xWP4R5LmgrCQcRPumjpzCSIkpHzRRvg8Ns8P/WuVJs0f5jGrlnkI6oW6N
         i8olFDF9sHvyFBO3qwxblK2rxtI4PeZhfnM62zGN7rllGycaC02swKbA8uUHnKd63X8/
         XECuTSENRO8HxZpyhBsbuiRd85sMFw4SPeFaSwq2t5RoND9VW9hUuGVsDNFqqdgNA1vy
         bw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K+KNXh23H/lYi3GHCxbvjXtlx4d86Mx/AsR2sdZAOx0=;
        b=tHV0tMnqJVJmVu6vwcykko4z+SzwGlA8m4RQebRJnTthyLpNVGI30vMw9rZDyiarr7
         A29rpA3TY1/t3ihTNMsmdGPznlC5UmJI6HJUaIefKqc6FqmVtZQ4kmHHjhN6PFbbtOZV
         6F7RTVc0N1RuJN126lQMfnNMrE0dV3TTG9c2nK2TWaTe0+8GrSSJfQPcWCG0jNfJhw/n
         6n7XeJxJDwL0o67S3YjAFpeUgCjHXj2jW6qXnZ5s+1cmU840juzPqKhrmK0hKcx8yrnw
         lcBdwdS68Iv6Bgh2MFmq0HG7cOP1Vq3ZXA/HxcEZnC4Dl1GpFEmt1zfUpp9BiNs9zOHB
         wfyw==
X-Gm-Message-State: AOAM533Hpoj/PYdgRS7bujpQlgC7nX/hbduw4W2riBr4PrxhRsKukTDf
        UB7tFqpi/VHMa50+PjAm2Bs+Nw==
X-Google-Smtp-Source: ABdhPJxiUeeezzcGOb8lAPdkuerSin9Li0ygjno4QPyVznXyHmDR8TeH9QsQO0j2UXr5TWOSHMp6jw==
X-Received: by 2002:ae9:eb47:: with SMTP id b68mr7757837qkg.479.1592061851859;
        Sat, 13 Jun 2020 08:24:11 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q187sm6895055qka.34.2020.06.13.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:24:11 -0700 (PDT)
Date:   Sat, 13 Jun 2020 11:24:08 -0400
From:   Qian Cai <cai@lca.pw>
To:     thomas.lendacky@amd.com, brijesh.singh@amd.com
Cc:     tglx@linutronix.de, bp@suse.de, glider@google.com,
        peterz@infradead.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: AMD SME + KASAN = doom
Message-ID: <20200613152408.GB992@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y + KASAN (inline) will reset
the host right away after those lines on linux-next (the mainline has
the same problem when I tested a while back, so it seems never work),

Wrong EFI loader signature.
early console in extract_kernel
input_data: 0x000000000c7ad3a8
input_len: 0x0000000000aa5f4c
output: 0x0000000001000000
output_len: 0x000000000c1808cc
kernel_total_size: 0x000000000b62c000
needed_size: 0x000000000c200000
trampoline_32bit: 0x000000000008a000
booted via startup_32()
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.

The .config (plus CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y):
https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

Reproduced on several systems including,

HPE DL385 G10
AMD EPYC 7301 16-Core Processor

Dell PowerEdge R6415
AMD EPYC 7401P 24-Core Processor

Even on one of the HPE DL385 G10, it is able to boot but NO such
message, "AMD Secure Memory Encryption (SME) active"

Set KASAN=n will boot and has the above message at least on those Dell
systems.
