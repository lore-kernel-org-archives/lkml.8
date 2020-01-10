Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB1BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710D2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578672356;
	bh=BwQ3hgNytp3Vhhb3/aGu1TWkWmHNJvFCwz8FcQOU1d0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=UE1RctRBJgcX4G4HZ10KDuZ+7EUXqSGoMJSIr4reTMMjRkHNGfdmRn/uMFqTdlhw6
	 yk83IauJzh5N1WA3C8wGd0npaMwiaC/C/SFG13QbQQ1AtWJVgwdlqaK9K0ehuuydi3
	 f2lzL63bWc6DF8QpF92/rJbbBFZf/6WyBh+5atx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgAJQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgAJQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:05:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C952206ED;
        Fri, 10 Jan 2020 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672354;
        bh=BwQ3hgNytp3Vhhb3/aGu1TWkWmHNJvFCwz8FcQOU1d0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=rSq1lc5qyWCWzqge30byPL+X5/xbXoMRsnWfIUMmQR1q9Z06hbsvq1xoudf0xEpIW
         8YYCWxOchNcLb3Ku5DnU0NPIDBLmlEidbgUOgW13cxDYpAbc4qv4ngDxdZeg6ir/RQ
         SYSZjLSqwZmMyGUmD3Cenz7LakTi8lItKQmOsRpU=
Date:   Fri, 10 Jan 2020 16:05:49 +0000
From:   Will Deacon <will@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        pasha.tatashin@soleen.com, catalin.marinas@arm.com,
        will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
Message-ID: <20200110160549.GA25437@willie-the-truck>
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org>
 <20200108174839.GB21242@willie-the-truck>
 <20200109004654.GA28530@linaro.org>
 <20200109083254.GA7280@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109083254.GA7280@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:32:54AM +0000, Will Deacon wrote:
> On Thu, Jan 09, 2020 at 09:46:55AM +0900, AKASHI Takahiro wrote:
> > On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> > > On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > > index 12a561a54128..d24b527e8c00 100644
> > > > --- a/arch/arm64/include/asm/kexec.h
> > > > +++ b/arch/arm64/include/asm/kexec.h
> > > > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> > > >  struct kimage_arch {
> > > >  	void *dtb;
> > > >  	unsigned long dtb_mem;
> > > > +	/* Core ELF header buffer */
> > > > +	void *elf_headers;
> > > > +	unsigned long elf_headers_mem;
> > > > +	unsigned long elf_headers_sz;
> > > >  };
> > > 
> > > This conflicts with the cleanup work from Pavel. Please can you check my
> > > resolution? [1]
> > 
> > I don't know why we need to change a type of dtb_mem,
> > otherwise it looks good.
> > 
> > (I also assume that you notice that kimage_arch is of no use for kexec.)
> 
> Yes, that's why I'd like the resolution checked. If you reckon it's cleaner
> to drop Pavel's patch altogether in light of your changes, we can do that
> instead.
> 
> Thoughts?

Well, I've reverted the cleanup patch so please shout if you'd prefer
something else.

Will
