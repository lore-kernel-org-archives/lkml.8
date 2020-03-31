Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E506CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D4A20748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sn1cOMq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgCaCwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:52:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgCaCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vwCf88W8uI6kfyG9YNKfcw+W9JvoHdjdDO+HJg3PNl8=; b=sn1cOMq2OvxDWuQvY1sqwfGIqY
        2peckD9Zh838ABaFcldXtRD0MvqgMI5wFlWDh5MpEkZrCxIzwAvgRqVR3idX4v+4yAd5r5V2n7Wze
        mChwjmY/4fxP9FxzcZGwP9uiNuicvD/s3MYA4oAAOJD5EREB1cWYqvWthJHKgi3JcARtYvP+P7Hhy
        mE7uz5mWVsIhsEDu+zwAV6mQ/Z64i6OAkhmQcrx20Nk/2L3WkHrx4aBMwumcOIt1MMssnRx517Pu7
        yfOYQzNX1tlRlWtaOQh5t0hiPzGi2U0N2vvub8ZB37jN5sn8siFm18w2X6+FXi2CO6P78UosmjAFL
        w1Wiv9yw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ71F-0003W5-Or; Tue, 31 Mar 2020 02:52:49 +0000
Subject: Re: [PATCH] vhost: make CONFIG_VHOST depend on CONFIG_EVENTFD
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200331022902.12229-1-jasowang@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5646e48a-b1af-6253-bc17-667ab9419fd3@infradead.org>
Date:   Mon, 30 Mar 2020 19:52:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331022902.12229-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 7:29 PM, Jason Wang wrote:
> After commit ec9d8449a99b ("vhost: refine vhost and vringh kconfig"),
> CONFIG_VHOST could be enabled independently. This means we need make
> CONFIG_VHOST depend on CONFIG_EVENTFD, otherwise we break compiling
> without CONFIG_EVENTFD.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: ec9d8449a99b ("vhost: refine vhost and vringh kconfig")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

-- 
~Randy

