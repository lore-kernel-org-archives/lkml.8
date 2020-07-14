Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0670C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4292071B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTy83YYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGNDYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGNDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:24:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186B6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:24:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so6986265pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=iESc58qsCWo0MOiWWMrd826m2kwPmJzkRlaRAPDMlJg=;
        b=CTy83YYoRTM97x83TSuJrtfiLCfmO5yYfWG44rNBiMyasplcnmu79l1AhuH0aAeRcF
         a8bfXhLGuCxT3MyGfm6AKmuscnciyKw/GwCvxsGCtXpFHd8CS6C/nHJFaPXzLBFMV53j
         3iA4z268pLr7fh3SRUowYJXbIrFaOuvDwD8RxqTDCFGWCsblcQogNOW+5tCBo92EfbAH
         i9gaxgUIcFobeEhuaKfvLn/slskxIIXZ646Oq+Bato0ACZZfXvLMYLbCfSCjxuerEtXj
         hwD6/8KYW6zQyYq6x2TXRVHG8vyFNdWpUGByWUxp/erS+uaeIZmvbClGpdexDSTCy3b/
         utPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=iESc58qsCWo0MOiWWMrd826m2kwPmJzkRlaRAPDMlJg=;
        b=iZbCT+dJrFPVP5hKcMiKBvDYvv7NyeLH03NxBiBJY+4pAhZBIOxKgCgfgRE2YpYzzi
         tDvEcxYwgYQaJREmSRDcSHxNJzlRBCO+lmK9Erb3zPUl/ZRXd48JE7rrcRc+0ajKffNt
         KqgqWE28kowqrQcIRHQCA+xlch1JgD8AOleCTtFLqS+zTxICX/OV1fqmK69Hfo6oyLAD
         RP4TbbhiGDJV6KXnXDV2P6rgII07iO9NoQb0qeqgxutloK6LWAvEXEuBZsgAzxgAu7MD
         XJF54do7aS/zW9fIRQS4NMI181eHs5X/cwR7jf0Dl11ZTbtO2KFgOFBng3bZnWMosC/n
         22bg==
X-Gm-Message-State: AOAM5304//tsdHGqBpUjj+q0YvU2EtI9lKRol9zTQqNzUJeJg6rNVVYg
        BoSId7hXhPr0mFF0z9F1jiA=
X-Google-Smtp-Source: ABdhPJy5ZWDHRZblS49BB/qSP1YOiDhEXi5QdEeykc/Pi+bPTuEAyzWyGorUXWnekmGk/CIeduaGTQ==
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr2379255pfg.153.1594697043507;
        Mon, 13 Jul 2020 20:24:03 -0700 (PDT)
Received: from localhost ([2401:4900:1692:3ec9:71c9:35ac:ef44:ed57])
        by smtp.gmail.com with ESMTPSA id k71sm876866pje.33.2020.07.13.20.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 20:24:02 -0700 (PDT)
Date:   Tue, 14 Jul 2020 08:53:52 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
Message-ID: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3hgmmmbz74cezwk"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o3hgmmmbz74cezwk
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

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
Changes since v1:
Add Reviewed-by and Tested-by tag

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


--o3hgmmmbz74cezwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8NJTYACgkQxIwpEWwx
hGTIig/+K/F3MQXvHGf/sxp0Q8Q8vh7vwX94sNKlsETxD7jjx9j8CbXafzRWwH6D
ZIVmH73PtuJ16K7Gs+RFEqOpwKvi86Xh8NN01aqKby+HFPnt6bVCA8T2wPzxyaz5
aDRJuCHe72ObRNoZUKenEFnNZIJoEIoriQz4vtdsauYrTYR2VUZC73Xp/0w2wF6v
EBzhXZrMe5uimgzOC3styUjqPqFpLdKMGszse3cdpRXnx7Fj4CfqYUnUwaNXsqmU
DINeDaiylCVC1SFKhCPRLfOHGxRx/sutxFk3RW1GvCw8xVJ5enG569yWgYqAEWrJ
MCdAChq14ZxV6VBzLOYwGBhZWu9rAVr0TEYMAQ27Nw+sHKN0GigmTdEpI++iwkXT
6r8s2vn2RZYc1hXIj+3VL2OMmxp1ag3M83g766VTou5mAJN4+54DyH5SE+PQTweq
1acIk9OBbAvUCNx0hOvHsyi64afT5q10G6EcOKcmzp38HwAHv9s1pFY2z1gyXi9q
dQgYPZxZT2//W4LrL3XEJoYU6CvybZXrHJ4UnOGfhC1jqbWxL2Ug08SHsVI00c3k
ynF+EHY1iYK2KhTXdnVRlFZ6JseLGu5ajMFPe/guF51h6nX1HKULNjAzWNk04op1
2kxdJ1g1KnvNtFu8Zimgn3aF4SGZar6hGSkdYkCw6BpbKQQA/zk=
=1xgs
-----END PGP SIGNATURE-----

--o3hgmmmbz74cezwk--
