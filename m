Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A11C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAED720714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20150623.gappssmtp.com header.i=@malat-biz.20150623.gappssmtp.com header.b="Fdjop2Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgCZPkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:40:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCZPkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:40:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id u10so8360484wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XEACa47R1YYA9qHdOiFfEkBUAM/n215wAmRNcBN8QwY=;
        b=Fdjop2Y7+L6YPRRq3UV/wtGW2NHguQSXMW9DdVOKRM4FI1a8TVD6RUBb0p2AL+YVLY
         86uf2MCprux6gKpqMXQDyPrhgzrLd0BGo6ylK+XeCEcD/nguONB71GyxnKzUwL32llKH
         8RRO+S/3awfwIojE86vdypyUtHq0HjV23+eovqI+vKi0BSfl190styxTnAoFZI4r/JtM
         ZO2oYik9u03NDJGJ0jvgTAA8EF02O1EKG7Kt0n5Sp9xanFHBJcPXt/8+u4VVoJzlY17e
         6MdsWQVcPMDqCqpsd8LwzihzaT70AI/h4QYoAVotXdBQjFaSPnDZDj11WzNtDEga5WnW
         8jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEACa47R1YYA9qHdOiFfEkBUAM/n215wAmRNcBN8QwY=;
        b=swLgcgmo/CgBz0I8S1rkexFRHSHAXxkHX1IaFrzjk8yJgiJ0PD3YCxbCdlkCoUOlce
         t7l00GKimyyhrPx3h2+2vF86lmp68yI0ZcEsY3GAk8EQAy7TYnf8+Qe6P3/7xyTDQaBW
         M2XFMxfQAmA966y2JRow9lzmL2iMXATXgFBBtN6DRvrA49HJx4vUyWlYgivk8BbRbAxv
         k+6U8HvXRvWeYB1oSiEYNP68a5J60Z+fTO8h+5EmCUJdLU/j/8xBY8rRYGQ303wfMJ6X
         cEFcy6gLldeFjGKd7DXiOWnYyLrmQfmFM5kolXOCndiEx3F36CtLiAq2pv4x9bJrEdWr
         9PVw==
X-Gm-Message-State: ANhLgQ0jrFSbN9lBIQmCBubszdieQdMDVEWyoZK3X6c5bnJEl5H/0w/L
        IlGlCel4mcfWht/3/ePeseZHrA==
X-Google-Smtp-Source: ADFU+vtop7dLCupf/5Cj0LJPXEZFIZb8nPl47px+m0Juh6AjaUQIZHhP5YiWzaS9s6aHc/n/JZymqQ==
X-Received: by 2002:a05:6000:370:: with SMTP id f16mr10335036wrf.9.1585237249033;
        Thu, 26 Mar 2020 08:40:49 -0700 (PDT)
Received: from ntb.petris.klfree.czf (p5B36386E.dip0.t-ipconnect.de. [91.54.56.110])
        by smtp.gmail.com with ESMTPSA id c5sm11522353wma.3.2020.03.26.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:40:47 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:40:38 +0100
From:   Petr Malat <oss@malat.biz>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, gregkh@linuxfoundation.org,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v3 1/8] lib: prepare zstd for preboot environment
Message-ID: <20200326154038.GA21231@ntb.petris.klfree.czf>
References: <20200325195849.407900-1-nickrterrell@gmail.com>
 <20200325195849.407900-2-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325195849.407900-2-nickrterrell@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,
I finally got some time to review your patch, here are my comments:

On Wed, Mar 25, 2020 at 12:58:42PM -0700, Nick Terrell wrote:
> * Don't export symbols if ZSTD_PREBOOT is defined.
I'm not sure if this is needed. When I worked on my patch, I have found that
all exporting and modinfo macros generate symbols in modinfo and discard.ksym
sections, which are then dropped by the vmlinux linker script, thus one
will get the same binary independently if he puts this change in or not.

I'm not sure if this is intentional as there is also __DISABLE_EXPORTS define,
which should be used by a decompressor (according to comments in export.h).

> * Remove a double definition of the CHECK_F macro when the zstd
>   library is amalgamated.
> * Switch ZSTD_copy8() to __builtin_memcpy(), because in the preboot
>   environment on x86 gcc can't inline `memcpy()` otherwise.
> * Limit the gcc hack in ZSTD_wildcopy() to the broken gcc version. See
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81388.
No comments to the rest.
  Petr
