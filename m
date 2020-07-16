Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25F0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAD72065D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="OniGW0QP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgGPP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgGPP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:57:15 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D86C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:57:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so5130036edz.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7ZTrgnbVy1vjZemfA6CrwyOwuqJRgX22NBFVKy7mJ70=;
        b=OniGW0QPefqaE1Pu3X3AeSrA+Ez8+e1Tfjibofp2o2ptBMKEnOAepDKhoBjkb6Ellc
         sQHdkWgUVRA6Vpm7dO4+tifS4hFZX2/ovZUjKiqhHPXQ8PjTzZyvMiePLeyow6xwkUE7
         i8LaevdviDkzIFMorYpI6QMSk310Q5kjn2rdSXCU4zsdgwp5GloyyK4IeZ+w/tuhWFZh
         O8cz0hurMpd7jrqdVCrzf6VHtyTTShFYzFJeGGCOr+HN2l3vO9ZTnXu8ddrdnfpgCMnt
         GsvMJrv3FVT4ADrewaV8nvQiQMsg3EnwlWKlKZzHcZCAXXj/5A1JCTXROnll+0Oz21i2
         FsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7ZTrgnbVy1vjZemfA6CrwyOwuqJRgX22NBFVKy7mJ70=;
        b=t/DWuazc5fIQb2vdmNHy4McvBCQsCcR1/nJT3+lf52QRVt77I3dAq4NCEOEUycVNhj
         tov5Dk3rMJFtYFd5n+LvI7otmeluwbz9ULdZGLVOv7FmARVdHBwwSQT7hqqVG2eBsoyp
         VbcoHn9lNyrFi8Fs0b/DmhreAd+8o8i3aDD24I/6dqKPE5BmSC/M7cGL0/xbGpGfdF5d
         +Nu/KBYK7xORbLc9vNpOhbbfsVka2jDtwNo5dZAksJ0FF6gNrjx2qkMfK1lRxtQgF8TE
         aB+RBxJfVL++f8OgnvGDapPPoWFJWvYRCuLoyD4CwrFykY1Ks6tUDMtaetMkld980s9V
         P9eA==
X-Gm-Message-State: AOAM5320GLYcle6s6JPcmbeHqEurYDB413maexVgcRZlloVxBydLs8Bw
        1YAHX00b+bGRhYJRWgnMD+xTd0bXK2BEjw==
X-Google-Smtp-Source: ABdhPJyJFY5MDKgfi9kzpiIwMsqvq1uusoXLJ7QuDb4vsWlYMhGqrdvrpq478UJYhZ766tojh5a+iw==
X-Received: by 2002:a05:6402:1803:: with SMTP id g3mr4807400edy.377.1594915033870;
        Thu, 16 Jul 2020 08:57:13 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4843:4a00:587:bfc1:3ea4:c2f6? ([2001:16b8:4843:4a00:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id y22sm5591028edl.84.2020.07.16.08.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 08:57:13 -0700 (PDT)
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
References: <20200714190427.4332-1-hch@lst.de>
 <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
 <20200715065140.GA22060@lst.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <4b38a63b-af09-608c-c4fa-b9e484ebe6bc@cloud.ionos.com>
Date:   Thu, 16 Jul 2020 17:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715065140.GA22060@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 8:51 AM, Christoph Hellwig wrote:
> On Tue, Jul 14, 2020 at 12:34:45PM -0700, Linus Torvalds wrote:
>> On Tue, Jul 14, 2020 at 12:06 PM Christoph Hellwig <hch@lst.de> wrote:
>>> this series starts to move the early init code away from requiring
>>> KERNEL_DS to be implicitly set during early startup.  It does so by
>>> first removing legacy unused cruft, and the switches away the code
>>> from struct file based APIs to our more usual in-kernel APIs.
>> Looks good to me, with the added note on the utimes cruft too as a
>> further cleanup (separate patch).
>>
>> So you can add my acked-by.
>>
>> I _would_ like the md parts to get a few more acks. I see the one from
>> Song Liu, anybody else in md land willing to go through those patches?
>> They were the bulk of it, and the least obvious to me because I don't
>> know that code at all?
> Song is the maintainer.   Neil is the only person I could think of
> that also knows the old md code pretty well.  Guoqing has contributed
> a lot lately, but the code touched here is rather historic (and not
> used very much at all these days as people use modular md and initramfѕ
> based detection).

Hi Christoph,

I just cloned the tree, seems there is compile issue that you need to 
resolve.

hch-misc$ make -j8
   DESCEND  objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CC      drivers/md/md.o
   CC      drivers/md/md-bitmap.o
   CC      drivers/md/md-autodetect.o
   AR      drivers/perf/built-in.a
   CC      drivers/md/dm.o
   AR      drivers/hwtracing/intel_th/built-in.a
   CC      drivers/nvmem/core.o
drivers/md/md.c:7809:45: error: static declaration of ‘md_fops’ follows 
non-static declaration
  static const struct block_device_operations md_fops =
                                              ^~~~~~~
drivers/md/md.c:329:38: note: previous declaration of ‘md_fops’ was here
  const struct block_device_operations md_fops;
                                       ^~~~~~~
scripts/Makefile.build:280: recipe for target 'drivers/md/md.o' failed
make[2]: *** [drivers/md/md.o] Error 1
make[2]: *** Waiting for unfinished jobs....

And for the changes of md, feel free to add my Acked-by if it could help.

Thanks,
Guoqing
