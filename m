Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B275C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714BB20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGOGXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgGOGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:23:49 -0400
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:23:49 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id D15FC602BC;
        Wed, 15 Jul 2020 08:23:43 +0200 (CEST)
Date:   Tue, 14 Jul 2020 23:23:43 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        torvalds@linux-foundation.org, ribalda@kernel.org,
        viro@zeniv.linux.org.uk, mchehab+samsung@kernel.org,
        luis.f.correia@gmail.com, geert+renesas@glider.be,
        paulburton@kernel.org, cyphar@cyphar.com, martink@posteo.de,
        davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: remove link http://www.dementia.org/~shadow
In-Reply-To: <20200714154708.71b3efe2@lwn.net>
Message-ID: <alpine.DEB.2.22.1.446.2007142318110.9019@trent.utfs.org>
References: <20200713114321.783f0ae6@lwn.net>        <20200714193805.49746-1-grandmaster@al2klimov.de> <20200714154708.71b3efe2@lwn.net>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Jonathan Corbet wrote:
> >  N: Derrick J. Brashear
> >  E: shadow@dementia.org
> > -W: http://www.dementia.org/~shadow

That particular entry moved to:

 W: http://www.contrib.andrew.cmu.edu/~shadow/

(The https version only supports TLSv1, and Firefox balks)

Otherwise, what Jon said:

> So thanks for addressing these.  That said, I do wonder if this is quite
> the right thing to do.  I'm assuming that the old sites still exist in the
> wayback machine somewhere, and somebody might actually want to find them.
> Pity the poor anthropologist researching the origins of the the
> billion-line, free-software kernels widely used in the 2500's...
> 
> So maybe we should either mark it as "[BROKEN]" or make a direct link into
> the wayback machine instead?  That would enable the suitably motivated to
> go after the content that once existed.

As an innocent bystander, I'd opt for [BROKEN] tags, or Wayback machine 
substitutes, instead of just removing those entries.

My 2 cents,
Christian.
-- 
BOFH excuse #128:

Power Company having EMP problems with their reactor
