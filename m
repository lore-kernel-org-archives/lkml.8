Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD3BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E7820674
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597772381;
	bh=X2MHH+ajAt8ye/9QwPzB+aG8Y9hDwLgxvzGBUmiUFUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fZfdkEsaHTdkNor4kh7i5Mk6DQWR1IiYG7qheWLb1tC89n6OKoMOE9VPnzJzE+UyR
	 HcgbVYFpkwNwrKbGfoZBVnRtgw9e21g/19j/BQJWRFoNWr1PA7YnYY+iESPJ/CvT4c
	 /E5yUVojTctM4l14nsdsRgkh3w3nUj1V9HpLaTlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgHRRjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgHRRjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:39:39 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8D420738;
        Tue, 18 Aug 2020 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597772378;
        bh=X2MHH+ajAt8ye/9QwPzB+aG8Y9hDwLgxvzGBUmiUFUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2GWk3PWMd1NreljfZxP+OqUTzod2fm7mIpCQ2qDQ3qvyktQFZsiI1Hu65eBGngzS
         /pdohnETh4V1X31tm8Fvq5I+D2HMEhhxkB8xsfbl6HRDH09D5WWdq8xSfdSRmMlL5n
         W52qnLFBeZuAX4Ov7JTOB9KCrbr3c4fgaVtkzFxY=
Date:   Tue, 18 Aug 2020 10:39:36 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818173936.GA3097355@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818172912.e54klrofz3tfhxhj@MacBook-Pro.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 07:29:12PM +0200, Javier Gonzalez wrote:
> On 18.08.2020 09:58, Keith Busch wrote:
> > On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
> > > a number of customers are requiring the use of normal writes, which we
> > > want to support.
> > 
> > A device that supports append is completely usable for those customers,
> > too. There's no need to create divergence in this driver.
> 
> Not really. You know as well as I do that some features are disabled for
> a particular SSD model on customer requirements. Generic models
> implementing append can submit both I/Os, but those that remove append
> are left out.

You are only supporting my point: if your device supports append, you
get to work in every ZNS use case, otherwise you only get to work in a
subset.
