Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F44206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591144817;
	bh=NlD2jPn6cNNUUUVK/+NlBV7fX7kuzjOImjXcrhUam6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wzKE0pQYNDTBGqSCURH7I0Jj0iT6io6ykOeAAg/HVrYbwxGg8VaUXqHtD2yHMV3mZ
	 VyIRkUeXSUhJeKb1ZDlwl+/ioXWwV5gb/M2EEJzD9w/Tx43QC4IXo1BnQXKjvXxVYL
	 7JM6KmwMhtacuMlhdDXbNUqWEYNnAq31Nt304eP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFCAkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:40:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0167FC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:40:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u10so504565ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kGoCBA5DS7Gg4RTq4Y1cfvZFri+BwLVI8ih5oM9KhU=;
        b=FhGbMjiAPRBLkoRndyuewftQbr/2riV1V6xUqNHXLmfjq6YYYV18bLVRze+Zx84ghl
         D8ZtzBj8a2JIDjPYUE0PTf2ZQ1+G38IqMhyOu0NOsuLpvYUvHU9eERiOVjdyd0J/vfK5
         DDc0mrXlp/lSaPnLyCJHdubQL3qRfzCvvrMKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kGoCBA5DS7Gg4RTq4Y1cfvZFri+BwLVI8ih5oM9KhU=;
        b=G6x5Yeng2aATmjG+UGNOdR9wgyeMS9QcVXZt17CXzuGYyeequ9gVyszbi5ifsaU5Rg
         jJi9L2MSamc7NbqY0YwPnhwYCIW2brLuPb7vUNeIJ+AXiLMAyqzuURlyg4tXIebJVRuK
         NA8bIRuWhKcLWj5sMtxjAoRaxqONYkgU+aOw3gpr+29Fa4Ac3aDzrgV2swCq9O4OLxr3
         bt1VP3dVeSkY585yuWwMz/MKEJhCPwhEkR8UY5nof5wA1RKaZxIrjPcfLPQbE04E8SwN
         yJObr1kn7AHnRIwN3/v7LvV7GPSxQaM/xOrkYjGV2FC9dpEFKIshWg8Ue15UsfiOZLnn
         IUPQ==
X-Gm-Message-State: AOAM531xJezVh13xUIBkLABdTlMX/JGfunB3FjPZtrDfyjSNZg4na7NI
        Ye0B70YlP7/BxuvCBa72nDOBZS8osRU=
X-Google-Smtp-Source: ABdhPJwAvwC2ckvbjvDms7e92ZbbB/hnUi8tChi6xYq9EMMzzN6z45j8BrFy1rlMo63vCGRgEXdxUQ==
X-Received: by 2002:a05:651c:1207:: with SMTP id i7mr752426lja.86.1591144814007;
        Tue, 02 Jun 2020 17:40:14 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i8sm159252lfo.62.2020.06.02.17.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:40:13 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id b6so552427ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:40:12 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr713504ljo.371.1591144812598;
 Tue, 02 Jun 2020 17:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.2006021212490.12446@namei.org>
In-Reply-To: <alpine.LRH.2.21.2006021212490.12446@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:39:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5hZ8BPKMAK4OhXCrRNvZ=43gE8j=LGX_urGUgbdcqqg@mail.gmail.com>
Message-ID: <CAHk-=wj5hZ8BPKMAK4OhXCrRNvZ=43gE8j=LGX_urGUgbdcqqg@mail.gmail.com>
Subject: Re: [GIT PULL][Security] lockdown: Allow unprivileged users to see
 lockdown status
To:     James Morris <jmorris@namei.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 7:15 PM James Morris <jmorris@namei.org> wrote:
>
> Just one update for the security subsystem: allows unprivileged users to
> see the status of the lockdown feature. From Jeremy Cline.

Hmm.

That branch seems to have sprouted another commit just today.

I ended up taking that too as trivial, but it shows how you seem to
basically send me a pointer to a live branch. Please don't do that.
When you make changes to that branch, I now get those changes that you
may not have meant to send me (and that I get upset for being
surprised by).

An easy solution to that is to send me a signed tag instead of a
pointer to a branch. Then you can continue to update the branch, while
the tag stays stable.

Plus we've been encouraging signed tags for pull requests anyway.

              Linus
