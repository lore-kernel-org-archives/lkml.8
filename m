Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B5C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE48206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VMc7Te6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGXJnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:43:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD60FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kNkEtUhN6G10j8lkCGnOIYtN8tdnhHhV6JVj3Tz3i4k=; b=VMc7Te6uaHHWKfyUJLz6ZoC6eX
        5ltTiCU4C2aEwBm2VhccQCTQMZDsPc/8ieCjJ1nWUcRgXEhZk/Ha6EWyJNIujA/1kIniyMT/y/T+l
        OMZJ/KZPqzu+6ybAC6uU58ndj9UTuH3tIMv+wK7KH3RYJwJU1AYyKX1gtQ3hGZ4813oln82QC2fw4
        Dtb4c2js11Awtcixp+ofweY147nUC6R3QGuu968OPYwnHbFV41Cnd43T1rt0FQiaVxfbtPaBVHZ6e
        xSh7Lh1ND68Ev0Ry6Ao0XTVencQqHm/T7kL/xGXvpLuYIx7bKUWcBL07rDjG5k4i0shH0vG3gR25x
        Z3ez/7ug==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyuEq-0005sG-U5; Fri, 24 Jul 2020 09:43:36 +0000
Date:   Fri, 24 Jul 2020 10:43:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
Message-ID: <20200724094336.GA22178@infradead.org>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:08:03AM +0800, Kefeng Wang wrote:
> +maillist
> 
> On 2020/7/24 11:04, Kefeng Wang wrote:
> > ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
> > 
> > ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> > __cpu_logical_map to fix build issue.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >   arch/arm64/kernel/setup.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index c793276ec7ad9..3aea05fbb9998 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
> >   arch_initcall(reserve_memblock_reserved_regions);
> >   u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> > +EXPORT_SYMBOL(__cpu_logical_map);

EXPORT_SYMBOL_GPL, please.  Also consider turning the wrapper into
an out of line function instead of exporting the data structure.
