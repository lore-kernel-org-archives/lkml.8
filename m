Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6988D20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590619837;
	bh=AC/qBVIz2RY3tjOrzusi4AN43Yd3fTkCrWWr78GG/34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=H/fpliM0dFg8L/nOnlEiaf7YjWRmzl7obCMYMv9ix2NE6urbu75JR3HMyq7JdqGX2
	 1x13ONn97z9ZqLEc7NdzkXsX2iMSMmXBZdY+YCDK9PVlfpNRfp5XC5hLH7TjXPZCkw
	 B1wV4TNfQ6lGuny1enox7HaNkiBkpHote9E5MVR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgE0Wug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0Wug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:50:36 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EEFC2071A;
        Wed, 27 May 2020 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590619836;
        bh=AC/qBVIz2RY3tjOrzusi4AN43Yd3fTkCrWWr78GG/34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VGr0mm/uYPh+W6nREpEC/OqhxQ54VwT0nXe0oLBmmhPRb48QhwaTYd3VgVQO3kJ59
         3UJbET/o9qWoUkvbv97YWwpxa2JX5FSr5+QalNF0uLbxOR60YCdltuCmj351kl/Iba
         V7Knj2in8qphInGIehOaq1LhmIuM1JqviKvUTM14=
Date:   Wed, 27 May 2020 17:50:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] xen-pciback: Use dev_printk() when possible
Message-ID: <20200527225034.GA270348@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612fee00-4e7c-9b90-511d-4efb7676cbed@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:34:26PM -0700, Boris Ostrovsky wrote:
> On 5/27/20 1:43 PM, Bjorn Helgaas wrote:
> > @@ -155,8 +157,8 @@ int xen_pcibk_config_read(struct pci_dev *dev, int offset, int size,
> >  	u32 value = 0, tmp_val;
> >  
> >  	if (unlikely(verbose_request))
> > -		printk(KERN_DEBUG DRV_NAME ": %s: read %d bytes at 0x%x\n",
> > -		       pci_name(dev), size, offset);
> > +		dev_printk(KERN_DEBUG, &dev->dev, "read %d bytes at 0x%x\n",
> > +			   size, offset);
> 
> 
> Maybe then dev_dbg() ?

printk(KERN_DEBUG) always produces output, so I used
dev_printk(KERN_DEBUG) to retain that behavior.

dev_dbg() does not always produce output, since it depends on DEBUG or
CONFIG_DYNAMIC_DEBUG and the dynamic debug settings.

If dev_dbg() seems like the right thing, I would probably add a
separate patch on top to convert dev_printk(KERN_DEBUG) to dev_dbg().

Thanks for taking a look!  

Bjorn
