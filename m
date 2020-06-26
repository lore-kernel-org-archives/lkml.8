Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFDAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583E120B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pqzaouq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFZVaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFZVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:30:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF2C03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:30:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so5494976pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IN/dHrnSFJwCdsiVxf8dhkTYXziQPztMYyCGVl57TM=;
        b=Pqzaouq9BT4GE0gjlmD3L3Uoidh8l7ZS7+O86mF+FHQf7Fm27moUcW7Dod9X/TdcKT
         rT06Kwg1pQmk8zhRtK/5z5iRSdXzqfIs2K0BC0hqy21Vim6PSB7gW7XyFtjDu4LOB/bD
         RU8AX5Ebj622H1q2YqlUvFkcglwp2WcEqUoD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IN/dHrnSFJwCdsiVxf8dhkTYXziQPztMYyCGVl57TM=;
        b=boOXvoOcvM6pvkkkBJxVpFgG+m/N2Mtl9zeEiT38HSJPm5nhD4vg4ENcP4koSTlVkg
         wmRj/hV4t7P+BBLgIUeBDPs1Hb4hqdS2VQnWYBD0Le5EPVsTuZWK5PotaBqqtu68fr48
         u8C1Orl4i8TaREMPcX1zy4civxPUG3zQ3+g/QVbjIFuNG2YhM9fgSpWhwDgtRMM6MoKu
         xs/gfUhFRmJ7WxwrN+V+IRpKNnTBElnBpnd9Hnl5a2bp6dAVnv7lXuHmVZplkB24/e4f
         TwvAnK/N6Qho4NeVwH5Kbvb/jJpQtBVm9iAwOnhh5o+0VJrvwuLtgUw44TqqLGsTcwig
         7gww==
X-Gm-Message-State: AOAM532fjItYAIIi3DK3MyaGhpUaFdKD5SZp3/Ktx8RviRGkAR10d6rf
        x3aG2VcJg3awF/0/JUOaUS8mWQ==
X-Google-Smtp-Source: ABdhPJwffNZVFojpM9ARq7D+MFPkJd4phuspFIs1JaOLslJ57S8CfThHPaQNj4fP51cEdSRPJwcAjQ==
X-Received: by 2002:a62:8811:: with SMTP id l17mr4509571pfd.72.1593207002451;
        Fri, 26 Jun 2020 14:30:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm12857762pjd.2.2020.06.26.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:30:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:30:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 06/12] arch: xtensa: add linker section for KUnit test
 suites
Message-ID: <202006261429.5F1A1F72BB@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-7-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:11PM -0700, Brendan Higgins wrote:
> Add a linker section to xtensa where KUnit can put references to its
> test suites. This patch is an early step in transitioning to dispatching
> all KUnit tests from a centralized executor rather than having each as
> its own separate late_initcall.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/xtensa/kernel/vmlinux.lds.S | 4 ++++

If you ever find yourself modifying multiple arch linker scripts for a
series, something has gone wrong. ;)

-- 
Kees Cook
