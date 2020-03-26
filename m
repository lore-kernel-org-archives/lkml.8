Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E15C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0452070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20150623.gappssmtp.com header.i=@malat-biz.20150623.gappssmtp.com header.b="GcBMssEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgCZUQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:16:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54175 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgCZUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:16:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id b12so8326875wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJd2r32O8oRypAa5o9iHKon3qqroPaK9fKkWmlFzpvg=;
        b=GcBMssEd0ac5CL77EZp4+xWSbdMvIA7rQ+IDlsfwUPunB3Al+xkaVD/ZQ08PXGiVUz
         N9QqLz6Zm3QEwgwqLV+X+DwBitZjcnuq4E4IY7KThwDgDa+oA3W/MlfmMMWSxkcBt0ER
         ETn/0kv81PAp2aHmOjGgvLg3JTO8oduA79SCk9TSwAJy2ODzV5ob3B+sAD0Ep4QQalOd
         /w479MwXq9C+cD4iWPAcLqIaVROvxgKHY8QwyyLYh063OjDsVigWMyM19RhPKNtInDqO
         87I8LC02kYHe8xc/xM3Vl2O2SkpLoMoNtLtBI1nfHvgzpuktufyYcigl6PqLqz1duLL0
         wGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJd2r32O8oRypAa5o9iHKon3qqroPaK9fKkWmlFzpvg=;
        b=n4ik8t/tXgqKE0T70fWvljY3MVzh2/9tX3v9+/SloIrF6VcJTBYjuQ/iJhOxfT+mp7
         YtOhZMYE2iBfJbvNFJyWeZhvedHOG4YVbQZPjA8ByzkzEcsab0rdsjFG/zDwOHhtd8/G
         15VfC//mg9/NIRe330UK08z1BNcz2sQ2DzOEZPexQZiiDtD9NR1rPqLB+CardI3vLqmU
         bP6LKAoNQmXmryyg3lNtHrkucu3DATCVsgEmivRZzOHHgOTgCDxbmDcAm4ig+nRsGzhL
         4doLYaZn+AX8LtJsbNPfiZ4Kz/WlrrtPBAeG6VGbK1VejRhQ2Gx1k+34jlhUemn3jino
         KDLg==
X-Gm-Message-State: ANhLgQ13pFkfMjYXOh4Vmp8HffYYWwo+0O4XSVDRpguvdafwFK4qYn33
        ciW89pz327ITv+5j9zEVz4PG5g==
X-Google-Smtp-Source: ADFU+vszuKd0m2fN3U/Uyz8Hf/tvzHDDhcNFhWW7EHox8Ri8sV3k2X8NAUG10dVFupb4HqhRj3qg6w==
X-Received: by 2002:a7b:ce9a:: with SMTP id q26mr1821977wmj.180.1585253803260;
        Thu, 26 Mar 2020 13:16:43 -0700 (PDT)
Received: from ntb.petris.klfree.czf (p5B36386E.dip0.t-ipconnect.de. [91.54.56.110])
        by smtp.gmail.com with ESMTPSA id p16sm4774022wmi.40.2020.03.26.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:16:42 -0700 (PDT)
Date:   Thu, 26 Mar 2020 21:16:34 +0100
From:   Petr Malat <oss@malat.biz>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Mason <clm@fb.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>,
        Michael van der Westhuizen <rmikey@fb.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v3 3/8] lib: add zstd support to decompress
Message-ID: <20200326201634.GA9948@ntb.petris.klfree.czf>
References: <20200325195849.407900-1-nickrterrell@gmail.com>
 <20200325195849.407900-4-nickrterrell@gmail.com>
 <20200326164732.GA17157@ntb.petris.klfree.czf>
 <611A224B-1CB3-4283-9783-87C184C8983A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611A224B-1CB3-4283-9783-87C184C8983A@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Thu, Mar 26, 2020 at 07:03:54PM +0000, Nick Terrell wrote:
> >> * Add unzstd() and the zstd decompress interface.
> > Here I do not understand why you limit the window size to 8MB even when
> > you read a larger value from the header. I do not see a reason why there
> > should be such a limitation at the first place and if there should be,
> > why it differs from ZSTD_WINDOWLOG_MAX.
> 
> When we are doing streaming decompression (either flush or fill is provided)
> we have to allocate memory proportional to the window size. We want to
> bound that memory so we don't accidentally allocate too much memory.
> When we are doing a single-pass decompression (neither flush nor fill
> are provided) the window size doesn't matter, and we only have to allocate
> a fixed amount of memory ~192 KB.
>
> The zstd spec [0] specifies that all decoders should allow window sizes
> up to 8 MB. Additionally, the zstd CLI won't produce window sizes greater
> than 8 MB by default. The window size is controlled by the compression
> level, and can be explicitly set.
Yes, one needs to pass --ultra option to zstd to produce an incompatible
archive, but that doesn't justify the reason to limit this in the kernel,
especially if one is able to read the needed window size from the header
when allocating the memory. At the time when initramfs is extracted,
there usually is memory available as it's before any processes are
started and this memory is reclaimed after the decompression.

If, on the other hand, an user makes an initramfs for a memory constrained
system, he limits the window size while compressing the archive and
the small window size will be announced in the header.

The only scenario where using the hard-coded limit makes sense is in a
case the window size is not available (I'm not sure if it's mandatory
to provide it). That's how my code works - if the size is available,
it uses the provided value, if not it uses 1 << ZSTD_WINDOWLOG_MAX.

I would also agree a fixed limit would make a sense if a user (or network)
provided data would be used, but in this case only the system owner is able
to provide an initramfs. If one is able to change initramfs, he can render
the system unusable simply by providing a corrupted file. He doesn't have
to bother making the window bigger than the available memory.

> I would expect larger window sizes to be beneficial for compression ratio,
> though there is demising returns. I would expect that for kernel image
> compression larger window sizes are beneficial, since it is decompressed
> with a single pass. For initramfs decompression, I would expect that limiting
> the window size could help decompression speed, since it uses streaming
> compression, so unzstd() has to allocate a buffer of window size bytes.
Yes, larger window improves the compression ratio, see here a comparison
between level 19 and 22 on my testing x86-64 initramfs:
  30775022 rootfs.cpio.zst-19
  28755429 rootfs.cpio.zst-22
These 7% can be noticeable when one has a slow storage, e.g. a flash memory
on SPI bus. 

> > I removed that limitation to be able to test it in my environment and I
> > found the performance is worst than with my patch by roughly 20% (on
> > i7-3520M), which is a major drawback considering the main motivation
> > to use zstd is the decompression speed. I will test on arm as well and
> > share the result tomorrow.
> >  Petr
> 
> What do you mean by that? Can you share with me the test you ran?
> Is this for kernel decompression or initramfs decompression?
Initramfs - you can apply my v2 patch on v5.5 and try with your test data.

I have tested your patch also on ARMv7 platform and there the degradation
was 8%.
  Petr
