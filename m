Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96861C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FDA2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgH0QQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:16:02 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:48044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgH0QP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:15:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A8A618384366;
        Thu, 27 Aug 2020 16:15:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drop48_1110f0b2706e
X-Filterd-Recvd-Size: 1744
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 16:15:57 +0000 (UTC)
Message-ID: <4a680693ac758647c8e936ef71f067571c12f46d.camel@perches.com>
Subject: Re: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Thu, 27 Aug 2020 09:15:55 -0700
In-Reply-To: <8fc9d4a25f25472384d9de2b6d5e8111@paragon-software.com>
References: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
         <63ae69b5-ee05-053d-feb6-6c9b5ed04499@infradead.org>
         <8fc9d4a25f25472384d9de2b6d5e8111@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 16:01 +0000, Konstantin Komarov wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Friday, August 21, 2020 8:23 PM
[]
> > > +- Full journaling support (currently journal replaying is supported) over JBD.
> > 
> >           journalling
> > seems to be preferred.
> > 
> Have to disagree on this. According to "journaling" term usage in
> different sources, the single-L seems to be the standard.

In the kernel it seems to be a tie:

$ git grep -i -w journalling | wc -l
109
$ git grep -i -w journaling | wc -l
111

I think 1 l better.


