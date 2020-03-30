Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DC2C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1CE207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585608714;
	bh=EXmX9dErmlEkFgnbipzAfMRYR83Acb60UF9bDXiz0DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=StGi5EWnFab8XSXsdrGfc2R2VGrz02t9+m9shvdylBCuZfEHItNQn4vVgHFVAlIYd
	 ULg1i1PS6AeHU0VgTDGY1BwqEGxHXkEhaUfMUnT8DdQI7ywXcEpSGkj5q3o53Fpx2v
	 WenXOxhfkesQryTsGv75e+d2FMXfizRHO+YyEVk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgC3Wvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgC3Wvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:51:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8F620733;
        Mon, 30 Mar 2020 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585608711;
        bh=EXmX9dErmlEkFgnbipzAfMRYR83Acb60UF9bDXiz0DI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z2ihfI3sBMfsr5Wfl0ingXQoY+GET5tztqWSEKsLwaPrr7s+ZlNiSAKTokhw8O+xN
         ZHVynMZSxwgLZ5vqpo7pk6F7cOLNDYCHpT8EuVMpy6pEAuagf741mQ/aHK8qub7GET
         5sfIGbrfC8VOGI745W0EmSJ89zj6DGCdOS5BwtB0=
Date:   Mon, 30 Mar 2020 15:51:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nouveau@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/thp: Rename pmd_mknotpresent() as
 pmd_mknotvalid()
Message-Id: <20200330155150.750ef923d297c455c7b418e0@linux-foundation.org>
In-Reply-To: <2e67f1b8-d196-89e4-aee1-f552db1433a0@arm.com>
References: <1584680057-13753-1-git-send-email-anshuman.khandual@arm.com>
        <2e67f1b8-d196-89e4-aee1-f552db1433a0@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Mar 2020 19:12:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> 
> On 03/20/2020 10:24 AM, Anshuman Khandual wrote:
> > This series renames pmd_mknotpresent() as pmd_mknotvalid(). Before that it
> > drops an existing pmd_mknotpresent() definition from powerpc platform which
> > was never required as it defines it's pmdp_invalidate() through subscribing
> > __HAVE_ARCH_PMDP_INVALIDATE. This does not create any functional change.
> > 
> > This rename was suggested by Catalin during a previous discussion while we
> > were trying to change the THP helpers on arm64 platform for migration.
> > 
> > https://patchwork.kernel.org/patch/11019637/
> > 
> > This series is based on v5.6-rc6.
> > 
> > Boot tested on arm64 and x86 platforms.
> > Built tested on many other platforms including the ones changed here.
> 
> Gentle ping, any updates regarding this ?

We're in the merge window so I have parked this for consideration after
-rc1.

