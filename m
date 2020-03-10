Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_96_XX,
	ENCRYPTED_MESSAGE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32DC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF95720753
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCSIJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:09:19 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:58184 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:09:12 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48hc8g4q7xzQlDn
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:12:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id yo1XONw00XU2 for <linux-kernel@vger.kernel.org>;
        Tue, 17 Mar 2020 16:12:00 +0100 (CET)
Date:   Tue, 10 Mar 2020 11:55:59 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Stefan Metzmacher <metze@samba.org>, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200310005549.adrn3yf4mbljc5f6@yavin>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
In-Reply-To: <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
X-TUID: wnPNaz9edK1L
Content-Type: multipart/encrypted;
        protocol="application/pgp-encrypted";
        boundary="1583818369/211147/27842/localhost"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-encapsulated message.

--1583818369/211147/27842/localhost
Content-Type: application/pgp-encrypted
Content-Disposition: attachment

Version: 1

--1583818369/211147/27842/localhost
Content-Type: application/octet-stream
Content-Disposition: inline; filename="msg.asc"

-----BEGIN PGP MESSAGE-----

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
=cnO7
-----END PGP MESSAGE-----

--1583818369/211147/27842/localhost--
