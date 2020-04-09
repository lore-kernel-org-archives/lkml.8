Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B5C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6980420757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fPxjZEHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDISNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:13:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDISNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VKu2GwHKdy776+Q+3ZafpPkMqFFXezhqf/z/GtNHOOo=; b=fPxjZEHJooPef0SzPRnhP1oPRV
        nv4PSkiOgFB+lgZTQFT/9e1iVzo7GX5aCLua321EeMBoppIgDZUTH8wWRSnkdXm9wU+Ka3I8nWfYA
        GzhFy4Bj5zIMVR1l92EloIo9878xYxSuMYKqjKy/SsRHfYr1obbIJ5KqB/v7KcreNfU6xKMZNpIKA
        CsNJk3c4IQM+83kz3EBU7yJiy8LBIXFSSTfFI6zFNRA/P6PPGybmtAXsLw30VuC1DbDzC7HKFelBI
        eAUKu00GJ3FQ++zKwztTyMj1CN/ZYjHWfQ6oYLtXc78DFnvLVNHPWvEdPscfso5uRa3IA6OsOniqI
        /gqJuIdQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMbfr-0004pk-KQ; Thu, 09 Apr 2020 18:13:11 +0000
Date:   Thu, 9 Apr 2020 11:13:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Cristian Souza <cristianmsbr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH v2] docs: admin-guide: Clarify sentences
Message-ID: <20200409181311.GW21484@bombadil.infradead.org>
References: <20200408144653.GA123268@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408144653.GA123268@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:46:53AM -0300, Cristian Souza wrote:
> @@ -1,34 +1,30 @@
> -Explaining the dreaded "No working init found." boot hang message
> -=================================================================
> +Explaining the "No working init found." boot hang message
> +=========================================================
> 
> -OK, so you have got this pretty unintuitive message (currently located
> -in init/main.c) and are wondering what went wrong.
> -Some high-level reasons for failure (listed roughly in order of execution)
> -to load the init binary are:
> +Message location: ``init/main.c``

I don't think this should be the first paragraph ;-)

Maybe just skip it altogether?  The sysadmin doesn't care where the
message is located.

> +5) **Binary cannot be loaded**: Make sure the binary's architecture matches your hardware.

Line exceeds 80 characters (other occurrences of this)

>    e.g. by providing additional error messages at affected places.
> 
>  Andreas Mohr <andi at lisas period de>
> +Cristian Souza <cristianmsbr at gmail period com>

We tend to use :Author: at the top of the file instead of signatories at the
bottom.
