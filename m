Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A849C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB8E20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yi0s3b6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgBNJFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:05:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgBNJFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:05:44 -0500
Received: from zn.tnic (p200300EC2F0D5A00F0C2F03C7F1C4548.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5a00:f0c2:f03c:7f1c:4548])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4A821EC0570;
        Fri, 14 Feb 2020 10:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581671142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5j3ZjigwZ3zGXN14rYl0tUEzvt2zvOdTA+Q2q/hVZ4M=;
        b=Yi0s3b6sgjbqizw1/UtzB9JEUktNWqOCShbVh5RnH/3pZDhOwLs6TYkU0h2dMtkBauYLKN
        6uY5bo/IuXywdXg94fDEINl8hXjF1NIFA9zAUBTuaS9n0KC8VokgHEFpzIFEpxvf5lEzVH
        6mfUM2FivlBAzaSSeXL5BHmx14/BF6Q=
Date:   Fri, 14 Feb 2020 10:05:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/mce: Change default mce logger to check
 mce->handled
Message-ID: <20200214090537.GF13395@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-6-tony.luck@intel.com>
 <20200213170820.GN31799@zn.tnic>
 <20200213222750.GC21107@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213222750.GC21107@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:27:50PM -0800, Luck, Tony wrote:
> That's pretty hard with a chain.  I think folks will have a conniptions

LOL. And they do already for other things so let's spare them :-)

> if we invent an error return from a notifier chain function that means
> "Go back and start over". Though if we did it would make the "handled"
> field useful for functions that didn't want to redo ... they'd just
> check if "their" bit in handled was already set.
> 
> Still, seems like a terrible idea.

Yap.

> If some driver really wants multiple bites at an error on the
> chain it could register more than one handler with different
> priorities.  In which case we should have "enum" names for the
> highest and lowest priorities so such a driver can go "first"
> or "last" (though such a thing would be dependent on whether
> some other driver was attempting to add a "first" or "last"
> entry on the chain).

Yap, makes sense. I'm fine with us even having a possible way to do
this, *if* someone decides she wants it.

Ok, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
