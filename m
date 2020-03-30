Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B382072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="j3F+pt8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgC3U3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:29:09 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45120 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3U3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:29:09 -0400
Received: by mail-il1-f194.google.com with SMTP id x16so17216058ilp.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wRE9skQiDOyL/NwP++MZjMIXWKMRhzu11GnAjRZxZ0=;
        b=j3F+pt8VEBaTXag4YyMtj/czjH6vJ+cXky5caKr/vsTZB0Zw/llYEDrLRNA3nSiU5W
         Pt2FBpDa4AsPrZwVQ0bsqww17OBPP5xlTKmy07P60DjZ/KAntiULP9lGqudbD0AOfbl9
         mvCBImTFxmA59jftjIzHyhHIdemR04U2NYVEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wRE9skQiDOyL/NwP++MZjMIXWKMRhzu11GnAjRZxZ0=;
        b=IzXBsmU2jEziF/r6fi6pGh955rFsSQWwUGaFT5x5aTLBBpaPknPoloAjZPIle+MYHR
         eLFy7aHskMoK9fAd3XYl9nLJkZuzEo7u+NybKR5C+c1xzi9o7vSe0rdhtlIYNoUUpeG4
         RTmoeysR53HMEeI5i4Wcp9J0Jq9XEUjw05rSTbtiX+tu6h+d6dgTQj4n22P5INgBVldL
         kx8rhYpIBdlDcXSs6rehd5zmuK9ZAzsaWkCox5KvGeih32Y8Jv9NT+SB2tPeA3WOm0dw
         H4zUmBlmy5PcbET34sckH5PAZNRZ3o2nvfeOleEZ6WCp1cvg7Nk964OYkR806T4lrkAM
         GgzA==
X-Gm-Message-State: ANhLgQ14US3iwFh8sS+B31FU6WuCcm5Uj2FRzjFI/LVy5YXZ3/r8Ww1E
        udvcJl8EDKWHPpAgDCeA+1RdwMwna+uQPWuiH2+z0w==
X-Google-Smtp-Source: ADFU+vtRoI7ov8IVr1QxRy1CFyLzeT5qFbKHO3DNdyHr9xLr2wfTu8lvo64ee+deUv4Av2czf29wsrHaPEuUcKx48F8=
X-Received: by 2002:a92:b6c8:: with SMTP id m69mr12262028ill.21.1585600148216;
 Mon, 30 Mar 2020 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk>
In-Reply-To: <1445647.1585576702@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 30 Mar 2020 22:28:56 +0200
Message-ID: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 3:58 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Linus,
>
> I have three sets of patches I'd like to push your way, if you (and Al) are
> willing to consider them.

The basic problem in my view, is that the performance requirement of a
"get filesystem information" type of API just does not warrant a
binary coded interface. I've said this a number of times, but it fell
on deaf ears.

Such binary ABIs (especially if not very carefully designed and
reviewed) usually go through several revisions as the structure fails
to account for future changes in the representation of those structure
fields.   There are too many examples of this to count.   Then there's
the problem of needing to update libc, utilities and language bindings
on each revision or extension of the interface.

All this could be solved with a string key/value representation of the
same data, with minimal performance loss on encoding/parsing.  The
proposed fs interface[1] is one example of that, but I could also
imagine a syscall based one too.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/20200309200238.GB28467@miu.piliscsaba.redhat.com/
