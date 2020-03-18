Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A4C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DAF2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584535809;
	bh=4sAHYFtjA0FIdYJcOZIot3tUfnyJiT7eyznRhSXxk3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dfwe7RInAv736dL2W0i8S+VzVB20Co7z2HQwKj216oCRVb7evfIMdC6E/Ch2RIMH1
	 pw08XYs4vpaXrdoN6nCCVV5PmxiXYivUOe8+EBAkGvHFdUYiPDmw0DlE47lNTamg61
	 jijDJxdKvlBPyhZ04gXoL2UKeg5nLhfAAFSICRtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCRMuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCRMuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:50:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B498620772;
        Wed, 18 Mar 2020 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584535805;
        bh=4sAHYFtjA0FIdYJcOZIot3tUfnyJiT7eyznRhSXxk3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIezsSKKuQ3seIdtO7kKrRl5zs5TwtTF7vVaWUEN68+xXAXgxNUrLCElI6m+cYkID
         rfNxn+j8J42BrRHX2n2rzTy7Y2uTU9phPEFF1Ec7UzSsw+mw+iyO4ULhLtwP2kZf98
         Q/l5hfHFWMk83eNAWUpAYETxHr296cWmeS/SlDSk=
Date:   Wed, 18 Mar 2020 13:50:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajan Vaja <RAJANV@xilinx.com>
Cc:     Jolly Shah <JOLLYS@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write
 GGS/PGGS registers
Message-ID: <20200318125003.GA2727094@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-21-git-send-email-jolly.shah@xilinx.com>
 <20200318115141.GB2472686@kroah.com>
 <BYAPR02MB4055DE6560EFDCFD0EBFD8E2B7F70@BYAPR02MB4055.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4055DE6560EFDCFD0EBFD8E2B7F70@BYAPR02MB4055.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:41:46PM +0000, Rajan Vaja wrote:
> Hi Greg,
> 
> Thanks for applying patches and review.
> 
> Please see my comment inline.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 18 March 2020 05:22 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk;
> > sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> > dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
> > Subject: Re: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write GGS/PGGS
> > registers
> > 
> > CAUTION: This message has originated from an External Source. Please use
> > proper judgment and caution when opening attachments, clicking links, or
> > responding to this email.
> > 
> > 
> > On Fri, Mar 06, 2020 at 03:47:28PM -0800, Jolly Shah wrote:
> > > --- a/include/linux/firmware/xlnx-zynqmp.h
> > > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > > @@ -105,6 +105,10 @@ enum pm_ioctl_id {
> > >       IOCTL_GET_PLL_FRAC_MODE,
> > >       IOCTL_SET_PLL_FRAC_DATA,
> > >       IOCTL_GET_PLL_FRAC_DATA,
> > > +     IOCTL_WRITE_GGS,
> > > +     IOCTL_READ_GGS,
> > > +     IOCTL_WRITE_PGGS,
> > > +     IOCTL_READ_PGGS,
> > 
> > You do not have explicit numbers here?  Bold :)
> [Rajan] Here new IOCTL IDs are continuous so didn't mention explicit number.

Yes, but is that guaranteed by the compiler?  I keep getting conflicting
advice with that.

> Are asking for adding numbers like below:
> enum pm_ioctl_id {
>       ...
>       IOCTL_GET_PLL_FRAC_DATA = 11,
>       IOCTL_WRITE_GGS = 12,
>       ....
> }

Yes please, especially as your firmware is expecting the explicit values
here, right?  That way you _know_ everything is correct.

thanks,

greg k-h
