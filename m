Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D54A2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598221768;
	bh=RgN5z9cgNlrqEmZ1oM12a5y8rpE4G1O6xn9/7wXWNcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K1czAmFvXUyHWgufnHruYQ55ZTc/bzT/VmjDjSi+Np3oIEWpmtO+uNnYpruqb6FEZ
	 /wdx+aT5eTx9KJ4e8kHTi4v3lGP4205ni4FspjKQZPkMbRf4pTWEE6xMGbVK4NareM
	 3EkhBPg2R/y4DW2h7lOCFYBOl2EO4mFAXtEEMfB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHWW31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgHWW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:29:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CBC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:29:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k10so479140lfm.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CF4HO+TVVT1FyRQL+8yO5ovIj/EE/cR2DqILLNrf6A=;
        b=aYbeOjBSavL0qSOBvKnIK1XY7QJYTsB93xmLK83lrSOOUcdnaXzMeFAdN1IViFIagP
         6zJ2qty4xm90qfTXThY54CetNTZUWHdNATKFbcfL3yVTZddNtRfVcviKXcqydVzUSRJw
         +2FqyZTFJODnzh9YARA3chHrAgL3bZlSPWHdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CF4HO+TVVT1FyRQL+8yO5ovIj/EE/cR2DqILLNrf6A=;
        b=jzIkzzmF3AX0h37ct7e+W6KXZsqkRAn0BmqVN5tjN/2MR4VaJwq7EH99e4xK46gJM6
         uDYtALMudhdQUV09pUhsQJTXVNQVpPc3tcZki2tmcP3ZV6XGCKNj5Uie/gv6iJhhggMM
         a8VbHRCdZ7nO0xImMQM1HE3VzyBuwq+s7BtGGM4oxqZsvlfPLdenFLVMWwv7tuAYr3ke
         yA4VAP9V0bFm3/v2151ZILuZlyOhMPMkhTAM0sb2BfXkjSfcjy8CRORoBM1NK8Nb97oN
         +iapyHFIyZMMGT+s+01YdvPZoVU39rTYCoHtwOVHmt7zqsZurz6JKKXbItOdr5f1c/9u
         IY4w==
X-Gm-Message-State: AOAM532dWbIo0Ig9Aq85dRrb2nvJG5bOXa9Q3iHwqAoz6AjJacAcn3ZZ
        pAdDYBV62AUxFe+URyr65Kh1ID0AzBVs3g==
X-Google-Smtp-Source: ABdhPJyROltLclK2JsJDIeUFa7aAfgYN/d/K05hROj4BiGzLy0YtOWgHMHKm9EBnyaszt3Qpw28/XA==
X-Received: by 2002:a19:457:: with SMTP id 84mr1218033lfe.191.1598221764393;
        Sun, 23 Aug 2020 15:29:24 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x14sm1827894ljd.1.2020.08.23.15.29.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 15:29:23 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id v15so3456480lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:29:23 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr1260211lfl.30.1598221763278;
 Sun, 23 Aug 2020 15:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos>
 <159817113762.5783.6214320432160748743.tglx@nanos> <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
 <87ft8dqaxw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87ft8dqaxw.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Aug 2020 15:29:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3RkhuNytiG5MR0O0wdnN6vMP2mOuTVwpEqo6+RBTqVw@mail.gmail.com>
Message-ID: <CAHk-=wi3RkhuNytiG5MR0O0wdnN6vMP2mOuTVwpEqo6+RBTqVw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 3:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > And I don't think we need the GDT for anything else normally, so it's
> > not even going to be cached.
>
> Who cares, really?
>
> It's pretty irrelevant because the main source of horrors are in having
> to run through _ALL_ registered NMI handlers. Why would you worry about
> the extra cache miss?

Yeah, it's probably not a big deal, it's just sad that KVM can't do
the simpler sequence well.

             Linus
