Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3A1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DD921D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUDAZHWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIJVMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbgIJOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:32:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72CC0617AA;
        Thu, 10 Sep 2020 07:20:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so6530339edv.1;
        Thu, 10 Sep 2020 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqYP69u6EXo/SysyWBW0+nlQMG0J6Ocm49GIaUZelBo=;
        b=bUDAZHWm9YF4plGhsM1Nza1WuKrIrg3kVvCIilsl7y96mCWYP/2edjQVFXlzqm3LqA
         z1x0oHSkiWBt5dCCVloB6KxbVuT6zXqQ7NoRmvRoQQk+0nGhemZ4vL1XItmz7eCQwCIk
         O4zJNB2Vw4K/+ywSpq+x4ByKQ9pV5wFVdvj9E4SaLWJlriRaONdbZbF5IVjwQH8rB5z6
         wmMRd4LQzwo7OHoFvxxpAblyj94sW+WzZiUhNtOujX9L3XDfPjiPV/yPq9BF/W6Dmygy
         w3Rs/8EK5FAhW2k3Iw4IUDJL09YJTyi7yT0rXZqqH+6oozTtBDZoVDWMOjoPPNu5C1+x
         ArWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqYP69u6EXo/SysyWBW0+nlQMG0J6Ocm49GIaUZelBo=;
        b=ufhuVXPdzBnXaXPNc43K989KJFpD+pCNFyAXx1fd9x2T6VoExGYLJ7eVbtR4DZByfW
         HeRVTBQ9vEoYe4z40IZhHWTa9SnbMC1L0qmJ9yZQ0so+msgx/doE01pgxVDJUULrRyet
         YujIYB3u0tt4E/tF7vV0k32Cf+gozcXNdWGIaRWnk3ckKXXoivkpv0adC1ZuXSdSKLuP
         0LFy6DADk9dErJsRL8/+g+TZDcNb81twtbjX3LFTueBG8ILlpHVAZYJIUDjVUeILNPQm
         FkBsbXGco3ZiUrA1TKsLY/wyly0GhZOAGaJqNC1eQGEliQjSJcPoiWzxURxOyysGJFZ6
         8A/g==
X-Gm-Message-State: AOAM532EQxnKTWtCXIy+ij1Wjm7TCDFZK6G7P2d50pIcWZedUVgyzbn9
        C8KdpdaOEzPq335FVuShfxkosNVnrmGzmVfwkkvZ66OWBRI=
X-Google-Smtp-Source: ABdhPJz1awMw7XZ11QjIEJ4q0d1xkTs1E/NS/8CmOFBaVYYqxRVkRHSm8uiDeK4OOuiOKf9v4V/YZ0XXO9+OvrdlPy8=
X-Received: by 2002:aa7:c504:: with SMTP id o4mr9794775edq.82.1599747646976;
 Thu, 10 Sep 2020 07:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
 <20200910134040.GZ1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200910134040.GZ1362448@hirez.programming.kicks-ass.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 10 Sep 2020 17:20:35 +0300
Message-ID: <CADxRZqyQo5XhMeyGy2regB4rcRp6tm4DLd=LK6DOJ=c-RTmHww@mail.gmail.com>
Subject: Re: [sparc64] kernel OOPS bisected from "lockdep: improve
 current->(hard|soft)irqs_enabled synchronisation with actual irq state"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 4:40 PM <peterz@infradead.org> wrote:
>
> On Thu, Sep 10, 2020 at 02:43:13PM +0300, Anatoly Pugachev wrote:
> > Hello!
> >
> > The following git patch 044d0d6de9f50192f9697583504a382347ee95ca
> > (linux git master branch) introduced the following kernel OOPS upon
> > kernel boot on my sparc64 T5-2 ldom (VM):
>
> https://lkml.kernel.org/r/20200908154157.GV1362448@hirez.programming.kicks-ass.net

Peter, thanks!

That fixes the issue for me.
