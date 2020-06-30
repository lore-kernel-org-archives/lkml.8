Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4852073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyc38uIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgF3Wr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgF3Wr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:47:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5E6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:47:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 67so5999278pfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YepCmL6Zy9anQ1sRlkkP9pvK3CUKQhUxGu+AG0KM++s=;
        b=qyc38uIzl7LUPoPWYqmsVtcrkFkEFPYPjRsgow45zKixNGo4PHTtBt3ksWSl7XXu71
         CS/SEVvVpa91HNNzi4tR6UFsh3Co+aQqR8gsykxuPh8O3Ui2uVT4+bgISieRS0xcGydD
         dFIAXdd4MqjONAI2uBn8b7SORUq5ecF+ml7P63tc4jYqBxp9CFmRGclfqC5EXBPN5kSM
         9TcWO0iCKcrv3x908dRs7nbFwlPDzAlWl/93/VfuBfTRQClV1w3pg3I/FJWrJQ6olYtc
         t46Wc9+scrXGJ/C7pmnbxLUVwaqKUlLbVmPYaZs/ghcNWPysFWEhxpJz7zMqKmJrRVIY
         XoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YepCmL6Zy9anQ1sRlkkP9pvK3CUKQhUxGu+AG0KM++s=;
        b=hHMHvgeydyhN2RXbz2tevkicwd8PAeYTginpW6fSjUXQ4gNjlVnS5KP7n8oTNRB9H6
         D4ZhtXxu7FBBu7KoqIb7/yVQR8EfompQylYH/i+3KFv5g4q1bF+1uAf/YzXdX0RRUgaD
         sZW/UekskXujtXejnn6jG9DdMSO7aVAA9soAOPbCvbN+NtZ2b17WLrnLyLEb+L5NyW06
         tVzP6DVCMtDmxhrGq3lvBDl8cLGsHpcbCxe3z80/uBd17eqDFi7HuOV7xIUKmUs5zk2T
         o822x7IzRObqOuw2aYtiXrDYHPVR4OpbmTntd5wMuwBjvl+sTTyOeji5F93mUgFgFVZw
         rJog==
X-Gm-Message-State: AOAM531RFWbmsnaWsrOlWngoWitlBsfxCxzYi3HzIBVSV7ua6Jb48LAy
        vyuUYCn3nmPX54DMPIEQeWls6vTSL7hQQ49Sl5fwnA==
X-Google-Smtp-Source: ABdhPJw7JJySNmuo9piXQaqMMoJ+YGgTgAnqL7wPcGA8UvlcLCGiIkcPsCWMaaoJPHzMB86Xuw4ndPNpgpoy64M2Pnc=
X-Received: by 2002:a63:4c08:: with SMTP id z8mr16421730pga.201.1593557246515;
 Tue, 30 Jun 2020 15:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200624212319.403689-1-ignat@cloudflare.com>
In-Reply-To: <20200624212319.403689-1-ignat@cloudflare.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 30 Jun 2020 15:47:15 -0700
Message-ID: <CAFd5g47asdiBPdkQjTQ3-+Rwn+cE-pp1CcB41aV=bvvBZw2ePg@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "um: Make CONFIG_STATIC_LINK actually static"
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 2:23 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> This reverts commit 3363179385629c1804ea846f4e72608c2201a81e.
>
> This change is too restrictive. I've been running UML statically linked kernel
>  with UML_NET_VECTOR networking in a docker "FROM: scratch" container just fine.
> As long as we don't reference network peers by hostname and use only IP
> addresses, NSS is not needed, so not used. In other words, it is possible to
> have statically linked UML and UML_NET_VECTOR (and other networking types) and
> use it, although with some restrictions, so let's not disable it.
>
> Additionally, it should be at least theoretically possible to use another libc
> (like musl, bionic etc) for static linking. I was able with some hacks to
> compile UML against musl, although the executable segfaults for now. But this
> option prevents even the research to be done.

The reason that we removed support for static linking when these
networking options are enabled is because gcc doesn't support loading
NSS when statically linked, which consequently breaks allyesconfig for
UML under gcc. That is still the case with your revert.

I fully support the goal behind what you are trying to do. However, I
do not want to see this patch accepted unless it is accompanied by an
alternative change that still allows UML to compile under
allyesconfig.

You said that in the current state, researching a solution is
possible? Can you not research a solution with your patch applied to
your own branch?

Cheers
