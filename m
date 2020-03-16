Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA5C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4EB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584343352;
	bh=i90tGLn33Tv00DaJ3sLB7WbfrF23W+1D/UTdCPfargY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=oVE5olstslXUZTEqaZAzOw0bfOXWWVDEyC6xvWZSsNi4VFIDo0AtofePYx6xt0Q4A
	 wYRGLF/zmnI30c2/sA/nBFGne9xRlvgROE0xVxAFyz7TwQDajFkmMPC5D5bBs6KKOR
	 cTabfED195oEan2pMLxLzDhwsi94VWd/13zQkvbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgCPHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:22:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45194 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgCPHWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:22:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id e18so17393768ljn.12;
        Mon, 16 Mar 2020 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=zM8KKIBzhx1kO+5WbVIIuZQdbPNyIKOWqBOoeUsitpE=;
        b=bsRnJTPgAHC+3edYWQkWocNVD1PQaRvLiZVab5K+Wb42YHWaXlYOe5hZDH7ZP9gMu+
         EfOTbqk/56yLXuX+p2vF8MZL9FufyepJTLb9s8E0RjDMQJM/lrgnX36FG7yipZg4r0Qb
         BOiw3OOfpWGzRqkAsYP80LxsOfNHKAugUfzmHtmJkOgcHbQlT1gWz5KqzJwGCc7JdLUr
         EIyBNekRJGiDvT10FA5a/PUkQcHcC+1H/wXWgmG3E5vl8FYvtuALyz/oYN0/1SSa6lLG
         0ad5iyvlNZPFjxuOjPc8qh3JM5ZDEYFwd55R++r1TgKcsaiaWiuWRjb2DARTgZluDxld
         PIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=zM8KKIBzhx1kO+5WbVIIuZQdbPNyIKOWqBOoeUsitpE=;
        b=Lvs27J6Oods5/O7IajUYTz2q07n2ZIwU86omlp8TQJafAZcvW7nbENp7k0MV7whUZ5
         Htw9cKLX/V+W/6anWliFXADMT4EPTBOvwX7QeVF8V+WBKZgDtm+6AXTaBwPPt5Y2VB5f
         OqBkdRmkKo1eQZc20oeUSnzypOcc+Rdbjmd+WY4Jud4OYIFzkduP1E/keGyrPi1iEDTz
         khWJ9CHQYQnO7eb2sUGq0MxtjEa2ZDaq6QaDSDi6d1YS4+60652XxJGT40rnJ37MMs6a
         ovzvexJ1KC4r9UstUx1LV+U2Gs6BQDL2GhXJpOdW1mlAluVTVi8IESi5EH7dDwaT6Maj
         Hnqg==
X-Gm-Message-State: ANhLgQ0UpAVUecKJ+56JKplOY5zXylUFll46vW1r3DH9cTlcvSw+Yqc9
        z09Td/jOJSvPugrTaE6NN8/hN6emL7E=
X-Google-Smtp-Source: ADFU+vu7oM/7DXs8El5eK1zdRL5vi2cRkxZBY+xv2ACF67YVjAnjTf8plkdDyZHGxHCKRw7S2ObxDQ==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr16124424ljh.44.1584343348106;
        Mon, 16 Mar 2020 00:22:28 -0700 (PDT)
Received: from saruman (88-113-215-213.elisa-laajakaista.fi. [88.113.215.213])
        by smtp.gmail.com with ESMTPSA id 18sm15467494ljv.30.2020.03.16.00.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 00:22:27 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: dwc3: enable runtime PM for drd role switch / extcon
In-Reply-To: <ab538c6e-b524-d690-984b-126651cf4d4d@puri.sm>
References: <20200312143038.11719-1-martin.kepplinger@puri.sm> <87fteaf0b1.fsf@kernel.org> <ab538c6e-b524-d690-984b-126651cf4d4d@puri.sm>
Date:   Mon, 16 Mar 2020 09:22:23 +0200
Message-ID: <8736a8228g.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Martin Kepplinger <martin.kepplinger@puri.sm> writes:
>> (for commit logs, please break your lines at 72 characters)
>>=20
>> Martin Kepplinger <martin.kepplinger@puri.sm> writes:
>>=20
>>> Note: runtime PM currently needs to be enabled ("auto") manually via
>>> sysfs as its power/control is set to "on" by the driver.
>>=20
>> Right, that's on purpose
>>=20
>>> When runtime PM enabled, dwc3 currently doesn't resume when a cable is
>>> connected.  It only suspends after a cable is disconnected.
>>>
>>> When using an extcon driver (for a different chip on the board), dwc3
>>> can register a hook for that. (Still undocumented -> TODO?).
>>>
>>> Make sure, dwc3 is resumed when "set_mode" is being called by drd.
>>>
>>> this is only a question about what's missing to properly keep runtime
>>> PM enabled for dwc3 and if my change makes any sense at all. It seems
>>> to work fine for me...
>>>
>>> I'm glad about any hints on how to keep runtime PM enabled (at least wh=
en
>>> having an extcon hook set up).
>>=20
>> You need to remember that what you write here is going to be placed in
>> the commit log and will survive forever in the history of the
>> project. Can you be a little bit more technical? For example, why did
>> you change the asynchronous pm_runtime_put() to synchronous versions?
>> Why was that necessary?>
>> Also, you're missing your Signed-off-by line. Please, read the
>> documentation about how to write patches.
>
> I don't sign off on this change. It merely servers as a basis for the
> question I have: How to properly have continuous runtime PM in dwc3 (at
> least when having an extcon device connected) and is there any specific
> reason why this isn't yet implemented?

Probably because nobody has spent the time to do it. If you have HW and
time to implement this, by all means, go ahead.

Just make sure to keep the current functionality: pm runtime should only
be enabled by userspace.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5vKS8ACgkQzL64meEa
mQYeGA/+OgHY0ROt+AIADj8SxrXz4bPiq9uAEgd/J7CBDwkFVXNqodsXENY7+1uI
ji3yVk1PDYZYYXU3C+wpJJLGYun9pt6extOZ6kdiZub/08gpVl8QsJ40N/5/32gp
TI/qrRQphkC/UQmzzE97j7LgIburGVBjp31l08TifualMtEhAoJ5fcA91y9ynF6p
ZG0h0cwDCtisgXytMckyKOPIwSN9EdLr4PFlDr4gj23mLyJxH2cB8UlacBp83p6D
gBknR6vKnCWz+vhUXFUGHcKxWjjVTe9RgA7m+Iur9Eu/y60QkAs1P8IzsVLQgsUn
+22zh82AcrOIzjwSXJppCfIVx54nKrOrkEfwrWJnUoGawrtCC7mVMPP0Lz8PfmCq
k1UpByh5syaIm7NU9Rf+xYjsnxZEY9zevxPGUxrIvOMVhSxMHWuGd2gBSQTrhHDn
n0t7iBI5wLgHLsL4y07OVvP7tp3ICZPtTXNM91bt7THTOO959A58silEaDVcu5iO
t+2pbiL0BrBBQjX4136tIVGT403oPFqHa678mL7ykkeiUAx3WFBkEQHu3sFPdtBy
zU1gxzS6BY0tnzBIOT00oMdcUF0lGljuB+67N1DB87AWZq7yhY8kvM92KwuG5SG2
R+Fg3/Rq88aXrep4ADZgQwTmlO7OA3HVWs+d9bdR2P3XL6oKGC4=
=UNxB
-----END PGP SIGNATURE-----
--=-=-=--
