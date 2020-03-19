Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E3C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1FA20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584604111;
	bh=DpO44T5jLSZKdnEhkl065vGcFlq3vORTR/bjAmB0qzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pAiTOTPIwr5bUxJopsbQj6pE/MVKjzv+L5hOFVe+0W30r5UrfCz7UF6t6uMIJBcjH
	 daSSnRr2zpKHuYcY78Z4DFBxwpTeQ5XX4vonc8gZFgLuPmSyvn2EFYwaDFk7m+AkPg
	 NzCbxzXEPVWJ/hnHMDsg4Ofwbzwz9JSzYqhrNRbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgCSHs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSHs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:48:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA4E20722;
        Thu, 19 Mar 2020 07:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584604109;
        bh=DpO44T5jLSZKdnEhkl065vGcFlq3vORTR/bjAmB0qzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7I3czoT7LXJzenE68cfpJA+9lwbm8n0vpJEu647VjqTazfvK7mWmVuKmn+LEBtaZ
         zFW/IPkHtzbAl8nMFfMTc1KSQCV9sfnkpR0gkGVfWD3LHi4i2uFDlk4SUjn9HByvzi
         sZbbFlkH5Uhb2BfNNIHQASyyJA/A6uwvQYc0PKI8=
Date:   Thu, 19 Mar 2020 08:48:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiang Su <suqiang4@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] UIO: make maximum memory and port regions configurable
Message-ID: <20200319074826.GA3444175@kroah.com>
References: <20200319073923.51812-1-suqiang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319073923.51812-1-suqiang4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:39:23PM +0800, Qiang Su wrote:
> Now each uio device can only support 5 memory regions and
> 5 port regions. It may be far from enough for some big system.
> On the other hand, the hard-coded style is not flexible.
> So make these values configurable by menuconfig, thus users
> can easily expand them according to their actual situation.
> 
> Consider the marco is used as array index, so a range for
> the config is set in menuconfig. The range is set as 1 to 512.
> The default value is still set as 5 to keep consistent with
> current code.
> 
> Signed-off-by: Qiang Su <suqiang4@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Greg KH <gregkh@linuxfoundation.org>

What?  No, I did not review this, do not add a tag like that for a patch
that I have not explicitly given it for.

And how is the kbuild bot reporting problems that this patch fixes?
Where is that report?

Also, I want this to be dynamic, not static, please do that instead, no
one rebuilds their kernels for something like this.

thanks,

greg k-h
