Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ACAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B4206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YqjJMdYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgETHLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:11:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgETHLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:11:18 -0400
Received: from zn.tnic (p200300ec2f0bab00953ec33d5d0c7a34.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ab00:953e:c33d:5d0c:7a34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A916F1EC011B;
        Wed, 20 May 2020 09:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589958677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QPiIMZUkbpt1Zese/SOX4DKqaNvHdV5YK/MGVLNP5FQ=;
        b=YqjJMdYvUJFeiz+usX4+JRM3w4T5+aunyuXNW4Afav0jWtywiQbASuLZe+Ufr6REqeaWb+
        F3Ldd0wMjoe5fkHz6VMWlQxocjnEX2h7j/5kFTT0sEvNxVrCiEQ1BsSigT9RdRJ/2AqXyX
        o4OW5fCKNauaf3M058xPewlymlrhtkk=
Date:   Wed, 20 May 2020 09:11:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/4] x86/resctrl: Enable user to view and select
 thread throttling mode
Message-ID: <20200520071109.GA1457@zn.tnic>
References: <cover.1589922949.git.reinette.chatre@intel.com>
 <20200519213516.GF444@zn.tnic>
 <1d9ee0f0-8078-e8b6-ce66-6c0bf51cb3b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d9ee0f0-8078-e8b6-ce66-6c0bf51cb3b4@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 03:13:59PM -0700, Reinette Chatre wrote:
> I am very sorry. I was hoping that this series could be considered for
> inclusion into v5.8 and submitted it seven weeks ago because of that.
> The recent feedback addressed seemed to be the final few small comments
> needed to be ready for inclusion and I was afraid that waiting long to
> address this would cause me to miss opportunity to be considered for
> inclusion since we are already at rc6.

That's understandable but does it really matter when it goes in? If not
in 5.8, then 5.9. I.e., there's always a next kernel.

So why the hurry?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
