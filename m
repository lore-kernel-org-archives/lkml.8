Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F56C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72B620732
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvU8SQl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC1VuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:50:17 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35588 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1VuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:50:17 -0400
Received: by mail-pj1-f68.google.com with SMTP id g9so5491844pjp.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRb5IsEMXQfgboPnAgWj3+2vIpSyjSusXFWfLG3LqXc=;
        b=CvU8SQl5E+YmYbDxDmbskBQ2t0JHHJQ8sASp0i2I0gH2ECAI5tRnkGDbtdi/C0KT5R
         LbajgCaWikJ72Ca+qnR7CDrJck+PCmajv50Re1zqDdZjjyRVXL4YMc9/4bUJWPVD1kum
         wnnHIQxObr7V1lZf1r4WgKqWIy6wY+zGWsFq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRb5IsEMXQfgboPnAgWj3+2vIpSyjSusXFWfLG3LqXc=;
        b=IR9HieVB7RupC9K2Rt9HDKiNbVP4tbaYYhOvjdTWSTPBtjRpraYzxc1nfVbGTglcz0
         raZaXoUpUQYysrHX5uH5Z4J/Tq8mcq2cFP60iUQe/WtBx89A2MfL8AtdjfnXcRks/8wb
         7/l7OswRnaX1ydqPCYMEmxyBPAYTEjNMAawbjDVvfITS3CvgBsKcncBWsrxih4NbpQlK
         o5wEpo4Y5dRdw4KqFN+56Gq6/03EA1gWuFC7a6Q73ad6vlQWwsYP/6W1AaXlDacBTCq7
         W+rOD+/Z3FXwlcXbYbAL3mZkk6SX6gYqb60SIXtidOQXNUsMTWIfmFNH6S0UVnN2ipf9
         5vMg==
X-Gm-Message-State: ANhLgQ0j3eiLEj39xuEzHkoe5Z03NuWKmfLCPTqw6bOcVRzoHWc8t1s1
        oqstbt0NvYAYE0aI5ZBIa3wi7Q==
X-Google-Smtp-Source: ADFU+vu2NiUwwEDLHzJMv3dcJEsAb3IO6DOtzKCkclXs6mjC9Cb9juZjNRndmUuOgRpk8swbUuht2A==
X-Received: by 2002:a17:90a:5d96:: with SMTP id t22mr7300491pji.132.1585432216326;
        Sat, 28 Mar 2020 14:50:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189sm6820905pfg.170.2020.03.28.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:50:15 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:50:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <202003281449.333BDAF6@keescook>
References: <20200327192854.31150-1-kpsingh@chromium.org>
 <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328195636.GA95544@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
> Since the attachment succeeds and the hook does not get called, it
> seems like "bpf" LSM is not being initialized and the hook, although
> present, does not get called.
> 
> This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
> there by default as we added it to default value of CONFIG_LSM and
> also for other DEFAULT_SECURITY_* options.
> 
> Let me know if that's the case and it fixes it.

Is the selftest expected to at least fail cleanly (i.e. not segfault)
when the BPF LSF is not built into the kernel?

-- 
Kees Cook
