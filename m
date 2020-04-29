Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91184C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB632073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="F5e4ITrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgD2PTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:19:16 -0400
Received: from mout.web.de ([212.227.15.4]:38761 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgD2PTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588173547;
        bh=sMJzVbT2zWH8TPGk9XmI96DQBxroaH91B1e+liZqZ1M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=F5e4ITrQyLx1ag/zSD08ptulSrx/jgqbVUz3Mm1Gmg2z79ng5iuLo0mr5MxXOQ0bg
         P06xnczKckd1itAhYlGLElxhUyUZ54dhIngkSS5fe385qBq/RMs+J6FZ6Wdf/+iTbV
         zEWaDgsQpjbN0c2JtIumIkQl7xjdboXpab0XbDDU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfkf-1jbKyd3mBR-00U0J9; Wed, 29
 Apr 2020 17:19:07 +0200
Subject: Re: [v3] checkpatch: add dedicated checker for 'Fixes:' tag
To:     Wang YanQing <udknight@gmail.com>, kernel-janitors@vger.kernel.org
References: <20200428020223.GA28074@udknight>
 <38e1a926-53a6-bda6-cb07-2614f4c682ba@web.de>
 <20200428161831.GB30042@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Matteo Croce <mcroce@redhat.com>
Message-ID: <f1234e16-eca2-e2af-c5a6-92f47fcbd98d@web.de>
Date:   Wed, 29 Apr 2020 17:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428161831.GB30042@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x0gBkyvn1kLj2sGIG/c9m9nTklu0RgqfkoyDHTeOnhTbtxcfgH4
 yFIeMoCo9mvJPV8z1ar+y6IQ057gjLPvMCSivsehSgdEQHgHpVZcpK533ttUds6W7qAnPx+
 jl44ihEJzphmy8N6+O5LAGyZ4oaVURwlxi8ug6FGWPXFhcglsTYIDwkq15LkIyNIwtVUyoe
 BDKOHfARh46mMp+xeZVrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ldhao7TSVZw=:yJTGFm/znE26QITc3ZT9e9
 kCbJqAXWcNMlMbUYeKGntr05nV16C7GPNZEdZHcRb5uFXCMiNbg0sd+YuCuU5okLN2XKPu7Nn
 XXDGQOqUVaBoDhuGPw/pJLwKVVotSScq9ZjyIusWarX8Gtfpguk7S6sX/I6LEvFOSZzbc0dXe
 iBaWeDJdNdbuDTILTpwIYShDGexXkyhYep+LSM/Uw9C+aFMokbeOw8XzxTeL4Riz6ngrYzBYK
 m/pE7DnJIWo6R5K52qc7Sc5Zk082sTpMFcTPy1tgigi+qqdOEmUqOE4GPXtYccXaO5CNr3Nel
 IbGLyTCfyCVhq2Qh5hTt3s1pMWAPlB1yQ+zIvt/m4aKCT7eQmhaT61bBuhuXQ9bG7a+x4OwjR
 dztezvpKBttzCT6jbxo1p1+DdVgWwLPkbKd8WEA0b9Qtc86qrD1i6y7zD0MJT8TWSUMHOJVs8
 wp1BCDqGLtM+D7R12ymyjsP2iFvBOnc9L6DqgbnPIuKUf4fWcQ13QnvQZkXjMxyA9hemnoSAj
 AaPq9z+s+OFvDxaA9f0DEYzpI0fNaA9PQzdhgTT5Vg0k7Vz93vvQ12KBVpVBXHdKvFtq0c/nC
 GiQjCInCpjgbk0t4A35tnc5GpEFG4QGC7PJBibqDmyh0WwstE2B7CMxLZFwL0dbu82e7FC+JQ
 E51cYL5tx/UlFkvsUXxZqxTKUd6pzgWXqsbKcC4rXMoRyBzad1Hw0ngtIYVzKIClh/YuzQd80
 VF6tOmICTYeDLwyzmOrsnkaWuomcgwIDATl38mpLAeGekj/HzxnkgET9Oh/kDLYqyHfnzxpiu
 jOYwKPQJG7LnDj+9La+exWUs3qjR+zNkUjKVHBm1skcbKN4BImzpwA+qMXS5TZTXdR2mG448I
 UbVyd9uOWzAZk5eBa8NifuLHF3hvBECErGhhiYLY3agTTxndir9hGfBJZLaomTSSK1ur8rQC3
 NPu3BfdqwlPST3FvLu7JJ6f5qCSkEpU80ZFJ02bWrseRq+J0WgMiinHkuD6yE7LtGz1LC3a4t
 ootjDy9KkIqhIKVSUooRUR0gJ69qnPbRTu9DbnOjZ5b0QZGBXvJ+QzxOP123ocqz+VtLxVxSl
 q+hCNQnyXykyfY+wYxUWPKli1oE5GS3/eGqRDxZHdmm0OGVMsz45X2wiHZB/fkA4oz1Fouq/V
 ae6iJ3lrb/zCACHbArw+a2hSuUHNTvGfShug8Ho3Y/uVE1rEAzLsyR+3SR+sE7nq8hO9QDznP
 ypjuri378/JcQDK++
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Do you try to extend the existing software analysis approach =E2=80=
=9CGIT_COMMIT_ID=E2=80=9D?
>>
>> * Would you like to avoid the development of duplicate Perl code?
>
> Fixes: lines don't need to have a "commit" prefix before the commit id, =
the description
> in normal commit id could across multiple lines, and we don't need to co=
nsider the
> $commit_log_possible_stack_dump for 'Fixes:' tag line.

It can be helpful to know such differences.


> I mean it will make the GIT_COMMIT_ID code become harder to read and mai=
ntain.

This view depends on some factors.

* How many data processing can be shared for your software extension?

* Do you get any further development ideas from a previous suggestion
  by Joe Perches according to the discussion topic =E2=80=9Clinux-next:
  Fixes tag needs some work in the tip tree=E2=80=9D?
  https://lkml.org/lkml/2019/1/17/966
  https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.ca=
mel@perches.com/

Regards,
Markus
