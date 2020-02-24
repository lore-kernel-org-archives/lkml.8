Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6518C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE2320838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582563181;
	bh=+BKg+9ltuyXskzUKcp22gQ/z3orass0x9uHtufnBFpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k5FckMjbHJfGhK60nAeZP2Rj6/VuWCz8/i1uVl4EF9JnLzcb/EHFHX+8DRcTvR//5
	 hpfCcuMkWK3j1c3+Y55fQVn3kIytvgkXXe2fors5d40UwFL13fTtFi7uSZq70W1YQv
	 QME8gUqABWsRwrOVJkGy8YiXpq1l9sCcd/CXOh0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBXQxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgBXQw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:52:59 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A3820836;
        Mon, 24 Feb 2020 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582563179;
        bh=+BKg+9ltuyXskzUKcp22gQ/z3orass0x9uHtufnBFpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kn/iCHRYniCjGtSCaGsKiFYWh1Ke7ajdlj2I59KwyP9Fq8RJa7U29becT7gHJE0aS
         P9roAjpb1/PZi5nJdRyuXiLRk/tKs2BRkPjZvT3VDpsUZT34Ju5B1xnqoUfWny6V98
         sVdAS0Bzfc+vNBbXjSkbOFdt7qcwpAV9hnPEv9Ow=
Date:   Mon, 24 Feb 2020 22:22:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 0/4] STM32 DMAMUX driver fixes and improvements
Message-ID: <20200224165255.GC2618@vkoul-mobl>
References: <20200128094158.20361-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128094158.20361-1-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-20, 10:41, Amelie Delaunay wrote:
> This series brings improvements to the DMAMUX driver with support of power
> management and probe function gets a cleanup.

Applied, thanks

-- 
~Vinod
