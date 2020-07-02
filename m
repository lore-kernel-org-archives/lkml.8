Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A82070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5GUDaE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgGBLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgGBLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:52:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF564C08C5C1;
        Thu,  2 Jul 2020 04:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2LYlRU7JyrrAAhL6kWTw5as9ctpjIL2vXkhqlV5CM/E=; b=S5GUDaE5JvUqQIPOl1eeQuBCS8
        umysz5K1Nthmw6mgoG+czq0B+QKng0w6vkTjXPQI56Ntfmp+/5ljciG1tOY4U7g75CKuMZOXLnpMK
        q36t49YZaXD0gpkuFWEk9seK1ASXD4xuJ558ONNZ6sDJwz0k4pKunw943/I9mslrPck9JOJFvNOKe
        ew5wYag8RUgQrZWAvHjJmqd47WkcaRseCmpETgzq9pLS4b8IQbMp+btEbBCPqknZh7J2SRnjasP8b
        IoU0NYLrF3R0FR1awyfcBvVNfnFAvhBGbGqPNcalm/vkDyyAYOy7Mea7QyE7ui0/DPGq18p3fIlCJ
        6gScIk2g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqxlq-0002WG-FE; Thu, 02 Jul 2020 11:52:50 +0000
Date:   Thu, 2 Jul 2020 12:52:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v3] Documentation: Coccinelle: fix various typos etc.
Message-ID: <20200702115250.GX25523@casper.infradead.org>
References: <def28907-18b9-5b7a-e743-79b0418c946c@infradead.org>
 <63450b02-93f1-1ea0-9e39-c5bb14086ce2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63450b02-93f1-1ea0-9e39-c5bb14086ce2@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:56:24AM +0200, Markus Elfring wrote:
> …
> > +++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
> …
> > @@ -260,13 +260,13 @@ If not using the kernel's coccicheck tar
> …
> > -We help Coccinelle when used against Linux with a set of sensible defaults
> > +We help Coccinelle when used against Linux with a set of sensible default
> >  options for Linux with our own Linux .cocciconfig. This hints to coccinelle
> 
> Another small wording adjustment:
>   … These hints …

That would be an incorrect adjustment.  Unfortunately, you snipped the
rest of the sentence that puts those two words in context.  Basically it's
shorter for "By doing this, we hint to coccinelle" rather than "These
things are hints to coccinelle"
