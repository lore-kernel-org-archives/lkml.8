Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87485C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C46E20675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdgajoGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgFWCb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgFWCb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:31:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A8AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:31:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i3so4819748qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=Wo9e9T/9y6k6D0DmLDThfgGgYgRwOajCN2XB1YV92bk=;
        b=QdgajoGeEE7bo4y72I+0b8/Np3fpunE4s1YdD1cDQjtyVbhCpgsgtrd9gM+24Aaw2b
         ahmkPca/g10Qx1GuJ14o6BKD8NK+vzw3j50H7B9GIicdehFwfowYAFWb4ABMJxLNvQHA
         8wYjtPUgWIo3uNyfeoOfSceWOprILFtlnLQM5LjqkcfWa7ZKuvwXRTU80ixLR305vTac
         yJGk/EdVckLe9W1vUHUvLNL1ViSz7rjfHYmAucWo9rkrON1wx9CwbjEi11rcC4Gk5L3R
         fvinWRIt5oNVk3AvWRjXlH3WqcigwtYMS9uHQjSKsFWwsblC7VYAXIxmjm8WOol+TpPc
         3vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Wo9e9T/9y6k6D0DmLDThfgGgYgRwOajCN2XB1YV92bk=;
        b=EIpIdCHtL8djUoW+4c5KU/VvQPAoHFkAcYMblYHLVzNMG1ictbOQiHOaqLDY0Q8gqg
         Z32wL8ylrYiVIWYUsF7+6rTu2eB7VekevEFjTWsq66O6jnnqtp4HhUFXt2Ww3SbZ/OJT
         1Zs+U42nLkJvEXZmn6LjWGRL40JdwYc7np1VoYQlvqcJsOKz7Nt0hs6cTTZE2k3sO/7z
         dcOoNHyeyCEvhXLtBlv9Ms1c2BmmJOOlhaeoN0LnWRSwwcVQiyPEAr6wsRDgCiaV0tGy
         jYmdJKdjRMoRWlRsxpR+I/pLqSlmbKklcHDp5m/U+BgzHsCyIOkLybNxhszkkF4trEm2
         FOgA==
X-Gm-Message-State: AOAM531Hq6g3XDSfhQDu9SuHhAXDc0WTS5KMUwsOB4Yd70D8kyEIFp8g
        Ar300ooFU7XieJi+iDmJRWo=
X-Google-Smtp-Source: ABdhPJxfrP3K3GfnHV/1x8+h8WIlRbvFPf4i6lgb2w8YbjNkoi+tDGbltgP29d0hvjCdTkHu6uX3dA==
X-Received: by 2002:ac8:140b:: with SMTP id k11mr19370482qtj.103.1592879485168;
        Mon, 22 Jun 2020 19:31:25 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id f54sm4368739qte.76.2020.06.22.19.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:31:24 -0700 (PDT)
Message-ID: <205edd45b7bbf39d2fc1d2d75fd7e35336f109ac.camel@gmail.com>
Subject: Re: [PATCH 4/4] powerpc/pseries/iommu: Remove default DMA window
 before creating DDW
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 23:31:18 -0300
In-Reply-To: <afd1c5ac-d291-5281-1592-a345ee3c0c8c@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-5-leobras.c@gmail.com>
         <ade15776-61d1-b660-db74-7aeba4eddfdf@ozlabs.ru>
         <4bf1d32da3d13a44e3c2e4b04f369fe52c24a023.camel@gmail.com>
         <afd1c5ac-d291-5281-1592-a345ee3c0c8c@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:11 +1000, Alexey Kardashevskiy wrote:
> 
> On 23/06/2020 04:59, Leonardo Bras wrote:
> > Hello Alexey, thanks for the feedback!
> > 
> > On Mon, 2020-06-22 at 20:02 +1000, Alexey Kardashevskiy wrote:
> > > On 19/06/2020 15:06, Leonardo Bras wrote:
> > > > On LoPAR "DMA Window Manipulation Calls", it's recommended to remove the
> > > > default DMA window for the device, before attempting to configure a DDW,
> > > > in order to make the maximum resources available for the next DDW to be
> > > > created.
> > > > 
> > > > This is a requirement for some devices to use DDW, given they only
> > > > allow one DMA window.
> > > > 
> > > > If setting up a new DDW fails anywhere after the removal of this
> > > > default DMA window, restore it using reset_dma_window.
> > > 
> > > Nah... If we do it like this, then under pHyp we lose 32bit DMA for good
> > > as pHyp can only create a single window and it has to map at
> > > 0x800.0000.0000.0000. They probably do not care though.
> > > 
> > > Under KVM, this will fail as VFIO allows creating  2 windows and it
> > > starts from 0 but the existing iommu_bypass_supported_pSeriesLP() treats
> > > the window address == 0 as a failure. And we want to keep both DMA
> > > windows for PCI adapters with both 64bit and 32bit PCI functions (I
> > > heard AMD GPU video + audio are like this) or someone could hotplug
> > > 32bit DMA device on a vphb with already present 64bit DMA window so we
> > > do not remove the default window.
> > 
> > Well, then I would suggest doing something like this:
> > 	query_ddw(...);
> >   	if (query.windows_available == 0){
> > 		remove_dma_window(...,default_win);
> > 		query_ddw(...);
> > 	}
> > 
> > This would make sure to cover cases of windows available == 1
> > and windows available > 1; 
> 
> Is "1" what pHyp returns on query? And was it always like that? Then it
> is probably ok. I just never really explored the idea of removing the
> default window as we did not have to.

I am not sure if this is true in general, but in this device (SR-IOV
VF) I am testing it will return 0 windows if the default DMA window is
not deleted, and 1 after it's deleted.

> 
> 
> > > The last discussed thing I remember was that there was supposed to be a
> > > new bit in "ibm,architecture-vec-5" (forgot the details), we could use
> > > that to decide whether to keep the default window or not, like this.
> > 
> > I checked on the latest LoPAR draft (soon to be published), for the
> > ibm,architecture-vec 'option array 5' and this entry was the only
> > recently added one that is related to this patchset:
> > 
> > Byte 8 - Bit 0:
> > SRIOV Virtual Functions Support Dynamic DMA Windows (DDW):
> > 0: SRIOV Virtual Functions do not support DDW
> > 1: SRIOV Virtual Functions do support DDW
> > 
> > Isn't this equivalent to having a "ibm,ddw-applicable" property?
> 
> I am not sure, is there anything else to this new bit?

I copied everything from the LoPAR, and IIRC the ACR for this change
only described this change in the document.


>  I'd think if the
> client supports it, then pHyp will create one 64bit window per a PE and
> DDW API won't be needed. Thanks,

That would make sense, and be great.
I will dig some more.

Thank you!

> > > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > > ---
> > > >  arch/powerpc/platforms/pseries/iommu.c | 20 +++++++++++++++++---
> > > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > index de633f6ae093..68d1ea957ac7 100644
> > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > @@ -1074,8 +1074,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  	u64 dma_addr, max_addr;
> > > >  	struct device_node *dn;
> > > >  	u32 ddw_avail[3];
> > > > +
> > > >  	struct direct_window *window;
> > > > -	struct property *win64;
> > > > +	struct property *win64, *dfl_win;
> > > 
> > > Make it "default_win" or "def_win", "dfl" hurts to read :)
> > 
> > Sure, no problem :)
> > 
> > > >  	struct dynamic_dma_window_prop *ddwprop;
> > > >  	struct failed_ddw_pdn *fpdn;
> > > >  
> > > > @@ -1110,8 +1111,19 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  	if (ret)
> > > >  		goto out_failed;
> > > >  
> > > > -       /*
> > > > -	 * Query if there is a second window of size to map the
> > > > +	/*
> > > > +	 * First step of setting up DDW is removing the default DMA window,
> > > > +	 * if it's present. It will make all the resources available to the
> > > > +	 * new DDW window.
> > > > +	 * If anything fails after this, we need to restore it.
> > > > +	 */
> > > > +
> > > > +	dfl_win = of_find_property(pdn, "ibm,dma-window", NULL);
> > > > +	if (dfl_win)
> > > > +		remove_dma_window(pdn, ddw_avail, dfl_win);
> > > 
> > > Before doing so, you want to make sure that the "reset" is actually
> > > supported. Thanks,
> > 
> > Good catch, I will improve that.
> > 
> > > 
> > > > +
> > > > +	/*
> > > > +	 * Query if there is a window of size to map the
> > > >  	 * whole partition.  Query returns number of windows, largest
> > > >  	 * block assigned to PE (partition endpoint), and two bitmasks
> > > >  	 * of page sizes: supported and supported for migrate-dma.
> > > > @@ -1219,6 +1231,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  	kfree(win64);
> > > >  
> > > >  out_failed:
> > > > +	if (dfl_win)
> > > > +		reset_dma_window(dev, pdn);
> > > >  
> > > >  	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
> > > >  	if (!fpdn)
> > > > 
> > 
> > Best regards,
> > Leonardo
> > 

