Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E815720715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3j2mJNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgERGSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:18:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4745C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mi/Yaj0SaOPBvEr8cdz4RwbxKfrvmg/VoMxx24QWS8c=; b=e3j2mJNzk+fSyCgHrmi8Y5KRYB
        4BwPvb62ZD3MD9HmtwxBaPKd5lyatjJEwDTnbJa4LHvZzVGftI2H4Dsvz8mLzRiZM5TfVZjQXFPVd
        oNogyGHS9pKoU2SyE2yndFHNnx335mC8Hk3cMKoheaY4OI66OVMWwItzw6OdoVA6I+vS/Uy/EItNJ
        6ALgssZ4/SaDqGyZ+ueYvet/pXld/lzUKFjCYp27Zj53Y034fn9/g9iw1ffRUpHSTOK03dVyBvBds
        pngg2/befR3UifMqLTWzmU5P0AQkTruuUo0FjYnctUZ5ZSR3Ce2cBkc8SZmtofDNfzn1tt7aumgMA
        SN14rg0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZ6i-0004VM-LX; Mon, 18 May 2020 06:18:36 +0000
Date:   Sun, 17 May 2020 23:18:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200518061836.GA15641@infradead.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:52:53AM -0400, Sasha Levin wrote:
> Benefits:
> Currently a user process that wishes to read or write the FS/GS base must
> make a system call. But recent X86 processors have added new instructions
> for use in 64-bit mode that allow direct access to the FS and GS segment
> base addresses.  The operating system controls whether applications can
> use these instructions with a %cr4 control bit.
> 
> In addition to benefits to applications, performance improvements to the
> OS context switch code are possible by making use of these instructions. A
> third party reported out promising performance numbers out of their
> initial benchmarking of the previous version of this patch series [9].

The [9] reference can't be resolved anywhere in this mail.
