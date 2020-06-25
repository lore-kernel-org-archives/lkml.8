Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5974DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FDC2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzlzzsXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbgFYCWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 22:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbgFYCWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:22:32 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C703FC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:22:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n6so3916461otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xdH2xoOfsMc7dLXOy11ch04mvWFiqfyRgGDX8RhsAdM=;
        b=PzlzzsXi4vVm7zffx8Yo9gyOUr3qCdbKHkUA4Zyjk1gn67CBMffhG5e0PgHHaJvSoF
         tnxPAXZIalCdxLefn4UWAkGjMM7Z9FE1WgqFzBpH8pxA85Xz4ai3HlNbRF5ti9WN4r9R
         hyKsgY+VszOzmchvlaubSQyESeb2ZE+rL/vEkUlIVCWFhCC5tQ/eaMv0n8wRnj4hlOVB
         9LDTKDErXb4ktKPXQGO1CgQoeeSt+SDSDKj+vKnfMAG64ckNEVFLhmRMAa37HeGg5UyN
         FmtyEyxDfDZZYeXFwg94RrICQCXBmkLmp+DW/3/jGP/q/9MRqeF9UHkuiD2/RxEnCCGH
         o34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdH2xoOfsMc7dLXOy11ch04mvWFiqfyRgGDX8RhsAdM=;
        b=D0nwOIvQOmuu8ugiydkq++tJ3e+v3WTtdLJUfFMNSmfCcCwQSV3zvCQGr51dv3tS1z
         bHWFeySFNjx+de3EMqSV4mjEmDpIj+89vujyANcTHWPiT9wFeIwKiNtJaTW6nyYzmflO
         F8DZUPZ2uGEJzyXTlXdSCiSDOeckyKj4j0V4xudjtu4rQY6WtXi31DU+Q52FFEZ9iFVM
         1tHlI91CD9Io1WpoC2s5vcpTB2TXdOifRAlDa5kC3kdDkByW7tz3y6ca9QbFxzgjUABj
         iccKcL2gYjfJC0crXJ92cmkOyAnfLhVMcuYuMzr5Ag7R3+zNNDP5i3OdR5UWS418Dw7V
         1J9w==
X-Gm-Message-State: AOAM531eP1uZ61kTKAVhNb94s+IPuX4GO7eZCfUFnY8yZvGv/ItO3PJd
        ZsqRkuD4OEsUfFt3lQUMJL1Qhe/I
X-Google-Smtp-Source: ABdhPJwCCJUGGje/syyoFSwUc/3gTdj+4NS45vdvyfiLp8yXx33fvNF2taA0vu8wfSWV15opFUr4Qg==
X-Received: by 2002:a4a:b791:: with SMTP id a17mr25742894oop.48.1593051750035;
        Wed, 24 Jun 2020 19:22:30 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id h17sm2801127oor.18.2020.06.24.19.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 19:22:29 -0700 (PDT)
Date:   Wed, 24 Jun 2020 19:22:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Geoff Levand <geoff@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
Message-ID: <20200625022228.GA2871607@ubuntu-n2-xlarge-x86>
References: <20200624035920.835571-1-natechancellor@gmail.com>
 <1bbb6956-d9de-e0c8-5b45-20b6fecc2189@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbb6956-d9de-e0c8-5b45-20b6fecc2189@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geoff,

On Wed, Jun 24, 2020 at 06:18:48PM -0700, Geoff Levand wrote:
> Hi Nathan,
> 
> On 6/23/20 8:59 PM, Nathan Chancellor wrote:
> > These are not true arrays, they are linker defined symbols, which are
> > just addresses.  Using the address of operator silences the warning
> > and does not change the resulting assembly with either clang/ld.lld
> > or gcc/ld (tested with diff + objdump -Dr).
> 
> Thanks for your patch.  I tested this patch applied to v5.8-rc2 on a
> PS3 and it seems OK.
> 
> Tested-by: Geoff Levand <geoff@infradead.org>

Thanks a lot for the quick response and testing, I really appreciate it!

Cheers,
Nathan
