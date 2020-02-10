Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16222C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DBF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581337339;
	bh=/JtHuma/Nuv5fXIEEbQCivHrdEm+001qeJ+s7A5Ip5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oi6z4UMVl/OmVrAc8vjLaIck6jNFZYBZDCy2OKBaTSBiVph3mwaCBQuknO2Wipv2b
	 zoeNWRjAATfbgQ9iJHIHTpaoXnWdoGV6NMMtNL57PWMqc40nad2cKs+DRxDLlK2r0s
	 4oJx71oSJoGPTlAsxp3bWa5JSpCe9MI7ibqlzRAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJMWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJMWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:22:19 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC9E2080C;
        Mon, 10 Feb 2020 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581337338;
        bh=/JtHuma/Nuv5fXIEEbQCivHrdEm+001qeJ+s7A5Ip5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9O4QOGUfqG6m4ObKiNVo+GAfkB/xEoukbOEalpbDMuTxCQHl/gUtFJ9vr8/w8/Lj
         cCsaOMmnQleGSIt0/JpT3YSbvQoKClNKtTAWaua4mvt4Zq+aGpXOlnMXmCkLsWxLdN
         TY5wRvRvEzKZl0NYmlrQipNEg8nRWgImLT5N7s5o=
Date:   Mon, 10 Feb 2020 04:21:47 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: Extend report buffer size
Message-ID: <20200210122147.GA413013@kroah.com>
References: <Pine.LNX.4.44L0.2002071018580.3671-100000@netrider.rowland.org>
 <20200210120847.31737-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210120847.31737-1-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:08:47PM +0100, Peter Enderborg wrote:
> In the patch "HID: Fix slab-out-of-bounds read in hid_field_extract"
> there added a check for buffer overruns. This made Elgato StreamDeck
> to fail. This patch extend the buffer to 8192 to solve this. It also
> adds a print of the requested length if it fails on this test.
> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>

Can you add a "Fixes:" tag here pointing to the commit it fixes, as well
as a cc: stable as I'm pretty sure that the commit this fixes is also in
the stable trees already, right?

thanks,

greg k-h
