Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5276CC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 19:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156AE2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 19:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBBTMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:12:17 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:56756 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBBTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 14:12:16 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990824AbgBBTMNY3IIg (ORCPT
        <rfc822;kernel-janitors@vger.kernel.org> + 2 others);
        Sun, 2 Feb 2020 20:12:13 +0100
Date:   Sun, 2 Feb 2020 19:12:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] defxx: Fix a sentinel at the end of a 'eisa_device_id'
 structure
In-Reply-To: <20200202142341.22124-1-christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.LFD.2.21.2002021858330.683661@eddie.linux-mips.org>
References: <20200202142341.22124-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020, Christophe JAILLET wrote:

> 'struct eisa_device_id' must be ended by an empty string, not a NULL
> pointer. Otherwise, a NULL pointer dereference may occur in
> 'eisa_bus_match()'.

 Umm, that's weird code there in `eisa_bus_match' (I do hope at least GCC 
optimises the `strlen' away nowadays and checks for the character pointed 
being null instead), but as usually with old stuff let's keep changes to 
the minimum.  So:

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 Thanks for the fix!

  Maciej
