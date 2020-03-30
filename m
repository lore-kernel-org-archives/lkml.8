Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A61206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iYesi6c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgC3KQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:16:22 -0400
Received: from mout.web.de ([212.227.15.3]:40595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgC3KQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585563355;
        bh=zsBiGiIa31e8ui1zxfktpO90PCVnD6YbHW9QGGkN6zI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iYesi6c+Ehu6DJlJusWXqKk19qoqYFKVfwAgcaGtFfit8qKga87FN/CcfmzfYW8n7
         Ud9bmK5kmOoxbVNVvxYTjvscUJuujaebkt2FiHtbZQ2TmISo8c8lZmcpLATe/xE6wI
         L/Z84mQONvoFPFsA1LYh2EKFdfiLpOmuvT9f4Jco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.71.255]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MT8x4-1jkruP27M6-00S7s8; Mon, 30
 Mar 2020 12:15:55 +0200
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Improving the Coccinelle
 software
To:     Julia Lawall <julia.lawall@inria.fr>,
        Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
 <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de>
 <alpine.DEB.2.21.2003301046530.2432@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a840e22a-0152-6aa2-e626-33011ef4afe0@web.de>
Date:   Mon, 30 Mar 2020 12:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003301046530.2432@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DizUx6WtbYFM5m80rOwdVZvvtZR2W/LOfgobqr9fxTnoj73+9Wy
 jgDhUjk0OfEM29HNYJMMeDVsel5ybIkjVsn2/S01Q9QMnxg8BaUUdPWaMq0Fzz2BD7gVpzo
 No+Mk3D+rR1WTHAjOVuK6ToEbaMaP9VtS9j0OBQPyjTjnuIiMPIH7113E7VjKNXHvq4KnwW
 zMvtJtCB1USycWhtFm94A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KvXrQBUKEGg=:Vrc3p6B1s95MJKwXe7GiWK
 EACDx/DP1V9otIkc0oHgDnOs6nwBhl/dsE7zrKrnWMtX6CCXnPYU1oTNBH8mS1tCkYoPgQgAu
 9ql98nfzYQN/1nqnQ3HSu+DTdh0b+AHkzg3UwxV0iPDB7gEK8n2B7dn3lxNpyF6QkdqfZH7Pe
 lBd5kjSl4eNa8Q7ZLBBSVvh5V0LvV/Yy6I/RU4MANEKzaGKGDqNYzTP4bUJ8sQV8uRs0Gfax5
 CwO3LVA4qpB2xa/Pgc9Oukcg+lg9I/P0GirI3qnOPAyJpqUwbGTV0V0HJtNF4fNhbLoj8ITQp
 Yv0af655kb4dgoFD3lkb9vav+UPRWgE3QWUOjvQoosqRwnEV1ulYQCvHjz5DGDfQfg3H+SS6Q
 doTKv6tbdLw4Nxem0n3IvfgK+Io7zOZsyDgoYRQIP8a1DOEXDSX+K0pNIzsKGA7td3dvj+8B3
 85dnberzifmlu0tGWg0Kp1RPkpIcfIdkyifD/dPA6l5sURpxEdQ+ccUnBa9GNrurZCtfG5XLm
 1gynxliIziP7UZpaihAf9BLkr5Wtd3au+JDbbX3qDyCLwmDIjN8GtJNi+2aGXxJy4SDA+7NE4
 z1zooQpQU2D24L4o4ZSbHlcm3nJpBfOhoH5uZ0JxeGmSQvaymIH1EuawO2TYuZh+8NJDSi3Gm
 8VNw1Q4L4sLoqEpm9EpDKNxnewWwAYtpvysQKCwpnFDt8O0udKo914QEbw9VqEx88bB5DtEDI
 lUrllLA8ndU+9QPPxP94gtrgQllwgyQ9DSt5Hqgbz4KULU+6KZYRgwTDQSp0UzjvjzRebHn9r
 K6n2705gHfGRYcxN0ibnaN9TQwVkhoStQH9fZkISRrc5BN4fmYef6TFHa83y824FKWy9Y32sK
 FyviUWifHJH6/C0XtwTLlquxtnfCn77v0KZFJHjEI8aIU0gQCFyFrxjXMzh/6OZCbJPMtzkvJ
 pn/94WHL+by+k9IEshXHHFDl58HabIIl4G+WMPKi0+rLnltNRC8kFsbBtyHxWBK0XP8XJ4AIc
 IpQeCDhSFSbStqVK7DhIvyxRsFbSeHYEX71+/I57hlE0eQAspxVkxACyo6cWgamRgx84atFYJ
 GNvsYJaxV4q5M8idRpcs5GdZ8BZzixsQaevtmcGUwvabQKs6Qx4HwvLHL5el7z5RXDSRDgRmV
 MPTFz5uptrE5BXF2/6XGuw2pZqLzzQIvHt7FV68QLIHaHvXUnAezYIkE7l22CVNcvF/nZH/xn
 5TX3SKX5eEMMkDXM1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> =E2=80=A6
>> (ONCE) CPP-MACRO: found known macro =3D FNAME
>> =E2=80=A6
>> parse error
=E2=80=A6
>> How would you like to improve the affected software areas?
>
> This can be addressed by adding a macro definition to standard.h.

A corresponding specification is used already.
https://github.com/coccinelle/coccinelle/blob/fdf0b68ddd0a518cc6ca64f063bc=
74ed54e29a7b/standard.h#L508


> But once the change is done, I don't see any reason to bother with this.

How will the support evolve for data processing around the application
of similar macros?

Regards,
Markus
