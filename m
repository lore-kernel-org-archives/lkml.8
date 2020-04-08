Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314CC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4F220771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586366806;
	bh=sV0ecLe67alt8oNkGOCjdtD3ROJCQhtaujwTUBGIxdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P+keW2PUkS/CZ8Qk6gZcyFGz9cP+YmsuTr2NWwj5xhOLd5C5MSBTjcXcHuGLQpyJa
	 i4M1PtFue+05V3Dp+6Tu/Qkm+nYCfZDpHv7XlbQJFrqFRnsmQ/NQMhOYmKrXkZ58jQ
	 IOuTBAiF+ujJrSEXzJk+7RzgvYKuKL4yWyE79XAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgDHR0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:26:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45268 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgDHR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:26:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so5727553lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRhFElbNkEBmxdkpnBfQNo7aVC1SDQkWmyCC9X/mFOQ=;
        b=RHVkLHA1gIc5Xs2OwyldZxxfTZvWVOhMitapxtU7Cl49awp9OXaxENsk1WAcFgmMYo
         U5oP2n1/ivDJWH5kBdHA3lWoxC/fk/RCzMVL4lWVeHtMm3UayC6wNQXOUvrS/gGxqQDC
         dXsB/7UQRS1iPCO1Z06G6NEFOm5kcaNj/q87M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRhFElbNkEBmxdkpnBfQNo7aVC1SDQkWmyCC9X/mFOQ=;
        b=jknMKz6qtkkOw/xiTS+jNeEyQYdzocvNk2Z3lMJe0exlyJflN30rxDSessNGKxF9Dd
         LGnNmmvrZ00KQ5QGQQm4MR/9y51EKgebdPmpkBMD+QUEYzV2A0VMDfb+KiXRaZ+oDBlf
         9D8Moz04mG5NIGTQTIEGa3cby2fnJIk0aMJajMt5f8Y3jx7s3d1C1ecfdwA8jRQiIa/B
         fXPCM6pWWred4AZ6RS5HvdpxMXB/YMWrYTnv29+CjsDCeuZaDubxjfDzEF86bd6Scj71
         oqAFreOKV6NwJ7qqx6cO2D2ePjFNCp1kVI3WWYn/RKUhhEag5QUT1QB2InTfybKIU4d1
         /eWQ==
X-Gm-Message-State: AGi0PuYOGqRN25C0R8awn2NzuDmg6bo6zjFVKU14qcEfztKJyKZpqbMM
        3gBVvp+6NiN4yyT07y+pj8KmLL1elPY=
X-Google-Smtp-Source: APiQypI5bp51vgqjEq99BTOgbk9FZVqyIOzMxn8FA52Lwn0AZHW2Y4JszGNrVs/9lJbWC23kS9Bjqw==
X-Received: by 2002:ac2:52b9:: with SMTP id r25mr1974558lfm.133.1586366801157;
        Wed, 08 Apr 2020 10:26:41 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m21sm761605ljj.56.2020.04.08.10.26.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 10:26:40 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id f8so5727492lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:26:40 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr5276110lfl.125.1586366799615;
 Wed, 08 Apr 2020 10:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 10:26:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtr6spGYmn9XFxMNBu=+v3jXz=UyNg3KL0VaRabAcyqw@mail.gmail.com>
Message-ID: <CAHk-=wjtr6spGYmn9XFxMNBu=+v3jXz=UyNg3KL0VaRabAcyqw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] exec_update_mutex related cleanups
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 6:32 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I will resend this after the merge window for a proper review when
> people are less likely to be distrcacted but I figured I might as well
> send this out now so I can see if anyone runs screaming from this code.

Ack. It looks sane to me. I had that one question about a further
simplification, but even without that it looks like an improvement.

           Linus
