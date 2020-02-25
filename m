Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89B7C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FDD20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582620306;
	bh=6c3IuGsy6ZsjI8u0LwfN1xfHtyxVaHNFDuen1/jojCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vis9HRp17eCl9emknJLclOOd+7hcYyWNmzMNz/DbNdWXt+DXAlLVGzkXNu+PHVvFR
	 UjrJd4r9X+OZyXYmw5ZTMnzm5bIzaPB5IbWefA75BLgvU65QlV5BNxIgQ8gamKqOHU
	 m5Qvij0MGQkg2fSVSHICpb67mB5AOeMNNF1Bq6I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgBYIpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:45:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45046 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBYIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:45:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so13044399ljj.11;
        Tue, 25 Feb 2020 00:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiv9myvgkw7xumEgeJGJ5mKNPtyekzHsqGUH5eUSRc4=;
        b=Q3B/A/3F3ZPIfBBwceYha+7UH8tj6hYiRUwebqZZoCYGcBMCTYnzpBU479Fwu76mHE
         wPgqLwnbHiUp1Jgm/a3hxmy7E5E4rqseJtGsF7cAgqCA5g0Dlg2uRTeDvG5FwvsXMyiM
         1dHglkj+lkKtypvGKJrKcb5/eS4EkftWta0A4EvHC/WnwYr1DSHRUrCL2uiqFH2j7XUV
         6KFdCBDRK8+wnoNBQ+zM6EHymTIDjZHe2fqaiDP8NzCX84eRHMBrIsWYNpwzvJoum+Bz
         SnpTxNCeLB4Req98pSvnF5qlelNnq6Nsidh7II+gJsT8lIkGjrscdeo3fD/55/icHSU3
         4ELA==
X-Gm-Message-State: APjAAAVcU8GT5u7sB7HmWgcjS2u2QM3LcZ44wevsaraGWA1O+TvTCxBO
        elFmhKiUCTBpp4u1XJgAirI=
X-Google-Smtp-Source: APXvYqzGgTQlZDTjc/WdsduCx/ZBfzNVw6Bsa4sPCaQ5okT0MJQT0iJdL306dKc+VA7rZExFnSr49w==
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr33212112ljg.292.1582620302745;
        Tue, 25 Feb 2020 00:45:02 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id d24sm7300090lja.82.2020.02.25.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:45:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6Vpp-0004Ni-IX; Tue, 25 Feb 2020 09:44:57 +0100
Date:   Tue, 25 Feb 2020 09:44:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] USB: Replace zero-length array with flexible-array member
Message-ID: <20200225084457.GO32540@localhost>
References: <20200220132017.GA29262@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220132017.GA29262@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:20:17AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/atm/usbatm.h              | 2 +-
>  drivers/usb/dwc2/hcd.h                | 2 +-
>  drivers/usb/host/ehci-tegra.c         | 2 +-
>  drivers/usb/host/ehci.h               | 4 ++--
>  drivers/usb/host/fotg210.h            | 2 +-
>  drivers/usb/host/ohci.h               | 4 ++--
>  drivers/usb/host/xhci-mtk.h           | 2 +-
>  drivers/usb/host/xhci.h               | 4 ++--
>  drivers/usb/serial/io_usbvend.h       | 4 ++--
>  drivers/usb/serial/ti_usb_3410_5052.c | 4 ++--
>  include/linux/usb.h                   | 4 ++--
>  include/linux/usb/audio-v2.h          | 2 +-
>  include/linux/usb/audio-v3.h          | 2 +-
>  include/linux/usb/gadget.h            | 2 +-
>  include/linux/usb/hcd.h               | 2 +-
>  include/linux/usbdevice_fs.h          | 2 +-
>  16 files changed, 22 insertions(+), 22 deletions(-)

Looks like your scripts still doesn't catch every instance. A simple
grep like 

	git grep -A1 '\[0\];$' drivers/usb/ | grep -B1 '}'

found at least three more in 

	drivers/usb/atm/ueagle-atm.c
	drivers/usb/gadget/function/f_phonet.c
	drivers/usb/musb/musb_host.c

Johan
