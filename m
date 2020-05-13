Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB600C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33082054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589397112;
	bh=/GCNReSmCO9wet49yjeZWebjr4EvER7vzTxofeDO+nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NFK268VQJ3hPN1ghkIc8OZhaVlXkvFJgBFwJSDowyZ4zYuoDr1mVjLZFUZOe5LJAC
	 CfBkUCtEiT++YSYFvojIKbU3qKFRjHyUpcn5gPEMfSmnbuyedOxoRJn6RgIs2KL31f
	 8ZStWdkDIEvEoEfauk2EGy6clq8knW/dnPeiKDo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgEMTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390379AbgEMTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:11:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C60C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:11:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so798711ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlDe1IobgVm68K0PtFybaGZyKFGHK1OfKry00qMtGtQ=;
        b=V1UkNiRNfL733X9vr+6V4+xkxNISM7utjyshsT36quvy8jA5IVqpf+k3EDQxjXOIYU
         JkvVkJQB05ajebE0nuwA1SP0j1/ZNVxXHdyZbBxtTdovrxuSXCzKJOTV20D7eG1vu7ZV
         OomJViLlEUU/v3q1g+qPNyPfCuDydticNEJPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlDe1IobgVm68K0PtFybaGZyKFGHK1OfKry00qMtGtQ=;
        b=SushdP5Ujgpe88Gu3LTgIS4OnQrobWNITmQa4OCGaKfoveUeoBs4Q2JmHuiR9KN3B6
         72FfpFxV6AxQZKoXdDlz+sIWJ2MtCs8+5MoK8KcMC+DsM/hGqPLHOkXQmq8HH+qY5TUi
         lXPvbQpiEj5Q2Ayy0Zny1wtLM6qrCVyEsd/EAZ/UOoBE2zLwqdjJ9JqTc+3UkRjP6Ws/
         +vcl6n4sx1mQZUrK1B7R5wz80kYvG7UxcT1PUI0oY9grq9KxtIlxCxkz8vY8HNb0NCC7
         1vb3QTzdYetwgw3/9wPHYsLAAAHwR06m7eo7lVuy1z+c6YO6L0z6UCZ4fIWwDk0mn0ki
         FKjQ==
X-Gm-Message-State: AOAM531wg9seXwH4kVHH7LkP56p7GtfYaq496RCfW4InoJfRQfsNcocI
        zZdMccr3kOacs/mcFopPMePNSIwc/QY=
X-Google-Smtp-Source: ABdhPJzLL3VMClEvCJMpJcjTOuQ4xuisFWE9jdwMPfIiRGEvrr67Cp9uqCvEVJbsGWFaLUy5puQyQw==
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr391229ljp.100.1589397104905;
        Wed, 13 May 2020 12:11:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id v12sm200073ljc.37.2020.05.13.12.11.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:11:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z22so507343lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:11:43 -0700 (PDT)
X-Received: by 2002:a19:ed07:: with SMTP id y7mr627896lfy.31.1589397103373;
 Wed, 13 May 2020 12:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
In-Reply-To: <20200513160038.2482415-12-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
Message-ID: <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +static void bpf_strncpy(char *buf, long unsafe_addr)
> +{
> +       buf[0] = 0;
> +       if (strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
> +                       BPF_STRNCPY_LEN))
> +               strncpy_from_user_nofault(buf, (void __user *)unsafe_addr,
> +                               BPF_STRNCPY_LEN);
> +}

This seems buggy when I look at it.

It seems to think that strncpy_from_kernel_nofault() returns an error code.

Not so, unless I missed where you changed the rules.

It returns the length of the string for a successful copy. 0 is
actually an error case (for count being <= 0).

So the test for success seems entirely wrong.

Also, I do wonder if we shouldn't gate this on TASK_SIZE, and do the
user trial first. On architectures where this thing is valid in the
first place (ie kernel and user addresses are separate), the test for
address size would allow us to avoid a pointless fault due to an
invalid kernel access to user space.

So I think this function should look something like

  static void bpf_strncpy(char *buf, long unsafe_addr)
  {
          /* Try user address */
          if (unsafe_addr < TASK_SIZE) {
                  void __user *ptr = (void __user *)unsafe_addr;
                  if (strncpy_from_user_nofault(buf, ptr, BPF_STRNCPY_LEN) >= 0)
                          return;
          }

          /* .. fall back on trying kernel access */
          buf[0] = 0;
          strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
BPF_STRNCPY_LEN);
  }

or similar. No?

                   Linus
