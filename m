Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E28C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2963C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597259167;
	bh=y3iRGvh4O4fsyQkFTMG80pi7bhD3FpwJs0LLfrRyRMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hSlJ0aKCLCO4gXvjiEYZ57SMZIXRgCPnFQHUq1xbktYlk9DgE/tpNZkN/JD+3jScN
	 1yyIW9j6B6cBSn3TOQGaDntinc9Ue4z2oQ3rX9hHkfoN91aKNUAQ3nAwPSpRScZyvj
	 4gWewnHUKcEbK498NcXOv9orcX6Jka+sWaFSgHc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLTGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgHLTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:06:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187A3C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:06:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g6so3427318ljn.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aI/FL8Tvc9ElqJ7Vjyb3qFum80s66LEZMcxmIKB+pHM=;
        b=YeeHgDpVSVBgkET3Ky9UU2Ct8EvO3d1pyGPbHJPydkUtX6ammtgkcWFFIN7i+2ajf3
         u/CQpP7JSmfuj/v2yXgZCtgLMX5s5RkoGMwFY/XSPTyF7WbTOQElnPyJ9y6MomJxsBjo
         rSb1Ae8B2JHyu2fe4Uw8k7epl2fqomJhBOUzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aI/FL8Tvc9ElqJ7Vjyb3qFum80s66LEZMcxmIKB+pHM=;
        b=fkH0hjXPpyfZ3F1sV8uXWZGnlloiLquCKEAQf9R+V/Gkfm3ekEknUpLesUPh/Zd7q3
         gdHe3fv3kza+634uqQY6WZywgc5ZxnwIozIxatZwVJUgoXSl4DGxuENHzC69Cs405xec
         PEj4hbgIsHtVuIcviY5g0V9XcGcHJWrh7hcAhH8vwIrPRBcungmNCVdhUe0nXNhwy4oh
         7yXfDXPgrUtaqW4RfQ6vIACkt8+r8VkQJaGKrPgmLUCaTV2Rx2WmEsYc2gZa0OJixXzy
         udP4XO/UIqgkSw5oHS2SlK3KHNNBlhJC19M1vZI9o5A/w5lH9C0fLSrdzAoSbFDE/ReG
         WuVA==
X-Gm-Message-State: AOAM530EZXDFqNwESLDswHxOWY+3Z5IiuhmvajhA7hMzbtPwGFsIzAln
        SDcJ2WdimDK6aGKWLUpprssiS0sETcM=
X-Google-Smtp-Source: ABdhPJwlwDSZcRG9J5bh3MPqRBCHSQRKPE9opFxWUBFcPs30xVgvb+MLhdi5G5WGG/fg+fWiUctcyg==
X-Received: by 2002:a05:651c:88:: with SMTP id 8mr294547ljq.277.1597259159548;
        Wed, 12 Aug 2020 12:05:59 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z15sm673913lfg.81.2020.08.12.12.05.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:05:58 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v12so3449597ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:05:58 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr246876ljk.421.1597259157988;
 Wed, 12 Aug 2020 12:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200811074637.GG4411@dell>
In-Reply-To: <20200811074637.GG4411@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:05:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
Message-ID: <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
Subject: Re: MFD for v5.9
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:46 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Enjoy!

No.

This causes new compiler warnings.

I pulled, did a basic test-compile, and unpulled.

I refuse to pull garbage that hasn't even seen the most trivial build-test.

And no, "I built it but didn't check for warnings" is not a build
test. That's just complete garbage. It's showing the code to the
compiler, and not bothering to look at what the compiler said about
it.

You can try again next merge window, by now it's too late to send me
completely untested garbage and try to fix it up.

                  Linus
