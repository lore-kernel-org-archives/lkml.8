Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8620C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10132078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588833986;
	bh=DKx3ZXKFviFup1PFzs642HAbWJOA7O7flMe6V9QzH9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m4k9Gxp7jF+0YuJ4hJKhogJ7zNQe2Qp65vrbAlCtFFml9Y/ZTnnjOWHXM1jB4ocWF
	 Dt8rr2yC4pFmf0PGSALr+s9OH2B7MvmT/hy+cexQF/IzIbTSNV4Xr+ai+wNqOK2RYk
	 TqPh4zI4FMNf90+OiP1uQRlkvBoDbonWyChC3vpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgEGGq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgEGGqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:46:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8982078C;
        Thu,  7 May 2020 06:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588833984;
        bh=DKx3ZXKFviFup1PFzs642HAbWJOA7O7flMe6V9QzH9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbUZ0bvZ6n8hsYBKU5Jdd7f/Q6anJhf2x8xQWYh55kcVdWAhJoeYoAdznOhiGsNUm
         wqUL5VcIL+oFlGQBmXjj0yKdkQww451GMz24aYyKaIglg6+BQDHpE5Y5AjsU268KSy
         eUNnlLiw26nsPbVTtllijLrtKjYwbc9poWrFNU8k=
Date:   Thu, 7 May 2020 08:46:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/1] usb: chipidea: msm: Ensure proper controller reset
 using role switch API
Message-ID: <20200507064621.GA789457@kroah.com>
References: <20200507004918.25975-1-peter.chen@kernel.org>
 <20200507004918.25975-2-peter.chen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507004918.25975-2-peter.chen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:49:18AM +0800, Peter Chen wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Currently we check to make sure there is no error state on the extcon
> handle for VBUS when writing to the HS_PHY_GENCONFIG_2 register. When using
> the USB role-switch API we still need to write to this register absent an
> extcon handle.
> 
> This patch makes the appropriate update to ensure the write happens if
> role-switching is true.
> 
> Fixes: 05559f10ed79 ("usb: chipidea: add role switch class support")

This should also go do stable kernels, I'll mark that...
