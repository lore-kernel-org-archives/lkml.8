Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0316FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EAF20714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rvheysi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGVTpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:45:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA95C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:45:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so1493697ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nWRg8habjmwUq/aSOIs5oJ/PIMDu1J2enCdaZpnqjtI=;
        b=Rvheysi+PYCBmuMOpzRtK6Oze6jqgkcolfrm0c2G06ZfucZ7GN0cNoCE00nMt2FymF
         bAeDzTaaaM7LEWiVN/ByX7unj0u0rupZmXTT/6dfvTS1tdTa5UQ1K1x+SZPtoxk/hjTq
         +c06od/fOU5c0Kj4Evbb/bGw1U4B0Ub2f8v6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nWRg8habjmwUq/aSOIs5oJ/PIMDu1J2enCdaZpnqjtI=;
        b=E8r2Grc+6tEw6U43XvyuZzyEtVjeogLKSmFTh8tTA9lh3+lXja172l4mGs25j+hhLF
         DPN5GRf2J0cM1iF1gt1qTi2Z9aLWX01qDmggSMrCL8ipVdPluN22RBmSRgEmCFXD8KLD
         JkC+jvd6SRL6jOu9m6gjfugGqPKSDBWFC35Yv5O/Omw4aGozAST4Wn6gWIvg8/0SPh5D
         rAumQycEDl8HQN1aCWR8xelmRQJLnW6tmPrvBrfZ5fR8ztjtR2hPYCyMljJEKNzQQPaS
         9j+/Ey03bSTgeyWkK8YPcMsFiR/42gGu+dupYdRdESBuTeyZx6aITShsl4PNPbXthRuK
         R4WQ==
X-Gm-Message-State: AOAM531rajImn31U5JIA5GFU++ZzAAhNtq4ec0GrK6lglnZqgEAMpYdo
        u/iSdZHSD0MKkFwRVO4v35a1Pg==
X-Google-Smtp-Source: ABdhPJxp0OPbK17T/FisysBhZk0+gpPejV6bgMq7eWQizEQTOQ0sgf0Q3VWKJW6xGgrHmxb3WQ5IuA==
X-Received: by 2002:a17:90a:a50d:: with SMTP id a13mr837453pjq.95.1595447112507;
        Wed, 22 Jul 2020 12:45:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t29sm432106pfq.50.2020.07.22.12.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:45:11 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:45:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
Message-ID: <202007221244.4E3C9E45@keescook>
References: <20200721174654.72132-1-vitor@massaru.org>
 <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
 <202007211911.666E080@keescook>
 <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 03:29:27PM -0300, Vitor Massaru Iha wrote:
> On Tue, Jul 21, 2020 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> > > When you talk about end-of-test summary, is it what is written in
> > > dmesg and not the kunit-tool?
> >
> > Right, if I build this as a module and do "modprobe user_copy_kunit",
> > what will show up in dmesg?
> 
> No, It doesn't. I'll put the messages again.

Would it be possible to add that behavior to the core KUnit output? Then
all module-based tests would include a summary line?

-- 
Kees Cook
