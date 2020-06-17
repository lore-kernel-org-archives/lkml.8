Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5108C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7470121532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC4Q7nmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgFQNdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgFQNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:33:11 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E9C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:33:11 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id c1so1356619vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTqaTkfBEJNdDtwOMT4r6+BJgXb7m5WLotnwfVqPg5s=;
        b=CC4Q7nmJnWLQT7rqxXtQyAge6sKG3krsrNAsBWHV7qNTGiCt+PrvXW4Thhago31Yi8
         mXAWyZp6VrjLO+lZO0Xiss4zOcctQwZ98Ob6iEVwK3NgVJEu6hXyaD4z8+0hIIVucvfs
         Rb64c3hyuCYCNA2/WfE7y3VcoAxraae6uUTrqXQL8xfB29xUWuf1pkgyK9qDyxXZ1EWR
         sVakhNpT1DdVTmfU+LxdEFlLl02FVAKeAZri6Ub1icjUbV4eUZq/bw9wYX7Nj6g1Y5+J
         Mfez1mrnL43ahAFlfpcp5OD5bwc64e6y2xXMPiWc0GWo4wXioZOIzs+4yt1x8cr07Ot7
         8xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTqaTkfBEJNdDtwOMT4r6+BJgXb7m5WLotnwfVqPg5s=;
        b=dsan6Yyiluzcdnijromkr75zWxWerbjl5Z95cjgTENU7tnIIsKyzXdxO642IV56EEA
         rlsiqkzhOJPbZtNo/X6/3XMFd9Cs68MFPkNyI5fQEP1CiQRVyrC9z9YJGnLarebKPr+K
         Hcb3LDxTvpCmtJICdfupjmGqTgQGJpuPgop0vU8LuwKuZqSh16UeJ5sDD7Dgoh80WeUu
         RH9oO6xXWTE5rJ+GNeHEHeBHFsbQwO4aEvngyM3VQbcLn6fsRST8LqEEIm/c8VvL8AvN
         EtgmkgdjwL345IoN4Eh2q87EqdTwyozvUT6NqcmQFVlYYsIUchDkWGBUovXK2PoCKbO6
         TyxA==
X-Gm-Message-State: AOAM532Tq2ZPbwcA4TPkXKfGplY4kPdQRGVg9pUPqMDRzgiq1c0pTak0
        dvn7zZRn5DXxHVgJ8BU3YAx2T8BkbBMjYizW54c=
X-Google-Smtp-Source: ABdhPJzivxNua6clGrscDh3vqjap3QKsvaZI38ohEIdwMwu8lcy9aTNCQ4nrIJ9sUaQsvB4IMxNxg4Tcyr2fyjKbduc=
X-Received: by 2002:a67:c511:: with SMTP id e17mr5514458vsk.210.1592400790301;
 Wed, 17 Jun 2020 06:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-20-jim.cromie@gmail.com> <20200616115727.GN31238@alley>
 <CAJfuBxwmMNzt6ffQkYX7vU1qRa12=mCbO9T4SMzF7RXV5UwkYQ@mail.gmail.com> <20200617121156.GV31238@alley>
In-Reply-To: <20200617121156.GV31238@alley>
From:   jim.cromie@gmail.com
Date:   Wed, 17 Jun 2020 07:32:44 -0600
Message-ID: <CAJfuBxwip11Ps_0HYTDqOTNsjixFFP_yTPMV3ca8f7vak9AWqQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] dyndbg: accept query terms like module:foo and file=bar
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Petr

> You made to do some research and I was wrong. For example, getopt()
> operates with options and their arguments. So, 'keyword' and 'arg' names
> look good after all.
>
> Well, I still think that only one syntax should be supported. And it
> is better to distinguish keywords and arguments, so I prefer keyword=arg.
>

hehe, Im gonna cite some RFC wisdom to convince you  ;-)

     Be strict in what you emit, and permissive in what you accept.

I see no potential for real ambiguity that would override that bias.

thanks
jimc
