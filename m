Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327AC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4B42051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A1+8yNm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCQVGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:06:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37316 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCQVGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:06:00 -0400
Received: from zn.tnic (p200300EC2F0C960029779DE4AAC583E4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:2977:9de4:aac5:83e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15F2D1EC0BFD;
        Tue, 17 Mar 2020 22:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584479158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HFR+t8qs+BETW/cIOn04p67zo0Dmc/q+y8ZzD5mYjgU=;
        b=A1+8yNm1sVm9L2XdYDq9Jn9i3fFQiAY+YK18Dd3iHshwbAShdu/tGs0xXWZNWZ4toGozad
        WRDRFAIPfqS7qTVWEWkoeWh8j7BphzvIGaZ0eWhpSnaSeeyB5oCxzdp9v3VCs7feFCMwzm
        4txEsQKLkI1UDSFIlhaJHoqHMbyNKbI=
Date:   Tue, 17 Mar 2020 22:06:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200317210602.GG15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
> On 3/17/20 4:18 AM, Borislav Petkov wrote:
> > Back then when the whole SME machinery started getting mainlined, it
> > was agreed that for simplicity, clarity and sanity's sake, the terms
> > denoting encrypted and not-encrypted memory should be "encrypted" and
> > "decrypted". And the majority of the code sticks to that convention
> > except those two. So rename them.
> 
> Don't "unencrypted" and "decrypted" mean different things?
> 
> Unencrypted to me means "encryption was never used for this data".
> 
> Decrypted means "this was/is encrypted but here is a plaintext copy".

Maybe but linguistical semantics is not the point here.

The idea is to represent a "binary" concept of memory being encrypted
or memory being not encrypted. And at the time we decided to use
"encrypted" and "decrypted" for those two things.

Do you see the need to differentiate a third "state", so to speak, of
memory which was never encrypted?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
