Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86AAC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82042071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwfrR7yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgICD0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgICD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:26:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8316C061244;
        Wed,  2 Sep 2020 20:26:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so1074408pfp.11;
        Wed, 02 Sep 2020 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYNxVzL5l70V80L5B0Ue2jMJbnoo4IGKc3sUTTOXxxE=;
        b=TwfrR7yrH/ZmCJKVq785xFnzcAW0rnrJtR2XAGj+ZbDY+vu1Bzp+l97m8nb8JpPUcN
         p8btnPGhknC5ymFX9NQp13zuslf6PXJBBlssl7s9dmeietFQ6hIhcpy/J9PwaJmrWffv
         32jsH4jdqFlLmsW++ObZL5lWUM2zfYC2PwAfo1my2rDxsy/jbBzY7jlHnuJdcWB8guKk
         1EDF7beW1xGiI4Tp/afrAOhNNdifprGE+enYaoD/xIiwiU0zssfWFLNt8BJnod33aGzs
         eDoH3yXto9deLRSw/Ead+1NvLFpo1Bek8s30VDf89NNTBImvQDMk/DFU0/Fp7Yrc9w3V
         Vxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYNxVzL5l70V80L5B0Ue2jMJbnoo4IGKc3sUTTOXxxE=;
        b=nQFcGapFqXZPLsNkcc41k+YD/ZwlukdI3l7hgbbcnKEh+uR87IfABNfiODL3ESOcO0
         vLgXDRBa3FmBC/lXMGyyX3Dej2F6z4RZi2PerbV0gHcEPYRF8kFMomgKEQpLkw1gLL3K
         0dYOtdpHWgWqpYp7BM4yklnBIdjXIWsgjVd+57IuNWZ3N8gzJL9R+Cdx0ua9oKKmjcDi
         NrzLYK02WTjZyxu2lJGWySfbYQLRJa1E+CzgDc4f73ZOg1K+FR6jawNKxUmKrYEwdmYZ
         cfJd4D4rCvQ1HxqJdtldGgT1cK6Ga3lAC9PiJFWGrgdVv5Ozv/xFnp3IuJHVRNPkZDfg
         sWnA==
X-Gm-Message-State: AOAM5330HR3/qNoYoAvBLmvWXnCuPEAfRr/8VNBwiDr0CRlKqPdcfHkQ
        ZUUh+VUGOiIVyjyLlT+fquU=
X-Google-Smtp-Source: ABdhPJyip7LHIa7QrFYS72EGsjmUF2oCbwaBJw2vq8sciVi3qTjTPlQFaDFcEKJyT/c1Yu9ACiqkAw==
X-Received: by 2002:aa7:9625:0:b029:13c:1611:66c5 with SMTP id r5-20020aa796250000b029013c161166c5mr98010pfg.16.1599103607264;
        Wed, 02 Sep 2020 20:26:47 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r33sm740198pgm.75.2020.09.02.20.26.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 20:26:46 -0700 (PDT)
Date:   Wed, 2 Sep 2020 20:26:00 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     hch@lst.de, sfr@canb.auug.org.au, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] dma-mapping: update default segment_boundary_mask
Message-ID: <20200903032559.GA4517@Asurada-Nvidia>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com>
 <2c8db0aa-e8b5-e577-b971-1de10ecc6747@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8db0aa-e8b5-e577-b971-1de10ecc6747@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:13:12AM +0200, Niklas Schnelle wrote:
> On 9/2/20 12:16 AM, Nicolin Chen wrote:
> > These two patches are to update default segment_boundary_mask.
> > 
> > PATCH-1 fixes overflow issues in callers of dma_get_seg_boundary.
> > Previous version was a series: https://lkml.org/lkml/2020/8/31/1026
> > 
> > Then PATCH-2 sets default segment_boundary_mask to ULONG_MAX.
> > 
> > Nicolin Chen (2):
> >   dma-mapping: introduce dma_get_seg_boundary_nr_pages()
> >   dma-mapping: set default segment_boundary_mask to ULONG_MAX
> 
> I gave both of your patches a quick test ride on a couple of dev mainframes,
> both NVMe, ConnectX and virtio-pci devices all seems to work fine.
> I already commented on Christoph's mail that I like the helper approach,
> so as for s390 you can add my
> 
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
 
Thanks for testing and the ack! 
