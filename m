Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89047C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6246B20842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596576410;
	bh=d17qrTwVToEq2khFjvUCA0fj8FN9UTVwp+G7iaKwOrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ENCQ/MQAjM7x3dIil2kydr6YnxxTPW7d8vN9NjA2b60aLNq19OSQpWAQrNf5zd7ql
	 LTZ5mzM5EEvg+RA6s+nPwerHq/DP6TLa/ILfv/YhVNGezLF95kys0ndU4BXZm+DW5c
	 teeYAN+47LD0vLhuIWKEtRFubOHGTOMzaahIBDTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHDV0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:26:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:26:48 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so15427164ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7NKZj1R78/D57WU2J4CvrtRn4wBXaNE6KwcqvJ/JXc=;
        b=F7DrzR6KC5lRwPOTJ5+7Vnit32BCitYx1s0qEr4ic3BJyt7CSrbsV5eHcR3dWnXNqs
         kvOTvETu6noM9tj2MwB4kxeKxidzTbTaHuPnWa0BNWEYLv2GU/YQ6k197BDadKCH0f82
         mwPlbiZ2qYYroHX4XXsiG5UzHXhWy8XEKumRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7NKZj1R78/D57WU2J4CvrtRn4wBXaNE6KwcqvJ/JXc=;
        b=l0l1j4e/u/JBR+UjeAXRgDgcdIP7kD3RIMsv46atLjydYb88CrF3ptepH9LASvHwst
         eoCJWXm1RazwPMOhIDdkSFTskipIwiibgKHwyPUtI7VatMf7lTyQj8K15UQcweMeWqf9
         BYoLX339dY+ja1WErkpjHzPRMMz98u/nJqXhIz7pMxsJeWyaT1UeFdacY7oKws4Cx218
         4mGhILuoMzhwQoqkEq82Ug06mTG8w6os1yYRxpCYxJDkvIQGaTdV/U4rUHVgEIkV7plU
         o9h8BYvRfSCOIVNuJEUsihPR4bE81xvW1bml1PxVwjRK7/C7po5A7n44XIsDqH4FgF5U
         JVFw==
X-Gm-Message-State: AOAM530GCfsdxs3L04Vd2/cw0nKj+iRu9WtbXbRzWGURJ31X3PwpCmt+
        MpwCy7Tzj5mC0WDhcUg2hpy9eJBc5+k=
X-Google-Smtp-Source: ABdhPJxi+ZgUOCm3T5fAwxL8wKA8sY5ai0MXkkCbHA0PCboRnqGjRvmI4X+puaM7j/p5Xh6pVSGQvQ==
X-Received: by 2002:a2e:958b:: with SMTP id w11mr7890156ljh.370.1596576405924;
        Tue, 04 Aug 2020 14:26:45 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 29sm6696249ljv.72.2020.08.04.14.26.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 14:26:45 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 185so35037252ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:26:44 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr11503214ljf.285.1596576404472;
 Tue, 04 Aug 2020 14:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <8ce85723-5656-0ee8-67a7-35597d9df0dd.ref@schaufler-ca.com> <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
In-Reply-To: <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 14:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkuGCCk7DCNP6836FYeOaKZR9KLOBzr21fPOVNnOZiKA@mail.gmail.com>
Message-ID: <CAHk-=wjkuGCCk7DCNP6836FYeOaKZR9KLOBzr21fPOVNnOZiKA@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.9
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 10:49 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Here are three minor fixes to Smack for the v5.9 release.

I can't pull this: that's not a signed tag, and I don't pull unsigned
stuff from open hosting sites, no matter how obvious they may seem.

You typically have a capitalized signed tag, but I'm not seeing that
this time. Hmm?

             Linus
