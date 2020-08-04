Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD24C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB922086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPOuT7Jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgHDPT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgHDPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:19:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 08:19:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so31149653qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t2E5fZ8s+06sEA4DwXBxlR5sfcJ2cU5SNyqUWePEmrw=;
        b=gPOuT7JyjMcLQO/Tiv3jj1/O9xyijD1szP+BXpTIwkeXPELcIM62Dp+zxKGUhSAQbj
         sEH2ud8Eixpmo9/r21KPaubwOkCIV97c1EQnSn7usRZ3kvhenOGz2o1T06/sr1WcEtze
         PSp6x+Sk1O8G1WcBjRZnD/C4jkCaMu1REViq4gMzdKxJY3z6NqcslG4NqUekx4ho5sfC
         fBzwVrTj+gTyGA7JVUMjoYJn0POIBB4TRlyfENB6wkTrSJnS4K3IqWcgoYmHdcveSili
         rI57fTvD8WTvBlboAjPxcMW+kMsx47opZcYbUow7+3KCEFJvrZVz8AGbIcxN2qEHs/YD
         vXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=t2E5fZ8s+06sEA4DwXBxlR5sfcJ2cU5SNyqUWePEmrw=;
        b=oLQTFeSs0L/ynJQ++L18t9B9X6luZkq6Qwx8m7XXa310V0L88bu0jgJbkvJfjUAn02
         8GNJ7Yw9/WCqZVMC/7pRipBVNSFCkJWeVT7wZyMFz0oLgjU2CV3o2e3JZd3jNriatQES
         oTzZ4r7f5OQIh74s19uALHbAtLYRytK8nuIwARztpZh5yi4shSkpTfjlA2nZLPM/OtlS
         15NiNDlxJpbtMFigtexUcXsq8/jLQ/yVRrCoaqUUHJWhf18JHRoq1KdlVKiXSoxMqnVP
         IEzQRWgmib/IoCwlock0+xASR3UDPWox/Z4YO1MsykicFqb5+sy6DYJdBjDovZ5RuGhO
         VhgA==
X-Gm-Message-State: AOAM530qkMFsM9iHYZ6BtFet05YYRASdb+LfX00uugVRNLUlGqdeVOKq
        xzKJ/ky1oKiVGm+EJ1ggaDw=
X-Google-Smtp-Source: ABdhPJy5tqk4ub4RKG9sL5lv/0oHktIEXeZ5KoH5WfWCkK3UAdTMtCi3tdhoZW4SSmWqRozKl0kKZA==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr22176458qtn.102.1596554390453;
        Tue, 04 Aug 2020 08:19:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w8sm23569943qka.52.2020.08.04.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 08:19:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 4 Aug 2020 11:19:47 -0400
To:     Nick Terrell <terrelln@fb.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Terrell <nickrterrell@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Message-ID: <20200804151947.GB2326348@rani.riverdale.lan>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
 <20200804015654.GA1943218@rani.riverdale.lan>
 <0C67BA74-E014-449B-9E22-E0B1DDB930BF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C67BA74-E014-449B-9E22-E0B1DDB930BF@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 02:57:50AM +0000, Nick Terrell wrote:
> 
> 
> > On Aug 3, 2020, at 6:56 PM, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > 
> 
> > -- I see that ZSTD_copy8 is already using __builtin_memcpy,
> > but there must be more that can be optimized? There's a couple 1/2-byte
> > sized copies in huf_decompress.c.
> 
> Oh wow, I totally missed that, I guess I stopped looking once performance
> was about what I expected, nice find!
> 
> I suspect it is mostly the memcpy inside of HUF_decodeSymbolX4(), since
> that should be the only hot one [1].
> 
> Do you want to put up the patch to fix the memcpy’s in zstd Huffman, or should I?
> 
> I will be submitting a patch upstream to migrate all of zstd’s memcpy() calls to
> use __builtin_memcpy(), since I plan on updating the version in the kernel to
> upstream zstd in the next few months. I was waiting until the compressed kernel
> patch set landed, so I didn't distract from it.
> 
> [0] https://gist.github.com/terrelln/9bd53321a669f62683c608af8944fbc2
> [1] https://github.com/torvalds/linux/blob/master/lib/zstd/huf_decompress.c#L598
> 
> Best,
> Nick
> 

It's better if you do the zstd changes I think, as I'm not familiar with
the code at all.

Thanks.
