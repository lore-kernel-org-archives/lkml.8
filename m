Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6881DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39592207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590739548;
	bh=YvGdmrYJYcYtBzVLzTkFHtpwhDYriyAvQc4dPK5A4Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sFTdSOVqQfgzdDXAiQq19gehA1brxmRfw+4Y+gVtd5dpTOC236YMdHKitUalHLrJD
	 TbIQ22kP/mKaiYS1aWQmsc1CU5t90SyLYdwFSd530s0AvdFlGvDROxgluDQ7t+KTiS
	 EhQchm0kHa0tqT8MaEr7Qc68rZ8ByEw2Q/3sCKP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgE2IFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2IFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:05:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABF0206A4;
        Fri, 29 May 2020 08:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590739545;
        bh=YvGdmrYJYcYtBzVLzTkFHtpwhDYriyAvQc4dPK5A4Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qu9h/QUNAWDXlVjT9KVQL2VKUSMYMlVszCMbH9kAx54sodTZdWpK2BvnPDZzVfGKe
         FHLUhuPwfq/GDqnBWkelWXUxZFqj+xx5ODXThtYDcx6ljmQw5QQxB7xKlBQsD9I0Bi
         M27c4HHSPLI+MaWX4sxTDfMRSnt+o/dtLbrpOVIc=
Date:   Fri, 29 May 2020 09:05:39 +0100
From:   Will Deacon <will@kernel.org>
To:     John Donnelly <John.P.donnelly@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, Chen Zhou <chenzhou10@huawei.com>,
        tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        dyoung@redhat.com, robh+dt@kernel.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        horms@verge.net.au, guohanjun@huawei.com, pkushwaha@marvell.com,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20200529080539.GC4351@willie-the-truck>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200526014242.GF20045@MiWiFi-R3L-srv>
 <897ea1b9-a68c-8544-6532-a21be135ce01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <897ea1b9-a68c-8544-6532-a21be135ce01@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+James Morse]

On Thu, May 28, 2020 at 05:20:34PM -0500, John Donnelly wrote:
> On 5/25/20 8:42 PM, Baoquan He wrote:
> > On 05/21/20 at 05:38pm, Chen Zhou wrote:
> > > This patch series enable reserving crashkernel above 4G in arm64.

[...]

> > > Chen Zhou (5):
> > >    x86: kdump: move reserve_crashkernel_low() into crash_core.c
> > >    arm64: kdump: reserve crashkenel above 4G for crash dump kernel
> > >    arm64: kdump: add memory for devices by DT property, low-memory-range
> > >    kdump: update Documentation about crashkernel on arm64
> > >    dt-bindings: chosen: Document linux,low-memory-range for arm64 kdump
> > > 
> > >   Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
> > >   .../admin-guide/kernel-parameters.txt         | 12 ++-
> > >   Documentation/devicetree/bindings/chosen.txt  | 25 ++++++
> > >   arch/arm64/kernel/setup.c                     |  8 +-
> > >   arch/arm64/mm/init.c                          | 61 ++++++++++++-
> > >   arch/x86/kernel/setup.c                       | 66 ++------------
> > >   include/linux/crash_core.h                    |  3 +
> > >   include/linux/kexec.h                         |  2 -
> > >   kernel/crash_core.c                           | 85 +++++++++++++++++++
> > >   kernel/kexec_core.c                           | 17 ----
> > >   10 files changed, 208 insertions(+), 84 deletions(-)
> > > 
> This proposal to improve vmcore creation on Arm  has been going on for
> almost a year now.
> 
> Who is the  final maintainer that needs to approve and except these ?
> 
> What are the lingering issues that are remaining so we get these accepted
> into a upstream commit ?

The arm64 bits need an Ack from James Morse, but he's not on CC despite
offering feedback on earlier versions.

Will
