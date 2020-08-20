Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3103E2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+CG0sAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHTCaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTCaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:30:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A289C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:30:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g15so339830plj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHJ7HRBHswVMUg6am7ER5uoMDi3Cn/npsWlI6SwAOCY=;
        b=i+CG0sAj4sWouxSJJlWvdKSPgQQwgRZiGfPJ4a+GF42DjElbTdznbu/i70bZanQY+Z
         ZHUHJs6VCYi+PvdDocMpJ5Rf58m6j1xKkSZ6aR0KIqy7B/qa9rx3HRWwJb2cJif8yW5q
         GaIuy4cHG2RRh7GB7dM/HbjuiurKYYEuvVcy+Q8hBpYByiaIa/V3UQwnRQm1f+LWiicB
         ObOhRKs+nmLsBitoqLT0BYj+6dkR1E9j1X+UiiSDlMmknppoxIlQe9Wx5uLAN/1709Se
         /g0POXsGiVmg/K8MxmdNPPBj+7EbdCfr0FzF1NbL1bgxmdPCJSenVF/7jkItiXcjlo8G
         /8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHJ7HRBHswVMUg6am7ER5uoMDi3Cn/npsWlI6SwAOCY=;
        b=iYg6Sg7+5ol9djOp5F7P69adVeZD5imDozYYCTJXtfQeh5jKpmGAniw5b99yrMmcd+
         qASBWtCOZB3WRw8X2z0AEmJVer/dcxrJkMJLrfYppseM5v22Qo5RqxyC7yYrdlvj3J8X
         TOj4Omml9NIBS/qIOAx1EWQ5BRJlEUq9Yu1+u1hDy5710HvMHrXEwRmvc3vdu0hFGtZ7
         bPZTElabGlZ7R3zXuxliXtwIlRlFROzqutTHlf2O5DhB0yNArHty5ImqBG+2XmmY0A78
         ofHjwkyMluGriCRpacm6IYPRRbb42i4B7y6UD9MZ/khQlrTKK6vIK1IK6fB9DLBolOyF
         r1zg==
X-Gm-Message-State: AOAM533GtTYY0AUcXSVTRv5eN9fGsHfR5S4Ku2CpdVBAnV3IfS04wxRW
        4dQTahNUm1kAwyQCnYPUFwtHLqDKOVVXZaP+m+jmzQ==
X-Google-Smtp-Source: ABdhPJy5FscZgZYiZn+++MzCBh2DDEb1I4sWufP3av3+bx3VwbyufGgotvToqPFA8XIgeFy5GBObv5SHhlZcsvHVfyQ=
X-Received: by 2002:a17:902:b485:: with SMTP id y5mr875957plr.119.1597890607308;
 Wed, 19 Aug 2020 19:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200812173958.2307251-1-masahiroy@kernel.org>
 <20200812173958.2307251-3-masahiroy@kernel.org> <CAKwvOdkL=667+cw_Rxq_5zaOKeTTptsMaxkkSXBic9QxozOWVg@mail.gmail.com>
 <CAK7LNAS4EjGchNzqhEcTPTU0mOUqAk8nF9QYW3qwfOp572uCHA@mail.gmail.com> <CAK7LNARPAB+UBcYJTauPRksOb1zVbicUt7z39szaO3o70vD1RQ@mail.gmail.com>
In-Reply-To: <CAK7LNARPAB+UBcYJTauPRksOb1zVbicUt7z39szaO3o70vD1RQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Aug 2020 19:29:56 -0700
Message-ID: <CAKwvOdkQTFEGaSXj5kHpuqTQ9hFYPWkCAyegQ4jienLaH5x9Ng@mail.gmail.com>
Subject: Re: [PATCH 2/3] gen_compile_commands: wire up build rule to Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 9:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Do you have any idea to cope with
> the 3% loss problem?
>
> If it is a problem, maybe I should try Idea 2).

I think it will be ok.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
