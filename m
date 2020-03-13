Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_96_XX,
	ENCRYPTED_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FEC5518B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5065C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:09:36 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:29364 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCSIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:35 -0400
Received: by mout-p-101.mailbox.org (Postfix, from userid 51)
        id 48jfhF5ThdzKmfB; Thu, 19 Mar 2020 09:09:06 +0100 (CET)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48hc9X41dBzKmcm
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 3Xxtn6OgBiBj for <linux-kernel@vger.kernel.org>;
        Tue, 17 Mar 2020 16:12:45 +0100 (CET)
Date:   Fri, 13 Mar 2020 20:59:15 +1100
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
Message-ID: <20200313095901.tdv4vl7envypgqfz@yavin>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
MIME-Version: 1.0
In-Reply-To: <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
X-TUID: WdayTkSEqCJn
Content-Type: multipart/encrypted;
        protocol="application/pgp-encrypted";
        boundary="1584094181/205813/95642/localhost"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-encapsulated message.

--1584094181/205813/95642/localhost
Content-Type: application/pgp-encrypted
Content-Disposition: attachment

Version: 1

--1584094181/205813/95642/localhost
Content-Type: application/octet-stream
Content-Disposition: inline; filename="msg.asc"

-----BEGIN PGP MESSAGE-----

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
PJudmQ==
=ixSU
-----END PGP MESSAGE-----

--1584094181/205813/95642/localhost--
