Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E2C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3454320736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLA2H+jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgEKBQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbgEKBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:16:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xqv2Ym3vil3bxjrUrKiymMGOx7fjyB/5xTF20GtSfUI=; b=OLA2H+jlCahiKFgvFw0/DNkhrf
        jPb185DyqOjFHYo9Y2lIOdbNoLetv/rIshO1ryUDS5vVcqFHSD1yANTgnNDCYAI7mQcNf1oZ8Ofg4
        vLBGo8TcTQy/266PkdM0nEkjwIU6DxnWWRYXiN+QO89E5O/eiXvbvKXBWnRweaJnkB/WxRdzOeLGO
        Rzqin1p++yQtRwlnWppYxc7J1dH0HpOJirtwMbkrl6LR0s7rtSikI+Iu4Yx3PDkzVB0eOiqSU/fJg
        QZFT1fuO4EVIC0LxQIedWc05SeMIZgnS7PM9BN/Gek+5sL1DlBETk3uE2QXlVACjNFD9kMfRrcZ5n
        m0wdPNwQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXx33-0005Go-67; Mon, 11 May 2020 01:16:01 +0000
Date:   Sun, 10 May 2020 18:16:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     0day robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [pipe] f2af7d90e2: xfstests.btrfs.052.fail
Message-ID: <20200511011601.GV16070@bombadil.infradead.org>
References: <20200511010957.GW5770@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511010957.GW5770@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:09:57AM +0800, kernel test robot wrote:
>     --- tests/btrfs/095.out	2020-04-09 10:45:28.000000000 +0800
>     +++ /lkp/benchmarks/xfstests/results//btrfs/095.out.bad	2020-05-06 21:13:51.276485703 +0800
>     @@ -1,35 +1,9 @@
>      QA output created by 095
>     -Blocks modified: [135 - 164]
>     -Blocks modified: [768 - 792]
>     +awk: line 19: function strtonum never defined
>     +awk: line 19: function strtonum never defined
>     +awk: line 19: function strtonum never defined
>     +awk: line 19: function strtonum never defined

This looks like a problem with the test setup.

