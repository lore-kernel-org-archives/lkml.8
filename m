Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17FAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD26F206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ucdhg60q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbgFYGQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389917AbgFYGQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:16:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8273C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:16:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so2551757pfp.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZ2PvzdtgciFAabeAtdBsGVo/eCilLMROlNDZwOk8SA=;
        b=Ucdhg60q6WdBMxdYtajQVswDIC1yjf+5xSIQSbbvwAlYDNpC4DfdV6MfEkaDMB3ofY
         vu0pHjlRaeDKqH5RSiWvxNN2Nj7jH08nun3M0ycuD6jJco1lOgIj5xeWCDwM+f70+6Gz
         wKDkM5ZoU8Pvb5goWYdeVnh4aUQvgYnozi/yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZ2PvzdtgciFAabeAtdBsGVo/eCilLMROlNDZwOk8SA=;
        b=LlVENLd+/aX1OFu9cRtJ5bxKGLNc+O4OLlsgnsfpUQ4/fYXv3gssn6pMisRmRRsD8h
         zd8vaiV8Za0iM4O+NYB05hmxb86b+frlT6MsqY5Et4oIjN1OWR8VNvDxu2THdKYw4Mar
         ut/uaZy/0WtDS3xwZ5PQhNMlQnZV1EQQADdTXxk9eXYDSwqvH/f66pKX5SzZwN1WVO2d
         WkY3IOGshcW0FdNPesnrjdFOQMxFi/ah6sd07pxqLXP0kw5TkKCH5EPCXjmnDPlbp10u
         KEZ+GAQNcMyxS1t1GbnvunlF6AiIBMpToKZQx5UJhfcMSVCerv1N/RSgOFDStg6W0N7o
         KJvw==
X-Gm-Message-State: AOAM530DKYI+JapVPuqXbLMOkRyINj2ME0HDNWgkAGffsaWxZjDfuwew
        hDOBTLNJUFMEjsfwjk30Iq/MQg==
X-Google-Smtp-Source: ABdhPJzOvRfNxHTxxVh/1x6g3vmqLvkHpgMIs7fv/bdMPlaUfZ5S/hQSdnKWRpmQm9oBxjyvFKmpoA==
X-Received: by 2002:a65:4507:: with SMTP id n7mr3683600pgq.180.1593065765208;
        Wed, 24 Jun 2020 23:16:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y69sm22946845pfg.207.2020.06.24.23.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:16:04 -0700 (PDT)
Date:   Wed, 24 Jun 2020 23:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Message-ID: <202006242312.8888AAFE@keescook>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 02:21:38PM +0530, Naresh Kamboju wrote:
> On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >  # Record and dump the results
> > -dmesg -c >"$LOG"
> > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> 
> We are facing problems with the diff `=%>` part of the option.
> This report is from the OpenEmbedded environment.
> We have the same problem from livepatch_testcases.

Does "comm" exists in those environments?

dmesg | comm -13 "$DMESG" - > "$LOG" || true

this is even shorter than the diff command line. :)

-- 
Kees Cook
