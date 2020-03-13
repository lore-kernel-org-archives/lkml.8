Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_96_XX,
	ENCRYPTED_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3381BC5518B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1594E2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgCSIJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:09:28 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:46952 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCSIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:28 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48hc9L6gQbzKmXF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:12:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 9iUC7x7Eiguy for <linux-kernel@vger.kernel.org>;
        Tue, 17 Mar 2020 16:12:36 +0100 (CET)
Date:   Fri, 13 Mar 2020 20:53:48 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Stefan Metzmacher <metze@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200313095330.lt5zl7vxufm2elww@yavin>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <1147628.1584032201@warthog.procyon.org.uk>
 <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
X-TUID: XNJuJ+xdfsM+
Content-Type: multipart/encrypted;
        protocol="application/pgp-encrypted";
        boundary="1584093273/945561/120428/localhost"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-encapsulated message.

--1584093273/945561/120428/localhost
Content-Type: application/pgp-encrypted
Content-Disposition: attachment

Version: 1

--1584093273/945561/120428/localhost
Content-Type: application/octet-stream
Content-Disposition: inline; filename="msg.asc"

-----BEGIN PGP MESSAGE-----

hF4DKxGIDJuAmzUSAQdAECXHdwnRm275WPukqxKfQ+WCS8+Fa3zKpFRrq1QwrEIw
8/QjFyBNdoQYMcpqemCUbsEczkW06ttH2+6J+fh0Xp0yhTp4Rc/UGFMAfS8tk/mV
hF4Da9o3/MenwwcSAQdA/QObRnL4UitLI5chK2xchDqZaqL5l5wIN5rOwvWmfycw
SWvHxsXazotf4u5DgpT5/QP2IXtpW7RGiXfYihdqFjo3MMBZSjaUM4aA9bPzJpQ/
0uoBOEYXocjRfIxSoWGXbNIRPfaXzQINnGdP19hx6XonrD1CyhFdQ4dI/xnr/n4R
OCxvWcV+qkggZWJ7bp31pY8mtA0DZIiFo08ve6JbfhDzVV8UYmVskqZ6GdIH9gKJ
NsRgyixBqR4LRIF4EfiRFJIaKXBNJ1is835L2d7XyIQ7qxj69RAvTdeiUoz/m7oq
zyJ8YsF1ibA0De6TPoVzGFtQJ4iReKFaIHOk5pY06brBHzHjDDOdPp02rlkr5I9X
UYDjHgq84xESs2eT4bCaFN4AHy5uKlUinqB+83+JT3l4F8zHvPVZ6AkifwNFezQN
AfzLbORFjzBl95x2ujrr0rwV888jcEczyn2P4y7G/sYs6n65e8KcE+hpMq751Jcm
O0L0IEw+EFiig0sYdrqJMEhI1r2NVM1inKArHK/hO8A49p55+1tDMAFgd2hA96q1
ecFyIxTulF/uNxjN5EVaKv90vXe1kKLvkZf3/OOuIyDAWbvHmpT1WzZX/9mcfgqc
p3e9UNkvb2SkGb+j3e246wFAc0f+5wXE+2HgYt9Nb2AMdoFqpCPSWE7NESWtgci1
Cn226dAzIZ59Sw+fz/sihw0q207vX8XpIHzLjkZYcE7T6qSndPKxMXVyalEEOY1D
huswgUgZ3INJi/ECYREobd1tPkiRYdnkbSqPbAkFZl7CnawXstn8v3vu7HvFAs+L
V1+a8dwWXK7nLG5gqLrGOMiZrnM9+Z2ODWrdf/T67ZfQ0ExGhAY1KW7OGbwK9LNO
pdYiISOxDdIvzOxALCcXMKQitvA2g7An2Pz3eGLi2cKxI+oc2uE3aNqnoyTAPxNm
AScm5RJ4t+sIasEzAXjVhWyT8nE0BLC1nt0vCpl/zeVceMAVB7hDmdLBw7zxNGFY
t/VNP6z76au+LMHhgl/NojG2F+plteEqzDgQOFXPtnlzA138vcGjU+6tsi1zc5En
YDQj1+3oMMvpcgebQzPvA/rQiliPM9OSHG+9AIyE0S8Ma3VLTjU7a0WE7p2JafmT
JqHfqk9u3tGU8IcKAqfuq+8jxoTAvHg0zADOI4j2mC3TZc81j23wf5u7baj34pEd
mPhOo706xgmqf2e6VtcjOzhhXU7Vsr10x7jlNN5Fx/FjEiIWArxk4KS8Ie/xWn6S
P0BDGZS/KMCv1YsRZWv4N1zS/J8OmdpzlcXXNZZqTFlvImVFkamaAL4YSXnAGMed
7uerb1fb892nZ5hqebUSg2myjHRCXRe4pk2XNXJ0yQgSUfkE2r5xm60xx9H/GJrI
ZtxtpVeqQGPX4jQ2cXSKeohBR820gYBls+vZxNLouYUd+bnC8EhLXAbkTcUerI63
DD1S6eFGqnILJZkTBDo6cYkwwDAhWhx93yXyMo+/tYP1+ZJnhtueyCik7fEczKkO
Y9dOWiDDARdqSrw4AtqMwCBrLv5hJlRDT0hrcNwfLg9O7+m+J3KkqXy4ZHrDvrsq
PjE6tXDC4NJ55Yxovetmy/Kizw8b/q5CZaorpSls0CURVoQXhFa9wFbruH6auEyG
rCJIDEM1G/R12YTVOR1nI/WvxLYfZ02mmpYTeyetaZ+Ut5g+JqoRuQK5aIsyV63d
/A3qYIJakJ0Y6wt7LBD6v85AhJnLm1/XJ5zMwSDyk80UJrvjKssAAAz3hINUqWoP
ZmEyLikdE7jyhGjOaq/f91E1iMA=
=/f3u
-----END PGP MESSAGE-----

--1584093273/945561/120428/localhost--
