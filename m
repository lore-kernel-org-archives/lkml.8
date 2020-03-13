Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_96_XX,
	ENCRYPTED_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4CEC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE192072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgCSIJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:09:15 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:58200 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgCSIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:13 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48hc911MSCzQlF1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:12:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id ea_laj_n9BJm for <linux-kernel@vger.kernel.org>;
        Tue, 17 Mar 2020 16:12:18 +0100 (CET)
Date:   Fri, 13 Mar 2020 20:50:16 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
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
Message-ID: <20200313095003.aqchjfnu2rzefes6@yavin>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
X-TUID: gZo3XffoHgFt
Content-Type: multipart/encrypted;
        protocol="application/pgp-encrypted";
        boundary="1584093273/901764/120428/localhost"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-encapsulated message.

--1584093273/901764/120428/localhost
Content-Type: application/pgp-encrypted
Content-Disposition: attachment

Version: 1

--1584093273/901764/120428/localhost
Content-Type: application/octet-stream
Content-Disposition: inline; filename="msg.asc"

-----BEGIN PGP MESSAGE-----

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
4ADqPBmctK1qKBqb
=9mAc
-----END PGP MESSAGE-----

--1584093273/901764/120428/localhost--
