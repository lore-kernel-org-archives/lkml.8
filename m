Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78562208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465881;
	bh=VU/RIJXvCYk+2jviH8h2AT1vE98UnjDulLXhUfcDuQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rRb9Drchn9FCw7BlmrlMBZ34jkgEMJtMhwXYQA69pPTrVM/7Sx9yVFcgL8HDUNekf
	 a6N7Iou5O7ahFKMx/QMyf4WCywC9MBlup96gK2UULbzPcD61Nr6LigXjr+M/PdT1GK
	 Qx3M2UoLFTEQNCwumVt5L+uvJrLOUuMrd7I7Geco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbgF2VYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbgF2SuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DCE25374;
        Mon, 29 Jun 2020 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593447622;
        bh=VU/RIJXvCYk+2jviH8h2AT1vE98UnjDulLXhUfcDuQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zekE3DSOLBcqpTnJqEY1MWbVu31fmkX0WoQ29NElsbLZeg5a1/ebgLKulJEaGDcAJ
         Ves1NgwfqAndZuwwUlg6t38RoVYM0obP7iONb6svovbBOH2Kbd4jrJutTSZDHnzYnS
         Vwek86TKKmK6noATwJONwfVYpkK0BrWm9HoXoR3s=
Date:   Mon, 29 Jun 2020 18:20:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     linux-kernel@vger.kernel.org,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v4 07/18] nitro_enclaves: Init misc device providing the
 ioctl interface
Message-ID: <20200629162013.GA718066@kroah.com>
References: <20200622200329.52996-1-andraprs@amazon.com>
 <20200622200329.52996-8-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622200329.52996-8-andraprs@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:03:18PM +0300, Andra Paraschiv wrote:
> +static int __init ne_init(void)
> +{
> +	struct pci_dev *pdev = pci_get_device(PCI_VENDOR_ID_AMAZON,
> +					      PCI_DEVICE_ID_NE, NULL);
> +	int rc = -EINVAL;
> +
> +	if (!pdev)
> +		return -ENODEV;

Ick, that's a _very_ old-school way of binding to a pci device.  Please
just be a "real" pci driver and your probe function will be called if
your hardware is present (or when it shows up.)  To do it this way
prevents your driver from being auto-loaded for when your hardware is
seen in the system, as well as lots of other things.

> +
> +	if (!zalloc_cpumask_var(&ne_cpu_pool.avail, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	mutex_init(&ne_cpu_pool.mutex);
> +
> +	rc = pci_register_driver(&ne_pci_driver);

Nice, you did it right here, but why the above crazy test?

> +	if (rc < 0) {
> +		dev_err(&pdev->dev,
> +			"Error in pci register driver [rc=%d]\n", rc);
> +
> +		goto free_cpumask;
> +	}
> +
> +	return 0;

You leaked a reference on that pci device, didn't you?  Not good :(

thanks,

greg k-h
