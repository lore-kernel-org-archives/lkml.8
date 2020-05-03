Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39EEC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4392073E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JdjgEj4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgECNvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:51:49 -0400
Received: from mout.web.de ([212.227.15.14]:57839 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgECNvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588513901;
        bh=QDo14EAcszfHq4qC8tvl1KUO8MM5m6uWXSqEEsohp7k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=JdjgEj4zM0bWfSb43tBGj4pODUJcMz9QUK9CBEMquYWnusRerTC745uuZgMUTuN7V
         0HLGKQZKD5lu0IQElMWoT/RaeL5umcdjncRFrJ1Gx8los8lnGtS1x+FI5srlA6A26w
         ZS3EQ6eQ9XWMNykBm/7rDxTdfZc/0qdt2NcEg04o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.26.31]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoLKj-1iyOJx3K1Z-00gEH5; Sun, 03
 May 2020 15:51:40 +0200
Subject: Re: [PATCH v5] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200503122938.GC10332@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <2d13b5c1-6745-23da-e22d-d56f0644edb2@web.de>
Date:   Sun, 3 May 2020 15:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503122938.GC10332@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mXyOL/BhJxe3g/a88pBBLWgfZNq7uWEbiPsK7vEJHpp5ON74/Ke
 w1CMmMjEzQSiZLuHxY7UWwBwWIS8+vNTPfRXSa7VQBU5Zsh1zwalUU1b9cIRymAsZL6OjPI
 Q/ke2nCUur0NF3BFenU3C0rB54EtmC/c0VrQl6bQjC0nQVKFe4Kh6kWvKsJocZ2CRSEQ+ZJ
 9ScMtJka99VFHscQkOgHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXMNh1nUJ1A=:QR7rXnqUX4q+OUI7ie77iE
 rbu1buULCUtuCxDMGzY6qtzcp62gRL5DhUzMNGWr5UO/bd+NER1Y31wHV6CuKS+/rneTAE/gZ
 HzfeC+Dt34Ff3lAZ28IIdUEYki5l7WT3gRUoAlsISSDqt6OuUxph1x7MCeBphU04joYZABexp
 AH2gNP02VNKaWFG570TSJd5mgFgt7mi9bliltd30GbT9he3uVE4HM907jNIu+AiCTltZdx1o4
 8S6LCrmGW5KbYkJ2Y73OaDusCN3R1lIUzaxaQZ8NXyMwSz7znjgNb6JNEIpYRw1NIzgny7jHH
 MQwNdGPHqaPe2YYOA409JhwiRYV3PDFyKvhMgvQ+/jgKuoEZJuGrTzFpzHL90NlLxeZb3d4cU
 W7iC/ao9mG2qWXhnzsfdzY4X+lgGNsKh+cD5tW87Ns6RiJVtLQNj12TrwvUPolu0Loz0B36oB
 J9M00vBdbNLHVlu8hIhPZNEZ1fVqFYKmT4XCpa7MNsG/rXfXaIRRZYmnRURFX0oR1sRdUKefI
 xuELhTrnPshg0S3hJHeu0cJfNdVJoRMjwvP/ylS2ALObZhCc8EyD5y0ZOKOdIQNg5vvCQ9PVm
 Nm7ZIDlEKZwJOy4xtf03RtUb9mbKNCoLRHudVEUWAtnDXl3zwMAfjqDx5TrzoRCJXrKZTUrLV
 S+cQewzKaioieyDiF0gSE8DoMbOWyH/DjKqbGAgeoQEh/EOUFpQewp0BM/oOuZoWnY0+sg0qN
 K7u6oDUgB0CYAHfF7MbIjlbTYt2TaFXIiIrDTwOu9XFWJGZUh+/6ug+PJXsMnRWmpLLW840Ub
 otU3gNqZbDcg2Ez9drI3bG5FKD40WurlYfFw3w3i22O2hu7dErbVChqN00spvQVwVQc2d8WDN
 RqJoKnnwEM77yYgAV0PCO3+tGA/pGrXv9CApghMDePXIWq3L8+9EQ5+rbtw/jXvBhk3wpHmBy
 AAIgGFZBZwnm6EF506aGiHefTF3idMFloJ1Ph3RoBrTxJGnj6nLjeThAvSIU/tczJw5Y9O0CI
 bfK0hcI17ukYeDnpJiTulvVZLdqzoJyITsHRl+bwZXDF6lFW1LRgDeoQcmXB7LJcxPuciUGal
 zwO3+szVFg2MLkEMeXtiCCyJGyvZ20rpIFXQpbzcz6ZQ7XKc/HwRBYP3r6Yed1ZewlBjbYT+S
 1dQ1WKeP5O3AuaP5rCDsjnNehJkM809yr3Zj5CIAVtYrO6qaeMxSyI9BMxupynkL3EmkYA1Ns
 qovB0I4QXsXYr0HMb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=9C...

Can the character =E2=80=9CHorizontal ellipsis=E2=80=9D (U+2026) be occasi=
onally nicer
instead of three separate dots?


> The check supports below formats:

I would prefer the explicit wording for the support of (Unicode) ellipses
also in the shown commit titles.
Will the document =E2=80=9Csubmitting-patches.rst=E2=80=9D need correspond=
ing adjustments?


> Because after GIT_COMMIT_ID supports 'Fixes:' tag format check, it could=
 do
> the same check as the UNKNOWN_COMMIT_ID, so we don't need UNKNOWN_COMMIT=
_ID
> anymore and I decide to delete it.

Would you like to propose related software adjustments?


> Note: this patch also fixes double quotation mark issue for normal git
>       commit description, and now it supports double quotation mark in
>       title line, for example:
>       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by defa=
ult
>       when checking usable channels"")

Do you care to achieve a safer data format description also for this use c=
ase?


>  This is the v5 version, and I have tested it with below command:

How do you think about to reuse the analysis approach outside
the script =E2=80=9Ccheckpatch.pl=E2=80=9D?


>  v5:
>  1: Rebased on '[PATCH v2] checkpatch: fix can't check for too long inva=
lid commit id'.

Are the software dependencies (and corresponding development challenges) g=
rowing?


=E2=80=A6
> +++ b/scripts/checkpatch.pl
> @@ -2818,51 +2818,101 @@ sub process {
=E2=80=A6
> +		     $line =3D~ /\bfixes:\s+[0-9a-f]{5,}\b/i ||

Would you like to reconsider the program organisation according to
the application of regular expressions?


=E2=80=A6
> +			if (defined($id) && $has_parens_and_dqm && ($orig_desc ne $descripti=
on)) {
> +			    # Allow short description without too short!

Will another wording adjustment become relevant here?


> +			    if ($prefix eq "Fixes:") {
> +				if (length($orig_desc) >=3D length($description)/2) {

Will the structure of the commit title matter any more?


=E2=80=A6
> +					$diagnostics .=3D "The title is too abbreviated, at least half of =
orignial commit title is necessary.\n";

Will the word =E2=80=9Coriginal=E2=80=9D be more appropriate here?
(Why did you not integrate my previous patch review comment?)


=E2=80=A6
> +				      "Please use git commit description style '$prefix <$sha1_leng=
th_min+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($pref=
ix, 1) .
> +				      " $id (\"$description\")'\n" . $diagnostics . $herecurr);

Can error diagnostics become multi-line?

Regards,
Markus
