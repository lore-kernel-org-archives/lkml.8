Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2937C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA8D208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgEIEzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIEzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:55:43 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 21:55:42 -0700 (PDT)
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0494dm6t018222
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 00:39:48 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0494dhiK005221
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 00:39:48 -0400
Received: by mail-qv1-f69.google.com with SMTP id w9so3900890qvs.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 21:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=4HlAZy+x5Vyp9f/R1vrNhputccwbqWK0vLECWfqcbjA=;
        b=WpIMCzJxN6LHP1pidLHOYwbW49W5qqbYEj+rRAHj++r6DA/YcSDXud3AMU/jt1kmYl
         8BlTFSehAZQmkjfZCTzDUO0ucvMXW1jg+PDzX2ZSOuqxRAr6FILisJGBZoicO/mSNBAY
         Gnw+gabXqWix9+WJLKnvxn4gNPuF+STfmVniW21HpaMgnq+Awy7F+2wkw5f5KXkP2HX5
         JuWoHV9rhwwo1wBv42VxOJS9qdzQF66YcSeFiZYrH3iqngkVOjRFcF3uMd+OAuXCoU7D
         /A1hauCWcERKxZfAxzWIJ0yupIvN1U0WNjCEnmoHT4AMMIE0rb374PP6UTd3cS/teRHt
         2JSg==
X-Gm-Message-State: AGi0PuayJn+jxoYKTSftTNVRbZM+JqKVBOkuiIpLcz6xFp3aClo7mLL9
        /Dp0WD+gOVcJVqXe7ch6rGWJ5NkOJOW7by9meslp6XtuMCzznjibSHleJjP/j6Z13SL4IfL6dHV
        xKjIhmD8bpRKHV7YTZzeSsOUGFuRIXoTmg+U=
X-Received: by 2002:ac8:60d2:: with SMTP id i18mr6351339qtm.244.1588999183105;
        Fri, 08 May 2020 21:39:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUKMRJwsuig4tOPD4UhjqCfhYBTzYXe/zcaSRYFPbaDlHVfzA30uj3uvwa+YZFmsCDPZupaw==
X-Received: by 2002:ac8:60d2:: with SMTP id i18mr6351323qtm.244.1588999182813;
        Fri, 08 May 2020 21:39:42 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id b42sm3466211qta.29.2020.05.08.21.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:39:41 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20200506 - build failure with net/bpfilter/bpfilter_umh
In-Reply-To: <CAK7LNARbKdfGiozX+WrF7fTSf6tpXPUQ8Hr=jC_phUwZa_FONg@mail.gmail.com>
References: <251580.1588912756@turing-police>
 <CAK7LNARbKdfGiozX+WrF7fTSf6tpXPUQ8Hr=jC_phUwZa_FONg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1588999179_6159P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 May 2020 00:39:39 -0400
Message-ID: <126705.1588999179@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1588999179_6159P
Content-Type: text/plain; charset=us-ascii

On Sat, 09 May 2020 12:45:22 +0900, Masahiro Yamada said:

> >   LD [U]  net/bpfilter/bpfilter_umh
> > /usr/bin/ld: cannot find -lc
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [scripts/Makefile.userprogs:36: net/bpfilter/bpfilter_umh] Error 1
> > make[1]: *** [scripts/Makefile.build:494: net/bpfilter] Error 2
> > make: *** [Makefile:1726: net] Error 2
> >
> > The culprit is this commit:
>
> Thanks. I will try to fix it,
> but my commit is innocent because
> it is just textual cleanups.
> No functional change is intended.

Hmm... 'git show' made it look like a totally new line...

Proposed patch following in separate email...



--==_Exmh_1588999179_6159P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXrY0CwdmEQWDXROgAQK7zBAAoJIkHQxqxrSHh8Xj26EcJbDRX+pxD8oO
7VHd42t5dEVS3+lr3FSfYfVwmIH3E/du6MlogZs9IvfBbahpZOtxBFrenL4Nbp86
xgHXbfD+dG70HKdi8n0e85dWOUxhOFSTtoBRdEYFPHIMKhvrXf+704OVC2ugB2bL
eqVKa0/7TzLBT2NZSy/2rZQmlc6S90fOCSy73TJsvKc/1yFOfQC1TW9sjzp+8kCl
evfrSHjEqpwmto8Bdl3nbcDyk64nvLlGtHf7vVzgnrwh2+llKO2cjzoBkuGPp2zp
BuL901PbPg9vMaZ6TvxApC2YZnsT1piaIR797/F8KzPuy44KV05FZw9HRL6/9kND
hV7su+7nwQcUsX0hbZlpi6LybKlYFe2Ly9a7q+HNgsj5MjBK8sHOc8mA3mOm042l
LYC/phYGLhgNVAy2ih9GaGOyw6MmQEABe4e8VNiavdfWaz2Z/W89pioa2v+DzwIx
U8SUdqD4vDIZ+Xwkfzss1sY72DEztwzL+Vkh/5h4wdm1qCic6o7zvOUGSSqqPDmL
NpqEEVkZQPTtifs4Od3/TgRdTJz/Vn8RsCuB3bF5x4DJ+7HRWXm9ROXrsXqZfZ5V
5jDlftMD70YV42WyihkcVAWAhqRLyzmRWcF9cmsllqVGupq2f+MWJowiacsNB0dG
EQ9pnXquFtw=
=x8/o
-----END PGP SIGNATURE-----

--==_Exmh_1588999179_6159P--
