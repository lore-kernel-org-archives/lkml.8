Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51F5206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592974985;
	bh=1uBhtl4quVofHKkIZZ7aUlBQYKZTxT/j8V3UTHtDKmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2rhJcHXc7U8b5y4OeyiSUNk+F3SY8+qBazzz3XkDTRkFWkBajl3CSr6KfHpqjWz6S
	 CKWb1QDE/nNzeoy/eSCEQhu04k9ekavqc8IDpE8baL51DxKQQH/6YvTZ2o4jbt4+s/
	 e+KOFBYkcUHh9uK7VBoKDXhJAmI74oe8WIcTjnzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbgFXFDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgFXFDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:03:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D27CB206E2;
        Wed, 24 Jun 2020 05:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592974983;
        bh=1uBhtl4quVofHKkIZZ7aUlBQYKZTxT/j8V3UTHtDKmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJ9vYrgpfGenjfuLOYWqdi+tiI+8wYvlI1Xpqt1tzuiSMGOX9yajy2taBrOwF2bdN
         5zka5yqNIB5nphbVydRROjEMHQxDCtl8gxLXkYIFv7VcjrkL34FYkJqnmjexpzzQeK
         AxVbUbOu2Oh6Dzsa7RjHO6OCB9QH8Cwd6xNprF4M=
Date:   Wed, 24 Jun 2020 07:03:00 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Phu Luu <Phu.Luu@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: Re: Subject: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Message-ID: <20200624050300.GA646978@kroah.com>
References: <DM6PR11MB285755DFFFCFB60E2BE09B369C950@DM6PR11MB2857.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB285755DFFFCFB60E2BE09B369C950@DM6PR11MB2857.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:11:21AM +0000, Phu Luu wrote:
> Assign the .throttle and .unthrottle functions to be generic function
> in the driver structure to prevent data loss that can otherwise occur
> if the host does not enable USB throttling.
> 
> Signed-off-by: Phu Luu An <phu.luu@silabs.com>
> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>

Why does your Subject: line have "Subject:" in it again?

Can you please fix up and resend these patches?

thanks,

greg k-h
