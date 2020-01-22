Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CDF2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579702231;
	bh=WfUcNW/ZPmgKZe/l2EWYX/kdrNXBQfDXJ5Jvq91EAps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OOEUcXGMetX4TbSLCU6W3KAr1BKQ9p4JKD5z1YxnrdDzxnlHHCXEbPGjLDdcpjHKx
	 emd4Sh7VSPNeXnzDXl+yzrVItIq8LOVKjGQdi4GvRh3DiQgxqulCS1tb7z78gBDZJs
	 XsTtS3ladNzrMkmBMlZev1hskugY23viLi+C9mkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgAVOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:10:30 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFCF2071E;
        Wed, 22 Jan 2020 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579702229;
        bh=WfUcNW/ZPmgKZe/l2EWYX/kdrNXBQfDXJ5Jvq91EAps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhV9z+AHWUYitwCbC1RsIFZd5BHFEV1flBmt/pvBFd9BYTFzt9BAeToHbXZmzopMU
         6sJ1e9qixIrlnGn/4tVG0gdk8qW+3joUFWMLhElOILibpY9YqWcvLp10CeyfC+XFxW
         Os3UcY8iXgoaCLnh44APh3EDXsC1VN0LszFpiV88=
Date:   Wed, 22 Jan 2020 15:10:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     will@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [RESEND Patch v6 2/2] fpga: dfl: fme: add performance reporting
 support
Message-ID: <20200122141026.GA10399@kroah.com>
References: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
 <1579230628-22243-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579230628-22243-3-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:10:28AM +0800, Wu Hao wrote:
> +static const struct attribute_group fme_perf_fabric_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_fabric_events_attrs,
> +	.is_visible = fme_perf_fabric_events_visible,
> +};
> +

I don't see any Documentation/ABI/ entries for all of these new files.
Please properly document them so we know how to review this.

thanks,

greg k-h
