Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0516C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36EA21883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgG1BZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:25:58 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:39316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgG1BZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:25:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3208C837F24C;
        Tue, 28 Jul 2020 01:25:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shake93_3a01cf626f65
X-Filterd-Recvd-Size: 2008
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 01:25:56 +0000 (UTC)
Message-ID: <51cb45c64431540fa0e98288aba7d7366c41d6e8.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add test for repeated words
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jul 2020 18:25:54 -0700
In-Reply-To: <e8cae8c6-84b8-0f1c-d94f-3ef5804a31e0@infradead.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
         <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
         <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
         <4e505c35-8428-89bb-7f9b-bc819382c3cd@infradead.org>
         <16aa5f86f2f899a9156305ead4b7042449278eea.camel@perches.com>
         <cda9b566ad67976e1acd62b053de50ee44a57250.camel@perches.com>
         <e8cae8c6-84b8-0f1c-d94f-3ef5804a31e0@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 17:03 -0700, Randy Dunlap wrote:
> On 7/27/20 12:33 AM, Joe Perches wrote:
> > Try to avoid adding repeated words either on the
> > same line or consecutive comment lines in a block
> > 
> > e.g.:
> > 
> > duplicated word in comment block
> > 
> > 	/*
> > 	 * this is a comment block where the last word of the previous
> > 	 * previous line is also the first word of the next line
> > 	 */
> > 
> > and simple duplication
> > 
> > 	/* test this this again */
> > 
> > Inspired-by: Randy Dunlap (rdunlap@infradead.org>
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Thanks for adding this check, Joe.

No charge.

It seemed simple enough and you are/were doing
an awful lot of work to fix these.

Thanks for that too.

Joe



