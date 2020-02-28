Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8646BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504652087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqGcQt7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgB1LA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:00:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38762 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1LAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:00:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id a16so821349pju.3;
        Fri, 28 Feb 2020 03:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQW4bOKSHmU5l0Lbtw43hu3nzYBtiYhV3Cs9XK1O2js=;
        b=FqGcQt7M9LOBvJLQAHMcr8nvGS+3bKX4hNxcwMSYzAtUeT1qlioANW7evrFMu+f2VJ
         NyRZTZBvSogXJiEO/YbyZzLFeRo085fID3MW0eNGHbKIzSgeEy46OjTgwjce1eOv/OxZ
         0CiGSdsyQrHJmz3+NB5IKlJ551XeMEU/kXokhXrDsmB5mo5XYfS9kHKCLaZ7WuY/oSP1
         mC8X6o2xuyfUgq9LqY6GrlYSQn83HyJNvwAJZn3e+Vk5/+xxN1jwCiQp9RsgciCCwRPi
         9nl8vmdeSD2xu44v+UEPSaZVOsUXvaQ1pZWYxzHLlvkS2os8AY8baIJLxaEdrZ0JOYMU
         mzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQW4bOKSHmU5l0Lbtw43hu3nzYBtiYhV3Cs9XK1O2js=;
        b=LPxcyvWrJ2UrEw/DpwxNqu52QprTHwp6y7rmL5t1n6L+acUzclTahG5qSrexs+oiUX
         6+0p/LjKqlV1x2Cr2QUB5seQ+mHz/wmuWaMlq7HDIaMXbrU9i6lrb6JTAyO4Jb5bXshz
         RgJHkedevVxCXi1EjR5t4DAUg5QhicuJBU0D7cNvtsegu5qAD6mxgWRUHfckPL+1PZMp
         7EcWC+NI/QhyJk4tiwdIv8HtSTYpXBFUTPBfGc9Xfccl9Yn/Q0JvO4bOcOr2UfqPkJfQ
         Q7P8R0zXkkNTnAcjtAEqC87Auoa6nQJIKNR4LicGcsh5igpvlCB1DXlPfyonqEWKORSq
         2Q8g==
X-Gm-Message-State: APjAAAWBb7KJkToIIkrVsaUv/Nj5ShERWSmi8ZfqFFHtRr/AD56JBkGA
        Pmda1CauUmtx29QbamKg4+M=
X-Google-Smtp-Source: APXvYqz82JUgk/ovz9no9ndPWLWIZDS2FJ4A6l9d3T+uSPQm6aLPld4kOwK3P9BJjBVf0EDJET2qYA==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr3518935plk.263.1582887654310;
        Fri, 28 Feb 2020 03:00:54 -0800 (PST)
Received: from localhost.localdomain ([2408:821b:3c17:4ef0:cc67:a77c:4401:27bb])
        by smtp.gmail.com with ESMTPSA id s206sm10932554pfs.100.2020.02.28.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:00:53 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     jun.zhang@intel.com
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        joel@joelfernandes.org, christian@brauner.io, maco@android.com,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, he@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, bo.he@intel.com,
        Bai@vger.kernel.org, jie.a.bai@intel.com,
        youling257 <youling257@gmail.com>
Subject: Re: [PATCH] ion_system_heap: support X86 archtecture
Date:   Fri, 28 Feb 2020 19:00:12 +0800
Message-Id: <20200228110012.3578-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20190929072841.14848-1-jun.zhang@intel.com>
References: <20190929072841.14848-1-jun.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch no help for x86.

i have same problem on Androidx86 10.

[  846.089339] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c07fff], got write-back
[  846.089756] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c0ffff], got write-back
[  846.090062] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c10000-0x77c17fff], got write-back
[  846.090311] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c18000-0x77c1ffff], got write-back
[  846.091353] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c20000-0x77c27fff], got write-back
[  846.094230] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c07fff], got write-back
[  846.095464] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c28000-0x77c2ffff], got write-back
[  846.099184] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c08fff], got write-back
[  846.100383] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c10000-0x77c10fff], got write-back
[  846.103239] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c18000-0x77c18fff], got write-back
[  846.104483] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c30000-0x77c33fff], got write-back
[  846.104906] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c20000-0x77c20fff], got write-back
[  846.104987] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c30000-0x77c33fff], got write-back
[  846.109349] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c0ffff], got write-back
[  846.109491] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c10000-0x77c17fff], got write-back
[  846.109965] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c38000-0x77c3ffff], got write-back
[  846.110136] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c40000-0x77c47fff], got write-back
[  846.111691] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c00fff], got write-back
[  846.112631] x86/PAT: NPDecoder-CL:11141 map pfn RAM range req write-combining for [mem 0x77c30000-0x77c30fff], got write-back
[  846.114647] x86/PAT: .vorbis.decoder:11142 map pfn RAM range req write-combining for [mem 0x77c34000-0x77c37fff], got write-back
[  848.562022] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c01fff], got write-back
[  848.562208] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c02000-0x77c03fff], got write-back
[  848.562587] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c04000-0x77c05fff], got write-back
[  848.562887] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c06000-0x77c07fff], got write-back
[  848.564765] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c09fff], got write-back
[  848.567498] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c02000-0x77c02fff], got write-back
[  848.568559] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c01fff], got write-back
[  848.569570] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0a000-0x77c0bfff], got write-back
[  848.571470] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c04000-0x77c04fff], got write-back
[  848.573627] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c06000-0x77c06fff], got write-back
[  848.575635] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c08fff], got write-back
[  848.576566] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.579950] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c00fff], got write-back
[  848.581189] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0d000-0x77c0dfff], got write-back
[  848.582210] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.582821] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0d000-0x77c0dfff], got write-back
[  848.584509] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0a000-0x77c0afff], got write-back
[  848.585061] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.585725] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.586834] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c04000-0x77c04fff], got write-back
[  848.587474] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.588119] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.589486] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c06000-0x77c06fff], got write-back
[  848.590083] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.591243] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.592301] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c08fff], got write-back
[  848.592891] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.596420] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c00fff], got write-back
[  848.596961] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0d000-0x77c0dfff], got write-back
[  848.598486] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0a000-0x77c0afff], got write-back
[  848.598598] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.599180] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.603080] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c04000-0x77c04fff], got write-back
[  848.604500] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0e000-0x77c0efff], got write-back
[  848.604969] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c06000-0x77c06fff], got write-back
[  848.606555] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c0f000-0x77c0ffff], got write-back
[  848.607668] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c08000-0x77c08fff], got write-back
[  848.611666] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c10000-0x77c10fff], got write-back
[  848.612810] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c00000-0x77c00fff], got write-back
[  848.613929] x86/PAT: oid.aac.decoder:11197 map pfn RAM range req write-combining for [mem 0x77c11000-0x77c11fff], got write-back
[  848.683124] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0d000-0x77c0dfff], got write-back
[  848.683259] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0c000-0x77c0cfff], got write-back
[  848.683420] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0e000-0x77c0efff], got write-back
[  848.683508] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c0f000-0x77c0ffff], got write-back
[  848.683583] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c10000-0x77c10fff], got write-back
[  848.683664] x86/PAT: MediaCodec_loop:11196 map pfn RAM range req write-combining for [mem 0x77c11000-0x77c11fff], got write-back
