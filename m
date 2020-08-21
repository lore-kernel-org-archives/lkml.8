Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4691DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2988820735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHUTVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:21:18 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:52922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgHUTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:21:18 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 150751803EB5B;
        Fri, 21 Aug 2020 19:21:17 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 59C72181D2063;
        Fri, 21 Aug 2020 19:21:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hate40_0c00a172703b
X-Filterd-Recvd-Size: 1695
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 19:21:14 +0000 (UTC)
Message-ID: <ed518871bf6182bb7d9a2b95074985cf8af1d5c4.camel@perches.com>
Subject: Re: [PATCH v2 00/10] fs: NTFS read-write driver GPL implementation
 by Paragon Software.
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Fri, 21 Aug 2020 12:21:12 -0700
In-Reply-To: <904d985365a34f0787a4511435417ab3@paragon-software.com>
References: <904d985365a34f0787a4511435417ab3@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 16:24 +0000, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.

Thanks.
Proper ntfs read/write support will be great addition.

Trivia:

If this patchset is submitted again with a new version,
please use something like "git format-patch --cover-letter"
and "git send-email" so all parts of the patches and replies
have the a single message thread to follow.

That will add an "in-reply-to" header of the 0/m patch
message-id to all n/m parts.

One style oddity I noticed is the use of goto labels in
favor of if block indentation.  It's not terrible style,
just unusual for kernel code.


