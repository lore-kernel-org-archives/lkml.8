Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D1C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A520801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="aZwZkJwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCERb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:31:29 -0500
Received: from mout.web.de ([212.227.17.12]:50077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgCERb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583429440;
        bh=VvUKxk5bXO+I3o1ImsdWG2jnrDgsLlq8+ZU0NYkkVBc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aZwZkJwTd01bqyytU04syMNjFQgF275HAmekP8OPf5t4d86HAzzMdq4N6koRThiTK
         hFeIuNy6LW6TiJnj8fWElgaU1wWTW0DWOVnZw4Wfo+0jmNIf8y6SBM3xweovWsJusa
         5hNUyUPTHxaIpJmHwVnt+AU7n5RRk43mEnfXoq3o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lmcf9-1jjVzv10y3-00aGyQ; Thu, 05
 Mar 2020 18:30:40 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
Date:   Thu, 5 Mar 2020 18:30:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W3xcFKaeZD/0HuoUZoRYD5Nv5XcHTvECbU4+pVGAlcwpjmIHktl
 737ccCT+3lNsPZD1so67EKNiZ51+XID+gpvwB1ltc9I13jo950pO6dIxocvJcCtU0v+FyDw
 4e2tXx2aAzuLgwU3UhMHkOw9Iiln8bODKDyxrfR96D4oZowdTrSr+WLBJCaPypceVpj6MQG
 yQJDErnnyuNgMtdiWzwZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3r12A7ywmpE=:bZSUsP7eg/hMMyRXUuDLcL
 E9SH5Gdp/9xuQZbq5LGMhmYPyrFw22cK5V0GFFnfzZOZMQeTdrYj2B1+QJae6QSJHrm2zoVSx
 12qqM3oLGl6izJeXQlmpWMwzPxeMEOouXA/KHTeGWDGTcSChbh2LZ0Oic8SUQJDX0p17O0f8a
 8I/gB269oh2Vl4pHXEKdeE3ntJPbaCJQwmxD0EU2cDkHR4YTecl0ZAME3UY875b2j3IldIGXn
 kWMBsEFVTvi4mFIkP3YnxBxIr9MVSYnZxJzpdgaNQJ/Z/q2WJa6d0UIpBS9KEjNJH3XYYpYGM
 IqlNxQSDYdMpt72hKDPhk5pea57PmJ464R/bobo07NlUbutL0j09+VT6Na2s1aCFZkedlv+we
 1txn/igfXLuprdpmd7loU1NmKH7w8KP/LeFCpHkzNdPiOpBtbZM3Sf+HMfVpPIywoUKy9R9Zu
 YCxJoUZ40Mx9hs8cKqvG4X9sxnaGxHdFSkO+sBscXuGEUxmHkLPdh+J3IjLRzVyKpT74AahCf
 KnTF1/oKQPTNEmif+bxGGeaeQEktkBshHl03b3wIwQ/ES1TyfE7NzF/0tb+tffViNdzyvdny7
 iODF7ED4hzUINleW/Xaghai0QgnHFziTDYd2ouDbN2vzlMLLC+YYURAgQdLsm0H5ZlE0ZC4uX
 DjXwQt44+TYtw238ZE38hBT9oscp16oWNFIn1OcHyiBLO7Tihy63rtQ0m58mzuoc8Sj8DULNZ
 Cm/sTIKtUPMPL8s58OBcf1rK7f8/kio2mFW7fSun8q7VU8NTr40A3mtKO21EYb05S0xvyBkkI
 w/1RM3mNAmcW8tFNI2SSlCkbJIMCtC4HM3YjrIRsng0sgpWutPmrCRA0trTCR+Znj+t4kQMCl
 nx+vjczBdZSSUmvDOY7YCDBkPaa8FsFzXXoa2pHd5WtesM+FseT+3XsKwfzXp+Y1Rgvcz04a9
 ty6kQlc/F3Z4dYFIon9nVE8+liDQvcmD19G8IFaeze5fu7MCoOj3xIUh4nJ5ASn362RSQT+j2
 iLFJvgsMW/6T26nPUOiHRw57U+RbH84gb3KaQokt7C5KSNNrKiqI5LLWXffW6zoz0s+FKA2Bk
 VeWwbChGFg7tkvJ/WWfE1fbzFtpo00TNSxdUdjyhgPTFrpbSYX+Odf9nI2DSlS98Bl0bfrYN1
 yQo10gwde8OxDUyNUNDLu54WeUefZ3u7e+fMwLBYKP0kMiF051DBjpITggnttBaakBKSpiABr
 8nn1PCnu2zgZEJSUN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How does this feedback fit to known concerns around the discussed wordi=
ngs?
>
> As far as I am concerned, it means that the documentation is
> sufficiently good enough to be useful and not difficult to read.

Would you like to add anything to my previous review comments
(besides simple typo adjustments)?


> It does not mean that it's perfect. Patches can still be made to it.

I hope that corresponding agreements will be achieved for
further improvements.

Regards,
Markus
