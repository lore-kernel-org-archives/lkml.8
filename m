Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF699C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AFA206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K03CgJJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIHfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:35:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43939 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDIHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:35:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id i10so4407430wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GbBkYdAto3GmeZ8k9ai+VjMEZHKuaYzsx51nNI90NCs=;
        b=K03CgJJLcnFNPtjHLyANjALcNZtiKJw0Pz76kqGtl2qssgAoISCq+CWgldcUQwBXgl
         Ftd5QsOcXkbpYsubrkra83D8gLwjU4vaIENnAaJTitETPgwcPkWOjVSOFRAW36NvpRLX
         jXzg1d5oNc50sf+kklslawSSsNCiug0BgTGIVo3MdYqhM9baAa+56mHQ8h/ev70sDw1L
         vsKAOC46H5xnIf7seKGsL4bJQuA5wSzvYZNiN6fnhoo1KPkWPhOWduPWxW0AXB6RJMSv
         JogfP/pdt4XyHstvSK3uuF3NHUUv1pTptLp+jIfpiydLcgO7UFQ2whVX3qdrwIzhnKI2
         ZRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbBkYdAto3GmeZ8k9ai+VjMEZHKuaYzsx51nNI90NCs=;
        b=c6coE4XAwrSoYwg7Y8WoI5sNz78Gw9sEc8ceffVIZXZvsEHH6cQwkuVPGNY0Ev7hnd
         llkLyV07C/GJHbNTKsZBLNUqvAj65GcYEUg/nvIfe9lnazhbmmQMo3Pn35zcyLw2cz80
         ezdd6GsIV9aBf2cdnwe/q1+K27y4aERiL7Zt4/KjzqgRvpn4zkTDW6qIg+pXVRV06a57
         q/pChu/W9IOlari0uaEQzNT7Q5Z+zfMfpFS9sdk2bWuRiV5vn361+TF+7ASd+pS0ku2b
         QYKqnFJXS+v7kcUXtiz7iB6usSbNZac0ZGqKxxcss0hqayxoSaK/YttkG5YrOOG5pIaW
         bT7Q==
X-Gm-Message-State: AGi0PuaiT9KRPTGK0T6KJK3Mq+++AvocMb3i8rLk9zCORTF7DRSHaCIB
        y8MBfb8ByTGT7nR/PPIGimPWeA==
X-Google-Smtp-Source: APiQypIz+nbmA+BaiJDyHzloSsIZFWA0uygarvMoYqSYfnWro08ms2WONffA7OP5UIZr8Wh6a3bPpA==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr10006417wrm.301.1586417741859;
        Thu, 09 Apr 2020 00:35:41 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w66sm2795410wma.38.2020.04.09.00.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:35:41 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:35:33 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200409073533.GB2435@myrica>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>
 <20200408040021.GS67127@otc-nc-03>
 <20200408101940.3459943d@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408101940.3459943d@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:19:40AM -0600, Alex Williamson wrote:
> On Tue, 7 Apr 2020 21:00:21 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
> 
> > Hi Alex
> > 
> > + Bjorn
> 
>  + Don
> 
> > FWIW I can't understand why PCI SIG went different ways with ATS, 
> > where its enumerated on PF and VF. But for PASID and PRI its only
> > in PF. 
> > 
> > I'm checking with our internal SIG reps to followup on that.
> > 
> > On Tue, Apr 07, 2020 at 09:58:01AM -0600, Alex Williamson wrote:
> > > > Is there vendor guarantee that hidden registers will locate at the
> > > > same offset between PF and VF config space?   
> > > 
> > > I'm not sure if the spec really precludes hidden registers, but the
> > > fact that these registers are explicitly outside of the capability
> > > chain implies they're only intended for device specific use, so I'd say
> > > there are no guarantees about anything related to these registers.  
> > 
> > As you had suggested in the other thread, we could consider
> > using the same offset as in PF, but even that's a better guess
> > still not reliable.
> > 
> > The other option is to maybe extend driver ops in the PF to expose
> > where the offsets should be. Sort of adding the quirk in the 
> > implementation. 
> > 
> > I'm not sure how prevalent are PASID and PRI in VF devices. If SIG is resisting 
> > making VF's first class citizen, we might ask them to add some verbiage
> > to suggest leave the same offsets as PF open to help emulation software.
> 
> Even if we know where to expose these capabilities on the VF, it's not
> clear to me how we can actually virtualize the capability itself.  If
> the spec defines, for example, an enable bit as r/w then software that
> interacts with that register expects the bit is settable.  There's no
> protocol for "try to set the bit and re-read it to see if the hardware
> accepted it".  Therefore a capability with a fixed enable bit
> representing the state of the PF, not settable by the VF, is
> disingenuous to the spec.

Would it be OK to implement a lock down mechanism for the PF PASID
capability, preventing changes to the PF cap when the VF is in use by
VFIO?  The emulation would still break the spec: since the PF cap would
always be enabled the VF configuration bits would have no effect, but it
seems preferable to having the Enable bit not enable anything.

> 
> If what we're trying to do is expose that PASID and PRI are enabled on
> the PF to a VF driver, maybe duplicating the PF capabilities on the VF
> without the ability to control it is not the right approach.  Maybe we
> need new capabilities exposing these as slave features that cannot be
> controlled?  We could define our own vendor capability for this, but of
> course we have both the where to put it in config space issue, as well
> as the issue of trying to push an ad-hoc standard.  vfio could expose
> these as device features rather than emulating capabilities, but that
> still leaves a big gap between vfio in the hypervisor and the driver in
> the guest VM.  That might still help push the responsibility and policy
> for how to expose it to the VM as a userspace problem though.

Userspace might have more difficulty working around the issues mentioned
in this thread. They would still need a guarantee that the PF PASID
configuration doesn't change at runtime, and they wouldn't have the
ability to talk to a vendor driver to figure out where to place the fake
PASID capability.

Thanks,
Jean

> 
> I agree though, I don't know why the SIG would preclude implementing
> per VF control of these features.  Thanks,
> 
> Alex
> 
> > > FWIW, vfio started out being more strict about restricting config space
> > > access to defined capabilities, until...
> > > 
> > > commit a7d1ea1c11b33bda2691f3294b4d735ed635535a
> > > Author: Alex Williamson <alex.williamson@redhat.com>
> > > Date:   Mon Apr 1 09:04:12 2013 -0600
> > >   
> > 
> > Cheers,
> > Ashok
> > 
> 
