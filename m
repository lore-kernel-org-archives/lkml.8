Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5573D20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IPqHeO5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEPPCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:02:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgEPPCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:02:34 -0400
Received: from zn.tnic (p200300ec2f1da500c93c46d36c4c5f0e.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:a500:c93c:46d3:6c4c:5f0e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B97231EC02F2;
        Sat, 16 May 2020 17:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589641352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ScgOQebiGu0KeKXh1PZEQWVWq+c5AmF15qTFduVQGXc=;
        b=IPqHeO5coInW11hgf9AkTZo3U0blIynxV017ZOVLgsm6XC/uSTQn72SAog15bV+avspk5/
        Egvimq2hkuA/j2zotw7DLFSi1TQTYl1NYWR3X9MBIa+CQ0GY/VD30jcN2//0hFbnhFQ7e4
        7rdWGnOANwk5CVEFBRu29YEW59TA6wg=
Date:   Sat, 16 May 2020 17:02:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200516150229.GB19372@zn.tnic>
References: <20200505184648.2264-1-tony.luck@intel.com>
 <20200516065431.GB25771@zn.tnic>
 <1138B55F-89DD-4ABA-98C2-61D2ED961764@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1138B55F-89DD-4ABA-98C2-61D2ED961764@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 02:47:42PM +0000, Luck, Tony wrote:
> There is only one actual machine check. But the VMM simulates a second
> machine check to the guest when the guest tries to access the poisoned
> page.

If the VMM unmaps the bad page, why doesn't the guest get a #PF instead
injected by the VMM instead of latter injecting a second #MCE?

If the guest tries to access an unmapped page, it should get a #PF, I'd
expect.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
