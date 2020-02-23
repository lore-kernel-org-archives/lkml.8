Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9551C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC86A20707
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424117;
	bh=lRts9Xv2X6CbQoQoDJEu9osQk2IUMJAfuMlzHZi5OuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l+FC3GWNxmgi4BVRw+/7WnnIlnbHkkFfTnQuKLo9UsWuHEVri9Vdgh1T6UenWOUEE
	 yn+QD6IajJbiAsPT0LsM1hOQaT6SMfX2SIZYp8vRs9gW9iw7lU8guVwfVTv5yEdlVq
	 pR6VZzK8hcQQ22Yu6k4MfXY+GiIQHVdZrZfg66Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBWCPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:15:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43934 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgBWCPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:15:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so4287190lfs.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usCPDZzqoEQffaBHKz63gbophNqdIvzMOB5/yaDj3Ek=;
        b=Ft335B/q4kOGEdbWJ0HffT8n8Ks0hvRKKjTvQ3F6wbdJ99TgY+eIt6+6Fy0GK774yr
         tYPrBAkT6L2g0sIK/wKLCIs8tAZgXl0SjKxSY3CbR9SbAlgPerdD0j+hCaheptaAknOt
         +y1EqTRtlN7zsr7V1qD6Wtb4ddO2Rwm46DDMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usCPDZzqoEQffaBHKz63gbophNqdIvzMOB5/yaDj3Ek=;
        b=Bm2yvC33kbuUmI76ZI6Ny8yiCClTEqKeHVcEIcCZUuEfAppXfVd67JAaBgBY5XV9jC
         EKa3NUIZYlTMof3R7ZIzjaATUWvXoUrZAPhqwvrX8jrq31hE8jieeec5rJpjA8tDITvv
         MHYgRIFUSeNgI28zGvhbK3ZFLHoo2zTfajGbBSQFsSv8TRb+HVwencURlOJ8fa/0flhF
         5z98S+8eTEjvuSX5JRlbxP51y9HNss1voNabbXWkXZJqVBFbQLX6iDCHRwfjERF6g/kz
         iyHfQYCMsyPSNG73pfPS+vuwYWV98NYr1bjY2rVSsjhViaqQKWst6+pIZbTmlYr/s8Hv
         ntXg==
X-Gm-Message-State: APjAAAXUHtrIJi6UVY1EAbG2d2oTIeB6NytjDBGJVmxcKYU8N3tnepIr
        Y1svtifhro65eowRoZisp0KaWG30oAw=
X-Google-Smtp-Source: APXvYqxj4+J5b1J7Q1AnVzKeeLNABtfvGoWpkTSg0vDPuIz3TMSm1mJ2VxhUH9q1PJIP44nM1HjBJQ==
X-Received: by 2002:ac2:44d5:: with SMTP id d21mr23611745lfm.188.1582424102172;
        Sat, 22 Feb 2020 18:15:02 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 14sm3928028ljj.32.2020.02.22.18.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:15:01 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n18so6214790ljo.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:15:01 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr26872226ljk.201.1582424100766;
 Sat, 22 Feb 2020 18:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-14-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-14-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzmY4RdkqtitWVB=OJvHG-8_VLZrU1oXBX8b+5qJKBag@mail.gmail.com>
Message-ID: <CAHk-=whzmY4RdkqtitWVB=OJvHG-8_VLZrU1oXBX8b+5qJKBag@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 14/34] new step_into() flag: WALK_NOFOLLOW
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (likely(!d_is_symlink(path->dentry)) ||
> -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
> +          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> +          flags & WALK_NOFOLLOW) {

Humor me, and don't mix bitwise ops with logical boolean ops without
parentheses, ok?

And yes, the old code did it too, so it's not a new thing.

But as it gets even more complex, let's just generally strive for doing

   (a & b) || (c & d)

instead of

   a & b || c & d

to make it easier to mentally see the grouping.

               Linus
