Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1720936
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiDqrpMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGECyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 22:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGECya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:54:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20229C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 19:54:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h28so31670859edz.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dvqshmDN/tsxghSmW5OA1k02BKJNMJmYoR6UGK4L9Lg=;
        b=NiDqrpMf/AJsvghlpr+Lt8VZU0ifVzoi9xQN5xZ9wUxz12wjosKVh7dkVnC5Kz+rSv
         fDUhm8HZAeEiZ2dx8QgVZyiHKp3dEeqIGmJyaV1r5cQ9RkGWT1v9XYnZdMbdLWXa3T47
         lBlY6I8D9ySNLODit4mDwh6Vyxsm23NM9aUDMJZ1iXdX+UCI/KQ4WmQLYcBS6GH4qwxx
         AJcW4YV3cQRABe9qVGtqqEs80wfl9JeYpPwOS5EfMJom1CnNjteO7xuafuTFt9rkFAZ/
         BJVLVZcI7VeD8jzQnFDZ0fMYSQ4VTjB+Ihv+K662F0Sk7r1XoQJcoSc7vJFjiX3eFVdB
         y/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dvqshmDN/tsxghSmW5OA1k02BKJNMJmYoR6UGK4L9Lg=;
        b=T4J3N3LKWqBZGyVxlqylxw7ibrtSK4BJOJVd7m9Uzyy9/73nzx0jMTqC/WGqe4u5df
         o1zNbHR8jDQhB++8lo5DZEM5q5Wz87QLc1R4j72GSHJQItOnILeIoNtbuRV/dMkgPMlM
         /osFRT1e7StHk8RYpnX9AR+To267wF37RIETrNb/xOSl4FPLV82LrCiXyFUjpnadsIBU
         W2yyLmeR/9+yeub8kOMKBPnNMIP31jqhVbExDImwTndeayAFdP6qgRvbUHH+wtmctvdD
         Q8pkYcDoWFZlC9VJx4Kr8a3rSFpIWocHiCQJrrEV2XLTXIT1Ced254Sbe5JTfZW97U15
         fyRA==
X-Gm-Message-State: AOAM532Sw8w1ghFeFd+o5yI/XE2SHaic1ytk30nL+eYMXMvkJyrnvOni
        h9+CtEYtvMKuRCcDzHPBMCWKG1mFok2IROyZaxxF35XdvmA=
X-Google-Smtp-Source: ABdhPJwsIgz43ZzWE+J2JD/Bh+9Jueukwp1CnUfHkq5hnTEl+gW/egfyKyE+uVLoskAeK4yKwxHQ6juZC9NEdeccJNw=
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr50886256edy.78.1593917668742;
 Sat, 04 Jul 2020 19:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org> <CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com>
 <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
In-Reply-To: <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 5 Jul 2020 12:54:17 +1000
Message-ID: <CAPM=9txhJvp8dvJA7HWa=dEaTgKCzrNc5evof+z7ZW8+e=cKTQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Matthew Wilcox <willy6545@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jul 2020 at 10:10, Matthew Wilcox <willy6545@gmail.com> wrote:
>
> Erm, red-black trees don't have a derivation from gambling terminology ei=
ther. The wikipedia article says:
>
> In a 1978 paper, "A Dichromatic Framework for Balanced Trees",[6] Leonida=
s J. Guibas and Robert Sedgewick derived the red-black tree from the symmet=
ric binary B-tree.[7] The color "red" was chosen because it was the best-lo=
oking color produced by the color laser printer available to the authors wh=
ile working at Xerox PARC.[8] Another response from Guibas states that it w=
as because of the red and black pens available to them to draw the trees.[9=
]
>
> Left-right tree makes no sense. It doesn't distinguish the rbtree from it=
s predecessor the avl tree.  I don't think it's helpful to rename a standar=
d piece of computing terminology unless it's actually hurting us to have it=
. Obviously if it were called a "master-slave" tree, I would be in favour o=
f renaming it.

As I said "it means nothing if you've never interacted with gambling
culture," red black in the context of the trees as zero meaning other
than as a name to find it on the internet, Search for that name enough
and you will undoubtedly be getting ads for online roulette sites
within hours, if you have a problem gambling past, this might not be
the desired effect you'd want.

The reasons something was named a particular thing can and will be
different from what a societal context for them means now, and I
believe it's more important to worry about current societal contexts
than legacy historical namings. I'm not seriously suggesting we rename
red-black trees, but if someone who had a problematic gambling
background had issues with them I'd definitely be open for considering
it.

Dave.
