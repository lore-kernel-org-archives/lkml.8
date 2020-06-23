Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3EEA206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgFWC1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgFWC1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:27:17 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C086C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:27:17 -0700 (PDT)
Received: from mr2.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 05N2RE6a016599
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:27:14 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 05N2R9iT030880
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:27:14 -0400
Received: by mail-qk1-f198.google.com with SMTP id h18so14345695qkj.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=+tx+pOYJvZ9eTxB5UMFg+DUdHuZXQfS64TJtcUMMBrg=;
        b=fxBPQQ8aUGO+BTv1IhKmmotDYkBn2GizNmdfy7lD+phX1QdS2HAVqk7ArlQgFuB3/z
         GZN1+BTxhlwjkIspaj8RkYqQu3wCFn60Jtx9qESqiLvVgNZvrIY93gJxirvoCgPFWZ50
         Kawcrp/eaPRadLiIoqqa03IjuGQeLwQ0JbSwMZ3kn8Rha0+qIekxktoOnTsnZpmkjvir
         MwbH1KgCzoxGA8pM1nGcyhrJv7xp9WB7kadi/nrEdayH2cWpGvhVLhHGVRCugRMXDS0Q
         uRv7kzi62if6n5funAEYpZ81n1ui7ERxmKfhl2KC6niFVoqnjb6MN6qIfuxtoY3Ljz6H
         uUvQ==
X-Gm-Message-State: AOAM53125Ux1+3xLkooROGCy/GUPLQk39s5sOVU0hQTGDn/ZUgbvfiA6
        +n6Hk7CtvGZgW05uixksEqFfTrxy6Kyg2dAPvuh8mGEyYHSCHb39VjHAelG+KTnEMn9DjxF5ukM
        gwbIQAWecawqRKmxo4Jm1e8R/auqzQkKxHVs=
X-Received: by 2002:a0c:f991:: with SMTP id t17mr24855603qvn.123.1592879229056;
        Mon, 22 Jun 2020 19:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZwuTxC89TFwp2ScpxEmvcF4a++QGM55NORtq8+7aSkWI44MQlxsgKHE1A7EWob7dKi4JrnQ==
X-Received: by 2002:a0c:f991:: with SMTP id t17mr24855586qvn.123.1592879228665;
        Mon, 22 Jun 2020 19:27:08 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm15549488qti.62.2020.06.22.19.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:27:07 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: separate kerneldoc warnings from compiler warnings
In-Reply-To: <CAK7LNARevD4o1WCRatKqZcf9-arxsvBcyLKHcNSM1ih+TDS5Mw@mail.gmail.com>
References: <591473.1592679153@turing-police>
 <CAK7LNARevD4o1WCRatKqZcf9-arxsvBcyLKHcNSM1ih+TDS5Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1592879225_62491P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Jun 2020 22:27:06 -0400
Message-ID: <771628.1592879226@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1592879225_62491P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 Jun 2020 14:10:13 +0900, Masahiro Yamada said:

> > This patch introduces a new build flag 'K=1' which controls whether kerneldoc
> > warnings should be issued, separating them from the compiler warnings that W=
> > controls.

> I do not understand why this change is needed.

> IIRC, our goal was to enable this check by default.
> https://patchwork.kernel.org/patch/10030521/
> but there are so many warnings.

So are we getting any closer to actually achieving that goal?
I've done a fair number of cleanup patches to make the kernel
safe(r) to build with W=1, but there's still quite the pile.

And actually, if you want people to actually fix up the kerneldoc
issues, making it easier helps the chances of getting patches. If
somebody is in the mood to do kerneldoc clean-ups, having an easy
way to get just the kerneldoc messages rather than having to find
them mixed in with all the rest helps...

So I ran some numbers...

A plain "make" for an arm allmodconfig weighs in at 40,184 lines.

Building with K=1 produces 10,358 additional lines of output - that's what
needs patching if you want the kerneldocs cleaned up.

Building with W=1 (w/ this patch) adds 155,773 lines. Not A Typo. Of those, a
whole whopping 116,699 are complaints from DTS issues, and 39,074 for all other
gcc warnings. (Though I have 2 patches that I'll send later that will knock
about 3,000 off the "all other gcc warnings" numbers).

(And for completeness, building with C=1 for sparse adds 18,936 lines that say
'CHECK', and 56,915 lines of sparse warnings)

> Meanwhile, this is checked only when W= is given
> because 0-day bot tests with W=1 to
> block new kerneldoc warnings.

Looking at the numbers, I really need to say "So how is that working out for
us, anyhow?"

In particular, is it just flagging them, or do we have an actual procedure that
stops patches from being accepted if they add new kerneldoc warnings?

Another issue that needs to be considered is how high-quality a fix for a
kerneldoc warning is.  Getting rid of a warning by adding a comment line that
says the 3rd parameter is a pointer to a 'struct wombat' does nobody any good
if looking at the formal parameter list clearly states that the third parameter
is a 'struct wombat *foo'. Heck, I could probably create a Perl script that
automates that level of fixing.

But making an *informative* comment requires doing a bunch of research so that
you understand why *this* struct wombat is the one we care about (and whether
we care *so* much that somebody better be holding a lock....)

> K=1 ?   Do people need to learn this new switch?

--==_Exmh_1592879225_62491P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXvFoeQdmEQWDXROgAQL45g//RXlI5mcm9sTrsYpGogD7fPTZmf8rV5Ev
kwvwylKgIZwB0K1kBrK4tK8hgq9BErcMpEjKsCdJcpXNzbGiyfKSIYylxOQtdspA
nsENDIw4kh0HXOrbOJDpYyql58OKXKl5PPWLoQm8ZXWiLsMgo5mE7YAaLLoWxi3f
t6Q04i4rCL/PjtgF9IcZgoGRS49G+9HwuPHRlmPgzwYuKtn2Jx3nAGdA3sjEzIFr
J2G79OeRX88qwOxeehDcCM4AKbvjnsVichPrBJdcQh+n9kHdHJ+vrxvYtB644WFd
qAva/xY7gkptMX97yO9eAQiZF/xg2qF/lIkRcM9ETdMM42HNLc+jkjkxIUKrTwFA
Y4uqXWAzXi0vdZK+jAEWjgTnrrh1zIROY+6Uob11Zcp/vs9cCgtLFIdKMTndeh+/
D23ZcjHyc3WbYKkFVj3gAc30VG5/pIB8lQ7Fm75orP0agqf3jJUclYOLb2VC4GiM
HtplgK3ewJNkW4x3VDaNiOG0obFY6WnQgUxMsfLzGRmVEXEedshQ+3EapZPS0t0n
fHDbGbU8wZLHsCKkosyy8iin/lwGQzan/rW3R98PQSYz6uGLD0p/rZKAmbHGThee
Lqhn4oCZ+rBtgepfQhWACXwAmXBx6MthxJPMoveD2CVXh1IVc7c1cfaRq1O2vOn1
S0ApTLmmm9Q=
=5z/x
-----END PGP SIGNATURE-----

--==_Exmh_1592879225_62491P--
