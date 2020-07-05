Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A442820724
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGEUGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:06:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:51506 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgGEUGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:06:42 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0D26C2E2;
        Sun,  5 Jul 2020 20:06:42 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:06:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] Documentation: Coccinelle: fix various typos etc.
Message-ID: <20200705140641.3b1442d6@lwn.net>
In-Reply-To: <def28907-18b9-5b7a-e743-79b0418c946c@infradead.org>
References: <def28907-18b9-5b7a-e743-79b0418c946c@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 12:17:32 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix various typos etc. in dev-tools/coccinelle.rst:
> 
> - punctuation, grammar, wording
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: cocci@systeme.lip6.fr
> Cc: Markus Elfring <Markus.Elfring@web.de>
> ---
> v2: s/at minimum/a minimum/ (Julia and Markus)
>  Documentation/dev-tools/coccinelle.rst |   40 +++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Applied, thanks.

jon
