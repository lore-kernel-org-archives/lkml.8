Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E909C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D4D2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="i4IFI01y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGQQFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:05:24 -0400
Received: from mout.web.de ([212.227.15.14]:32801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgGQQFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595001915;
        bh=IXSBqWZE7pE8IG9SsTMiiZ0y4wKidBcIctGlOhcTNuw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=i4IFI01yWPkDINO6OoW+03rO9waaBUv18duTjejHxD5Q1z+Sf2hSd3r7sEeZkpOLm
         09J/ZOcaC2gTEpFDsqCtKjKo+9KUJmAwD1CIwrCrdAiYgyOZJ3h+X186FymMeXmXy5
         5FJ+j9VYEU5mjsTelC4tkus6lwR/2I6p0GrqqIco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.15.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP3CC-1kCtoF0i2m-00PJmV; Fri, 17
 Jul 2020 18:05:15 +0200
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: api: add kzfree script
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dedf7ce9-b0db-735e-f73b-83d0c292eb5d@web.de>
Date:   Fri, 17 Jul 2020 18:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pKIFLkCMfXOR3B7TE46iyvM/kz/6zP9oIH2IWKSNZ4WBJo2kqd+
 jGPkIGX2lqp2B9NeaRoAkDrHz2SVrclEXESX7lap4wQ5H5PXUZMoDTTfjOIn2xP0nG0+a3H
 eiCse1vMx+/IdKEUNEX3oa2xjIy8wEyfBsH2JOGbyGU0NOfdEzA/A8uyqcY6zckrnfM3orC
 7p6wgUeBM+WTbVgKVHg1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DF7btZ07Dac=:O2dZaojWPdey47X0drF8Ae
 Nd1Ga62Bx6VSHLQAak+1iUT1sVj/eWoOAry29J1VA07k569X9wWPlFAs8sOK+AbKzPOYQ+2gA
 ILDS4FXYpi4/UkabmPobSeEg3TNtUbweO5GKaDBC6ULDLq6jNIl0cozFjCdsnRa6f5MJtsIZr
 CxJJWCcRQcuQmicrd9XhcKYvf8/TQl5xMUdC0A8gw5PX+jUu+G2cDprYA9TNhMLqMAOmsaRBC
 rBrndjbqmmbY/2lbSxh0IeAcnn3thQdYylgHFwcr0u6Tjgk2kjzWI1tLiB44ncQuxT2UbXozS
 YQgJ9RL8/wLFsTmvfMjdVS5VhiE1JPZuefg6OtUoQK56Xs4t1RI2fLrfkWygTMlqX+6NWghFK
 EvZcXzeKVHPwS3SYPDcePHq8jfQo5iZUFooI36B06zPnkwq8gcDVUA9ld90F1whFY1JOEXq3j
 qfAteP9Au0D+ms/pcZZ1gdI/JCw7WBJ3P4fB47/itH8t4iWg4vkJMa/zL8pwyR015Lgetz1oM
 oY6rTmHcp8cO567i35GvKb2D1MLjZ6mNC/TPQkOUj2iSZToHc/TwVkehnd4dE1GPC092XlTFp
 JWzqp5UclpMngiWqwxTef20U9y6UE0Eyt0+QlpOfe0iJl3qrA4C/JNgQMXwflGuDwNnVHxsS3
 MLzYdaU5MgDq6z8pTyHoujO1MqTA8j7NDMhno+Tb0mWDLRH1od1y+QOCxalGPzgalvBhENn/j
 LT1v+1ENQiIKYhnDhnekcxniO0zweyrrdibvM78iK/qhgmAUUDqrTfrut8cMyCA6+yAhhYgJn
 v0AdSUIYdSENI5QBxhgtahMy9YEAnmy4TtvNB/cUwPvzJRtauVFPvB811Eq9VKD94YJhVTvAD
 CmyRB/t7JV8g1Y5f8jKiCI9GXEqXxgfZOaRgGZPSKds0e72Sk0iUkSRr5+IV5BzMoFre9yTXM
 rFkdOOQzZZOSQqP0GHlP9nOnpIcQyPubxnq/e4SxA7A3VsMjpVKobqdsoYp63yX5AOH/toH/C
 t3NVM2rArUWp/LD9Xplk/xeQCPqhPu68PCR1jtnkrKyBvhORRCM/2vaFNneDCkuuXSwt0/Umu
 THJr20ae3dGPnePbBpqQeuSRKZ/2PDzdkb09vp0HxPmfPrLmxiHAXo0IfPf+z1P4Jl9bh6CYD
 zkQZ1nWotvh6j7U3csMJtuQ3PlH4lHvGZ27zqY1XLPFR5Q9x22TOpneu5AI6yKi4ddu5jmSLz
 KVvp0jCgqQaVMFu7UyHOYQGh3O13d77au1kNLtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I dare to repeat previous patch review aspects once more.
https://lore.kernel.org/cocci/a316f076-1686-25d8-18fe-1bbc0cf9a701@web.de/

=E2=80=A6
> +virtual context
> +virtual patch
> +virtual org
> +virtual report

+virtual context, patch, org, report

Is such a SmPL code variant more succinct?


=E2=80=A6
> +if (...)
> +  \(memset@ok\|memzero_explicit@ok\)(...);

Would you like to tolerate any extra source code around such a function ca=
ll
in an if branch?


=E2=80=A6
> +(
> +* memset@m((T)E, 0, ...);
> +|
> +* memzero_explicit@m((T)E, ...);
> +)
=E2=80=A6

I suggest to move a semicolon.

+(
+*memset@m((T)E, 0, ...)
+|
+*memzero_explicit@m((T)E, ...)
+);


=E2=80=A6
> +- \(kfree\|vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
=E2=80=A6

Would you like to increase the precision a bit for the change specificatio=
n?

+-\(kfree\|vfree\|kvfree\)
++kvfree_sensitive
+ (E
++ , size
+ );


=E2=80=A6
> +(
> +- kfree(E);
> ++ kzfree(E);
> +|
> +- \(vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
> +)
=E2=80=A6

+(
+-kfree
++kzfree
+      (E)
+|
+-\(vfree\|kvfree\)
++kvfree_sensitive
+ (E
++ , size
+ )
+);


=E2=80=A6
> +// TODO: uncomment when kfree_sensitive will be merged.
> +// Only this case is commented out because developers
> +// may not like patches like this since kzfree uses memset
> +// internally (not memzero_explicit).

Will this information trigger any further clarification?


=E2=80=A6
> +coccilib.org.print_todo(p[0],
> +  "WARNING: opportunity for kzfree/kvfree_sensitive")

I propose to align the second function parameter.

+coccilib.org.print_todo(p[0],
+                        "WARNING: opportunity for kzfree/kvfree_sensitive=
")


Regards,
Markus
