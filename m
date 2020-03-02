Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B462465D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583187855;
	bh=JUU4hEGar97jd+V9k2N9lDEIJZMNf+Nfj+ecj2VanY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MAOe9IaTao1Wb1W1sK0n4pYpN0QT6xNniB87OxBRaaedajc8xAB+pdVhn7lF8UWsc
	 caom1JWPylTMlNMIjkm1tHZ0HJqcawBqDR2M5KE+d95ZCm5vrJWEkC9Vi+MLtcIHeG
	 jHN6Bc4jhV0SjCcGff4iMhEJ8uRvnfv9/ZZsv3j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCBWYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:24:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:24:13 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B597421775;
        Mon,  2 Mar 2020 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583187853;
        bh=JUU4hEGar97jd+V9k2N9lDEIJZMNf+Nfj+ecj2VanY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V/qsC4MIBAWcfedFF9SutIYTIaKV0oVS8iCnFgaa6E1jLw3KpHxkKliWr7CsDcakJ
         msAYZl44Nk/pYtoLL6DV6GCON0+oUguHaQ+pT0TezlWz9BE4LhccfO6Td8JX+FtF6f
         Ui3csBq7LDMKCXTzP+CUnkwubKa926b83ECFvsOs=
Date:   Mon, 2 Mar 2020 14:24:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        anshuman.khandual@arm.com,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
        suzuki.poulose@arm.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Linux-next-20200302: arm64 build failed
Message-Id: <20200302142412.f8f2b17a3387b46ce94c7cb6@linux-foundation.org>
In-Reply-To: <20200302174553.GC4166275@arrakis.emea.arm.com>
References: <CA+G9fYtAM-m0jygud+i0ymU+XknV9_GcAbDQChiD2NZjvQ+D3w@mail.gmail.com>
        <20200302104726.GA7995@willie-the-truck>
        <20200302135443.GA24831@linux.ibm.com>
        <20200302174553.GC4166275@arrakis.emea.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 17:45:53 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> >  static void unmap_hotplug_range(unsigned long addr, unsigned long end,
> >  				bool free_mapped)
> >  {
> > @@ -854,7 +872,7 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
> >  			continue;
> >  
> >  		WARN_ON(!pgd_present(pgd));
> > -		unmap_hotplug_pud_range(pgdp, addr, next, free_mapped);
> > +		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped);
> >  	} while (addr = next, addr < end);
> >  }
> 
> Thanks Mike. With the additional diff below, I can get it to build with
> and without the p4d clean-up patches in -next. If Anshuman confirms that
> they work, I can add them on top of the arm64 for-next/memory-hotremove
> branch

Can't I simply fold these into the offending -mm
arm-arm64-add-support-for-folded-p4d-page-tables.patch?
