Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A8020814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591696132;
	bh=wyLG6SBNai/VvAbjCDP9k/44SpoSnEoGVYCYicCYJXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9bcumXQcCNKe6cgBiYiAw/eYN5FcvPVPse29SOPVO+6niyrUzIVu33QWAKxtHY0P
	 KG2+CMUIp10vc8KQBQc3ID0A8owHQMGfxnHFGCUg6g1XYuHYXCIGlhsq70Vf3TiKsr
	 epjUgxgJKIP59klnR7ZdVdZhYMRHg61Lb7q8Hq0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgFIJsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgFIJsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:48:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E4120812;
        Tue,  9 Jun 2020 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591696130;
        bh=wyLG6SBNai/VvAbjCDP9k/44SpoSnEoGVYCYicCYJXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jd3H8v0uUoduq8dz3cwRXSoNOuUxCbWE6CTb/pOfLSHUalPyPNlT+lndlq5BB0W0Z
         YkmXtMRRhPeYsbz4vT08HoH/rMqG1jPBPJubfQW2UcV/r2u3i1PHG+YbPvX3O2YVSS
         I6Gb0RDf5gK6Y/kyek70Rzd5Xq75zqdU9HzaHFvM=
Date:   Tue, 9 Jun 2020 11:48:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHVz?= =?utf-8?Q?b=3A_gadget?=
 =?utf-8?Q?=3A?= function: printer: fix use-after-free in __lock_acquire
Message-ID: <20200609094848.GA533476@kroah.com>
References: <20200608071622.33081-1-qiang.zhang@windriver.com>
 <20200608073305.GA252221@kroah.com>
 <DM5PR11MB2058F82DF00D26338119BF0FFF820@DM5PR11MB2058.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB2058F82DF00D26338119BF0FFF820@DM5PR11MB2058.namprd11.prod.outlook.com>
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

On Tue, Jun 09, 2020 at 09:35:11AM +0000, Zhang, Qiang wrote:
> Thank you for your suggestion
> two referenced counted objects in the same exact structure. another  referenced is
> "dev->printer_cdev_open"?

Maybe, I don't know, but a cdev does have a reference count already,
right?  Why do you need printer_cdev_open as well?

thanks,

greg k-h
