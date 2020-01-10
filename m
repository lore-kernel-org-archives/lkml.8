Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD611C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314B2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fExreOjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgAJJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:01:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54960 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgAJJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:01:24 -0500
Received: from zn.tnic (p200300EC2F0ACA007185EBC54541D9EE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:7185:ebc5:4541:d9ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 274961EC0CAD;
        Fri, 10 Jan 2020 10:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578646883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xnr6C2hDjOfC/HacyeY5eXZFfWBvMpn+1v9XrGxlkcg=;
        b=fExreOjg50CwGhojk/7t5ZrmIE/pZE8+UBsOJa34ZX3gQYj4k082fLHVjL2LB8YDLqxWOh
        c0CxbZAjJkgFbkB0YY5S3XQ0drf7kSNtyEspHXjBzgbcvGqcdY2X9HjQtbDpx+TFOvKpc0
        aHe2yFs14XcxxIPmHa0BiPZ8LCPj8qw=
Date:   Fri, 10 Jan 2020 10:01:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200110090120.GC19453@zn.tnic>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic>
 <20200109204638.GA523773@rani.riverdale.lan>
 <20200109205041.GJ5603@zn.tnic>
 <CAFH1YnNdmHD9rnriTVx-se-Z5MHsgUZ0jYWMrg6OYVjr4Ap+JQ@mail.gmail.com>
 <20200110082700.GA19453@zn.tnic>
 <CAFH1YnOpuv3MOvJnkSoyhwgmTP_9uGyh0BzyscanRzhXrPbALg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFH1YnOpuv3MOvJnkSoyhwgmTP_9uGyh0BzyscanRzhXrPbALg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:36:26PM +0800, Zhenzhong Duan wrote:
> I'm sorry on that. Will do next time!

Do that *every* time from now on!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
