Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD00CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A677E206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4QOMu0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgDMTKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:10:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35467 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387811AbgDMTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586805015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2w0zTL2S2HNCke1rO2a892We/kRrnfinWwPLR7p/D8=;
        b=D4QOMu0nBsCUPlF/qnKS+vTTJ57F3gIoej1j5gUBcMrNiELPtlr4BLbd9Z4hh25hTML1Yl
        Szq/Fm5Hn1F3CmV/EZMmWZSXMhplrX+UNAmV9hQrwN3rEgEDWTFu+WH1iZiUfP1Kkgsa+0
        GR/s3xkC7t8ZStWucA59D674XOnXRp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-LRRuLY3rMi27XnVi9zMzzg-1; Mon, 13 Apr 2020 15:10:11 -0400
X-MC-Unique: LRRuLY3rMi27XnVi9zMzzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E339107ACC4;
        Mon, 13 Apr 2020 19:10:09 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 973D799DEE;
        Mon, 13 Apr 2020 19:10:08 +0000 (UTC)
Date:   Mon, 13 Apr 2020 13:10:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@linux.intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Wu, Hao" <hao.wu@intel.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200413131008.2ae53cc3@w520.home>
In-Reply-To: <20200413032930.GB18479@araj-mobl1.jf.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
        <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
        <20200402165954.48d941ee@w520.home>
        <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
        <20200403112545.6c115ba3@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
        <20200407095801.648b1371@w520.home>
        <20200408040021.GS67127@otc-nc-03>
        <20200408101940.3459943d@w520.home>
        <20200413031043.GA18183@araj-mobl1.jf.intel.com>
        <20200413032930.GB18479@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Apr 2020 20:29:31 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> Hi Alex
> 
> Going through the PCIe Spec, there seems a lot of such capabilities
> that are different between PF and VF. Some that make sense
> and some don't.
> 
> 
> On Sun, Apr 12, 2020 at 08:10:43PM -0700, Raj, Ashok wrote:
> >   
> > > 
> > > I agree though, I don't know why the SIG would preclude implementing
> > > per VF control of these features.  Thanks,
> > >   
> 
> For e.g. 
> 
> VF doesn't have I/O and Mem space enables, but has BME

VFs don't have I/O, so I/O enable is irrelevant.  The memory enable bit
is emulated, so it doesn't really do anything from the VM perspective.
The hypervisor could provide more emulation around this, but it hasn't
proven necessary.

> Interrupt Status

VFs don't have INTx, so this is irrelevant.

> Correctable Error Reporting
> Almost all of Device Control Register.

Are we doing anything to virtualize these for VFs?  I think we've
addressed access control to these for PFs, but I don't see that we try
to virtualize them for the VF.

> So it seems like there is a ton of them we have to deal with today for 
> VF's. How do we manage to emulate them without any support for them 
> in VF's? 

The memory enable bit is just access to the MMIO space of the device,
the hypervisor could choose to do more, but currently emulating the bit
itself is sufficient.  This doesn't really affect the device, just
access to the device.  The device control registers, I don't think
we've had a need to virtualize them yet and I think we'd run into many
of the same questions.  If your point is that there exists gaps in the
spec that make things difficult to virtualize, I won't argue with you
there.  MPS is a nearby one that's difficult to virtualize on the PF
since its setting needs to take entire communication channels into
account.

So far though we aren't inventing new capabilities to add to VF config
space and pretending they work, we're just stumbling on what the VF
exposes whether on bare metal or in a VM.  Thanks,

Alex

