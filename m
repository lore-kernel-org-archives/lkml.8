Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78879C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ED72074F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWHv1Ri4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbgF3PLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbgF3PLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:11:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C70CC061755;
        Tue, 30 Jun 2020 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=085m+qYdj3d+tEZKWFcDUm8R54zn/OUFEGECmgixYQk=; b=PWHv1Ri4OahOBANGBdgewR1kYX
        0eV4Y+TiQMLmgJ4d41YcXTM7CKLL9ty0+/e8FIX7uWPhCdNzbZ5lsL4sF0T/6WQ8xW0qEzlA+5B1p
        vdcK2H8HsqkztCWF79XfBWMwQwb0j//v2LNsh5l/chxeVz4IrMzM9lHs8gFcEisyV8y58rMykPlZX
        dxwRpK9JUjzqIeAIuu+v4VGJ5Q/nRbeMXY2x+sJhA43J+ySwFVY0pIqkbn3BY35spqryNtnWoGaaO
        ES3tlzjCAXc5wzqubmWWmKyiagTx0a5NjYpIqlxgoWTF+QWBALMvzD5yIXTfVbMiXudsp2iw8ExDa
        HOUJEpcA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqHus-0005fe-NV; Tue, 30 Jun 2020 15:11:23 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
Date:   Tue, 30 Jun 2020 08:11:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 5:23 AM, Markus Elfring wrote:
> …
>> +++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
> …> @@ -177,13 +177,13 @@ For example, to check drivers/net/wirele
>>  To apply Coccinelle on a file basis, instead of a directory basis, the
>>  following command may be used::
>>
>> -    make C=1 CHECK="scripts/coccicheck"
>> +    make C=1 CHECK="scripts/coccicheck" path/to/file.c
> 
> I would like to clarify further software design aspects around such make functionality.
> 
> We might stumble on different interpretations according to the wording “file basis”.
> Do you find a message like “make: Nothing to be done for 'path/to/file.c'.” interesting then?
> 
> * Would you like to add any links for information around the support for
>   source code checkers?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?id=7c30b859a947535f2213277e827d7ac7dcff9c84#n198
> 
> * How do you think about to enclose the path for the shown parameter
>   by single quotes instead of double quotes?
> 
> * Can such path specifications become more interesting occasionally
>   if also an other file extension would be chosen than “.c”?
>   Would you like to achieve any software extensions around suffix rules?
> 
> Regards,
> Markus

Markus:

Feel free to submit patches.

-- 
~Randy

