Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF62C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7421220719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20150623.gappssmtp.com header.i=@malat-biz.20150623.gappssmtp.com header.b="hMol9Oyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCZVob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:44:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54067 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:44:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so8926980wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+4lM45XTZukmqA+Vd7SePaQmncNUUq8lz2uA6qbpmo=;
        b=hMol9Oyb4KP20yY1HAFoFaWogw81z812WwY6QZxGCoUGm5W6ml2flQKMlDT/uuzOFR
         MSThiOe7a8Sju/CMsXnqMOci8aUSyp9q7ZCEzhvtoTpbejJwcC0lJ5vN2ywjlKvxW8D5
         QQ3CN2yRIOLgkf8hdsnRoSPDCv+occfH+iVHNRA/5oo2RwIFhOYlXbSAfNrpt1wu0xmf
         XjBAvoMmhrq+hnbecmw+JPs4VsJECXHFtLWUn+8qcBvXaUbkaZJZRePsVzMAanu0cnSv
         ENHgDou+EI1Gdb/pyB0iJarhbLLrjk3B0X6bUUiFAnJfnOvsuF/mBo3hLLr8lL95cVtD
         oz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+4lM45XTZukmqA+Vd7SePaQmncNUUq8lz2uA6qbpmo=;
        b=YSD6ScZNqNKGHD5T90C+i2TwIBFc6zWymqy6m6FoAanQ/SYBr3fWvF9CIlHREdjKhm
         MgsxdbQ80pjs+cypHG/pJotEB2g/XrFP/tAdLBkuw9SrOC2iJxkbe6PY4YszwNcOFJ7m
         43+mHAi8woWs8GhR0uDUI/vHTVVcqwpzQe/kGmbtgclF/UI6gcS997qz7QSBvIJIudpv
         G+3l4PaWZKEwe2Bc91mYs+UhSm6J/Kiqg5elNQWX0HG9lLfRZ0RK1G3+Mr6KB1gulf1e
         ZoLNVcErtHXTa77zE1uQblwp+bD9cHYZl+zLTo6ig17Jr4h+gq56P759T2+rf0OPLniV
         zG1Q==
X-Gm-Message-State: ANhLgQ3Tk9sfZYGALpointdbYCypLhl/rqhzvHjOXXYWUbZG6AqYd0BE
        kXD2pwufq4mJ8LjF43S0SX38BQ==
X-Google-Smtp-Source: ADFU+vuryZ7GiRt+cJkO1nY7/OCQcAHtmzLx8m1LfM1l3E+UBHJaKNw5H8v7YVbnjW6bBEBhqQ19dw==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr2041169wmj.92.1585259068826;
        Thu, 26 Mar 2020 14:44:28 -0700 (PDT)
Received: from ntb.petris.klfree.czf (p5B36386E.dip0.t-ipconnect.de. [91.54.56.110])
        by smtp.gmail.com with ESMTPSA id b11sm5310706wrq.26.2020.03.26.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:44:28 -0700 (PDT)
Date:   Thu, 26 Mar 2020 22:44:19 +0100
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
Message-ID: <20200326214419.GA13249@ntb.petris.klfree.czf>
References: <20200325195849.407900-1-nickrterrell@gmail.com>
 <20200325195849.407900-4-nickrterrell@gmail.com>
 <20200326164732.GA17157@ntb.petris.klfree.czf>
 <611A224B-1CB3-4283-9783-87C184C8983A@fb.com>
 <20200326201634.GA9948@ntb.petris.klfree.czf>
 <ED5FFEDC-A3B7-470E-95AE-B60EB1E6AE64@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED5FFEDC-A3B7-470E-95AE-B60EB1E6AE64@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:13:54PM +0000, Nick Terrell wrote:
> >> What do you mean by that? Can you share with me the test you ran?
> >> Is this for kernel decompression or initramfs decompression?
> > Initramfs - you can apply my v2 patch on v5.5 and try with your test data.
> > 
> > I have tested your patch also on ARMv7 platform and there the degradation
> > was 8%.
> 
> Are you comparing the performance of an 8 MB window size vs a 128 MB
> window size?
No, I use the same initramfs file with 2 different kernels for the test. I have
removed
  if (params.windowSize > ZSTD_WINDOWSIZE_MAX) goto out;
from your code.
  Petr
