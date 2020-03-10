Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC179C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90677222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HziVMxK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCJV1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:27:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbgCJV1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583875638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elF36Gh6wAO43EXQWi3veY++EdOPHWUl7a5YAiXhFTQ=;
        b=HziVMxK2D5RJcYF0bqBbXWQ4EDx1t0YTx09F0AKtSze4CAM39HvESxL4VhtXPm8gIjJ2yC
        Xzk353m2CIwXQXo10qBUNwzvgSvQ5ZikWL/laAXQnJA+KfgXFfq1NbNIPZMiop6NKdJNBY
        k5h56Vg36nn4E+oElzwpeqAx7ehH/TM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-wVchelQ2Odm8hnwS7-Er4A-1; Tue, 10 Mar 2020 17:27:16 -0400
X-MC-Unique: wVchelQ2Odm8hnwS7-Er4A-1
Received: by mail-qt1-f197.google.com with SMTP id r16so10086466qtt.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elF36Gh6wAO43EXQWi3veY++EdOPHWUl7a5YAiXhFTQ=;
        b=ViCeCPtM0QDX4H4Mns0B7pzDqd7HfGm8+cJs/lPEwO30cZm4BJ80qRoHypFMC7S4zX
         4Xa00XT75kSvKjjAuV6MAHhPCQEp0ILB10wgLoez4lk+5nHH5nY6ezWR9O4oIehUy2AO
         6Nrm/ujpRCw6nULl/ZmuW/+GOeud0F0/mwMcl3ZTHy32TnJmutLTP9C/MbkhbS+p/jTs
         UE7hB9yBQpZGmdE/iVk/KgMqk+z8JLHrCGpvlsGiXgtWW7axG769g+TcBtw434TQRF+W
         YJKQzWa0moPTHE2m5VyGFNYWfKouqLzlBW1h0G3u1S0XBvh/AszgM0v7lI4Aa6JCDHui
         qTRQ==
X-Gm-Message-State: ANhLgQ1tlOpXVVOvkryBS3a8JxlPkShVnwusLCJD0GJO5XOza6+iOIfd
        Ht130Fx/LoTyX2JRgBQCs4d/MxejsOkjxbesoppXtPDmgP/suRf7XCg9FkZ5ITX1hcAfNnK2B7K
        BWTPUaEl4LxHN4k5287Adod+A
X-Received: by 2002:a37:40d2:: with SMTP id n201mr21535558qka.211.1583875636357;
        Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXf2G2CIG42koICoLhPiploL8mRnMRgCVqT/plH2Fo1ASYnuHMzPvSDT2uyk6rvt8fR12jmg==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr21535545qka.211.1583875636149;
        Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id x51sm3774837qtj.82.2020.03.10.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:27:14 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:27:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310172603-mutt-send-email-mst@kernel.org>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310071043-mutt-send-email-mst@kernel.org>
 <20200310184720.GD38440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310184720.GD38440@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:47:20PM -0400, Vivek Goyal wrote:
> On Tue, Mar 10, 2020 at 07:12:25AM -0400, Michael S. Tsirkin wrote:
> [..]
> > > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > > +			      struct virtio_shm_region *region, u8 id)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > > +	u8 bar;
> > > +	u64 offset, len;
> > > +	phys_addr_t phys_addr;
> > > +	size_t bar_len;
> > > +	int ret;
> > > +
> > > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > > +		return false;
> > > +	}
> > > +
> > > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > > +	if (ret < 0) {
> > > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > > +			__func__);
> > > +		return false;
> > > +	}
> > > +
> > > +	phys_addr = pci_resource_start(pci_dev, bar);
> > > +	bar_len = pci_resource_len(pci_dev, bar);
> > > +
> > > +        if (offset + len > bar_len) {
> > > +                dev_err(&pci_dev->dev,
> > > +                        "%s: bar shorter than cap offset+len\n",
> > > +                        __func__);
> > > +                return false;
> > > +        }
> > > +
> > 
> > Something wrong with indentation here.
> 
> Will fix all indentation related issues in this patch.
> 
> > Also as long as you are validating things, it's worth checking
> > offset + len does not overflow.
> 
> Something like addition of following lines?
> 
> +       if ((offset + len) < offset) {
> +               dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
> +                       __func__);
> +               return false;
> +       }
> 
> Vivek

That should do it.

