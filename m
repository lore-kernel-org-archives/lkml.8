Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F52CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F55620740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589358828;
	bh=nB/55BO079UYamFpCt8YrKpVHQPJ94TfWCsRp/2eHes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z18+BdX7DUHf1ryZiyn3/5P9HFDa5GOFa0ZVTDFZWSTVRzJnMLBt9nban9GmfIGmc
	 893oFLrTY1z30mmEb406hp7RFQzGy0ajtewmFvhhcD02DEAE5KNiSDtrrR+sNntSoz
	 2LRpfW6kglTDGlyIHJ8AFpyeE9atiAn/IF/FHgxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgEMIdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbgEMIdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:33:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3F920740;
        Wed, 13 May 2020 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589358826;
        bh=nB/55BO079UYamFpCt8YrKpVHQPJ94TfWCsRp/2eHes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Onup83Bm/AReOo/jn4w37LzyOPNt+O6Pi4mx/8WRVPBGgpV8J+qw7wECUDaIsWIei
         eKjzA/ZtGCLeycc60TbuUWxTHoDSkRZypTwk6qUDCnncEkqAMD1hBqracK7JZPZjU3
         t0cf2VETjGQNgkYPYq3LuadD27ruwnhZb/eus8HI=
Date:   Wed, 13 May 2020 10:33:43 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Ravich, Leonid" <Leonid.Ravich@dell.com>
Cc:     "Idgar, Or" <Or.Idgar@dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: CMA enhancement - non-default areas in x86
Message-ID: <20200513083343.GA772573@kroah.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
 <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513071413.GB766804@kroah.com>
 <DM6PR19MB26827EFC4DDC6CB9DD5C52D098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB26827EFC4DDC6CB9DD5C52D098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, May 13, 2020 at 08:29:16AM +0000, Ravich, Leonid wrote:
> PCIe NTB 
> Documentation/driver-api/ntb.rst

> 1) Basically PCI bridge between to root complex / PCI switches 
> 2) using out of OS memory is one solution but then this memory is
> Limited for usage by other stack, ex: get_user_pages on this memory will fail, 
> Therefore attempting to use it for block layer with (o_direct) will fail. 
>  
> Acutely any generic stack which attempts to "pin" this memory will fail.

So why isn't the BIOS/UEFI properly reserving this from the general
operating system's pages so that the driver knows to use them instead?

Is UEFI wrong here about these being valid memory ranges for general
use?  If so, why not fix that?  If not, how in the world is the OS
supposed to know these memory ranges are _not_ for general use?  I feel
like there is something missing here...

thanks,

greg k-h
