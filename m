Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BAFC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9022071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584367797;
	bh=vFvUiDg0TqTQhetpQUmap+C03m80Z77YOf/E3h/BVfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y2uxx71kRXO+Pz2aUkaHtsyvyIb/CbSDiCmiltbW19G072xMek8bpK08a3IgKg9pp
	 ddx5D3Ejml9lbBktCFocnlvpMB/5RROiyy4qjjcxNyMnx1M5o9ip+neQbzOsFvjrvB
	 XB0rTzsOONNTcaPSWSLOmMw2+oSYHE6RrHsRFVO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgCPOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731254AbgCPOJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:09:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739572071C;
        Mon, 16 Mar 2020 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584367795;
        bh=vFvUiDg0TqTQhetpQUmap+C03m80Z77YOf/E3h/BVfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJ5dggJgeVgnSh5IqkzaHGljar1RJsDVPk4dUOxNVoUxuJ/KV+PQbjFNzWF8x8a/N
         cPFEgFAWcldftjgcdMOOvbZk7+WCA1Mi60lkyJLNw3pcwIL1Kgb58zRMafrvFiTjS6
         mvAl9QuL0PHuzwTFD8PHo7jo8mPzLLMnjIC2WcBg=
Date:   Mon, 16 Mar 2020 15:07:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        x86@kernel.org, terrelln@fb.com, clm@fb.com, keescook@chromium.org
Subject: Re: [PATCH 1/2] lib: add support for ZSTD-compressed kernel
Message-ID: <20200316140726.GA4041840@kroah.com>
References: <20200316135025.7579-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316135025.7579-1-oss@malat.biz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:50:24PM +0100, Petr Malat wrote:
> Add support for extracting ZSTD-compressed kernel images, as well as
> ZSTD-compressed initramfs.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>

That says _what_ you did here, but not _why_ you did this, or why anyone
would even want this.

thanks,

greg k-h
