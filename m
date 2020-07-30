Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD0B21883
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuWCFZU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgG3WiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3WiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:38:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:38:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so15540584plx.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/tH2obDhOAeb9AFFbuoPCMXYIQU9maJaUQmRmpTfUo=;
        b=AuWCFZU71DHpVB6oOERjqFXvHMISxWOrX2yzPAFFs6ziS2ntJAE/Iu9YXxg55HK8oC
         RCizC+p7A5NojVnmquEmDaZlPNaBrkJ7CPUV9eaU/qat7QwzJ3dhbMmHAwNr3ke0aCy3
         pl2eusHKTc3zUGL+bjJf65/Pay19Xu/+xjLIFpvj8yVtEPpsIsy9XqSpGHKG6OhDmr2Y
         SGGdjq/kN4HHGkyqBqRzJxpQWwTiLrosfMANiuBkGL79TvmttThwStt+sIPEiiuuU7+C
         DUyRWe4k0BCrcHMyskmOEWSNF06DcNgSzvYIZPi4CVfJ1P/3jWbnXCFCW3FZ4BW07YFa
         lUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/tH2obDhOAeb9AFFbuoPCMXYIQU9maJaUQmRmpTfUo=;
        b=pExlv2Wpk0unrsnBLgOIF3lDXJFIEAarY781WaxZPz7YYLvAijHj8gnSvZXi+p1fRj
         gHDBi2+kykynFpyHFcHFo+qPe8RcAVOrCQNlFYWpE9Bg7+cpRj+Q9scu3KfsxAl8pPlL
         Lm7oTL7Y3+rZitnSPjeLNA6edu6rEU2DQqadN4EztwiVwNPj2zfuyDigvGWAeAuBvC4A
         6GtPN62f2E7LiriH6UbHPhG3cMUpdA9xWrrtcxp1THP5ufRWJRy63a5QG3ZafUE6TzdC
         kj3vDzAoIQFxLhaPM3qrSsDb/qKCXFkUb/aW4majwcQwx7to0Bvy+DblYa7fty8vWTsR
         NFag==
X-Gm-Message-State: AOAM533blLBkPRBhKjAQGMglxqJSC6d5c/+mMgSeSXpF7vpbvv/Mpp3D
        FJCAevlO+FhE9oFqTsrRx8UO1Z9OxwPzWVStQsJcng==
X-Google-Smtp-Source: ABdhPJw1mdmYhTwcHCzcUrT7+xVlCTKS2/woVPdTE10B6OPbS3JXL0HHCdSgIH3aXAuwIpUTZgDHWSZliMRreSrTF+U=
X-Received: by 2002:a63:7d8:: with SMTP id 207mr999664pgh.263.1596148687990;
 Thu, 30 Jul 2020 15:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200708230402.1644819-1-ndesaulniers@google.com>
 <CAKwvOdmXtFo8YoNd7pgBnTQEwTZw0nGx-LypDiFKRR_HzZm9aA@mail.gmail.com>
 <CAKwvOdkGmgdh6-4VRUGkd1KRC-PgFcGwP5vKJvO9Oj3cB_Qh6Q@mail.gmail.com> <20200720.163458.475401930020484350.davem@davemloft.net>
In-Reply-To: <20200720.163458.475401930020484350.davem@davemloft.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Jul 2020 15:37:56 -0700
Message-ID: <CAKwvOdmU+Eh0BF+o4yqSBFRXkokLOzvy-Qni27DcXOSKv5KOtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2 net] bitfield.h cleanups
To:     David Miller <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, oss-drivers@netronome.com,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 4:35 PM David Miller <davem@davemloft.net> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Mon, 20 Jul 2020 12:48:38 -0700
>
> > Hi David, bumping for review.
>
> If it's not active in my networking patchwork you can't just bump your original
> submission like this.
>
> You have to submit your series entirely again.
>
> And if it is in patchwork, such "bumping" is %100 unnecessary.  It's
> in my queue, it is not lost, and I will process it when I have the
> time.
>
> Thank you.

Hi David,
Sorry, I'm not familiar with your workflow.  By patchwork, are you
referring to patchwork.ozlabs.org?  If so, I guess filtering on
Delegate=davem
(https://patchwork.ozlabs.org/project/netdev/list/?series=&submitter=&state=&q=&archive=&delegate=34)
is your queue?  I don't see my patches in the above query, but I do
see my series here:
https://patchwork.ozlabs.org/project/netdev/list/?series=188486&state=*
but they're marked "Not Applicable".  What does that mean?
-- 
Thanks,
~Nick Desaulniers
