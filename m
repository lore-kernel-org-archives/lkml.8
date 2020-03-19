Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A6C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684002072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="T6v01yv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgCSVJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:09:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSVJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:09:05 -0400
Received: from zn.tnic (p200300EC2F0A8500B0E932A909542483.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:8500:b0e9:32a9:954:2483])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7337B1EC0CFC;
        Thu, 19 Mar 2020 22:09:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584652143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WTyW5ClbVde/DKYAJcR8mI48JLXYSr1JwaFQzF9KoEw=;
        b=T6v01yv748i0RpZlHQJWMxuQByTaCTl+eTEm0SWWH9w9Qy8XRE8jiNHNsuHS1Ox+d/mC5y
        nAxXiKVi/BpS+Sq6fbZbCheFVmzkYgtGeyb3mNUbd2W+zgyc8FezQIexrEA+W7LyFo/qaO
        w2eF0UV8Y9P+ambxwgXNyKF6Q7Bzb/E=
Date:   Thu, 19 Mar 2020 22:09:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Huang2, Wei" <Wei.Huang2@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Koralahalli Channabasappa, Smita" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Message-ID: <20200319210909.GH13073@zn.tnic>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
 <20200316180829.GP26126@zn.tnic>
 <53d25b8c-dabe-1b91-4d3b-0a223075e42a@amd.com>
 <20200319202134.GG13073@zn.tnic>
 <CY4PR12MB1352F7AED37C67DAECC063E6CFF40@CY4PR12MB1352.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR12MB1352F7AED37C67DAECC063E6CFF40@CY4PR12MB1352.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:58:17PM +0000, Huang2, Wei wrote:
> However, there is a small problem: during boot, mce_setup() is called
> once before mce_amd_ppin_init() is invoked.

Which call site is that exactly?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
