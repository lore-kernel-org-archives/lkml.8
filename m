Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A077C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17C821D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579808479;
	bh=in09G1WumARhfhDSEQ2jmhDr3ghqnL4h9DkZIB6s2OM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ri0yC32wVoaT08IDDajeAe2nH5yPHbNsslDK+PoxCme70mDXcOR7VbBUNfsm1o2LG
	 GFJkqeClFq78GWFM24E69R/NJbfzawyylHRCSE1dpsWENOwHAGRyZyNXGsDtKzzYqw
	 hlJCQzHqOuyRTZ5VxVo5tRYYj5JGy8XbHeEoBX14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAWTlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:41:17 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43142 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWTlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:41:17 -0500
Received: by mail-lf1-f52.google.com with SMTP id 9so3227788lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6ze77FgMrI1xfP1P2js4rFlpAnmgMg+78g8PoeL9bM=;
        b=T2m2lrf9w9GTBB29xgh0fUvSUpfa84CkPjcE3nPTjF6DJyXJmBzeYOyV/Wwg/0+a6V
         N3vu+LeFUl7h7PXzKp2ahe0V5nlHwSz6n441RSC+Ti4pfRRva7PYJ6IFkl3TO8WSr1jE
         3jTu06CzlAZMv/TfjoEl/LmpPdzqMLW/uZRX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6ze77FgMrI1xfP1P2js4rFlpAnmgMg+78g8PoeL9bM=;
        b=IK4Xf4de5u5LxO0vTiYl4SW17swviPRCMW9dvZ0Avp8K/TJn8ZZSuFrr5gRokwWWKl
         D/iD/vE1nM/L1h1pfh+lWxCKucNuoPpiz4neMGyRWikQMAzy5qz4Rvrf7DOCwSzwXyw1
         F4ZCQQj2b/VtdMqr0NapwQ7H3J/4k3eIy88Rp3pTs9lEN/C4S7p0PyojhB3+xbrYuwVU
         SkRToBFPUE8YBJrWGEYnfsiB3sbcCx6M/VKAr2782pHxyFfVfAPSMfa8JBEzoR0yn7Ik
         MGrs8bxUIrdXGO6enZ55kVqLRfQBn3tjx9p1K9zBruh+Sg7Lik7zVGKOCtUcFpNAojWU
         R6tw==
X-Gm-Message-State: APjAAAUfspRF3ehld22P4Vk1Q9v/h1MN1pHIDhXslBniVWyjej7NVcKF
        Xh4/2ipw9zmQ+fxaOExy3b/Z/XxnHVk=
X-Google-Smtp-Source: APXvYqyR4Ac9FBlLW86HIW/y04H6GegBQtaaZoZKLIjmgmlOQm7854PlzA6GdseOySXK3NjrkVj7FA==
X-Received: by 2002:a19:5013:: with SMTP id e19mr5476237lfb.8.1579808475278;
        Thu, 23 Jan 2020 11:41:15 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s9sm2091754ljh.90.2020.01.23.11.41.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:41:14 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id n18so4971595ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:41:13 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr114178ljk.201.1579808473496;
 Thu, 23 Jan 2020 11:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20200123064140.GG4675@bombadil.infradead.org>
In-Reply-To: <20200123064140.GG4675@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 11:40:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAz1qHTSPyKMf2TpEcF7E4b=8O2BVw56wknK+yTwUW4g@mail.gmail.com>
Message-ID: <CAHk-=whAz1qHTSPyKMf2TpEcF7E4b=8O2BVw56wknK+yTwUW4g@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 5.5
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> So I feel pretty comfortable asking you to pull this, even though it's
> so late in the development cycle.

Augh. I hate the timing, but looking through the changes I don't see
anything that makes me too worried apart from just how core and subtle
this is.

So pulled. This may be part of "we'll do an rc8 after all", but I'll
see. I was hoping to avoid that just because I have travel coming up,
and travel during the first week of the merge window is suboptimal for
me.

Oh well. These things happen,

                  Linus
