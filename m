Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8567C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD664206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgGLVtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:49:47 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:48406 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729249AbgGLVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:49:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4EAD8182CED28;
        Sun, 12 Jul 2020 21:49:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk82_3d001b926ee3
X-Filterd-Recvd-Size: 1701
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Jul 2020 21:49:45 +0000 (UTC)
Message-ID: <27660a3e38af43c9e741a4dfcdec50757c32f409.camel@perches.com>
Subject: Re: [PATCH] decompress_bunzip2: fix sizeof type in start_bunzip
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        alain@knaff.lu
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Sun, 12 Jul 2020 14:49:44 -0700
In-Reply-To: <9af191c2-0f2c-7637-433a-b557a07590ca@redhat.com>
References: <20200712125952.8809-1-trix@redhat.com>
         <639c8ef5-2755-7172-fbb8-ce45c8637feb@zytor.com>
         <9af191c2-0f2c-7637-433a-b557a07590ca@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-12 at 08:12 -0700, Tom Rix wrote:
> On 7/12/20 6:09 AM, H. Peter Anvin wrote:
> > On 2020-07-12 05:59, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
[]
> > > So change the type in sizeof to 'unsigned int'
> > You must be kidding.
> > 
> > If you want to change it, change it to sizeof(bd->dbuf) instead, but this flag
> > is at least in my opinion a total joke. For sizeof(int) != sizeof(unsigned
> > int) is beyond bizarre, no matter how stupid the platform.
> 
> Using the actual type is more correct that using a type of the same size.

Sure.

But this hardly matters as this same type conversion
from signed to unsigned or the other way round is
_everywhere_ in the kernel.

And especially the cc of stable is unnecessary.


