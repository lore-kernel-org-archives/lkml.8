Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C46C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780AB246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582874125;
	bh=bzqcvY1+w7p+H0tBmGUux2b6d1gIUiq/keZNLNBznKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HZBAJqzR2mQiYyDeut+vpT4T0UVwP1rtLcugLVyi3uMbmernDufKJxAgtAkSpPoj2
	 Bz/M3lMhwX46lGx+LPefbIwm6DU+NSMErLZjgEFAl3jd8bO8FQU4BCMIWKZ5T2RM8E
	 iLzo2JTl6xQJfHJv77N0dazQ8XW3Kf5Ck/ZkNq4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgB1HPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgB1HPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:15:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D562469D;
        Fri, 28 Feb 2020 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582874123;
        bh=bzqcvY1+w7p+H0tBmGUux2b6d1gIUiq/keZNLNBznKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxdwK4hX9SZG6cAVJ0xxZYzqkemDxOmWY+1cEmTnG4oE4Is+PBG7kHaRUPLcqZa6I
         d6IGDzBLr4do0Wg1pJ5rCWIJV/BjZIkr2D3Cl0iJkW8GoyZG6jjyNX/oSPJsGpkcGC
         3xXHY8ZcCXVl//QBuWTZ6yQC5BG057R15eUhlo4Q=
Date:   Fri, 28 Feb 2020 08:15:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 25/27] powerpc/powernv/pmem: Expose the serial number
 in sysfs
Message-ID: <20200228071520.GA2897773@kroah.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-26-alastair@au1.ibm.com>
 <96687fbf-38ab-13ff-ca19-ccb67bbc4405@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96687fbf-38ab-13ff-ca19-ccb67bbc4405@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 05:25:31PM +1100, Andrew Donnellan wrote:
> On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> > +int ocxlpmem_sysfs_add(struct ocxlpmem *ocxlpmem)
> > +{
> > +	int i, rc;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
> > +		rc = device_create_file(&ocxlpmem->dev, &attrs[i]);
> > +		if (rc) {
> > +			for (; --i >= 0;)
> > +				device_remove_file(&ocxlpmem->dev, &attrs[i]);
> 
> I'd rather avoid weird for loop constructs if possible.
> 
> Is it actually dangerous to call device_remove_file() on an attr that hasn't
> been added? If not then I'd rather define an err: label and loop over the
> whole array there.

None of this should be used at all, just use attribute groups properly
and the driver core will handle this all for you.

device_create/remove_file should never be called by anyone anymore if at all
possible.

thanks,

greg k-h
