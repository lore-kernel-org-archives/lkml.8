Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_96_XX,
	ENCRYPTED_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283BC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28DE2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCSIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:09:12 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:58196 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCSIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:11 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48hc9k6DQKzQlF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:12:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id SPcfIbQ_n371 for <linux-kernel@vger.kernel.org>;
        Tue, 17 Mar 2020 16:12:55 +0100 (CET)
Date:   Fri, 13 Mar 2020 21:00:42 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Allison <jra@samba.org>,
        Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200313100029.x7y3atg6opbxv4bh@yavin>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
 <20200313095901.tdv4vl7envypgqfz@yavin>
MIME-Version: 1.0
In-Reply-To: <20200313095901.tdv4vl7envypgqfz@yavin>
X-TUID: 9JCVK7rviGFk
Content-Type: multipart/encrypted;
        protocol="application/pgp-encrypted";
        boundary="1584094181/570733/95642/localhost"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-encapsulated message.

--1584094181/570733/95642/localhost
Content-Type: application/pgp-encrypted
Content-Disposition: attachment

Version: 1

--1584094181/570733/95642/localhost
Content-Type: application/octet-stream
Content-Disposition: inline; filename="msg.asc"

-----BEGIN PGP MESSAGE-----

hF4DKxGIDJuAmzUSAQdAmVvIB2FuP5R9tS0nT/A3OzIwO98t9YvwPHsG5Z4d7VIw
088d7qpc6jwngun1T+xkELrxkhVhgnFg2bQlBpO1LNQITlnlcfZ2itZTrW1kBCF3
hF4Da9o3/MenwwcSAQdA3dMPDNYbnIfXOb7YS/mJ0u2LA/xLn3SEmGgWdCR8pk8w
cGMLm06QefIHaiS7Z3huaLgN/4v1bZ0JqatErfj5rm/Of8iElRUFafFXZmvJhDj+
0uoBa6AYnhbJSkcOvR9P66d8spYoEGSg5qVDSXjRz1tUHubdwImGpfSIKRCdjcyZ
36igUvHlJMTOeQqOwSPICyIyFMmjryDIsIHrLWC5cp0fuoxfaz1kcZG65DLgerRG
WqdaTY2XddcsIylHWb3BI7kKH8Sg7OfCoOU/+3bMQpBMfkzBaGtc4+pBcBPfTapv
YjBot2lMddhrMZiDtiez4cj9SBfcPNSToRmLT4oO1dHZNNrJZDG3puPpBBz2rYd7
S1ds6CVHGKF25JZyHkNMHfHm9/0tDVXWfB5NX547ZTfq0mSNELXmxohc5JFiYGZ/
mJvY7skeFNlbOYhdmKGUamUPne7M93qJX8XVaZQV5r6qkDORYwVs3lSrlImLog+q
HlSwaicdw0MSR7yJMrBtnV553egigdCHduTgZAT0xkA2RkVEaOvGUoq8UlRk8vgC
w0mHFhEGRWiThv8aACJ3n1iZH4BTFRZAfNMGAUd5cWHxlm7aBA52W8JRd7G6klZn
JFt+WvIDgNYwAraJFKa3bGw6Yha4McYtHSFw9i7k92jOE/SagTmm85okPWrY7vkL
lTdDjNcvAhGO4zMDxFpDqKdzXoD6Z7L5tnlqCd+5/51v3mp1aQ4X0Nek72Tsslw/
IwiMti2f/aXSQYqH7AVjxLY+FxS9YcCkOs3GRf9lEZf+FLLf2BbjUkvrmkpKlfQq
/mStnukYJP/4CPcYYXS8IweN/RblMtRxpuBqBj0hrO3pbWd8UNqPBMa66HbkVogD
JoZqa0bOFRiu6/JRaJVHxQCP+8FbqORaYwpn8tz08l7mLxmXrUMoyqA4cDKYF4Gz
SX8JQaNj8Hx9vZ6x3CMgzAdOtIZOnxk9/BLVlercHVexUY8d8dFlqa+BvEYxPmnY
6KzmQ4BNSmDHDj94ramcMNNhlSRV6OBV29fRtbMuKrymKRIzEE3zAlSMAssR5cRE
AtUfVMRtMk2Zv76flW7M9mJ6SNKMX7k9V4YYLfppupDPaX+YwYYQiLVRJ70DQTDP
5vfK7nqLyKXJGzXauLe3QOFeL7kaCTOLIjNpACLq1XJPsug5aJswDePEq2Nt6nVv
58cRbQpeufi6XzddcZo9yYkK3T5YocP/U48cjI8Oyu8h0oqjgN3v4xTT/A3DNm/F
Y/hxg8NnYhQEQ8t0ACF9yi6KYrC4ff5icRIOyr/LPDWZhZRz+eJ4aUAkV5WjuA05
EjC1cqmsLKnN9lDd+MXhzG0Zzk0V749vUySZnqdddqzufTf3rmf26RXVB2nn3wXA
kbcI0+GquBZpZboX78jgiTqjQffl/6oVV+g8VTucaCpudBE//Ire5SSNYl7Fa38q
4Jg/KW+oU8Y4xispqVTeXnY0PZqkllL06fcySlWaozUtxcsXeNgJKUgX0LCzNEGc
ox8ScJfwkCa55VMfDHqQph4lIao2ZZpponAxYci7m1g=
=gkj7
-----END PGP MESSAGE-----

--1584094181/570733/95642/localhost--
