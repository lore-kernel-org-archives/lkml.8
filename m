Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FBC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99182071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587923136;
	bh=pnOWcpSAiDStJDqUiHUWzsC7iVRGv+lYjVOWuy5yegc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=otbzfO1hTUxrO7oszGpmP/PojOV0zsIVDGxbBiA37WxC5JrbM83xnD0t6iySwOr7t
	 V5wHSRR5tQU/KrF5LPQA5L0/BHaOM2+kJwemLO1iqqXJnk8SN4ll0F5Hrze7wjzyoC
	 U+Jm+NjrcsguaC+eoF9zZkOLV5SzHAIc0+rTkWGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgDZRpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgDZRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:45:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CD3C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:45:34 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so15158229ljj.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhfmNbpoua12nkQLRWqMQ42xHqPthmCD94K/R9Vvam8=;
        b=WN7+F69IoVGLnPR+mBfmh3Lh6UKj/N2KdBRpP4wMiRNr4Xk2F3InWJpHcOEqo5IH3l
         tV1r3Y7GPftgLkQUDIer0xAI9AAr6SDquCRsKrogBfdD9BZ9z8mQK0MvMuYGisjKYJL5
         jvv0aAg6kOuGa3VKh35adzvWUgIYxPtga5eoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhfmNbpoua12nkQLRWqMQ42xHqPthmCD94K/R9Vvam8=;
        b=EumLR2ZVS/abtm2IjWxr5uRKuC1tbkow8ge/TOEhqE1yjD3NtTCzMzykLLzt6XvOdw
         PC73s707VbOlKnWYJ1O7010Z0bvcZ18amfjySJ4p0+1XsmAMOvYRuAZ92bf5jpr1249R
         ekkC5HGT48mQWPatxC1M4GEXmCoEiAhqbSpCii5qbrGZQO+TKl9oc2wKq0HTGR/SnkPx
         pKX64s3WG9AiBFypUNRI1yPpWpz0bToEMabZsns/BpsGi2KdBJuIqgLB2nkvsxJntlth
         ZbWbCNYz9lwfUcE0/NDlOTJRMjAepSU1PW8LIcOtDmd0eILwzWymP2n0nTw43McDtLf4
         2qyg==
X-Gm-Message-State: AGi0PubaAjUvIBpzvIqWQEkW+TwqsdsDgX0ZvbkETsUBBXCEWjVDZO+h
        F9MXMOTnxaNJl9oH4mjjXDWNSJ8ntY8=
X-Google-Smtp-Source: APiQypJd1jCY12wlicr3EijS93MqNPSCZDvSDExVF0CWhAR6tdL/BdISIWbDNo4pp/MIwVdIFH655g==
X-Received: by 2002:a2e:82c7:: with SMTP id n7mr2425388ljh.47.1587923132705;
        Sun, 26 Apr 2020 10:45:32 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 25sm9404907lft.68.2020.04.26.10.45.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 10:45:31 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j14so11857617lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:45:31 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr13109086lfk.30.1587923131294;
 Sun, 26 Apr 2020 10:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ea_CtRyP9KtpJDjpEzobRyhrodiycDCAxhLbCjuOwhCQ@mail.gmail.com>
 <662aa817-04ff-e924-6880-7c23fa1cfe31@cn.fujitsu.com> <CAEemH2cF-kziNEHuN1GayTtzwdxFFzsu0wRGB85yJ=LaKS-XBw@mail.gmail.com>
 <3268f153-6730-708f-ed93-19ca4cf85fdd@cn.fujitsu.com> <CAEemH2ee7c55=EQb5qohpu40XMACSOCrSStwWt7u=_GyqjrxLw@mail.gmail.com>
In-Reply-To: <CAEemH2ee7c55=EQb5qohpu40XMACSOCrSStwWt7u=_GyqjrxLw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Apr 2020 10:45:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7u4AjZQd49VjrZXikDMfK-HchOKHYqoUFwcXjsbJ3XQ@mail.gmail.com>
Message-ID: <CAHk-=wg7u4AjZQd49VjrZXikDMfK-HchOKHYqoUFwcXjsbJ3XQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
To:     Li Wang <liwang@redhat.com>
Cc:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 4:59 AM Li Wang <liwang@redhat.com> wrote:
>
> From kernel code seems you are right. The pipe indeed takes use of PAGE_SIZE(ppc64le: 64kB) to split the writes data in the packetized mode (marked by O_DIRECT). But in the manual page, O_DIRECT indicates us the PIPE_BUF is the correct atomic unit.

The manual is correct.

PIPE_BUF is the size we _guarantee_ can be used atomically.

The fact that in practice we do have bigger buffers on some platforms
is an implementation detail.

Yes, that implementation detail can be visible, but basically any test
code that tries to test for "what if we use a bigger bug that
PIPE_BUF" is buggy. It's simply not guaranteed to work any more.

O_DIRECT is kind of immaterial, except it's just one of those things
where the atomic size is slightly more visible. But basically,
packetized pipes with bigger packets than PIPE_BUF is random behavior.
It may work. It may not.

                Linus
