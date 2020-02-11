Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C2C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1791A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k6I0EA00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgBKKz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:55:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44206 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgBKKz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:55:57 -0500
Received: by mail-il1-f193.google.com with SMTP id s85so3028112ill.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ip/rGfkF7G/a6O30OvCDbXytusxYnQXnVEqCr+9FAQ=;
        b=k6I0EA0094zzaaYZwbZeS99DaTzpQusIutEmeqRj1UtEdjv0Vh3LOf6XO1D0Bm/peU
         5D5r3PKLynXB0MvhlV0ILEuPXhlx0Z/pp7Zu4XZGdcRfCKrwOliMh7ZPi4sedDdBcid/
         zqQBSheUtB8mg8pvzIlBj7yOuJb19GWr7//Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ip/rGfkF7G/a6O30OvCDbXytusxYnQXnVEqCr+9FAQ=;
        b=WSTUef2nJ+YZu5t3cNLLdL8R+vjHtsibalI+ijj8hm/bE+V3NCCAi+iqcGpBuqZgR0
         ivKY3KfWmG8rtxYCrBUlHs8t+5IM35lcB85xVrmrhZkVzOKZOdRvrda6VQchMfDHT1Q3
         /Dad8RkIMh1d4T8nO4erOLn2zS+ksbXPfm29DVKobR0pDYRLy2EGX8B2tLOwOtao9zr8
         y01BIiHjGxKpbF/ZOcdKv8HwDZioiw8U9wah5axNFY0DksKukQoRzwcFiEWGv/jLcw8w
         Ab4Yhu+cZ7NkQZg8Av3R6Uv/kx5Jgu3A3jkElr9nO2ehh+2j03ORxW1fvQDiE3eIrb9O
         EbEQ==
X-Gm-Message-State: APjAAAVMvEoh7HUJxgDH4BxXcgXyDl/0D8StsxijKu+vUkb5hOuIDic3
        7OSWff1wZQ4ug+hp86tbryvXGv1sqhYZ897jRRX+cA==
X-Google-Smtp-Source: APXvYqyG1RSF3lCIDiXWjx7JsJ8UmF3VhDB5MzH7ll4xhEJWj8zjGQdeG4rb9OxDTACRSBDR6cbzpWfO3/2tQV7BEV8=
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr5633269ilg.285.1581418557300;
 Tue, 11 Feb 2020 02:55:57 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch>
In-Reply-To: <20200209080918.1562823-1-michael+lkml@stapelberg.ch>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Feb 2020 11:55:46 +0100
Message-ID: <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     michael+lkml@stapelberg.ch
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 9:09 AM <michael+lkml@stapelberg.ch> wrote:
>
> From: Michael Stapelberg <michael+lkml@stapelberg.ch>
>
> Hey,
>
> I recently ran into this, too. The symptom for me is that processes using=
 the
> affected FUSE file system hang indefinitely, sync(2) system calls hang
> indefinitely, and even triggering an abort via echo 1 >
> /sys/fs/fuse/connections/*/abort does not get the file system unstuck (th=
ere is
> always 1 request still pending). Only removing power will get the machine
> unstuck.
>
> I=E2=80=99m triggering this when building packages for https://distr1.org=
/, which uses a
> FUSE daemon (written in Go using the jacobsa/fuse package) to provide pac=
kage
> contents.
>
> I bisected the issue to commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2b319d1f6f92a4ced9897678113d176ee16ae85d
>
> With that commit, I run into a kernel oops within =E2=89=881 minute after=
 starting my
> batch build. With the commit before, I can batch build for many minutes w=
ithout
> issues.

Pretty weird.   I'm not seeing how this could change behavior, as the
args->end value is not changed after being initialized, and so moving
the test later should not make a difference.

Could you print out the complete contents of req->args?

Thanks,
Miklos
