Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C575208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590620267;
	bh=D7Z47XdXCd8usmwGeOPgUCeB9bacDk/hJaO5p9C3cdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UH2Aq+81202e5yUJ3Nuo2Fm2I9o9vruU25Z80EmL0DAd8OUHvM8ir7kCz6FQph2Ys
	 v1ixJam24IVHcBXo/E6VjISXdYEo45kI9yy69JoWpvPMqP+zxifMkQggNd+4zBTkdy
	 iuTJyqUsaeL5nSp/xuDRlUogUtn/+vEIHFozTyI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgE0W5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0W5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:57:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B012C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:57:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w15so15401837lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1o9yH8PwCtYCZb1G6vqgxvTofHUhlST2MYbKWRNoUMc=;
        b=HJOClZU9Jx692wWjV8dAK8qoBQJOIp6cV3W4aTmRDleA0DLGpZ0/7ohIQvhQcSZtBP
         qAaK65Tj3bYm0tp4mKn9acDv9Z1M77mKGuP+zaU5pDUpGpXeMRPqv5MJ4y3FUkhKNxpy
         CL/breuu+UzCxEeS1sVIBcEjnwVSSqwCXFsbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1o9yH8PwCtYCZb1G6vqgxvTofHUhlST2MYbKWRNoUMc=;
        b=BFyUyaSAkrxqhcovWPW+mj0Xfk9tsJ/sDHDIZPAhzyb9fxiYLaUy9BEcPk/qRWQ6b3
         js9R48StYIpqEuBPe9KHEsfKEYcLg/Ob6RfZGYQyMRpSGhL2OYg49gkVyOgIA+Hz1Wcp
         tz2OwchfO6KGKVl9iicWvlj1UAfadNdtN1Txf9nx6PZjY1NlBYbHUOFbsFwOORCZ6AVh
         ekIeKSAPgzwDV4fJvQpEvaSBWNtgozXwgiDYAniTZXnhrEMbobDClkmxGde61dm0PRMo
         6xTWEcuTLApYeuVotWSfoL6gB2JVcJXuqZ/nedibZoOyt2kpl0FEkE2DbpjBPd04QaB/
         BeDA==
X-Gm-Message-State: AOAM530AwP1b0xSgS7NY74lsLrv48FamOilUCDBYg29gDf/JeQKTYxNt
        WI2l5HAqa9RbMJ1fE2wvLeeLlVBNs1E=
X-Google-Smtp-Source: ABdhPJyh2ygfb8uA1z46x++1e1fLtP78VEvPxmMkO+ZPrjZUS8RijK+3EEeBHHct5ZwFxvV70gde6w==
X-Received: by 2002:ac2:5324:: with SMTP id f4mr135744lfh.209.1590620263567;
        Wed, 27 May 2020 15:57:43 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 21sm357922ljr.16.2020.05.27.15.57.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 15:57:42 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id l15so30658801lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:57:42 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr1028ljg.421.1590620262429;
 Wed, 27 May 2020 15:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200527194633.1660952-1-bigeasy@linutronix.de>
In-Reply-To: <20200527194633.1660952-1-bigeasy@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 May 2020 15:57:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi76nv2co86p6qtBbwiardqcZu3xOHWwPqEt-_P+p==0A@mail.gmail.com>
Message-ID: <CAHk-=wi76nv2co86p6qtBbwiardqcZu3xOHWwPqEt-_P+p==0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] workqueue: Make the workqueue code PREEMPT_RT safe
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:47 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> v1=E2=80=A6v2: Use rcuwait instead of swait.

Thanks, both series look sane to me.

I only scanned the other one, but I didn't see anything that made me go "Hm=
m".

                Linus
