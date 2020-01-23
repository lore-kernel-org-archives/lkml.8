Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B53C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6A2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579779282;
	bh=+r90l2uoL8NnqDDDJFW1ex4a2VbKEX/hPb2DVnWyXY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1VXrN7qA3Whc59mhoR2nxX27nvkfR0ifn0ghUtTMiopwSTs+2M09pUZO10ThIltFK
	 dJK4mgh7Mvuz74PasA3jOlp/Nn9NGGV3hKVdZr7yWUnkFmA5E/3FckBJpTg6gZNqN4
	 y2fQ/6o9xWbIUJpcB/ZGoFSB0bpHXCM3/+jAvmK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAWLel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgAWLel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:34:41 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA9624673;
        Thu, 23 Jan 2020 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579779280;
        bh=+r90l2uoL8NnqDDDJFW1ex4a2VbKEX/hPb2DVnWyXY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJ1SVFv9DOSPiRZtXwZIPhq0Rw5NPM2/pVNyzyhS66BsJJ3WGck/cTi+sXjxHaoJY
         uXpCgDT5pdbV5BaRbg1p6sudwV1JxvMsOtnUvwdOMs4oDeD93lhaPSFpnNGKMr3Xvc
         NqpGjG6/oKCxJkqOb8X/Z7/UbrMQt3QiUGYiCeAA=
Date:   Thu, 23 Jan 2020 17:04:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: s3c24xx-dma: fix spelling mistake "to" ->
 "too"
Message-ID: <20200123113436.GX2841@vkoul-mobl>
References: <20200122235237.2830344-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122235237.2830344-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-20, 23:52, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.

Applied, thanks

-- 
~Vinod
