Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6CC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3E620720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndH1QMbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGJQPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGJQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:14:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0143C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:14:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z3so2718879pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9lBY9pYp9JUzVayxMXqZuU4yWSRYAwmBQ//oKA6K0hs=;
        b=ndH1QMbDsgnY7oGL35UIxrr6Yv+cubgdgMU/sFroEyDe6PkWDrrWYZwvxrezSTUhJt
         UEkzPjM4+UyPJRZ73fmcwybl2J1IKxEazZum0WPyQ8pb/wm66/f+zlRJbE1oXc1lou0o
         j6jKFsM6dR7G56+xqF99DdSoST0PP4g0GqSKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lBY9pYp9JUzVayxMXqZuU4yWSRYAwmBQ//oKA6K0hs=;
        b=Uy+gafKWeWy8hwskN7101FdudAYXAG7sVbj/e3eT3kK1O6cfnBA20IUhqgZVfjLoVG
         6nLD290HcsZCiG/kvHYTu2owHvgoJfkTe+neQsmeRoDRkf+N2hRR+O5CwVdOBnUHW4OS
         Uidoe6HTd4eftzsZummsd8VHpPPQQTyxGg2E1vomTx3vZlGakDLq7CnoXnMKGFMbT3Xq
         p8LawcIbXLFJAY0KwnAe2q4B7tjmp64gikLoWsVGX1lFVv1jMCgXaHYsZHmges+R1UQY
         oUf0fTms27aqXu+qutYrgW5O/bIhQNZht8Zr7m2lgO9PWyavMh3lIf2GqkPd/XYD7Oh/
         +1Og==
X-Gm-Message-State: AOAM533goYjIx02i75RMk8zee6t2n777KYt2s+o5voSTe8TzhcN3aKQ1
        lVBQvIrKb2Xjq58LS+mu/bGIEA==
X-Google-Smtp-Source: ABdhPJx9/WxZqBjaUOJ6z/UGh38dhUYKTMjcadx8P0uQFcix5pNXoxF4vIwwcjtrPiTmDYWwnzIW4g==
X-Received: by 2002:aa7:94bc:: with SMTP id a28mr63725969pfl.94.1594397699224;
        Fri, 10 Jul 2020 09:14:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm6710589pfc.118.2020.07.10.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:14:58 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:14:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <202007100913.B43F8EE371@keescook>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
 <20200703154426.GA19406@willie-the-truck>
 <202007030851.D11F1EFA@keescook>
 <20200704123355.GA21185@willie-the-truck>
 <202007042132.DAFA2C2@keescook>
 <20200710124253.GB30458@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710124253.GB30458@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 01:42:54PM +0100, Will Deacon wrote:
> On Sat, Jul 04, 2020 at 09:56:50PM -0700, Kees Cook wrote:
> > (What doesn't pass for you? I tried to go find kernelci.org test output,
> > but it doesn't appear to actually run selftests yet?)
> 
> Sorry, realised I forgot to reply to this point. I was seeing assertion
> failures in 'global.user_notification_with_tsync' and
> 'user_notification_sibling_pid_ns'. I started looking into the first one,
> saw an -EACCESS kicking around, re-ran the tests as root and now they all
> pass.
> 
> Are they expected to pass as a normal user?

Oh right, I still have that on my TODO list. Right now the tests are a
mix of root and normal, but since there are some root tests, it needs to
be run as root. I've been meaning to do the appropriate permission tests
and issue SKIPs for the ones needing root..

-- 
Kees Cook
