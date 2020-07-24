Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB205206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGXX6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:56598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgGXX6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:58:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82899B157;
        Fri, 24 Jul 2020 23:58:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Sat, 25 Jul 2020 09:58:35 +1000
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
In-Reply-To: <20200724145148.58836d66@oasis.local.home>
References: <20200724132200.51fd2065@oasis.local.home> <20200724174130.GC23808@casper.infradead.org> <20200724145148.58836d66@oasis.local.home>
Message-ID: <871rl0v51w.fsf@notabene.neil.brown.name>
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

On Fri, Jul 24 2020, Steven Rostedt wrote:

> On Fri, 24 Jul 2020 18:41:30 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
>
>> Great example.  Some people definitely go too far with rst markup, and
>> we generally try to discourage it.  And I'm pretty sure we take patches
>
> I'd send patches but I suck at markup ;-) [1]

Do you read Jane Austen at all?

   "I certainly have not the talent which some people possess," said
   Darcy, "of conversing easily with those I have never seen before.
   I cannot catch their tone of conversation, or appear interested
   in their concerns, as I often see done."

   "My fingers," said Elizabeth, "do not move over this instrument
   in the masterly manner which I see so many women's do.  They
   have not the same force or rapidity, and do not produce the
   same expression.  But then I have always supposed it to be my
   own fault--because I will not take the trouble of practising."

:-)
NeilBrown


>
>> to remove excessive markup where it's gone too far [1].
>>=20
>> You can see how this renders in html at
>> https://www.kernel.org/doc/html/latest/filesystems/path-lookup.html or
>> run 'make htmldocs' to build it locally.  Personally, I don't think
>> the markup style it uses works very well in the html either.
>>=20
>> I'd like to see this paragraph written as:
>>=20
>> > It is tempting to describe the second kind as starting with a
>> > component, but that isn't always accurate: a pathname can lack both
>> > slashes and components, it can be empty, in other words.  This is
>> > generally forbidden in POSIX, but some of the "*at()" system calls
>> > in Linux permit it when the ``AT_EMPTY_PATH`` flag is given.  For
>> > example, if you have an open file descriptor on an executable file you
>> > can execute it by calling execveat() passing the file descriptor, an
>> > empty path, and the ``AT_EMPTY_PATH`` flag.=20=20
>>=20
>> I think we're all pretty comfortable seeing function names adorned with
>> a closing pair of parens.  The ``...`` to adorn constants feels OK to me,
>> but maybe not to you?  If that feels excessive, can you suggest something
>> that would distinguish between POSIX and AT_EMPTY_PATH?
>
> Honestly, it's the context that distinguishes the two for me. I don't
> need any markup. But yeah, the double backtick still seems awkward.
> Funny thing is, markup like this:
>
>   <b>AT_EMPTY_PATH</b>
>
> doesn't bother me as much. Not sure why though :-/
>
> My frustration with this stood out quite a bit because I went from one
> file (with the same name) in .txt format, and went through that fast and
> quickly where everything made a lot of sense, and then jumping to this
> file, and feeling like I came to a stand-still in my understanding of
> the material.
>
>>=20
>> [1] Too far being a subjective measure, of course.  My preferences
>> are on display in core-api/xarray.rst
>
> [1] I maintain trace/ftrace.rst, but the markup in that was written by
> others, and I gave a lot of pushback when I found that the markup made
> it hard to read with "less".
>
> -- Steve

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8bdawACgkQOeye3VZi
gbk68RAAwFYbbnauE9CuyYsESOmOZMp89dDmLIMl4aAkNGKBRKfoJZPthrw1JdlT
gPvdheno/gI8QcvBvx10IWmw2P/8w7kx7bh5NarAn9f8tOvLQOj4RwAPa/vOZrXb
es+a5mYJt0quhQg7lDvWMSnpCdWNMbIPTS+RoB5GbGZiZO5rAj1DvIToQOeyzBGo
Jc1gPM8MZgXmYVgER8qivij+B8JoomF5ta1jY1tKS14lc64Z9/3Y6fcJXmAKxkts
2NW3FNV7lJYAwuHfQjeVH07UO6mi1N4r0k09WEZ2T+cbxy+iSmvhMXqW77ztgHvN
0tQ4FBGx5ePURIrbD6Xd1eBRzKqHTFfHEcg4k/34BYwHUK7XkPMZwu0eB3cD0xJE
p/YACQkiskF5GSghS0DoO3NtSi0ZC7XDd2mpnEkq3IudY5uc6Fs8fM/YBQGx5VkD
pxFFomfoPgXB9y+InRplVY2fBIU4+GgUjpjm1nN1MSd6aboOeT1vmGGzDF9HCn90
tTz3yQYTKtGGHP998itYkDIqVuvIozfO/F3lb3u7m+k9ChIAzpBFVjbhw1yRzX7i
ZH8q1n+FBZQ1Ty1JxS174I5JnpW7JlZZElTYrAIsyHAMpslOUP7mvDmsYUsqxbpc
arwBib1IwUuEaIWRgVDtkj8LY6W+SvW3D0WOzDWjvZQHe7b4xjo=
=SZtP
-----END PGP SIGNATURE-----
--=-=-=--
