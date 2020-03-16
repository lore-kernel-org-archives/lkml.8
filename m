Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DATE_IN_PAST_24_48,
	ENCRYPTED_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410E62072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCSIJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:09:10 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:43886 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgCSIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:09 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48hc9w6B0pzKmds
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:13:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id VmV0JvK_pR0d for <linux-kernel@vger.kernel.org>;
        Tue, 17 Mar 2020 16:13:06 +0100 (CET)
Date:   Tue, 17 Mar 2020 01:21:11 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
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
Message-ID: <20200316142057.xo24zea3k5zwswra@yavin>
References: <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
 <20200313095901.tdv4vl7envypgqfz@yavin>
 <20200313182844.GO23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20200313182844.GO23230@ZenIV.linux.org.uk>
X-TUID: e/MLe+hCS29J
Content-Type: multipart/encrypted;
        protocol="application/pgp-encrypted";
        boundary="1584368685/518741/20472/localhost"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-encapsulated message.

--1584368685/518741/20472/localhost
Content-Type: application/pgp-encrypted
Content-Disposition: attachment

Version: 1

--1584368685/518741/20472/localhost
Content-Type: application/octet-stream
Content-Disposition: inline; filename="msg.asc"

-----BEGIN PGP MESSAGE-----

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
=aDWU
-----END PGP MESSAGE-----

--1584368685/518741/20472/localhost--
