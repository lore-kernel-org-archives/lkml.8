Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2184EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF25120C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598610452;
	bh=2HMaFFzIYNfyzCAR+aLtQE/mPzur2gCXlFOpWNbhD/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IGEPSu7ePPxn1EQgI1re/Dypg/CzfKR5eMJEceMdrozDsWdtE+DSmsuVKCdUuUBc5
	 tJKYwjRkplFD3/ysB/NzP9wn9moLu2kxMjqpC8MqHAPSFB6qHG8EHoIMDpDoSH1+X7
	 lu2HwxLuh4waYb2o/8CUb2JavOeNGY2z5XP0HHcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgH1K1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgH1K10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:27:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813302080C;
        Fri, 28 Aug 2020 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598610446;
        bh=2HMaFFzIYNfyzCAR+aLtQE/mPzur2gCXlFOpWNbhD/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kn6iAs8yfXuidc0/hLQhLPV3UCWmCz+2Icg9nm1GC9lWPQU35cj6CiqKMSxzlx4nS
         icsZJBlTlmV/b4N+8eUGjwm1IWlfOxLziwTYgPY4lIb7oogzb+bgv/caEu9pZ1aLmB
         8NeRT179YqHF7tR+q4aysycNFAYrpsUj5QuD0mZw=
Date:   Fri, 28 Aug 2020 12:27:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200828102738.GC1470435@kroah.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-7-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825024516.16766-7-shuo.a.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:45:06AM +0800, shuo.a.liu@intel.com wrote:
> +	default:
> +		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
> +		ret = -EINVAL;

Wrong error value here, right?

And you just made a simple way to cause a DoS on the kernel log :(

thanks,

greg k-h
