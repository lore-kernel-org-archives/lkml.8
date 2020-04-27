Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1390620661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588003550;
	bh=YDqfBQ5wST77dFIwfCuEmRqFbRXErmX0b5wHi05B4vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2TSzQciFjgM0lPgJa34QfFqkopYKKiCAGg/3r8XLAvIkYSSJNG8KkzHcdEYt+Rs0G
	 JUU6mW8kmQiAuDi9NCEtO5GvEuu43cFPwNNChEzTM0Cnrw3hz0saCawkydWw+PeVVQ
	 KGLZBf+W0wgd0Y0p6ni6jPhsXuOW2ZfzZQ7yT5mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgD0QFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgD0QFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:05:48 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5547205C9;
        Mon, 27 Apr 2020 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003548;
        bh=YDqfBQ5wST77dFIwfCuEmRqFbRXErmX0b5wHi05B4vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9iXdN2b1kMrsbi6D5R7l3ad8DUziDatl/mXJbkZPMYZGdqbJ1of5kwTae5YaxFr1
         +vVU2O7OJY7LHSbO24ztrE0TfP2w9lKPMZJlYf2JJAOXyWTSLIjboxp2yFyUFVwROX
         9ma+Zq3K2de5eNZ4nWS60kbP+LIlTwgeFLwme+FU=
Date:   Mon, 27 Apr 2020 21:35:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Ensure that clock is enabled
 during of DMA synchronization
Message-ID: <20200427160543.GH56386@vkoul-mobl.Dlink>
References: <20200426190835.21950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426190835.21950-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-20, 22:08, Dmitry Osipenko wrote:
> DMA synchronization hook checks whether interrupt is raised by testing
> corresponding bit in a hardware status register, and thus, clock should
> be enabled in this case, otherwise CPU may hang if synchronization is
> invoked while Runtime PM is in suspended state. This patch resumes the RPM
> during of the DMA synchronization process in order to avoid potential
> problems. It is a minor clean up of a previous commit, no real problem is
> fixed by this patch because currently RPM is always in a resumed state
> while DMA is synchronized, although this may change in the future.

Applied, thanks

-- 
~Vinod
