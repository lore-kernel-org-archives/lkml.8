Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98ADC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D042145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599469028;
	bh=s01xbXbPNyv6rH591FQyqxsjCLQuQdhxzdNarQUjX+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zfdX42RFK9OYKSICgFokqNN0S1qonzHpQMRqkI1zX30lSFolygWXXVusuPjL4mho2
	 GKh0Jt5Vvm1r3VW2duP6fULvdWG2gtvn+VoRB0Ioi6o4ddC+m2lGCnlKAv7RFmhOUk
	 r8gdwNMcZ2g/FSCl9Ox5QwtCScFXuvcjfMcsTZ3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgIGI5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgIGI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:57:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB84C2078E;
        Mon,  7 Sep 2020 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599469026;
        bh=s01xbXbPNyv6rH591FQyqxsjCLQuQdhxzdNarQUjX+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDULc1x/uM0s7sxF1i423l0Eoq/YhsmyY6nV346Ugbsnu+E5blMdXDbVQjnM7StLm
         rYQhdQO82XC5jyGcM6XHhui2KpmcARsaxmOy2fsnQpqYyM8JOVygp81yDYcXyF7/tB
         NlPEPFdkQ0YzPDN83Uc41hG21IpjUHkIdzYSIDuc=
Date:   Mon, 7 Sep 2020 10:57:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        David Duncan <davdunc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>, Karen Noel <knoel@redhat.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm <kvm@vger.kernel.org>,
        ne-devel-upstream <ne-devel-upstream@amazon.com>
Subject: Re: [PATCH v8 08/18] nitro_enclaves: Add logic for creating an
 enclave VM
Message-ID: <20200907085721.GA1101646@kroah.com>
References: <20200904173718.64857-1-andraprs@amazon.com>
 <20200904173718.64857-9-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904173718.64857-9-andraprs@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:37:08PM +0300, Andra Paraschiv wrote:
> +static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case NE_CREATE_VM: {
> +		int enclave_fd = -1;
> +		struct file *enclave_file = NULL;
> +		struct ne_pci_dev *ne_pci_dev = NULL;
> +		struct pci_dev *pdev = to_pci_dev(ne_misc_dev.parent);

That call is really "risky".  You "know" that the misc device's parent
is a specific PCI device, that just happens to be your pci device,
right?

But why not just have your misc device hold the pointer to the structure
you really want, so you don't have to mess with the device tree in any
way, and you always "know" you have the correct pointer?  It should save
you this two-step lookup all the time, right?

thanks,

greg k-h
