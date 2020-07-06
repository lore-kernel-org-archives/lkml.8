Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9588C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA56A2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594027495;
	bh=SKlcidpbSyUFcSUEjNJ2TCMy2bmEi2/HDMux5eq+x60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SEtgE8wDxc09dOSajyTj/7u04XSAMMeKCY1ELLFzwGY2oWNBcF+8YHo9ni62p4zB0
	 zG/ZEWhT/WVG9xnwzNbF0ZhN4rkB1rJwhED/2I+dAFFuLBmebgLDP3OrGWjTuwuKGZ
	 mjL4uttDNvHXIthVzi+JijMzEcrqbR2iejoFlQlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgGFJYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgGFJYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:24:53 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B0220724;
        Mon,  6 Jul 2020 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594027492;
        bh=SKlcidpbSyUFcSUEjNJ2TCMy2bmEi2/HDMux5eq+x60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2LSnEn641AvuW/VNIr07O+nmigAhX8C66q9+duZjb/si6SlicgvOawO+diLw9MsM
         h/2pOBNHrRwRkiR5eGc1dwG3jJN2QpSO4cYA8gD3Lskgdwg/ZmWcseKuSVHgFyRXjA
         Qs6NGeI4qAJuIMFccyJpCSltXkb8ZfN/KAMMC0O8=
Date:   Mon, 6 Jul 2020 14:54:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 dmaengine-fixes tree
Message-ID: <20200706092447.GJ633187@vkoul-mobl>
References: <20200706175506.7d35ca3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706175506.7d35ca3e@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 06-07-20, 17:55, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   09c6b5536361 ("dmaengine: fsl-edma: fix wrong tcd endianness for big-endian cpu")
> 
> is missing a Signed-off-by from its author.

the sob line was in the patch but after the three dashes causing it to
stripped, I have fixed that up manually and pushed again


Thanks for the report.

-- 
~Vinod
