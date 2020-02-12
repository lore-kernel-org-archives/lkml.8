Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F483C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEC924677
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581538450;
	bh=1n0exh70Auus9JKhTssAdUdH9Q9qfNWsWrp5su6euew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wSkD47ynDi2S9fQ4CL0shR0dectADpBIdFrHfYPSzlwqNR0Wgsp9X0UWJW5yvK8eF
	 sjyeuLNUI6DX4UXGXa/dYLdsOaizkvaMr+BufYHVguLZHkCiXDgzu6Mlpyyfl7uB2K
	 RoQZajvIRuvfMAR9hRJi5WVGMa69pTCi4zfjG6aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLUOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:14:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33004 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgBLUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:14:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so3858693lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8rkEvPmm2/3C3lqf62Iz0nM0CBnRzi7Rqch1cLEjuM=;
        b=DIFb93kbDLtTa42QN6IXEtChk6umapMJ93xcDqr95+Q8R9OVe5IsvX0GevzZb1PsCM
         WE5xAAhHVLd9OCuY2Pdtbw+SavI/FqeOMfT3g+Z5+bXNfxRoE+RmSgtRaCSpF3+56bzw
         YbGGsgFqZHixlW2pRb2BlE5TqyH310/yLeE8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8rkEvPmm2/3C3lqf62Iz0nM0CBnRzi7Rqch1cLEjuM=;
        b=NhwywRC/dVcmb28n5VMtrMQK0XIn4D4Sjn8eQFRZE7Dy2BD5PO4dbgnjx0RHRQoLKA
         5aOIx/NmSnyCNA42/uT7+Yw6MDO1odvYYli9nRvVB2eB1ZnRGbiAuoEh3y6/XiUN0E3N
         flYOzIHtbhUXupyW+5m08OeKuGPYpEPnMSn7nRIGTqaNzpIgpZqlOGdAHnc3iNEPl2Ji
         ToFr/rvfyXYFtMgyhPkMnjkeXseg7Lx0flsvPFghR2wP/fx0QTnxPNrpa1wIZxk7tGXl
         nFYfUQPWYT9hgiktRsc3rl7a7IXDTsOkQdm3wQn27ZcQK0MPrNxLPD+YyHDPaoQ3Cs0D
         jOww==
X-Gm-Message-State: APjAAAU74CAW8ek06oPz0ibLQhszeEbKZSWsZP0aqXZn7ZwLO57eJQ9V
        bAjf8McXKmlxuY8zMqnMHEfEWS4Unpc=
X-Google-Smtp-Source: APXvYqz9tc387w/MgdY7jz5ShAsq/yPTh9zkKclLCfL9sUMkyG8Mj2Ej21PAydHOyXgePj11e3DpSw==
X-Received: by 2002:a05:651c:314:: with SMTP id a20mr8865040ljp.91.1581538447309;
        Wed, 12 Feb 2020 12:14:07 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d25sm108274ljj.51.2020.02.12.12.14.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:14:06 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id b15so2527149lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:14:06 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr7688870lfo.10.1581538446050;
 Wed, 12 Feb 2020 12:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20200212164714.7733-1-pbonzini@redhat.com> <CAHk-=wh6KEgPz_7TFqSgg3T29SrCBU+h64t=BWyCKwJOrk3RLQ@mail.gmail.com>
 <b90a886e-b320-43d3-b2b6-7032aac57abe@redhat.com> <CAHk-=wh8eYt9b8SrP0+L=obHWKU0=vXj8BxBNZ3DYd=6wZTKqw@mail.gmail.com>
 <23585515-73a9-596e-21f1-cbbcc9d7e7f9@redhat.com>
In-Reply-To: <23585515-73a9-596e-21f1-cbbcc9d7e7f9@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 12:13:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjv2V==7jGwg2OkyX4F6Cdtt4qCpdGF56rOi-kVtjGCZQ@mail.gmail.com>
Message-ID: <CAHk-=wjv2V==7jGwg2OkyX4F6Cdtt4qCpdGF56rOi-kVtjGCZQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc2
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:02 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> I know, but still I consider it.  There is no reason why the "build
> test" should be anything more than "make && echo yes i am build-tested".

It damn well should check for warnings.

And if you can't bother eye-balling it or scripting it, then simply use

   make KCFLAGS=-Werror

but sadly I can't enforce that in general for all kernel builds simply
because some people use compilers that cause new warnings (compiler
updates etc commonly result in them, for example).

So I can't add -Werror in general, but developers can certainly use it
trivially.

No grep or other scripting required (although the above may cause
problems for that one sample file that does cause warnings - I didn't
check).

              Linus
