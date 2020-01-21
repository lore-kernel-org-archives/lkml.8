Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8DFC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7160B24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579598163;
	bh=Kgec1nZPQAAponRzf6rEO6T4Atrgbblqp3fSPi8Yzt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZqEz9Dbv0UGUfN+Al1vAFk1AVR3wbfZ0H6BfkkSXoqOE/wrrR/8XxLzqssi5MNUNR
	 l68CFTxVZh2Mpm1t/nUSPW1wQBUzRUehfpP5ib5OcDsQhbB6GFo3PL/2JpEQBkQ/zS
	 l4XRWqoxAUKAtS7BIqnYpelUCqC3Ar2wtQ/SvdLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUJQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:16:02 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1E320882;
        Tue, 21 Jan 2020 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579598162;
        bh=Kgec1nZPQAAponRzf6rEO6T4Atrgbblqp3fSPi8Yzt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1FX+52DYbBAxlgBwBERsAfQOz1QGHCdYjT83CEzqvEwQDKSpFw8dj2XI2+FOHXDFp
         Af4JkUlC2ExQ35/3Qau71HCf1+tTEX+7wJTbIIolAE2Dd0Ze8x7iMBD2FRSxLnSutq
         enCGP174y9tpcVarujhc+OV5MHgMlSeuuGekGjw0=
Date:   Tue, 21 Jan 2020 14:45:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH v4 0/9] idxd driver for Intel Data Streaming Accelerator
Message-ID: <20200121091558.GF2841@vkoul-mobl>
References: <157842940405.27241.1146722525082010210.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157842940405.27241.1146722525082010210.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 07-01-20, 13:40, Dave Jiang wrote:
> v4:
> Borislav:
> - Merge unused __iowrite512() into iosubmit_cmds512().
> - Fix various comments for iosubmit_cmds512() patch.
> Vinod:
> - Drop dmanegine request API and supporting code
> - Update to use existing dmaengine API

This looks okay to me but needs a rebase on top of dmaengine-next,
Peters patches applied earlier move code around a bit

Thanks

-- 
~Vinod
