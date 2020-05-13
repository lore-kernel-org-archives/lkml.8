Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83802CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8C82078C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K7nyBuJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgEML1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:27:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:60017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgEML1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589369260;
        bh=cCH9ce0ofK04oJWNLTkL+FMK4Lj+/hzJecDZWq+GvUU=;
        h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
        b=K7nyBuJV6u5n19FLRuyTLVKcAvPI7E5FePoelJBEJaQszqY7Aw7doma5DbqxhP1np
         Bvr/G2LDw7U/Vq6ZL6F7Mo6/e5CBr6P8gLeK6rv7ai5PBFV3a8tQ1H8o579ul9b2d/
         FFwgSc5L1laZPCUczy4kqIMEeqP0ezMqmo78/aOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.93.10.6] ([196.52.84.7]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhnN-1jCKeg3owL-00vfzI; Wed, 13
 May 2020 13:27:40 +0200
To:     Jason@zx2c4.com
References: <20200507224530.2993316-1-Jason@zx2c4.com>
Subject: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for gcc >=
 10
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <2e80bcf3-d744-3869-2f74-5c1799761ead@gmx.com>
Date:   Wed, 13 May 2020 16:27:38 +0500
MIME-Version: 1.0
In-Reply-To: <20200507224530.2993316-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s8AsjOmGBnJEPBU5yKvJLXAVzgSjJ52CahDBSmYoV1XN693uHZo
 uVOM5h44Ak7M+pL12ap/wSQNlNntWxwECvvl7AvEHZGiacpycgm7QXPWrIlUHf+T8SOnS2f
 60sO4PvH3Wr15Zq2RRvobcpLeu9vXiL3RsJLWWrJS5YMlAKMBsdKGvqnLrty/AQZQGyFsPP
 dLEG7ShQU4T2ZAXvEldJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JPXaNvrnZoE=:jcEmt7eeeRcH4fNWhQmGTa
 y6TiM1n3qexiPLTw+9/6KR91InUsJdE7FoC6g/Eiwf97x7wSg0a3rwOwvV6qJp5fmVCclqkC+
 VYDj2ECMZE0q5IwtQbSdNQNAyrwTlCSMMz6Dt6vfA8iepf0sO3YY/5qusN0jS29Uk/qo1/WiV
 axBm4Eux+EKcMJeegpDQ4YS0YjnG8b6Srep02g8jQtyMPqNfWpyJ29kG5IT9P2Ya317hjcclc
 7klaqEsuv9w4Tivt3ilnYyyxC84AUpI+Cu+erDIQJslMgHgSUTJ/6OAyZ6Q0fFuukJ5elMz+u
 rNIAdgWB3peNdd0VZ7d5oAgjjGegmnsrCtyJJbxzRshkXxx/3/wv5mE8EKtdTqAJaS4xhGOLT
 RENvFgyAySciMdVyiMt81qsShVMw9DprFUwa8O1/xaRMbnvwn/yuFcgqY2vq3m5URtb91MWHB
 0MvG6/VLqJAqQtdRht9QY6JvCeNeQ55iiP8WaM34f1wqfLqp3eSdIr2GD7dMHqH44tkJ+1L4F
 e9cFmtERG6KJR5s8MrkeFiqsM+YgwegpVjdiOmy5h/CaIhRknM6NrzY2ZFz+G2B/TFTtqLxjm
 hLoR0fClVEnNAW4ZAX4shh5Bk0WjyVwNeYhF8sVkzHtLGkCy9nOAckgIqG+UhdBMoJA5ZOC/y
 pzA71xiidQ3EmiIY/EBlzz+WmCYhiIDuY9ahG2ziqzvygKk8Q9uQ08+LUePImp25fki4b40zL
 KhRe4GgmMPV8NZM/fThHeblly9OvaxBBBd1vjDPyoj4SOt/8vnb56V2PsSGLxRie0x1Qg7juJ
 Q70GXNbOyLZJCNJWBkH7Ipsg8bXbNZZlRAFw3PZV2aVJgSSx2KSr9SYHowWjWXuYtJ6MJ5/6r
 QQzceGJdbATiLwheTWCclzw++Kma83lMFJENNWe/aQ6MMRVyAeu78xjc7QhsD9bs1+jfEf6+l
 TCIfWIZiNFpzu0+D++VWEyBTvK4qEaeaJZtrMopI/U8s8A86fVC9auqN2NwWwpCxX6TCAwZXK
 89Zw9AkovVNTNsS53zpXlmwEBjgyprLPadajKdY/YY+sK3WDiTiuKZvHhPhZ1rC3EuYNemkT8
 eZJKuLFJx2iiHWvYmPrzLrrbk07cVpHBJoWCnkF2xVa7fYKZs6sRleqVZLMvtHk7DSirhratV
 HeMEl53PcPUTT1eEmk+n0batrLOIJe15xZPxEvxB+0yZQb4URMrIG8Z5E6OW+rdMU5Pgs/ewY
 l7H4GHcp59t0nW1jT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > GCC 10 appears to have changed -O2 in order to make compilation time
faster when using -flto, seemingly at the expense of performance, in
particular with regards to how the inliner works. Since -O3 these days
shouldn't have the same set of bugs as 10 years ago, this commit
defaults new kernel compiles to -O3 when using gcc >=3D 10.

It's a strong "no" from me.

1) Aside from rare Gentoo users no one has extensively tested -O3 with
the kernel - even Gentoo defaults to -O2 for kernel compilation

2) -O3 _always_ bloats the code by a large amount which means both
vmlinux/bzImage and modules will become bigger, and slower to load from
the disk

3) -O3 does _not_ necessarily makes the code run faster

4) If GCC10 has removed certain options for the -O2 optimization level
you could just readded them as compilation flags without forcing -O3 by
default on everyone

5) If you still insist on -O3 I guess everyone would be happy if you
just made two KConfig options:

OPTIMIZE_O2 (-O2)
OPTIMIZE_O3_EVEN_MOAR (-O3)

Best regards,
Artem
