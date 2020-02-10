Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B195C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B782080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581327666;
	bh=Jeekv8ZZYK1og9djL7Q1QKF6nhjkbrxnPdvePxFq+vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oj4+BgUfuYDPyWUXuSAlbqyH50sy4loJmjwv17BrwpJbRovzliCX53l7tthpuUBop
	 XS9IGeyKvK9YZzGcFLvUNGooJd30LilqjkITi2SygxGWkfLGOsbbUcj/+GbQJGh7Jg
	 IpW/yDVbqSaWo4ZOsyzCJEVdFSyWpC2VFWiVRfOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJJlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:41:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46286 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:41:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id z26so3652186lfg.13;
        Mon, 10 Feb 2020 01:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/G1mlQeVdMuqMC4m0LfR80YKfvoPA8y9J/QfNCKIgLQ=;
        b=tbE2JCZj4Kn09eADiEhSQOT+uZe/qa5xPAevcZWWaS5UPEsErRQJX081ZRcmzA8Row
         sxrXj1uDvyT2W9KIUNVAoU7hALizp2ZV5MVypaskGwNL47CfQwusKfOqznbe0BhiTb8X
         WHhUQKAnBDgOEpTDu0aIH51uinGKbnlQQTGOX+pAuwenmzTn+Bnfief28B/Huzhlkqoo
         LKgDvTFQXetiUIz3N07fRmZoOaPkOM1+LBa+xugpzogbD5p1YuCi78yHTBzywej+Wi5X
         Iei6MU3edjJfKew3WEFJ0LA2Oi2ajKvoQ6SnbCXyNmGaub9gcjwmd8dExiz1FSPIJspP
         L2kw==
X-Gm-Message-State: APjAAAUguprOHEnb4kMZRmtbCquS5ApRuR8V//x5buA2bv5f7Mea0CDf
        cPP2DJ1Qtstfd1xIjzAecFQ=
X-Google-Smtp-Source: APXvYqxhTk+aNhBV3z2jw7l/zmyHQrI8V8cH/p8M7fzDw7t5Z0/+C1SyFjioHQ3MuplYPmic+TKutg==
X-Received: by 2002:a19:2351:: with SMTP id j78mr287125lfj.173.1581327662343;
        Mon, 10 Feb 2020 01:41:02 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id y66sm5022967lfa.53.2020.02.10.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 01:41:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j15Yo-0007lJ-IH; Mon, 10 Feb 2020 10:40:58 +0100
Date:   Mon, 10 Feb 2020 10:40:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: digi_acceleport: remove redundant
 assignment to pointer priv
Message-ID: <20200210094058.GC3539@localhost>
References: <20200208164601.30032-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208164601.30032-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 04:46:01PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer priv is being assigned with a value that is never read, it is
> assigned a new value later on in a for-loop. The assignment is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.

Johan
