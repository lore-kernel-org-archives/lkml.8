Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5AEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDBA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597639919;
	bh=GVMbEW7Wl/ZrSbsiJvLcoeOoUi9FXdmO1BZYj5VZn/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rq0KfewQ65M0yH2/a41PLn981DMxVYc2NGnvNJbprc2N8wycYpUMuFMODVWucLG17
	 1bkg4hSvCtLJHTRebdxX9//jZCgsFdExes0qxSCuysIWCz3STJvRZWN+719h+rA54J
	 o3UN54vdbWaw5rulwXYExmxYbEYAcvzU9Pq62nPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHQEv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 00:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHQEv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:51:57 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E045206FA;
        Mon, 17 Aug 2020 04:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597639917;
        bh=GVMbEW7Wl/ZrSbsiJvLcoeOoUi9FXdmO1BZYj5VZn/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7lZZB1DpV+Rn7dUC1FMXkPsPVLK1DaWXOmKpiJ6GrBtfylWgSGGiQOi5VxdtxPLZ
         KDN0uZncydUBmpjubVzy+Fnsr+RxaBjAGefLF5O4p+aiNxGXbpKrtyUYq6fsPvBgfG
         X8u/qDHioPOqB4vnpKYj0r/kTNTUFqqdMxOdSNUE=
Date:   Mon, 17 Aug 2020 10:21:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: acpi: Put the CSRT table after using it
Message-ID: <20200817045152.GB2639@vkoul-mobl>
References: <1595411661-15936-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595411661-15936-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 17:54, Hanjun Guo wrote:
> The acpi_get_table() should be coupled with acpi_put_table() if
> the mapped table is not used at runtime to release the table
> mapping, put the CSRT table buf after using it.

Applied, thanks

-- 
~Vinod
