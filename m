Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F322C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0FD207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RKvKfAUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgGANUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgGANUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:20:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A3BC03E979;
        Wed,  1 Jul 2020 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NZ5j0zaMEeBcTQCTIfHMlgD1k2APAiWLx7DBz7K1OM4=; b=RKvKfAUTi2u9gsqOMxXP/SLUI+
        DQfKmNMI/8hU1D5g/hgg43LmXTi+qwaJ5iFIZLXRdqh8FTrKoyfGvrbabGBh8loHmIQ6BOD2ZKVIY
        ooqd+ofQookVnXTPLHDOjXa0DcPReKyOhJRgSCyyZXhuAKl5wyv1uae0w5waanBIX7xVvvl3CElqH
        0B5mn7t0arO7F/bJgsYSXnHJciKOBvlcBVzdaShBKuMz6KF/NjSiDJAhV0bMR7OTT0WnRw48CsQd/
        Ifx1Us/DxmRyDp7MUPkZqiNCb/bgD3VrBI+HvtkALMtP23Yl+ndknsZmHaaZYpZqbavAmd5gv/svY
        AxtWOxrw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqcfH-0006g9-U8; Wed, 01 Jul 2020 13:20:40 +0000
Subject: Re: [PATCH v2] Documentation: Coccinelle: fix typos and command
 example
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
Date:   Wed, 1 Jul 2020 06:20:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 4:56 AM, Markus Elfring wrote:
>>> …
>>>> +++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
>>> …
>>>> @@ -177,13 +177,13 @@ For example, to check drivers/net/wirele
>>>>  To apply Coccinelle on a file basis, instead of a directory basis, the
>>>>  following command may be used::
>>>>
>>>> -    make C=1 CHECK="scripts/coccicheck"
>>>> +    make C=1 CHECK="scripts/coccicheck" path/to/file.c
> …
>>> We might stumble on different interpretations according to the wording “file basis”.
>>> Do you find a message like “make: Nothing to be done for 'path/to/file.c'.” interesting then?
>>>
>>> * Would you like to add any links for information around the support for
>>>   source code checkers?
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?id=7c30b859a947535f2213277e827d7ac7dcff9c84#n198
> …
>> Feel free to submit patches.
> 
> How do you think about to use the following command variant
> for the adjustment of the software documentation?
> 
> +    make C=1 CHECK='scripts/coccicheck' 'path/to/file.o'
> 

I don't understand the reason for that change...


-- 
~Randy

