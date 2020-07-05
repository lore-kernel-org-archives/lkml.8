Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990D2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B6820885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BX49XED6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGEBKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 21:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:10:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C1C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 18:10:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d194so13384646pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Vm4HRhvjHhFdTobKM449g3tVhZrMSOdwfZujY8R/hk=;
        b=BX49XED6kLgKZ2llloNkd986iui2sFmeYin1jeehgk2pTKbUwqfqDe8+IYO+6v65OK
         eSH8LREdtMsZKl7Ld4rqEoPZMa4EXb9F8YBn9DRln3JZ+ZeDdYzgk+BRG9l3hFzvPx3s
         /dJBk3IXA2nylMtu0hfsq2SWiv92VZKwQrqYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Vm4HRhvjHhFdTobKM449g3tVhZrMSOdwfZujY8R/hk=;
        b=ENpF+HCLreIw2dHJPriaJZ0WE3vMZHkaTzrG/iHPsua/pDaqrD4pvJBH5SWolO3GqZ
         eSuMqs1CF5IfA3kZ5hVrUmZfUPFCHvc0ttO9+2nsD0aRMN+gJfwZ+lR5WcOVDXLE0hfB
         K/uTq4zTBdTjjapoMrIPvbXrOwWy8tdYLa0GwXhUcPT/UhcN9SWSatM7gWIFHz4SeB9Q
         K6uvd8CO2ov8NWt6HKYrOuzyMvkuOYSCYz2YNN04ZXHlGHEjEA2JKJcaE5xVRViwkMT5
         S4ZEeVDZhT565G56978owLhEpmB3SnCXJ4g8gaYRwsDgZ3Oy9V1pnsTP1xMUDYXApD/l
         pd4Q==
X-Gm-Message-State: AOAM533Zsiywu87sJroPiVyKCMt4q7d8QpJAVWvdfXegWzm54GIZyalI
        2bQHan2OdipBgPMdGZLGUrCXDg==
X-Google-Smtp-Source: ABdhPJya9+b8rK6wZf0FcN/JrMCWTkK0eTwfDk2tA+2jp9upzyqC8kvr8z5dzQAWK4xYzFmMNXiCUQ==
X-Received: by 2002:a63:3409:: with SMTP id b9mr35832163pga.106.1593911419506;
        Sat, 04 Jul 2020 18:10:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mg17sm10385151pjb.55.2020.07.04.18.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 18:10:18 -0700 (PDT)
Date:   Sat, 4 Jul 2020 18:10:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy6545@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <202007041804.B5E229E2B6@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org>
 <CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com>
 <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 08:10:33PM -0400, Matthew Wilcox wrote:
> Left-right tree makes no sense. It doesn't distinguish the rbtree from its
> predecessor the avl tree.  I don't think it's helpful to rename a standard
> piece of computing terminology unless it's actually hurting us to have it.
> Obviously if it were called a "master-slave" tree, I would be in favour of
> renaming it.

(No one has suggested renaming red/black trees, so I think the
slippery-slope argument can be set aside here.)

As for the actual proposal on white/black-list, I've always been annoyed
by the poor description it provides (and I get to see it A LOT being
the seccomp maintainer). I welcome allow/deny-list (though the change is
not new for seccomp -- the man pages were updated last year (thanks
mkerrisk). :)

-- 
Kees Cook
