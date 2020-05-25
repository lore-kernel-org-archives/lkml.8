Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842FD2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590388517;
	bh=1QEAgjCyvnyb171lptQSm1J6l+YR5WoKvG6NJbtyIZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NU+sDYNSB4PO5ITZE/G7GQ2LYQxWcVVgHLbK1FfNbTI5YdnCJpzydzyGsEtvRSI+1
	 mhxcFkENw9Bd13XXC/+di/ALdiKNGJu035eM1zptSlTKZhGsBjFu4MzsKTNwcBYi7K
	 pP7JrI63aSiZ0ZMy0Cemy/Y8GeL2prurdgpPN7kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbgEYGfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388519AbgEYGfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:35:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDCB204EA;
        Mon, 25 May 2020 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590388516;
        bh=1QEAgjCyvnyb171lptQSm1J6l+YR5WoKvG6NJbtyIZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ZEULfnc+3Xbo8rRtjBgvdHFGWq5OzX/d9kjA5RznxpkpP3om5zFmob3nuUl9Lvkt
         C2Qgm2A4CqdqX/UAHkbW1bcCznkjJDjKFN0Xvi1C77SRkh4e3qYkv8/qa/WgjzDLjo
         Il/S6W7hpRkgFKtWtW4+7bgVL/4hA/ayaTQ4xoU8=
Date:   Mon, 25 May 2020 08:35:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] bus: mhi: core: Introduce debugfs entries and
 counters for MHI
Message-ID: <20200525063513.GA59195@kroah.com>
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
 <1589832241-13867-6-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589832241-13867-6-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 01:03:59PM -0700, Bhaumik Bhatt wrote:
> +void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
> +{
> +	if (IS_ERR_OR_NULL(mhi_debugfs_root))
> +		return;

Why?  Should not matter.

> +	mhi_cntrl->debugfs_dentry =
> +			debugfs_create_dir(dev_name(mhi_cntrl->cntrl_dev),
> +					   mhi_debugfs_root);
> +	if (IS_ERR_OR_NULL(mhi_cntrl->debugfs_dentry))
> +		return;

No need for this check either, just call debugfs and keep on moving :)

thanks,

greg k-h
