Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CB3206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151804;
	bh=6HmbBZ/hAaTNRvr57Ee3RynaZrY/B1u/OP33jjSR5xI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w74othoJze1paB0bnn8tABNx4OjY+91T5EyoFSI5jRgXLWQqurUCF7Qb7+nZH8puM
	 Ul0tRGfFxxz6cOOubGtwCWFxk/qBjiZGvschJDQoUz5X2Xykgszq1BkN/6Y08kwApW
	 bLRXrmmOgmyMVkcOq2sJ2/v1mfGinMXsSJ8bZaTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGGT4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgGGT4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:56:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256AA2067D;
        Tue,  7 Jul 2020 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151802;
        bh=6HmbBZ/hAaTNRvr57Ee3RynaZrY/B1u/OP33jjSR5xI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lKq8WJnIf/BWdtcQlYTM+oOooW0eT4U82nxraWoHAodiY0NemZA9OM3YS7xI82oCD
         +6LrwyY2OTwIGo6ywnm+FPlm1UhQwbaiNWDhO1ZcOoEGEdO+NiF7MYPwrSISekj/GA
         al/LS2hpUpow0Ke694K+b1UdLUGceUj9uqhZmTc0=
Date:   Tue, 7 Jul 2020 12:56:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Message-Id: <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
In-Reply-To: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 16:02:04 +1200 Barry Song <song.bao.hua@hisilicon.com> wrote:

> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> enabled. gigantic pages might have been reserved on other nodes.

I'm trying to figure out whether this should be backported into 5.7.1,
but the changelog doesn't describe any known user-visible effects of
the bug.  Are there any?
