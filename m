Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23603C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098E420855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596766685;
	bh=b7Qq+dJNZhU/7zza7rxiZgawP5B3QZPu8FRr0mt+wsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1i1bI4RAShn4NQNNH2h93M40MnwvAsuMPed8BZDGrk4xmOaxaUpBA2pu9NEncHtd4
	 uiaxVPkYzWjpjKAvTHErMio/Mui1ydABkAeNRNOtXxyfXufeC0jEBvyHnopriRxtAi
	 f8oj2rREymEfRGOyHv3sx9CczWBb2t6sxJeul8nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHGCSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:18:03 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 19:18:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so501223ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Lah8TzAGljxIbFtVurJusY2DfiaafQCEJzA/pwqjDM=;
        b=VjqpGoT1TBgvDGglmYSQIgK2T4nVs67xQsZm8S2CFvqnq61+ud20VYm9xLk5dgltGU
         ADPvjm9v5KrYjmqZ8uW6OSd4aQjfc4iLggDx8+szpkXLIhZHf/hLL81EtQEFHZ4T/BCF
         6BuSjL2rKWnTl3CKlISDpQwBpONjVlq/QE3Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Lah8TzAGljxIbFtVurJusY2DfiaafQCEJzA/pwqjDM=;
        b=Xu/ZkYAHABS0YSEMrpZFy7gLHhks0Rx27u6E92qLu7lN4r8TSbF1m34ZZHooOIIJ15
         uz7m6u0tVQw4AFPDZN6e/Bsjd6aJ+OeFD0BZrbeekqxpEwWjfCqjuJXebMc/UqDjfeQz
         zUJWmpj/npocHbjgZbJ7w1D60SjFOcJA0pcFDe8rB8A6QWdfEK5JymZ3/7CSPnv6Py4s
         ePQKiax+MAKGzXfaDaGSykIXhMJSRph8xvnIkrz9WCh9T6O79YqhtHbPsOaoUam+QFZ3
         JDYMwn/k5h6XK21jvcRYI6oBRisGAONiesVtYP9bKBkWtvUmUyTvDBzc4s4H8HNxNHgw
         L3xQ==
X-Gm-Message-State: AOAM530Bl+K1PuC1RbKjm9/ZRq6Mm/h4E3dT87dBEr/3TpFr4r5pYMiG
        6Z+QGjK0rwpeiWfVwTirf3Do+HtNu/Y=
X-Google-Smtp-Source: ABdhPJwjbWL0YThibJgbqokbpiPTsNypoOuCwnmBue6czX54fMN76x7vAv2eRvhyPd40qs5kd39kZw==
X-Received: by 2002:a05:651c:50b:: with SMTP id o11mr5482535ljp.411.1596766679718;
        Thu, 06 Aug 2020 19:17:59 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j18sm3229936ljg.5.2020.08.06.19.17.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 19:17:58 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s16so516830ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:17:57 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr5035498lji.314.1596766677614;
 Thu, 06 Aug 2020 19:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200807004904.72893-1-linux@roeck-us.net>
In-Reply-To: <20200807004904.72893-1-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 19:17:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTGZ2hVGP-UXVW2q2AtQh+gWOeCvasDm1Z4+g5+grkmg@mail.gmail.com>
Message-ID: <CAHk-=whTGZ2hVGP-UXVW2q2AtQh+gWOeCvasDm1Z4+g5+grkmg@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Use standard early random function
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 5:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Use arch_get_random_seed_long_early() instead of arm64 specific functions
> to solve the problem. As a side effect of this change, the code no longer
> bypasses ARCH_RANDOM, which I consider desirable (after all, ARCH_RANDOM
> was disabled for a reason).

This patch looks sane to me, but let's see what the arm64 people say
in case they have preferences..

                Linus
