Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC38C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12FA20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRyvkj1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbgFYG1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389659AbgFYG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:27:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:27:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so2379575plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cC+bIQGI4vbDez97R62VYhumMBGPjOeUnjK9anAQ43g=;
        b=xRyvkj1SfcKEwwIXmGGmO21KVbKVHlhyafW5P/kEECnsPWNg9NjnhSoYjj6KP/WG/j
         7NBcHTsxdxG9q20wFIMT7j4pOPr0omlrPPNOcxM4zVY0zMt6R6sPHvA4bRES+VZgN7bM
         JIgeatSDFwzZ4WGpd6tFFNhjRTV9lU1lfgWWDq83Y0WHZhmGwxzdIQ34cBtG0JdoLtF6
         qJNG3RIzqKU0A5jtQ67pBMivhzr16jsWCmKBLUgqnkFkImRQo1JGUBlVJbof6DH87u6D
         D3DcKIh2+TCs+Vua0oFVYs8mkLU6NZRYIPKKIKUfYBXCBkcQR2JkOZe1UsSHZDQFufLg
         y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cC+bIQGI4vbDez97R62VYhumMBGPjOeUnjK9anAQ43g=;
        b=qYNkqHI8Rf4Xti4RjocDo11l++t1ViHlg1JdBlVipDTHDP/Kwu24bbnS9rwP58jjMC
         rc7UadQvSKjXmN9jpXor9RHXc1VL5j+3v1H+vjFDqIbPf8jvR8KQsCCOuDRq+0bJ5tfK
         /sjBtb9vg3BBm50HhvKTllMWKy21+nyKB8RcRAnBt0NZ1fMdJ2hSO9ktwV6eDdkib3WW
         2P/fYxDNXVIypqNYaHixQiqGKfPEBXYZIu3yyvdp3szcuC+Tjc/6LzvwAqZXAoF7wk0l
         zdIoft9Gvgdx6xZ7clRe8HX/TckqrEXnz5kRUjLWyusbHCe/QJ+mwgqK8gY6CFioqMWD
         pFrQ==
X-Gm-Message-State: AOAM530Vp0Ya3MDf/AGNsOobx7U4/9IxOY1MCt5wGzUq6xhQz1fN2L9p
        QkmgKiSL2MK2E5ZU5jPYeV65
X-Google-Smtp-Source: ABdhPJzGrFQplgXXaCrxKu+iLIp37MqIeZOGvhVdfso+4wEIlz4LBA4npRXVs6NlKQMi/LxfqN+2MQ==
X-Received: by 2002:a17:902:d20c:: with SMTP id t12mr6597766ply.291.1593066428726;
        Wed, 24 Jun 2020 23:27:08 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id m10sm7006836pjs.27.2020.06.24.23.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 23:27:08 -0700 (PDT)
Date:   Thu, 25 Jun 2020 11:57:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v3 3/4] docs: Add documentation for user space client
 interface
Message-ID: <20200625062700.GB6965@Mani-XPS-13-9360>
References: <1591899224-3403-1-git-send-email-hemantk@codeaurora.org>
 <1591899224-3403-4-git-send-email-hemantk@codeaurora.org>
 <20200619063948.GC3245@Mani-XPS-13-9360>
 <7b64f78e-40c7-7c65-3832-4bbc5da93674@codeaurora.org>
 <20200625062327.GA6965@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625062327.GA6965@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:53:27AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 24, 2020 at 06:52:20PM -0700, Hemant Kumar wrote:
> > Hi Mani,
> > 
> > On 6/18/20 11:39 PM, Manivannan Sadhasivam wrote:
> > > On Thu, Jun 11, 2020 at 11:13:43AM -0700, Hemant Kumar wrote:
> > > > MHI user space client driver is creating device file node
> > > > for user application to perform file operations. File
> > > > operations are handled by MHI core driver. Currently
> > > > Loopback MHI channel is supported by this driver.
> > > > 
> > > > Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> > > > ---
> > > >   Documentation/mhi/index.rst |  1 +
> > > >   Documentation/mhi/uci.rst   | 19 +++++++++++++++++++
> > > >   2 files changed, 20 insertions(+)
> > > >   create mode 100644 Documentation/mhi/uci.rst
> > > > 
> > > > diff --git a/Documentation/mhi/index.rst b/Documentation/mhi/index.rst
> > > > index 1d8dec3..c75a371 100644
> > > > --- a/Documentation/mhi/index.rst
> > > > +++ b/Documentation/mhi/index.rst
> > > > @@ -9,6 +9,7 @@ MHI
> > > >      mhi
> > > >      topology
> > > > +   uci
> > > >   .. only::  subproject and html
> > > > diff --git a/Documentation/mhi/uci.rst b/Documentation/mhi/uci.rst
> > > > new file mode 100644
> > > > index 0000000..a5c5c4f
> > > > --- /dev/null
> > > > +++ b/Documentation/mhi/uci.rst
> > > > @@ -0,0 +1,19 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=================================
> > > > +User space Client Interface (UCI)
> > > 
> > > Stick to 'Userspace' everywhere.
> > Done.
> > > 
> > > > +=================================
> > > > +
> > > > +UCI driver enables user space clients to communicate to external MHI devices
> > > > +like modem and WLAN. It creates standard character device file nodes for user
> > > 
> > > UCI driver creates a single char device, isn't it?
> > No, it is created per device name. For example Loopback has its own char
> > device file node. if we add another channel for a new mhi device new device
> > file node would be created.
> 
> Okay, then please add a line saying that there will be separate chardev nodes
> for each channel specified.
> 
> > > 
> > > > +space clients to perform open, read, write, pool and close file operations.
> > > > +
> > > 
> > > poll? Btw, you need to mention explicitly how this char device can be used.
> > > You are just mentioning standard file operations.
> > Will fix poll.My idea was indeed to mention generic file operations so that
> > we dont have to be specific with use case. Any userspace entity who wants to
> > communicate over mhi can use the driver. Reason we have this driver is to
> > abstract the mhi core specific details. Even for loopback use case,
> > userspace can echo to device file node on one channel and get a same in
> > response from another channel back. I can add more examples of
> > other user space drivers use case if that helps.
> 
> Yes, just add couple of examples.
> 

Or.. just add loopback as an example for now and then if we add more channels in
future let's make sure to document those here.

Thanks,
Mani

> > > 
> > > > +Device file node is created with format:-
> > > > +
> > > > +/dev/mhi_<controller_name>_<mhi_device_name>
> > > > +
> > > > +controller_name is the name of underlying bus used to transfer data.
> > > 
> > > underlying controller instance.
> > Done.
> > > 
> > > > +mhi_device_name is the name of the MHI channel being used by MHI client
> > > 
> > > What do you mean by MHI client here? Are you referring to userspace client?
> > yes. i can say "MHI client in userspace"?
> 
> Okay. The naming conventions used in MHI are a bit weird. So from the start
> itself I stuck with some fixed names and client is one of them. The term client
> itself refers to both client device and a driver used to talk to the device in
> the host. So we should explicitly mention if it is a userspace client driver
> or the client device.
> 
> Thanks,
> Mani
> 
> > > 
> > > > +to send or receive data using MHI protocol. MHI channels are statically
> > > > +defined by MHI specification. Driver currently supports LOOPBACK channel
> > > > +index 0 (Host to device) and 1 (Device to Host).
> > > 
> > > s/index/identifier
> > Done.
> > > 
> > > And explain a bit on how this LOOPBACK channel is getting used.
> > Done.
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > -- 
> > > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > > a Linux Foundation Collaborative Project
> > > > 
> > 
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
