Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4198C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF982080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589574;
	bh=+k7C/qwwLHxtgwfWm617WiC6zqONmRvoVFwEBC/ZrEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RzFz8cGBdJ6kD31Z0eCETzWbtZ+02Dj5LGfv9GDLrk6lc5wxyNm1hEz+LkjOmTXQl
	 OsN2TPYE6PTPZc7LgR2cITFmEjudpbvQbKtz67l6VpbjwjCvMSSXyH2yhw7wtU7gTI
	 YbvtcJpFlnclgs9OQJzRPPOf8w0ZZxyn8OP6Lqj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgIHS0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbgIHST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:19:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05097C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:19:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so176815ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4ZG7pHNKJrTC8ewi1bAxI1rmelsYImAuRVz1o61Rvw=;
        b=AdYfsYsp+iKIH8WN3gypyY9mlMeSR1eCJHUXHjzjx3BSS0OC/iBPzRzVULBH6L6iSh
         RrevIvrJ7CAbiyPP2mSYuwOxD6YFOdh7Dttw3IwSvOtDRS9R9zLc5hV/T6Nqo8pMez0S
         6dW9/gN7Ikd2Mi/GEilIJvAWLv+OpE8VCFjqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4ZG7pHNKJrTC8ewi1bAxI1rmelsYImAuRVz1o61Rvw=;
        b=QNA7y6yTz3KxRJsjyYrsHLEIs9lnDT6pl+MPUAX6eNpbmHveG/VgWfYbwBi1+EOn+u
         MQfbvfdhbUolth4J2ZG2Isa9CLiqlKk2ag9cBeJQthqwYEJkMpRDfY3w2X4P0nPwxlfk
         TesSUGb4hKOtgMM1dYNBrnEEkzCqreC73U/db6aD2Gcbpdxj35NW/In7AL5Iqd38O3T/
         BtG9N1AGFsa4uoBjsigVNsPfFET8leSFkpGPOvb7v4OdXDCYMzTauBCrRBqnHhTu/y/+
         PPP+uXGfwB+gDVjYzPrCAR7bxB9ErHEFZVuRf+4QLe2z63nN0IXFOMazqQZ8vnToB40G
         9ANA==
X-Gm-Message-State: AOAM531dvyJfhlq+JgvkZ9BEF920jmtFeiw9k8i7tKUd4mnTLlwnUck8
        z3s7P8/LSiHjXZGuGGYBiWfTMMUFCuvw9g==
X-Google-Smtp-Source: ABdhPJznSSKGREpzspZ8IjUsV5VBmvo8xYVqyiv0JUcTGuBJqvXwpuBLgYgBzbv7iLM12HKAjS7sFA==
X-Received: by 2002:a2e:97d0:: with SMTP id m16mr14022783ljj.277.1599589186684;
        Tue, 08 Sep 2020 11:19:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 190sm69147lfa.81.2020.09.08.11.19.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:19:45 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u27so147582lfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:19:45 -0700 (PDT)
X-Received: by 2002:a19:4a88:: with SMTP id x130mr133090lfa.31.1599589185184;
 Tue, 08 Sep 2020 11:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
 <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com> <cfcea1be-e02f-b391-ab1f-780888da138d@skogtun.org>
In-Reply-To: <cfcea1be-e02f-b391-ab1f-780888da138d@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Sep 2020 11:19:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRLmayxnChONeb24pFPv=o733ptzpAyuAebrxWzhPYtw@mail.gmail.com>
Message-ID: <CAHk-=wjRLmayxnChONeb24pFPv=o733ptzpAyuAebrxWzhPYtw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.9-rc4
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 2:51 PM Harald Arnesen <harald@skogtun.org> wrote:
>
> Still doesn't work without the three reverts
> (763fedd6a216, 9e0f9464e2ab, 7ac2d2536dfa)...

So this didn't make rc4, but it's in my tree now.

Harald, I'm assuming things work for you again now with the current
git tree, but it is always good to double-check in case something else
interacted with the reverts...

                      Linus
