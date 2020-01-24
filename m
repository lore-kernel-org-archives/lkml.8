Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D60C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE452077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579844989;
	bh=nwwG9R53jMJ+nkiOV+lIAlkuJpzg3TfbYmeUeqDPxho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXEl7Ntbyg5OxKEkdptOXq53OR5XjLJkstvm90c0++lrxIcp1mM1Nn3XedASqiXXL
	 Fj5hftQVpIvALReD+KBiB7MMKxUZzJdiPHoCUNxDNS5+rSCPyiDvnvfUkh+YRkjgsW
	 t8M4g5IV0HDks6UiO+3OZK/i86hdNtMFV4yNKyUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgAXFtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAXFtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:49:49 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCC82075D;
        Fri, 24 Jan 2020 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579844988;
        bh=nwwG9R53jMJ+nkiOV+lIAlkuJpzg3TfbYmeUeqDPxho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi3BAOABMYlFUTCkKu/ewJc2XytURw12W/5fat/WIknoCu78gp1NEgfHhccDRwP3p
         uWfflX8Qh8HIfq2bQMcYIFD8mu91OvPlL3i27ZCmhn/HfKAneOlZV13nnp4GdQSyzr
         gMuUOhACo9gwmVV1xpvkWmSGAOz0AcfgRveZh6gI=
Date:   Fri, 24 Jan 2020 11:19:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH v5 0/9] idxd driver for Intel Data Streaming Accelerator
Message-ID: <20200124054944.GB2841@vkoul-mobl>
References: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-20, 16:43, Dave Jiang wrote:
> v5:
> Borislav:
> - Fix header spelling and added Ack.

Applied all, thanks
-- 
~Vinod
