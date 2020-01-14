Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B22C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC8E222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579026410;
	bh=qnqGgrP8e9yV1OsuzVTzNXGikt0eU6jSP1VAIcJyBmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=woB8eKQdMaqqRPNOWiRSkMlMyPbrCOqtOeyIB0dALWxBt0JsF3ZBl4KBvS5qYjxbj
	 K305xni7THBrnqAgwbVuqxdnNLMsKvuljX61VDbks96gSqMcRUnIWHkosXn0VlVQrR
	 GFg3E0ZgLS25ztlepVUinU4OCVaKaoMIdrd4gtBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgANS0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgANS0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:26:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C615C24672;
        Tue, 14 Jan 2020 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579026408;
        bh=qnqGgrP8e9yV1OsuzVTzNXGikt0eU6jSP1VAIcJyBmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrXuON6lNa/3kGMXfWgCZKeqToNfMEc/Bm81yU3i7YyzltzarzjHAYDGNnu+exqw5
         BWS8V+7Xk+pe0HfRkw7crfwWY+Sy7P0uSpIjfo6TNo07VEnP4BztnoU+rYjHs0VLrh
         fHeuTQaoSAjpIpBO2njoR8F/VNZT+HfKdUby0EI4=
Date:   Tue, 14 Jan 2020 18:26:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: Re: [PATCH v5 5/6] arm64: move ARM64_HAS_CACHE_DIC/_IDC from asm to C
Message-ID: <20200114182641.GI2579@willie-the-truck>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
 <20200102211357.8042-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102211357.8042-6-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:13:56PM -0500, Pavel Tatashin wrote:
> The assmbly functions __asm_flush_cache_user_range and
> __asm_invalidate_icache_range have alternatives:
> 
> alternative_if ARM64_HAS_CACHE_DIC
> ...
> 
> alternative_if ARM64_HAS_CACHE_IDC
> ...
> 
> But, the implementation of those alternatives is trivial and therefore
> can be done in the C inline wrappers.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/cacheflush.h | 19 +++++++++++++++++++
>  arch/arm64/mm/cache.S               | 27 +++++----------------------
>  arch/arm64/mm/flush.c               |  1 +
>  3 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 047af338ba15..fc5217a18398 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -77,8 +77,22 @@ static inline long __flush_cache_user_range(unsigned long start,
>  {
>  	int ret;
>  
> +	if (cpus_have_const_cap(ARM64_HAS_CACHE_IDC)) {
> +		dsb(ishst);
> +		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
> +			isb();
> +			return 0;
> +		}
> +	}
> +
>  	uaccess_ttbr0_enable();
>  	ret = __asm_flush_cache_user_range(start, end);

I don't understand this. Doesn't it mean a CPU with IDC but not DIC will
end up with doing the D-cache maintenance?

Will
