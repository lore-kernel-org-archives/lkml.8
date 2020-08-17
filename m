Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B325EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895532072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="tK9KPbz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHQHyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:54:35 -0400
Received: from mail2.skidata.com ([91.230.2.91]:19361 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgHQHyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597650873; x=1629186873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ofZrqwAJsIrM6P1Vwx0HSmOUvg40eLwTglG9qnXtQI=;
  b=tK9KPbz4XCO3lgUQs22GS0IrgImLbaV5JtTSZvjGNgra9W219D4NLZIU
   SJvUsA4FZ5CFnBGMgheHtdFULIfMMzNmBUvBpFl+RrHHxvOg4bNE21Vus
   cluQMLbqpvASfBqjmGSqd/9iax6agxkjTL6TLL5yd+GFXfSKtQ/kFpC/H
   sWXZ4rU41mhpgbQ2A1V7R6ULj61FyTSoEaZAupms3EB7ZYOwwsOJEyXYe
   26BNeUNnsvu52PbDTCcDJZBceGkLSHtLBlbGF8vnvxJ9GUcgZs3AkgSUD
   3eZHzdN5n/ZVUgMJ/HAsDrXtfO7H75iUotGALITCABsm/BAHd0T4be593
   g==;
IronPort-SDR: E6jKT3W4gGuPCqcb4dACYlUcJdMvMQ6vN3AbLOWDsFITViC1ocTwq1NFR8yGc6UYCithd/ds9s
 LPsfgBt9exsxIDt7Cyls6tvynZTqeupkZtIlqWC4Dj3vUtFmkq5ntcwsd7c0PGxzzJ4nfm0V8B
 RjUVFTXtvCyL5tAsN4ROaAJ0yohsvLVjerg1Vlr8I4Y63JzHavc/QzETBWPP406Je0v+nZiGr2
 zpp3CSi1EhzAgl6Kt38qpvIN7JsLTIy6kvy4BaIA+KHSXcnt1KuyRdMnsAN01TCTx0J/zeS+JY
 ybk=
X-IronPort-AV: E=Sophos;i="5.76,322,1592863200"; 
   d="scan'208";a="2642593"
Date:   Mon, 17 Aug 2020 09:54:26 +0200
From:   Richard Leitner <richard.leitner@skidata.com>
To:     Christian Eggers <ceggers@arri.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Hering <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add two new configuration drivers for Microchip USB
 hubs
Message-ID: <20200817075426.GA560469@pcleri>
References: <20200726084116.GD448215@kroah.com>
 <20200727083333.19623-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200727083333.19623-1-ceggers@arri.de>
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:33:29AM +0200, Christian Eggers wrote:
> On Sonday, greg k-h wrote:
> > Please resend the whole series, not just a single patch, as it makes it
> > very difficult to pick the "correct" patches to be applied...

Hi Christian,
sorry for the late reply. My MUA somehow didn't show me that series
earlier...

I haven't looked into the patches in detail, but at a first glance it
looks like a lot copy-n-paste.
Have you thought about merging the (after your series) 3 hub drivers
into one? Something like a "microchip i2c usb hub driver"?
Would that be feasible for your point of view?

regards;rl

> 
> Changes in v3:
>  - none (only resend the whole series)
> 
> Changes in v2:
>  - added property description for ocs-min-width-ms
>  - fixed property description for oc-delay-ns
> 
