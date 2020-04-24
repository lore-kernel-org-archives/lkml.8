Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B1C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC1F20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QXTjb2m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDXHrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:47:17 -0400
Received: from mout.web.de ([212.227.15.4]:43881 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXHrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587714414;
        bh=xMCKGIWSWfZDkzyNaAqTW8yUMH7LZKEPhEgmsf9ck/Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QXTjb2m0xdxAYX9eu3Galz/MTQkGEO6bmMiYS3pbobkOBO1Twi1f54BWJ2HLAUknf
         Mqzn9a6VB1yRr6i8DW/tHgv/2wyBZKeya1Z7gM9xnLMbyEll1zD+pzkUxksRTgZ9so
         KyYe5JthYbBAC8kx274rI/mDFpEwqR7gOOvVC5lE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.129.82]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKr7w-1jRt3009WS-0002Bf; Fri, 24
 Apr 2020 09:46:54 +0200
Subject: Re: console: Complete exception handling in newport_probe()
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        =?UTF-8?Q?Thomas_Bogend=c3=b6rfer?= <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5> <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
 <20200423170245.GA3417@nuc8i5>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f1d27f1b-d822-3457-7ca9-c4c5a8b98365@web.de>
Date:   Fri, 24 Apr 2020 09:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423170245.GA3417@nuc8i5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ff0orYrWO/G7vUnpE7QCfce/w01wByslkpPcrPrWkiDMpjXAbz9
 qgKmu/4GRKvxhETQ/A1BZsm+7OfvCytJ6Sb/eJZXcnp+iPO9E1voPdLfUuG8UVRZDMhVBd5
 diucdn0b4QbNb0ZTvMirvrsgIbSEJxEIL5lQUXCM5m1VmZoY1Akde182rL1zVEA4rXDYqD8
 apIuShZ9RJpY9cVQlL7HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J/+QIqeL3YE=:6lDLKSVKrIEOPNGdSfZgda
 FHPC/UFeCrD4kyHj/h0FGXXfNWNWhDn+yEeVqfop7VlNsRfkIfZ00VUa6Iya71XN03+54RsQa
 uKBW+rWqP12RG6DusANz8zXvtLHR7V4zP69RjYCs8o6YnUCUlHXpowcXDcyt2WP6LnkqH/D6A
 kkOI5GfNzZN/CqGJ7F8kANpQeo9k1cs3g+bEuSTxiZJSB3QwpKCTjZNsY50LrrLgoS4Hd/yjk
 8zTACZ6HuXJT1iYRI5xhw74OsPC3z3zXlTjG11VmshP1uPDaWeE3LN+lLVDMP8BaHhK5h9Ry3
 CaBk5xftjl033jr/QhTZ2ob4yxTaBJzeRhg9bfwqTZipBSOBK3109r9WvcT02daAVJka8nrzc
 KRMUa0htK6W7ZFc7KGP4ey1rOn5BbosRRuu3O9ebhQFOOKUxZhVQuVTHc1FxaOywsv7eo9jFf
 dDnRyWnUB7DIkwHpx2gqIJqqguN1MrHXbI69TP6YVo8QnqTAsLHroLcn3TJBkf6l2irU7p4Js
 9YqfhmI7Um47f4glaIdj7C2h67KWX0U72cgePbCuY+eQj09a8PmjDs+vmRMLitfiBRbYTMyak
 J6r9euiaq4BIz06+T5RSreCPc5fyN3h/bgxTKQIFzaJpU9b6Q4Dpxc6Vks2ooftQM1uhRHq0k
 DzK0Uu6jVkh025AoJLeyVl978NCcRxmJmiZUdtXdObnaBcZPmb601HHK5h7svT0wLohUjjPq1
 nwwBb/TXrojSH1LfvUGwnYw7uRLyIRrvUBUKo0/64tnxhew88XKFD2paqoGTxp7HrCFHxBxnP
 mFmjx77gQTKCEtx5VMhnTKeEnIgYZK9ezLey9vPTSZAHvLlBHQ0rQISU2Oyra8WOWmqYnpXFF
 bWczvn5ybf4Xii2lvDMN7U89VSHSF4d7byRJv5IcPBNwjIPfsNOUo37Z6UDFh4zK+nvl9Us3O
 1TvGgQ/noqqp62pZKDiQYAAVHczhsbFBOAWZgH7n42cbCf0I2HAWR2v9JWmMk3fqGtYJlesJ7
 8vBrAYwIOPhxyyeqG2S5SeGZqihkkaRqxx5HGRCes88Mph9KUzLGu2rZkWn/ensUcQS+A3Q3u
 PbtvEH5ytknb6UT2BdXQawL/k9blP6P/52padooVatmgEcnhvWy7uzc8o3RW4+gIFC8U/ghmP
 Vfirbswt2rNST+U8AdzbW23XxXioxdjXYg07fitM77Hgi2N76z4AC45QBN3Cr7i/F7woHZv0X
 Um9HtbwcALfuCxbI7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I do not know how to use the SmPL script.

I would like to try again to make you more familiar with applications
of the Coccinelle software.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?id=3Db4f633221f0aeac102e463a4be46a643=
b2e3b819#n9

Another small example according to a script for the semantic patch languag=
e:
@display@
expression e, x;
statement is, es;
type t;
@@
*e =3D (t) ioremap(...)
 ... when !=3D if( \( !e \| e =3D=3D NULL \| unlikely( \( !e \| e =3D=3D N=
ULL \) ) \| WARN_ON( \( !e \| e =3D=3D NULL \) ) \) ) is else es
     when !=3D iounmap(e)
 return x;



>> Would you like to let any more source code analysis tools help you
>> to find remaining update candidates?
>>
> yes, but I think the source code analysis tools only can found the simpl=
e
> repetitive issue.

The shown analysis approach can point 127 source files out from
the software =E2=80=9CLinux next-20200423=E2=80=9D. These files contain fu=
nction implementations
which might need further development considerations.


> and need spend some time learning to use it.

You came along a few files where you noticed questionable source code.
Would you become interested to find similar places for another check?


elfring@Sonne:~/Projekte/Linux/next-patched> XX=3D$(date) && spatch --no-l=
oops --timeout 12 -j 4 --chunksize 1 -dir ~/Projekte/Linux/next-patched ~/=
Projekte/Coccinelle/janitor/show_questionable_ioremap_usage3.cocci > ~/Pro=
jekte/Bau/Linux/scripts/Coccinelle/ioremap/20200423/show_questionable_iore=
map_usage3.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/ioremap/2020042=
3/show_questionable_ioremap_usage3-errors.txt; YY=3D$(date) && echo "$XX |=
 $YY"
Fr 24. Apr 09:08:44 CEST 2020 | Fr 24. Apr 09:10:37 CEST 2020

Would you like to extend your learning experiences accordingly?


> now, I think the best for me may be that read and check the source code.

How do you think about to reduce efforts for manual code inspection?

Regards,
Markus
