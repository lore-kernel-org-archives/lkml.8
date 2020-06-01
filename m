Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886F820734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fgfGvqeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgFAIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:04:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:46477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgFAIEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590998660;
        bh=gD1jYMR6Jfe1KRuDkbv5y4rc2qhXM0mIYVUCsOXLWBQ=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=fgfGvqeHv7QT62Tuz73nB/yAX711cylCu4d1bZINRP4RpPM/qXIpDmAM+7icX8nPp
         rfelJ5Ihc4tFrwyuaMqUrfjpFg9no4I9aOW/8jAkzrdslfGKgJc00zofmH10wt7DZV
         seEOemaCDSpgxexNkF4z+wR9389e9eQxyRXYKRbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.8.38.77]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1jfO313OBL-0020bG for
 <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:04:20 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Subject: a CGroup issue: a weird value in memory.memsw.limit_in_bytes
Message-ID: <f2fa95b8-4989-ebcf-f609-33ef49dc8acf@gmx.de>
Date:   Mon, 1 Jun 2020 10:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wLt0DUq2TQRbeFhq7JrUl9jW6yfDLn9cJ6A0zkRzjZ3P0IvCzWM
 lJKRYUSJGHB5tDaQqU4vl3XoyX5OhSIql+plGTYNnCIpmo5f82n0kNqUzxQtykpLyiMGZOp
 fi7nS1JoRlrKQ/AJBXpavO9agdXCx56ZNZlkM089FPhRx4USfx3+YowBwDMmoIVRPBKfcbG
 Lz82e1+vjoySAZE3ySnKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lgE9ZRvZ+iM=:asv8jJHqNQntTOeoCHtfz3
 3d7C85hvvaz3koma6WNs+EKPFkbLYTkmcZj2fJFFJ8QNAxg0SE16JsiI7AItyprKB7bYDRTy8
 gs+FGFnA8ZWVXm7tAN/wwALxZKBZZBsE3EnCu0hRGIkxV3bRVUl6KMjYoC2umJjxjY0ulETva
 iEfBbgWaFz0epITRDT0a2JiCxpZm4YW5RyFMBeDzK6G87Ec9Z7xgZuyvv0G592KIV6nslFZVM
 VbzhcnZpLYhD9qCVBF79UyxkCC7jZWnyFLGvzuYFpqZROWdaqK2l1pkaYhnZDLzJd7Tf8+d0N
 PoR4uNlGrsrW1GfY1YU5xG4GlZlwRq1mPOQ7mTeAkrHbim/F0PjWx+OidjH+bo2OmOOYGZPbC
 hhzIzr/+IS6O7tO29/Wz/MWgY3QORt/6+1i0dIfcBdbmatBS3k1jnPArkJBGk9Sno6QyR3PPf
 RxBhiWa3xWxr2sIERg96ouKX18sjhDnoiEDsutYg/Z0ghZmNbm5HKmxyTQVtpNM2gPW2ZXG3h
 FvyC4RNwko4WJBrt/hPIxywisrq5QxCTD0LtyLWDN8K7X/ge43bb7gPY+sNGHgvKOwoyJgbEr
 Lz/G60y59npXZQ/Q7HRaaCdi3dhiV7tj7FKxpI9D2eiH+6zTEjAzKNDHAibHFzzKyNDk1wGEd
 dtQ/NJEuGVsG5LxbzESsVO5Jwx/dhBL+++CPhmOCgffQ3EcKdP9swOUiBuIoZ6QXpTzgvddfu
 lX21bvOFc6obMN+idMuOqmBDjm5ShLKJIzoO3IxePSBtec2b7O3QbjvQPWEeCeYmpD7UI4cIa
 bh7iB5jPK05NW4gZEUgTnZflXmDV9YrGxWZeaYpk1cRG/664cBwSxfHKhWGEVGjs99wNKkabP
 u2dCHSTLBURX6/lslqrFc8ksSP7k3WMWyKK3LIjNk6AdZ/vak89Z0cdpYQHvvOL0jPZlPV8SB
 jUkJkKrL1dUPbFq/nxe9LTj1qE/gV1NcSqRIGD8Tkl5rWp7GvNOo5GpBCN7dVShQbY0PwHRFE
 qXpJO64AewrAx9NsgF5CKg54Lir24yofbc22aFlHkYnMplEq4VT0VnRKVWzLXA4JYzMuSKSpM
 wuDrU7KcPUqxLLM5EhmtbDPpsA7JrSQC3zGe2VccdgfMUVDW2QYRYQHMsA/bjGmD1U9nSE4DK
 TBTGJfcxYJQIemg2IkVVwQO1M/qfngjKZcsdGkHQzgi8m4NWESsh1P9wb1hU1h25ZKD+CAmHV
 QjAjr1xFRt/wrDX6K
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do wonder about this value:

# grep ^9 /sys/fs/cgroup/memory/*/*/memory.memsw.limit_in_bytes
/sys/fs/cgroup/memory/tinderbox/17.1_developer-20200531-193248/memory.mems=
w.limit_in_bytes:9223372036854771712
/sys/fs/cgroup/memory/tinderbox/17.1_developer-libressl-20200531-194547/me=
mory.memsw.limit_in_bytes:9223372036854771712
/sys/fs/cgroup/memory/tinderbox/17.1_hardened-20200531-195425/memory.memsw=
.limit_in_bytes:9223372036854771712

which are about 2^12 below 2^63 :

# echo "2^63 - 9223372036854771712" | bc
4096

b/c I do write much smaller values into it:

https://github.com/toralf/tinderbox/blob/75fcbe43f58dadfab94fdd67aef1f681b=
b74f451/bin/bwrap.sh#L34

This happens not always, just realized it yesterday at few files.
=2D-
Toralf
