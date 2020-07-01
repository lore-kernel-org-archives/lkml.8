Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC241C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE01D206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgGAPTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbgGAPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:19:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF99C08C5C1;
        Wed,  1 Jul 2020 08:19:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 148EB2AE;
        Wed,  1 Jul 2020 15:19:16 +0000 (UTC)
Date:   Wed, 1 Jul 2020 09:19:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
Message-ID: <20200701091914.7c8d35c4@lwn.net>
In-Reply-To: <35c7a2b7-a54c-ecd5-9903-efbb6e3c01d2@web.de>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
        <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
        <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
        <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
        <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
        <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
        <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
        <648d287e-3636-1858-1439-103d317f8571@web.de>
        <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
        <35c7a2b7-a54c-ecd5-9903-efbb6e3c01d2@web.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 17:15:07 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> Would you like to integrate any more details from the running patch review?  
> >
> > I am satisfied with the current patch.  
> 
> I got an other software development impression.

Markus, the patch is fine, we can end this here.

jon
