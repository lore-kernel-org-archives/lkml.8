Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F17C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B85E206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGZRtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:49:07 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:38526 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgGZRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:49:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E72A7100E7B40;
        Sun, 26 Jul 2020 17:49:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: woman01_070b5d426f5a
X-Filterd-Recvd-Size: 1771
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 17:49:04 +0000 (UTC)
Message-ID: <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Date:   Sun, 26 Jul 2020 10:49:03 -0700
In-Reply-To: <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
         <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 10:23 -0700, Randy Dunlap wrote:
> On 7/26/20 7:29 AM, Christophe Leroy wrote:
> > Randy Dunlap <rdunlap@infradead.org> a écrit :
> > 
> > > Drop duplicated words in arch/powerpc/ header files.
> > 
> > How did you detect them ? Do you have some script for tgat, or you just read all comments ?
> 
> Yes, it's a script that finds lots of false positives, so I have to check
> each and every one of them for validity.

And it's a lot of work too. (thanks Randy)

It could be something like:

$ grep-2.5.4 -nrP --include=*.[ch] '\b([A-Z]?[a-z]{2,}\b)[ \t]*(?:\n[ \t]*\*[ \t]*|)\1\b' * | \
  grep -vP '\b(?:struct|enum|union)\s+([A-Z]?[a-z]{2,})\s+\*?\s*\1\b' | \
  grep -vP '\blong\s+long\b' | \
  grep -vP '\b([A-Z]?[a-z]{2,})(?:\t+| {2,})\1\b'


