Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E85DC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96882074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584953567;
	bh=wG7SF/RkUIf8rHHlON28AbIfMYRx4lCr5muY2st+zok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O4SXonCqZ3rwrx3pfXSeKI5giWg8F0gxQtno7nxrnYyuj0+jbejDWfBuH6m5tKOnt
	 SLxoh0fNEPPcbYIpSdpz7qkzK7rW8wxkQU3ekfe/cptJpFAb3k2T07KhOj7fgbgASe
	 3589Jn2bNV9WZVPXxXvSZyOq06GBJxveOSqE66UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgCWIwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCWIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:52:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4F620663;
        Mon, 23 Mar 2020 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584953565;
        bh=wG7SF/RkUIf8rHHlON28AbIfMYRx4lCr5muY2st+zok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq+D2qplejpaEEiqKBfPUZfVoc8f0nWfIMvoK4uhIVehr0T/u9irhCLTM2abpYyqa
         uYZrJ5wH8dMpTNMiXi3rPw6df1vFI09lZs8uYQzwYDpy+5sd9tHI5NPmrj+fwn69KL
         7tEpDPkAnv77Ttj1cv/3do6EiivOo2aeo0AC0lzk=
Date:   Mon, 23 Mar 2020 09:52:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Adit Ranadive <aditr@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishnu DASA <vdasa@vmware.com>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
Message-ID: <20200323085241.GA342330@kroah.com>
References: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:22:33PM +0800, Xiyu Yang wrote:
> A NULL vmci_ctx object may pass to vmci_ctx_put() from its callers.

Are you sure this can happen?

> Add a NULL check to prevent NULL pointer dereference.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_context.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What changed from v1?

Always put that below the --- line.

Please fix up and send a v3.

thanks,

greg k-h
