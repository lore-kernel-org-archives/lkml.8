Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F68C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974642071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2jwLCb2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGATP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgGATP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:15:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA3C08C5C1;
        Wed,  1 Jul 2020 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/3mRpXE2WcpFPbt8RSkz8DlUCIiHtqfq+9DvEmy0pvA=; b=2jwLCb2EtCbo46BZ516z1Y4MhP
        oQ1EQW+ka/hrtaxfJd+ftPtbKiFiwrwZkMbQBdWcpvAfpyqQZeOygY2fCzZnB5M+CpXWqkUh/cWxs
        YWnnMToUVStyEXobc4jV1IXdLnbkjp2qrVDx31lDwxoTqB7yCOz3blmFIl30ePGyjVArK/FGFHlHt
        fzOkRjayoadft1Gk9ttVHK7aqUJlsFZc1tVXgECrAfFfxwPD9e8oD/ewj6vqwQ7iiCUUa+9ixK9b0
        CfLH1/MvtjeYDbT/teQaAdo2NLFYuNiG/USfrdID5E0F39G3DOA/MHvy9qj5J8RiyBgc9DCjJpNRR
        y2EAR8hg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqiCV-0004hm-3Q; Wed, 01 Jul 2020 19:15:19 +0000
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
 <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05f8cb2b-c76e-e2ba-24a8-5676c1792255@infradead.org>
Date:   Wed, 1 Jul 2020 12:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 10:32 AM, Markus Elfring wrote:
>> None of that has anything to do with the current patch.
> 
> Did you test the specified make command for the display
> of expected data processing results?

Markus, if something doesn't work, just say so, OK?
Don't go all obtuse on us.

> How much do you distinguish desired effects according to
> the specification of file extensions for such build commands?

I don't grok that.


@Jon, Julia-
I plan to submit a v3 without the addition of "path/to/file.c" in 2 places.


However, I thought that this:
  To apply Coccinelle on a file basis, instead of a directory basis, the
  following command may be used::

    make C=1 CHECK="scripts/coccicheck"

meant that someone could run coccicheck on one source file, but I cannot
get that to work.

Julia, Markus- can you tell me how to run coccicheck on one source file?


Thanks.
-- 
~Randy

