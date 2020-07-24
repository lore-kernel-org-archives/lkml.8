Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6682070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGXXrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:52316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgGXXrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86D4DAC37;
        Fri, 24 Jul 2020 23:47:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Sat, 25 Jul 2020 09:46:55 +1000
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
In-Reply-To: <20200724144234.3227b501@oasis.local.home>
References: <20200724132200.51fd2065@oasis.local.home> <20200724113325.44923f75@lwn.net> <20200724144234.3227b501@oasis.local.home>
Message-ID: <877dusv5lc.fsf@notabene.neil.brown.name>
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

> On Fri, 24 Jul 2020 11:33:25 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Give people a tool, some of them will make more use of it than you might
>> like. I do my best to push back against excessive markup (which all of t=
he
>> above qualifies as, as far as I'm concerned), but I can't really even do
>> that will all that goes through my tree, much less all the docs stuff
>> merged by others.
>>=20
>> The markup in question was seemingly added by Neil; I've added him to CC
>> in case he wants to comment on it.
>
> I saw Neil as the author and should have Cc'd him.
>
> Neil, you can read my full email here:
>
>   https://lore.kernel.org/r/20200724132200.51fd2065@oasis.local.home
>
>>=20
>> I'm not sure what to do other than to continue to push for minimal use of
>> intrusive markup.
>
> Yeah, I really didn't expect an action item to come from this. It was
> just some feedback, and perhaps you can use this as an example of "too
> much markup" when dealing with others.
>
> Looking at the web page that Matthew pointed out to, does make it much
> easier to read. But one still needs to remember that a large audience
> of this work is still those of us that will read the plain text.
>
> My viewer of choice is "less" ;-)
>
> -- Steve

Hi Steven,
 thanks for your rants - and under appreciated art form I believe.

 Short answer is: I don't much care and if someone were to remove the
 markup, I possibly wouldn't even notice and certainly wouldn't object.

 Longer answer is that I think visual appearance is important.  I
 originally wrote that document as an article for lwn.net.  I wanted the
 code fragments - even when a single word like AT_EMPTY_PATH - to be
 rendered like code (constant-width font).  The markdown markup for that
 is  `code goes here`, so that is what I sent to Jon (he graciously uses
 a markdown-to-html tool to munge what I send), and that is what I
 placed in Documentation.
 I subsequently converted this to rst (7bbfd9ad8eb2) which involved
 converting single ` to double ``.
 I agree this was not an improvement when reading the text, but maybe
 that is the price of using rst.  Or maybe the price is not being able
 to say what you mean.

 A brief look over the file suggests that most uses of `` are to
 highlight one of:
    - paths
    - function names
    - constant names.

 All these must be used widely throughout the documentation - whatever
 is the common standard should definitely be imposed.
 Constant names stand out least effectively by themselves.  In
 kernel-doc comments they are preceded by a '%'.  Would that make the
 text more readable for you?  Does our doc infrastructure honour that in
 .rst documents?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8bcu8ACgkQOeye3VZi
gbmjGA//SRXJ/QRPQ6cwMtokAfU6MOfPmzE/kje6niXlk/8S+ALs8C7Ln0KBvWnl
/lvGP8NPdadOp6i8t0n9/yHPwUiCUOSQrbXObCwkuKEPzEy7Xb9KFgpiSw65ZQne
m5DmKHCEQMbzqtI4lm6BHn1aPhXoHxJSmj7tKYhgy8TabCwC8xcL3QyQO8q+22zx
pWx+5gK2BoJPMLnsofcP9bWLwS7xlnxhCtkHVFcZycSBhgr2mY3P9jkX/+stkfPO
3uHDWrfq0LV7uPAS8yqJfCxfQ4fb6qSihia53cAwvwtjeH6khp+8jI3v72YzoyWz
/XYCGSm8ZVRgU1GUEKEyxZJko7NFCDNyBCjhXnqTipMG7SSaae4ZHPLIDbG1AOt9
svl9it1T0xl3SkaTUxBG+8d2fWVHiKpb064s6iYv7BnGHB8EZNPbQuCkiRvAvO3x
DBA8FFSe07zMitQ3fzDmA8ldVaSD2ToubP1x4v0kcpQJAOYaKUMBOuIB/EkK6O/E
jm07PJlSXVEg5D8aHMM88p6bjjwFntJbQyH3Ql8hWdhtzcrFHGYF8QgZYbOV8cqn
Klt3Evjss4cNi3N/HGaFwBcYMs2wTJER5v62caU4quFYKhy3q8930gYRe7m7sLEn
2LQwfFLBarX265kDM7/CwxaDkHgNoyBQl9SiLZ1dT1aLALu92d4=
=RP7I
-----END PGP SIGNATURE-----
--=-=-=--
