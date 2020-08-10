Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C03C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F972070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHJOTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:19:17 -0400
Received: from ms.lwn.net ([45.79.88.28]:53298 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgHJOTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:19:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8E192C1;
        Mon, 10 Aug 2020 14:19:15 +0000 (UTC)
Date:   Mon, 10 Aug 2020 08:19:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] documentation: coccinelle: Improve command example
 for make C={1, 2}
Message-ID: <20200810081914.37224551@lwn.net>
In-Reply-To: <ffe8c50d-0bb5-9477-a20c-96aa7bb45067@web.de>
References: <ffe8c50d-0bb5-9477-a20c-96aa7bb45067@web.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 09:30:18 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > Modify coccinelle documentation to further clarify
> > the usage of the makefile C variable flag by coccicheck.  
> 
> How do you think about a wording variant like the following
> for the change description?
> 
>    Clarify the usage of the make variable “C” for coccicheck.
> 
> 
> > +C flag is used. The C flag is a variable used by the makefile  
> 
> Can such a wording approach trigger understanding difficulties?
> [...]

Markus, please don't harass our contributors.  This patch is an
improvement and, unless Julia disagrees, I am happy to apply it.

jon
