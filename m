Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F44C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E329206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KmcTK8g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD1GVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:21:54 -0400
Received: from mout.web.de ([212.227.17.12]:59115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgD1GVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588054906;
        bh=vf/9q4JieZqCIWye6wQRE6vUQjSe9mpVMmZH70NKoCU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=KmcTK8g1Kbng1CciEQQY2+926Y93uG1EAl1SnrOwL+ROdHtOMfRAyvoixE3Y21CRz
         GCV6e5ikL3ZGhII0QQP8QQ193ZfeBj5ROtCkBaGRa8MbPPeTx0svfY86NHMqwgw4IZ
         WpHg5+HstKRst4HLXGOfrJgsywmQlZwOT4e5rDWc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.179.255]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu4uA-1j167j3tfq-011OW4; Tue, 28
 Apr 2020 08:21:46 +0200
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200428020223.GA28074@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <35069ae9-cdb4-4728-5e94-6d863dd2721c@web.de>
Date:   Tue, 28 Apr 2020 08:21:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428020223.GA28074@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8TpptPRw5e5gLUpRsNbhs+suYupeJoCUBzC5//nW3ZqMos8LoX
 hCcgHCSNAcNIMn5O5EQfIWAFF57gJVvaWdxZrNqSZbRlOEdWB97IbsT+Jxk6J1l5CV2CmcK
 WWct3rQ26zTsQ6jnr3awHcTk2yPSZGIICwMiHVZNziaUN9akvv2chqN5mwbSURXAVtoW6cI
 UrVCeHOpsv+jdOJ2wC25Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l2OBYPauvxQ=:svYTsTxT1hu1r9BBi2vPK2
 q8VyfaQDprrtcXo4W84BzFn6fcKeFtyIXsGQCA5C4flEDMGcjp4KdiUCbIVRqHP6ep7TFKjPC
 3BbPo7aOONmhoC3JkNjCZrYpkgJiYat0jknPGP7ZUYPTVMF6uc4CazTNgXntrzFTOd3hHnz29
 nqe6iNKGGnQms2HZ/yOW6RMjHxayjwgHsukYnIDAVNDxp8VPOixHdJ4ipLfLlKfSlGfgh+0vG
 mRHbV3CkHwO3vpzjyh7zlfTqAm7QtIQlFrlin+W47cNU01hztH0QvZ1wg3I2uQ7oLV8SyWBAH
 hBMbsgh86K/qeCQ962JSsHM+6e25Qzvqwe6f3MhA74eUMlxKa7MAWV2RrXi3NxGI8iD85ZR5c
 nfnvQafnT4dEUYAZ9dUyhIFwuZ68GprBaY/70AeJoXYJVYqFJvIobFN9y0jncOhReduSOVSDf
 GbsRevlOgmmcnIxuiRIS7mrN75gCxmMls9CwMyeFGgKE1FazpAFKLsOpt11dtzYqhP+sA3Xkq
 ZitTEgKhzl4H3g+cXoEm8aUiHl2q6bc0LPWolWl+SW7BEFdBEBj4jES4iqFZbd4bKKhiDxf7x
 QHdjNL/sV6On0c+qOkc7KCsDlfZ12A7HRJnuVwjmzL3W7rY7HJ1hM++1m7YYWDsLTpW2UQi70
 NecI3Y807itaGXXAlgselwGRYxabTAIM8nlQzqwWvcNxztpzCU6KL7HRQhoF/AGBxh1LPI5Mc
 mhwURDQayOokLDHfofVN7yphhOlka4potchgBfN4qKM2dIycslWfoWHg9kcLUQMGyIskHqKSK
 EHp11hTcO0N1CKk+b3JVu5iDavWEbbHkiVPcRqssdSuK9iIbpZSw2Vp0x6/WGFBW/1aZcGCpa
 UHa6cYbF99VPQm7CimsvmubAkTYQz/OCvbj+MfQ3XAgHmGyJ+77pmNnqheIVAbZEy+r5Mb8Lv
 YIAjR9vibCsnG7NCN9uZHrhq77DxjnyLcadFyMPDSsBzAfFfaw7jNCLJFx/RXGnW6zFbc0wSm
 l29D9aaSR1ouOzJa1fWuQM/x8v4s5/7BwH+JY/sUmjVqb3fdx5GQn0iic1blYRG5NVNIwvB7a
 yy4Lz5xrfMU6cv2+Qd+7W25wmdjligWtm26sD35Ab5cb5/tNFpqvpoLsm9infcxby6E/Z/0+7
 OJCzWlvyDJgUeNRRQomwBLY0jWae/Qc7h+p+FCiMlML8rOmjBLrCvpXZqBQmWRhzhk7kpEYeP
 nAlqhZUwA7s9paej6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> Do not split the tag across multiple
> lines, tags are exempt from the "wrap at 75 columns" rule in order to si=
mplify
> parsing scripts
> ...

I suggest to reformat the quotation.

=E2=80=9C=E2=80=A6
Do not split the tag across multiple lines, tags are exempt from
the "wrap at 75 columns" rule in order to simplify parsing scripts.
=E2=80=A6=E2=80=9D


> And there is no 'Fixes:' tag format checker in checkpatch to check
> the commit id length too, so let's add dedicated checker to check
> these conditions for 'Fixes:' tag.

It seems that there are further challenges to consider for an imperative w=
ording
in such a change description.

How do you think about the following wording variant?

   The script =E2=80=9Ccheckpatch.pl=E2=80=9D did not provide a check for =
the commit
   identification length. Thus add a dedicated check.


>  v2-v3

I would find a shorter version identification (without the arrow)
also sufficient.


>  1:No modification to GIT_COMMIT_ID checker.

Would you like to add a space character for the item enumeration?


>    I make a mistake previously, =E2=80=A6

Would you like to use the word =E2=80=9Cmade=E2=80=9D here?


> +		    my $id =3D '0123456789ab';
> +		    my $orig_desc =3D "commit description";

How much do these variable initialisations matter?


> +			$lines =3D 0 if ($1 =3D~ /^\(\"(?:.*)\"\)$/i);

I wonder why you see a need to use a non-capturing group in such
a regular expression (when no alternatives were specified there).


> +				ERROR("FIXES_TAG",
> +					"Please use 'Fixes:' tag with commit description style '<12+ chars=
 of sha1> (\"<title line>\")', and the title line doesn't across multiple =
lines - ie: '$fixes_tag_fmt'\n" . $herecurr);

* Would we like to support any other quotation characters around
  the commit summary?

* I propose to split the error message.
  May it become multi-line?

* How do you think about another wording variant?

  The title must be specified as a single line (without line breaks).

* Would you like to point questionable commit titles out?

Regards,
Markus
