Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA62C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zzywysm.com header.i=@zzywysm.com header.b="ekdIyW1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgB0BhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:37:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36547 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgB0BhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:37:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id f3so1646356qkh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 17:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fhn28C8CmqssH/Gf6DazyCM00s0sApLytGdLXcTC3KI=;
        b=ekdIyW1ARAJ9w1pPmn1HGRhHw3cPFFO2XVwXwP7/L5V8sKzmR/aqH7fLQHUGhs7ZqT
         +wMXB0bOYBBsh88J+rHdfh45PNuQdnTZQ6HomS6SzQFW7dkBTptHeVCbMSkz1BzRXhPe
         34tLvIVE9Dl1F8uQEaDjSErUlEfk81vgFL3gif1w5+3k6WFcDB4cqQWN50Lk4ATz9xH1
         tHoSRgNVQAmWFQQQdfdDqvPamMRAauyyMXcQQd1yGnFGsA04A7q+ar6jkELOTLu7TgCE
         8inDa8OhJnCNGCN0Si1+IJdSDOpofXNVz+i3o5PsxRO/xJyzesD8Mar739q7jzec4fIE
         utBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fhn28C8CmqssH/Gf6DazyCM00s0sApLytGdLXcTC3KI=;
        b=qQgjXyIHJ8o9Cx5iNndcVNEyErmutz6xyU5YoA/bfFxCFV7jvI5xTAwMthv4iD55Ma
         ww/8QohME5pbaZZboNp0HZRKIfBlhAsbCZARrp/5VPSySKMEbfLjoMyyYXkXqdoxteGw
         lXZgjLeJlsXDmiMpDKpK117ZJIWThLE9QRLva0n7A1JfrAd1FpJy6zOFnWN71iDhNJRx
         nJU4cn5iXxIoTaqJzZVkKdBtC7A4/qHBcVDh0+QE1SMLnsv+dJj6J9mhLfcoT+wBXjD5
         XToIR+5AAvxv4y4UpXut3DETyhpkOVb+LtupOSiEUjncmFJL6zbXfcMdx7upBhsObML3
         Kjdw==
X-Gm-Message-State: APjAAAVUwjJWtQ96Dnp8tS9qXJU+2qiPmrbfZRYmQa8QGmmt31NFANAk
        bLZtgDRl6DzPN7I8uG33KXf6jbkIbMCLfQ==
X-Google-Smtp-Source: APXvYqzZnViTN049E/8zB+DcGvlrKPUkmb2RKZfHSUvjD/c//iW+i3/S/fzIC9Vqg5dBrsqwvEY0Ag==
X-Received: by 2002:a05:620a:118c:: with SMTP id b12mr2264905qkk.261.1582767433368;
        Wed, 26 Feb 2020 17:37:13 -0800 (PST)
Received: from [10.19.49.2] (ec2-3-17-74-181.us-east-2.compute.amazonaws.com. [3.17.74.181])
        by smtp.gmail.com with ESMTPSA id p53sm2194463qtb.85.2020.02.26.17.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 17:37:12 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Linux Warning Report - 5.6-rc3
From:   Zzy Wysm <zzy@zzywysm.com>
In-Reply-To: <8b4fc03d-72fa-e58f-9b3a-c02926c07aaa@infradead.org>
Date:   Wed, 26 Feb 2020 19:37:11 -0600
Cc:     linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A706CFA-87D6-46BC-9DC7-DC56AAF447C3@zzywysm.com>
References: <2BDD2716-BC2C-4DD8-B0B0-E33C56FAF0A5@zzywysm.com>
 <8b4fc03d-72fa-e58f-9b3a-c02926c07aaa@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 25, 2020, at 9:55 PM, Randy Dunlap <rdunlap@infradead.org> =
wrote:
>=20
> defconfig isn't very interesting IMO.  x86_64 allmodconfig has 1103 =
warnings
> when using your KCFLAGS string.
> (I am using gcc 7.5.0).  What version of gcc are you using?
>=20

The gcc that comes with either Debian (gcc 8.3.0) or Ubuntu (gcc 9.2.1),
depending on what I use that day.

I agree that defconfig isn=E2=80=99t very interesting.  But it is the =
metric that
Linus used when he recently declared his warning mandate:

"we don't have any warnings in the default build=E2=80=9D

If I do a x86_64 build with a very large config, I get 1139 warnings. =
The=20
config I used is:

=
https://github.com/zzywysm/linux-kernel-compile-warnings/blob/master/almos=
tallconfig-5.6rc3

And the warnings can be found at:

=
https://github.com/zzywysm/linux-kernel-compile-warnings/blob/master/warni=
nglog-5.6rc3=20

(Also, thank you Randy for fixing some of these warnings already!)

zzy=
