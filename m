Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D4CCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD220675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC/3PHBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgEMKpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:45:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A41C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:45:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m24so16438447wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SmNmuU5Aep/IGe3eSTrjS6oLXRSTGYhw6IFWVs9Iuqc=;
        b=UC/3PHBoun3v1rx7wxmHxa5RFjjGfNLNpaCn6pfowgebDNYC32O8cp+YJHnvOEQaLk
         Nz+CjUwKVJxOPjAc+Am8F0hqrPMDiwM2aoGX5r90B7BN76cDKPh6nr/YlAAyxleAFf96
         NlJANIMYq5DpzZ6aRKewyuez8+MQkdZd9DSO/gtHi1WlvxunYaH+dufi8aFhaGuP+ph9
         zIeuSIUI2UQyBg6TbiMKe6swjsAYzSJuHyWPZUsJLZuCjKUsD55B1251N8tC3tLD40aj
         agDxckNYt6eUv6ydoTJ+56CrQqMMdERHKWIgm0l69OYmgLIINQMDX3EQTlKycym24/V8
         XC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmNmuU5Aep/IGe3eSTrjS6oLXRSTGYhw6IFWVs9Iuqc=;
        b=is9f/warFIW4VnvyfiXrK36hglFMAs+pWnq7wlchjUFfwdz0xgwdJ+tgvijRDKhQ+1
         ZMviBTgUsR/lxEDIrFGmqyePbmVxLg+KE/3nNLz+dQ0NRRB1Pfm5zfZnqglt6V6enKvM
         6aBxhIF29e3PepPrzJQmKAsoRb6sqqpCSi1OSo2tkIa5KoPAY4MaW1+HvPLi04LPbSAK
         wxSIBe6dnJTal6KWajyPkWzDH5Iv0ltPH+HzDQeyyWqLtw4j18OXGDYdvmcJu+9sy19D
         unxVpYs7ElOw8+uNRjPkSUFbFi99aS8quS15ESSbgf7ZXXeFRHz9qluvOUsgon3q3uSu
         LUiQ==
X-Gm-Message-State: AGi0PuY+xZ7jYNFwf3GelqJy3RyA2xG9Aws02Gl+fKiozYCWwpNbZlwZ
        8/i9enXnVwrwSahHqJAg4dlHmw==
X-Google-Smtp-Source: APiQypJmft0/u1tO86sQKhZsj1C97uNs/XnCzX9fNiwnwt1E0uNsNm62LaV0mFWoR6TcsuBFsKHelA==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr39555553wma.118.1589366747407;
        Wed, 13 May 2020 03:45:47 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id g135sm17966353wme.22.2020.05.13.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:45:46 -0700 (PDT)
Date:   Wed, 13 May 2020 12:45:37 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: Re: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap
 supported by endpoint
Message-ID: <20200513104537.GB214296@myrica>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
 <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:15:22AM +0000, Bharat Bhushan wrote:
> Hi Jean,
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 6, 2020 5:53 AM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: jean-philippe@linaro.org; joro@8bytes.org; jasowang@redhat.com;
> > virtualization@lists.linux-foundation.org; iommu@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; eric.auger.pro@gmail.com; eric.auger@redhat.com
> > Subject: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
> > endpoint
[...]
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	__le64					pgsize_bitmap;
> > > +};
> > > +
> > 
> > This is UAPI. Document the format of pgsize_bitmap please.
> 
> I do not see uapi documentation in "Documentation" folder of other data struct in this file, am I missing something?

I'm not the one requesting this change, but I'm guessing you should add a
comment in this header, above pgsize_bitmap (which should actually be
called page_size_mask to follow the spec). I guess I'd add:

/* Same format as virtio_iommu_config::page_size_mask */

for this field, and then maybe change the comment of virtio_iommu_config,
currently "/* Supported page sizes */", to something more precise such as:

/*
 * Bitmap of supported page sizes. The least significant bit indicates the
 * smallest granularity and the other bits are hints indicating optimal
 * block sizes.
 */

But I don't know how much should be spelled out here, since those details
are available in the spec.

Thanks,
Jean
