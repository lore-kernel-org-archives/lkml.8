Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE52C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8166A206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="At7oNete"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgAaTzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:55:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36736 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgAaTzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:55:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so9092771edp.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMM4l2AcsKr13k50NYp+NWAp7EWfl4QYfFE3hRDEQAE=;
        b=At7oNeteomf3wB5fyZHm2CWn9mFXRDBhTwh+PUhh5j6de7UIKumKV+jituI0gZxoc8
         byjKzHn3S59DR0+O/1HSZ+TBmFrnpSk8GXxA+Sj0oFQbMvF5+miDEiGaArrwjgbLm8wK
         du2K4KReYZQvBN5lVGwkBxrCTh9zZppkIkkm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMM4l2AcsKr13k50NYp+NWAp7EWfl4QYfFE3hRDEQAE=;
        b=H4do/f5tlpMGB6jatZXkqZi8DmpfiDkB+S183nT8333BW9pLasCU+/vqXa/wE4l/Tr
         QCjDceEdxW4z8TlChQDe15+bOlmnKvkE+S6zktMFg3dzfJpYH24/h80O2A7qe29NNC36
         rjv4bt49KPHHzGNfXE/mnq+tsdX+hY227OJW0e02uD1S6kTVcTuZHOgnZkvkuSRTlw6J
         Fcq/qsdgjasdmkSNBsoNzMV9/cOXpSmvuxzuEMj6JGPj6OtrYsaYObsd15ibcnK2aAKX
         5jgM0iKfC1K8WoEl7FVw/Nn/ArUyG+JsVj57kfCoNlYvKIZ1XzBH+oIZUDSSr4ntjzzv
         GvoQ==
X-Gm-Message-State: APjAAAWyvwo25qgaLz5AWHKOxtreIyscw4nb313B5rk+99oCM9ceo9Sd
        KOQNqnmrnhWxHpWg2q5VJ8/DT2dMJE4=
X-Google-Smtp-Source: APXvYqwt9HcZY81TL3H4qxJWrQQ31Aq18vlRhZVWos8oRzhGxjiGMGrQMRqGredSciEiTC5jYT0sFA==
X-Received: by 2002:a50:fd93:: with SMTP id o19mr2004875edt.28.1580500530217;
        Fri, 31 Jan 2020 11:55:30 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id i11sm534607eds.23.2020.01.31.11.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 11:55:28 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id dc19so9027050edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:55:28 -0800 (PST)
X-Received: by 2002:a17:906:7d5:: with SMTP id m21mr10793134ejc.356.1580500527743;
 Fri, 31 Jan 2020 11:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20200131002750.257358-1-zwisler@google.com> <20200131004558.GA6699@bombadil.infradead.org>
In-Reply-To: <20200131004558.GA6699@bombadil.infradead.org>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Fri, 31 Jan 2020 12:55:16 -0700
X-Gmail-Original-Message-ID: <CAGRrVHytokoWWok8uz3vVHuEn3bOkedc5pS1Lk3k4UtUvwPZig@mail.gmail.com>
Message-ID: <CAGRrVHytokoWWok8uz3vVHuEn3bOkedc5pS1Lk3k4UtUvwPZig@mail.gmail.com>
Subject: Re: [PATCH v4] Add a "nosymfollow" mount option.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 5:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Jan 30, 2020 at 05:27:50PM -0700, Ross Zwisler wrote:
> > For mounts that have the new "nosymfollow" option, don't follow
> > symlinks when resolving paths. The new option is similar in spirit to
> > the existing "nodev", "noexec", and "nosuid" options. Various BSD
> > variants have been supporting the "nosymfollow" mount option for a
> > long time with equivalent implementations.
> >
> > Note that symlinks may still be created on file systems mounted with
> > the "nosymfollow" option present. readlink() remains functional, so
> > user space code that is aware of symlinks can still choose to follow
> > them explicitly.
> >
> > Setting the "nosymfollow" mount option helps prevent privileged
> > writers from modifying files unintentionally in case there is an
> > unexpected link along the accessed path. The "nosymfollow" option is
> > thus useful as a defensive measure for systems that need to deal with
> > untrusted file systems in privileged contexts.
>
> The openat2 series was just merged yesterday which includes a
> LOOKUP_NO_SYMLINKS option.  Is this enough for your needs, or do you
> need the mount option?
>
> https://lore.kernel.org/linux-fsdevel/20200129142709.GX23230@ZenIV.linux.org.uk/

Thank you for the pointer.  No, I don't think that this really meets
our needs because it requires code to be modified to use the new
openat2 system call.  Our goal is to be able to place restrictions on
untrusted user supplied filesystems so that legacy programs will be
protected from malicious symlinks.
