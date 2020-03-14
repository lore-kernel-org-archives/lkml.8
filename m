Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104DDC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A952074F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584145972;
	bh=6H0PWzivS9YOvpc9z9KlyRLmW7t0JdHUfNBBy4MO9mE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lojBAAXiEVhMcWBnG9nXlrcY65Pzl3ql7XqRz1K0UZRUeXbkR6HOkxOQhX7SIeO7+
	 zLk/T9fRKPXgvms/BeTKHeM2c3uxdJs/h0+vIzLELH/fl3L0254Gp+Wv56bJtbwbed
	 2UDbtH4FyPGy8ghLk6tBgHlpcT9EO/iFyc/2XLV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCNAcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:32:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35170 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgCNAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:32:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id 5so2217367lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMErMaHHZEfJVKdh/LzqKM9AZGPTHK1128Br06lV9rE=;
        b=JmPs2t4VMNb7SjMik/nBvMjmm/0Ai21M6NG4Z1pEN2TGml1icBZolBKPU+MTFR3qov
         C1LT6aoBLNUDsT3oWiCnD8Vef9FBCVjYIeLZIDa7ayvP1kbcvKufavDoziWrLSjL1wbZ
         XsQq4CJwAGFvry6iJ4FZN1XfsilMkYlq1eU+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMErMaHHZEfJVKdh/LzqKM9AZGPTHK1128Br06lV9rE=;
        b=qn7EsPXfs8qKhkhNzZ9aRUwrNVq7KiN6i1GxtjYfFz7OkzmXtuPtgZZ3h1Kxbe/iDy
         Xwlg91PpgDMmInjRUS3iUG+IWDsOVaxUcR574DmV8YUp3c1+paZrwQpegNyerwVj33VO
         PrtDEXkLdw6iN0QVXZhNC6pqJxxzBFj5Esj78ApGCZOjOy+Q+B8Kfdf5nY6SqsFBheaP
         Jqk+K9HbicCTnlxtysWjtjCGar2Xa9H0wJjQrxnud7pjSOKz5gx1MCVFilaUWT9zsx2u
         aHn/+OhHdGW7uhKqlIKpdperjPjngKJB9KFMQhtQFbhvRsH/Mvkl8G3IedsY/WgvMBG+
         GssA==
X-Gm-Message-State: ANhLgQ3SC/22RG07EfL6WOngXpy2MD19IHdXH+rlmQOksPl7L7Rb/wW/
        7p6+aG7ykkSspP9umnJPnqQYeM5zWFk=
X-Google-Smtp-Source: ADFU+vtNTFgWh40CpmUvmUcKgpCMvSwyAwXFk3Z2apKtJHTB+45cNXDdBjxUK4z/ILNYivkYZkzZ9Q==
X-Received: by 2002:a19:484a:: with SMTP id v71mr9263655lfa.199.1584145969539;
        Fri, 13 Mar 2020 17:32:49 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w22sm9027166ljm.58.2020.03.13.17.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:32:48 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j17so9303422lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:32:48 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr10337015lfg.142.1584145968339;
 Fri, 13 Mar 2020 17:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-15-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-15-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:32:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=widhgJ=hB=dOcQMJzPL9mX+8TdbcAspBXs4FSdiLk2jMw@mail.gmail.com>
Message-ID: <CAHk-=widhgJ=hB=dOcQMJzPL9mX+8TdbcAspBXs4FSdiLk2jMw@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 15/69] new step_into() flag: WALK_NOFOLLOW
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I mentioned this last time (perhaps for a different sequence):

On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (likely(!d_is_symlink(path->dentry)) ||
> -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
> +          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> +          flags & WALK_NOFOLLOW) {

Yes, I know that bitwise operations have higher precedence than the
logical ones. And I know & (and &&) have higher precedence than | (and
||).

But I have to _think_ about it every time I see code like this.

I'd really prefer to see

   if ((a & BIT) || (b & ANOTHER_BIT))

over the "equivalent" and shorter

   if (a & BIT || b & ANOTHER_BIT)

Please make it explicit. It wasn't before either, but it _could_ be.

              Linus
