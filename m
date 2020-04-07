Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91977C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF6D20731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PmmIVYlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgDGLKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:10:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgDGLKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:10:51 -0400
Received: from zn.tnic (p200300EC2F0B270031CC7BB993460DB2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:31cc:7bb9:9346:db2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEF6A1EC0CD1;
        Tue,  7 Apr 2020 13:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586257850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kKSXjR2zcfAfxC6hm8YraN9x9I1XacHZ4DYRo5xZxuo=;
        b=PmmIVYlKh4MZc63sWAH8xBpIsTiN3nGyOKx/W+u7vSJ8zMRRc7SovkrUBbxrNGd28t547K
        LyWeK2LZfmQ5MUtxhDGY4hrraBhkQjQddj50brZ6x0fFuFQkHaGuv2/ygFd6fBsB7qtqB5
        /UkXWanYhMWNjjVOduQadJg0kjrRb8o=
Date:   Tue, 7 Apr 2020 13:10:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] x86/mce: Change default mce logger to check
 mce->kflags
Message-ID: <20200407111047.GB9616@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
 <20200214222720.13168-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214222720.13168-6-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:27:18PM -0800, Tony Luck wrote:
> @@ -261,6 +249,8 @@ static void __print_mce(struct mce *m)
>  	}
>  
>  	pr_cont("\n");
> +	if (m->kflags)
> +		pr_emerg(HW_ERR "kflags = 0x%llx\n", m->kflags);

I've zapped that hunk. I'd like to avoid exposing those kflags to
luserspace in any shape or form for now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
