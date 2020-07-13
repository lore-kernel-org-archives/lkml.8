Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AAEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3321F20724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzhOeaNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGMEcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMEcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:32:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B32C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 21:32:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id i14so5447845pfu.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=G0JQrKT2yetJx9RdaIRiBdtxJ5m9P3e1e1yI2fZaU1U=;
        b=BzhOeaNJw5mc5XUov/Aby2l6NocWwThlY3twORbn1TwIDEoS3dKplFq8UgCrSYkMGv
         qEtwSKA1ryLnIiIRujXDfjEWDVKfs8NA7RaZWuMJbRdg1QNecr0Og0cGbpvHL5dNDidB
         G9ntvhTYoBk5vfpkqDvnryNvn50HxvcDQRy23XjFK0+XArxpAbxzNq7Ef5iHMvb0JCyj
         cq+3aeq4oisXukStf8Ki6YcAuW2inCs7jsYRr56Vwc00TVGLfymccFg7D0WLsPzONQtM
         rWazDh0hCkNM+cALPcHJlKJwdj2Y1yblBcZiwCdG56LRNHyL/6wFWRlQWWQniqycLL++
         kADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=G0JQrKT2yetJx9RdaIRiBdtxJ5m9P3e1e1yI2fZaU1U=;
        b=BaahAhWLPMS+5TIyCsQ06mmhgsd19CBv/1rRo6/+mbN3302/drt7OY/JmsPHf6Yp9L
         n61g4fY1RmerfnkYkFRJ9MCtuBsYJFYhyYTwcj18QNe3zAWgOrpt5wJCLFcH3/WBOoKR
         s0HpOv7aYC9fpPz8vSksI3MCA6lQdbsWABmzDrXLqvUlXWQGzAdDdfECHVcfSbyTAqYP
         xYEAZCaSz4l4IzYcd7r6dh8qi+JEHr0lonwTZzYqodMvnO3WoiGmT5ot5h+02cXVmIQM
         RQRUTkbmvG3fgIp1EOAZcHMX1NaI5AN7M31Ul41DNvvGl9h0zDxwsOHZp3edXW5HYI1h
         f7NA==
X-Gm-Message-State: AOAM5338vSRtKy0dJzWIxoPAQ1AEXkE6rh1u9FG9YMFfle2CV1mYLpML
        Tnv4QFOnxvCVP8aW3LzLykA=
X-Google-Smtp-Source: ABdhPJwXO6SeKMCmOZOl/KjVLx4853d3XOrA4E29kKM+JtagHQgBdc2yZIz66f924rIWD+2BovOAGA==
X-Received: by 2002:a62:7a56:: with SMTP id v83mr72044979pfc.114.1594614760091;
        Sun, 12 Jul 2020 21:32:40 -0700 (PDT)
Received: from localhost ([2401:4900:1692:3ec9:34c4:54d3:ee0a:4af3])
        by smtp.gmail.com with ESMTPSA id c1sm11473199pgi.52.2020.07.12.21.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:32:39 -0700 (PDT)
Date:   Mon, 13 Jul 2020 10:02:30 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] checkpatch: Fix the usage of capture group ( ... )
Message-ID: <20200713043230.d7rhv6znvswt2h4u@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="awgtzp4uvp3ywwiq"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--awgtzp4uvp3ywwiq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The usage of "capture group (...)" in the immediate condition after `&&`
results in `$1` being uninitialized. This issues a warning "Use of
uninitialized value $1 in regexp compilation at ./scripts/checkpatch.pl
line 2638".

I noticed this bug while running checkpatch on the set of commits from
v5.7 to v5.8-rc1 of the kernel on the commits with a diff content in
their commit message.

This bug was introduced in the script by commit e518e9a59ec3
("checkpatch: emit an error when there's a diff in a changelog"). It has
been in the script since then.

The author intended to store the match made by capture group in variable
`$1`. This should have contained the name of the file as `[\w/]+` matched.
However, this couldn't be accomplished due to usage of capture group and
`$1` in the same regular expression.

Fix this by placing the capture group in the condition before `&&`.
Thus, `$1` can be initialized to the text that capture group matches
thereby setting it to the desired and required value.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c820607540b..e73e998d582a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2636,8 +2636,8 @@ sub process {
=20
 # Check if the commit log has what seems like a diff which can confuse pat=
ch
 		if ($in_commit_log && !$commit_log_has_diff &&
-		    (($line =3D~ m@^\s+diff\b.*a/[\w/]+@ &&
-		      $line =3D~ m@^\s+diff\b.*a/([\w/]+)\s+b/$1\b@) ||
+		    (($line =3D~ m@^\s+diff\b.*a/([\w/]+)@ &&
+		      $line =3D~ m@^\s+diff\b.*a/[\w/]+\s+b/$1\b@) ||
 		     $line =3D~ m@^\s*(?:\-\-\-\s+a/|\+\+\+\s+b/)@ ||
 		     $line =3D~ m/^\s*\@\@ \-\d+,\d+ \+\d+,\d+ \@\@/)) {
 			ERROR("DIFF_IN_COMMIT_MSG",
--=20
2.25.1


--awgtzp4uvp3ywwiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8L49kACgkQxIwpEWwx
hGRqHhAAkLywFExf90xnmdGZGVYQ1QQ8aYFuW6gV+Jvehv2GMfZUO35DCLkLfIsP
Rsx8I58ZbZHv19LfdOYxhb2gvgeTX4/8+eSCtRwyE7Zd6BUMdoJt6/BE/QljA2xF
CKXlVGX7OpIESqsQbQAq+vMqbcqYDZjCeWh3x8U1cV9pZ09mZ7CL/SqRr4Qfmcbi
uz8MOA4xNF/hISLgDwbyFiw6GIJJJ+mfrBqdhLHZ+E/W3Jx+1Kj/DwiqoXlMKJz8
NtOYb2CZ/zvQ89LK5H/Ed1e6az6yG+7a29f78Zes5Z51Pz9ApKjNwonNCyqE3UvH
04HJ3fAZHicKol5uQAb0RFwmyVUsk+iFCSw065GK738KoQlWNwnQJ3FosuOrvLDQ
22iIGLCH/sE+gWD7bgjCHJuVvWVHEDBqObFbmymqk/Hm8q/c4d2UGbxBSg0kJll7
tK6H+QTQCShukdccK8xRj4f5qwJgq6JBfrpEvKuH197ZHp/lrsIf4l4cdnPOhGsI
bEqg0xOv9jZbBrD3V/YpJhBuKDQxvUc8ihprTHHmWdJDuXtHutpO57r1pu4/UtpT
2XMPEE+AoV699FJwvHpSKcMu0M8dC+96D+t52knPefO5ea7Vsrmhw1G14fkY3R8i
DmlwKh/o/W+P04+3eW5uHblwudILshETG2POmU8Hdtzu2+reDOI=
=757s
-----END PGP SIGNATURE-----

--awgtzp4uvp3ywwiq--
