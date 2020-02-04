Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B49C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5A2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAsE2pvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBDWLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:11:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDWLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:11:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so167674eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1c8Sx/+v2lfjleperyhTLWYQbP5AjrZMIJnYtSmPQU=;
        b=JAsE2pvS4+eX7xyYLMmX23TdtQBQmxYCgHdJ21FAV72iuMv8HzM1+LlI1mpCrxJMIs
         Z1Y8Jctbh8mly6rjWTfp6xJuCiS3i3bw4WSoQ7hc+Nw+j58Wcw0Ed7wph4rQhruGbfKe
         /RRfs9+p3C3rNRcC3Md74U3MqKJidO7e/0Ro4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1c8Sx/+v2lfjleperyhTLWYQbP5AjrZMIJnYtSmPQU=;
        b=VI9A1ecwPcFdYxABuj3T2jpqURw5TITMq9drH+3/WImY9kd2bcAyTjVzNoRYD/VUTG
         RwZ4vlFaVNArPXIBkp+mLd+8UzXJZOiDUv8GAViPFkaPdaFbhQxptJr9nhvNi+YGldUO
         FEYx6NecejbQySb6yByFuOF9YY8Oq+MeoQl+LoEQHunJ+fhyWNLAzKLTbWhYjPu0QoPi
         CB5Z8psuByQGtNQXD3iww9N2RezcDJsfJZSvWxTEWr8xp3XFJAP3NT6HBM1ADd9iJx/q
         80IvHw4JyWnyny9NJqxfVucYpU4C+PbmOM1m97ocRo1iyatP4BuRUHRWnonYkQ2f+hxw
         4/Uw==
X-Gm-Message-State: APjAAAWx4rmqY8bMuTZ896F1ir+h7LY+mBtEyDOHNO7i47g4Q/APVFgO
        t3SVCBEUjuL7VV6yclWlhNzHt+lcg0A=
X-Google-Smtp-Source: APXvYqzp0pqY3MYG2HmGFDAiAl7Pl8qSrYWMMrwm+/dvzdutnzusZDBFdCwdA639/2p3KVvrNJIbKw==
X-Received: by 2002:a50:ee96:: with SMTP id f22mr2325191edr.272.1580854279535;
        Tue, 04 Feb 2020 14:11:19 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id da13sm1141596edb.63.2020.02.04.14.11.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:11:18 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id c26so183837eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:11:18 -0800 (PST)
X-Received: by 2002:aa7:c241:: with SMTP id y1mr2375799edo.354.1580854277802;
 Tue, 04 Feb 2020 14:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20200204215014.257377-1-zwisler@google.com> <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
In-Reply-To: <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Tue, 4 Feb 2020 15:11:06 -0700
X-Gmail-Original-Message-ID: <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
Message-ID: <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
To:     Raul Rangel <rrangel@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > --- a/include/uapi/linux/mount.h
> > +++ b/include/uapi/linux/mount.h
> > @@ -34,6 +34,7 @@
> >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> Doesn't this conflict with MS_SUBMOUNT below?
> >
> >  /* These sb flags are internal to the kernel */
> >  #define MS_SUBMOUNT     (1<<26)

Yep.  Thanks for the catch, v6 on it's way.
