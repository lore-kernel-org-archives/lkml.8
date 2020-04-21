Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA64C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CF52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mG8cHLnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgDUQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDUQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70814C061A41;
        Tue, 21 Apr 2020 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rp8VDyZBUeeKs2u9p/9GeFYyeFLSaQEg10VWwSynIMA=; b=mG8cHLnUUAcy4CshclETXtW125
        RxNldbED+BfXhPbFeAEMEt98KoxQAtlIokJFCpiv6uaANt2ywx80Oj3sBWYDSN4THQZ+lCQ4+uMyU
        4X3YMQ6ZA4kC9mxsgZsE3Nw2TnnCX4m6C3xJJM1ElcyZH7tjlzK3XI2BeoQANZ9gcJWbcyvz7rklO
        LTBMXDkr/vRNO556FrJ4gPue5gncbJ0zE3DMO5Lc0RlqxTYlsBTUUbb5jtyMnLmMJSLOIiFv47KFc
        G8DnFULu5uXdhhaDrinFBybtjd0TrFJDnlmKJN0NvXeAfxG8tqw7iPGxG3oo7cEV2aDEWDlKpsz/W
        /dAo455g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQw9a-00036p-7v; Tue, 21 Apr 2020 16:53:46 +0000
Date:   Tue, 21 Apr 2020 09:53:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de,
        rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com,
        tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com,
        steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiexiangyou@huawei.com, zhangshaokun@hisilicon.com,
        linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com,
        kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] arm64: Detect the ARMv8.4 TTL feature
Message-ID: <20200421165346.GA11171@infradead.org>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-2-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-2-yezhenyu2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:00:43PM +0800, Zhenyu Ye wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.

What does "issued with a level" mean?
