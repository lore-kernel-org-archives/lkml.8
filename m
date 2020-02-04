Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C5C3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1465521582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AqM0nw1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBDXuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:50:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35567 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgBDXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:50:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so418699edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSlSCku20FStpOcQykOPLBXpgF1lEZfJUZ3xezTMXUk=;
        b=AqM0nw1eNjCw1+k0Q8gPthLOiplhEcyUDU1L86hW5DIcXaKozOr4BXTLWPs0JHGhhF
         alVySvV9VMo6EtoIdVq0nb41lFaCoZgWXwhoq+I/tYIJY/N3OL1zIZtahG1+9xv6fB6w
         raQiSGMOHrtUYsg9QkqlUDluzMpH7EkTmyzV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSlSCku20FStpOcQykOPLBXpgF1lEZfJUZ3xezTMXUk=;
        b=DkqivSe0/EGOMmIbiu+8uRz8HBR7G+qMzHztUeUumMTKjJA9wdd0Dd7MVvPLtdP0iZ
         ILC8FlQdcIMN7c38wDRHosxzlnqNg/zHswOQ8qtgkZsLXF8PXomVsZRZNRy3fN6tyNAi
         Re/AyuhqgJeLE+aQKqpNVVRYbBHMYTty46LcB41WVDiloJnBAJQGV2Klizozlq7Cg7OW
         Xf5ghmV9qok7Rd85Lck71rQduyIDWgIDuPc+9lne49+bf3G5wfggunpYo9yDukonZMaD
         sR3Jn4BTNQcNmAQ2nhCAWGWcACBptnl5jmFctQKN27vroznfQe8oeT35FZjbJ4qxYuvt
         mRGA==
X-Gm-Message-State: APjAAAXUVjDJNoToQexlt1qBwcVkFhlT0IEvAUCD8/BHgdmHKgR7e014
        vCq3vR7QMD2Nxn9PkIjfQtUons+im2A=
X-Google-Smtp-Source: APXvYqxRXEvWvjb9uAjDXH7LbQYL3QTHtT8C3B/4f7nSKAO2AYyOhSOhxvyB5z6+UQWi9Gj5TiUgLA==
X-Received: by 2002:a17:906:f158:: with SMTP id gw24mr27669554ejb.315.1580860201192;
        Tue, 04 Feb 2020 15:50:01 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id c19sm1467756ejm.47.2020.02.04.15.49.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 15:50:00 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id cy15so410097edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 15:49:59 -0800 (PST)
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr3824734ejb.35.1580860199474;
 Tue, 04 Feb 2020 15:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20200204215014.257377-1-zwisler@google.com> <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
In-Reply-To: <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Tue, 4 Feb 2020 16:49:48 -0700
X-Gmail-Original-Message-ID: <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
Message-ID: <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
To:     Raul Rangel <rrangel@google.com>,
        David Howells <dhowells@redhat.com>
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

On Tue, Feb 4, 2020 at 3:11 PM Ross Zwisler <zwisler@chromium.org> wrote:
> On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > > --- a/include/uapi/linux/mount.h
> > > +++ b/include/uapi/linux/mount.h
> > > @@ -34,6 +34,7 @@
> > >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> > >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> > >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> > > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> > Doesn't this conflict with MS_SUBMOUNT below?
> > >
> > >  /* These sb flags are internal to the kernel */
> > >  #define MS_SUBMOUNT     (1<<26)
>
> Yep.  Thanks for the catch, v6 on it's way.

It actually looks like most of the flags which are internal to the
kernel are actually unused (MS_SUBMOUNT, MS_NOREMOTELOCK, MS_NOSEC,
MS_BORN and MS_ACTIVE).  Several are unused completely, and the rest
are just part of the AA_MS_IGNORE_MASK which masks them off in the
apparmor LSM, but I'm pretty sure they couldn't have been set anyway.

I'll just take over (1<<26) for MS_NOSYMFOLLOW, and remove the rest in
a second patch.

If someone thinks these flags are actually used by something and I'm
just missing it, please let me know.
