Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CD0C8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7AA2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzpsXmcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD2E5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:57:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbgD2E5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588136270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3nNJuKtjgttr9/75Tz29rm+bXY1XXpiZYQWZLWivAVY=;
        b=bzpsXmcN7/txQGw++B4c5Q3s4BRmz6ykAaHzuZWWc2cz89BvEZrerX/g4OLNvjV2qDooFr
        dWXjzpS/uMkWbO7ukBz6OS4hzh7Q3LrFRDKOGL6hgRS63qm22d9wEbVIiiGBXH01TqBYrp
        WZ2o6hzpNYXoUF2Vo8dpNz0E4qy5TzQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-HyGrS9prNrSVEEZ7WCIGSg-1; Wed, 29 Apr 2020 00:57:48 -0400
X-MC-Unique: HyGrS9prNrSVEEZ7WCIGSg-1
Received: by mail-wr1-f69.google.com with SMTP id f15so1117648wrj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 21:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3nNJuKtjgttr9/75Tz29rm+bXY1XXpiZYQWZLWivAVY=;
        b=G99sxWeVNk//yg6e9YR7X1HiOxcdbN1XXagpn/0Z6WuUXOTlEbJZttKKbAZgbNrte4
         vyFCuuW77cGaB9F3+QwKdUt3pikiMyAwLmD/3HD0axz2iOxvO+hM7dmoKLdvm6p5jXnL
         MyIViUquKIKzmiC4yW6zh837V+Ew6ucf+JmMzEmjvF98bPygueJFr8bAkHuvip0SoNLM
         HJp7eyOdcLdjQ/DSF0fJH2QuN0uigwdo4SaOj0X6j1K1+30qgbI5p4CsOYRwrBj+ln8B
         sMO1Vc06rI/wPXalYG8CewANbNy2M4GqrBm+/L6SvaPknsOyQ+WaIijOjjT0PGlRqoyT
         v9VA==
X-Gm-Message-State: AGi0PuZW5ub8CxZ4mwPLLTuopJZg3tyE+YWKUjxANk7oxhADkF8mzgk5
        figS+zOzOVk4fi9fZZSZdZa9auZeEVGFSjzZ3wovKEvd3T9hL2YQFpVZ1w9Tm+/NqBoPk3Rn7jE
        aKV348JbdBkAI2hwaSF/u71We
X-Received: by 2002:adf:f884:: with SMTP id u4mr36138567wrp.171.1588136267212;
        Tue, 28 Apr 2020 21:57:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLIkFFOdPPZMhssIAseU7SHZrcOaozQItYfLHySNTFChvxRbYL5g64fDwfcVxKEgSHYYt1vng==
X-Received: by 2002:adf:f884:: with SMTP id u4mr36138548wrp.171.1588136267003;
        Tue, 28 Apr 2020 21:57:47 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id h17sm5885719wmm.6.2020.04.28.21.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 21:57:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 00:57:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Srivatsa Vaddagiri <vatsa@codeaurora.org>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jan.kiszka@siemens.com, jasowang@redhat.com,
        christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429004531-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
> On 2020/4/29 4:41, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> > > * Michael S. Tsirkin<mst@redhat.com>  [2020-04-28 12:17:57]:
> > > 
> > > > Okay, but how is all this virtio specific?  For example, why not allow
> > > > separate swiotlbs for any type of device?
> > > > For example, this might make sense if a given device is from a
> > > > different, less trusted vendor.
> > > Is swiotlb commonly used for multiple devices that may be on different trust
> > > boundaries (and not behind a hardware iommu)?
> > Even a hardware iommu does not imply a 100% security from malicious
> > hardware. First lots of people use iommu=pt for performance reasons.
> > Second even without pt, unmaps are often batched, and sub-page buffers
> > might be used for DMA, so we are not 100% protected at all times.
> > 
> 
> For untrusted devices, IOMMU is forced on even iommu=pt is used;

I think you are talking about untrusted *drivers* like with VFIO.

On the other hand, I am talking about things like thunderbolt
peripherals being less trusted than on-board ones.

Or possibly even using swiotlb for specific use-cases where
speed is less of an issue.

E.g. my wifi is pretty slow anyway, and that card is exposed to
malicious actors all the time, put just that behind swiotlb
for security, and leave my graphics card with pt since
I'm trusting it with secrets anyway.


> and
> iotlb flush is in strict mode (no batched flushes); ATS is also not
> allowed. Swiotlb is used to protect sub-page buffers since IOMMU can
> only apply page granularity protection. Swiotlb is now used for devices
> from different trust zone.
> 
> Best regards,
> baolu

