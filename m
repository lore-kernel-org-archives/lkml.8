Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59BDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F81F214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580506935;
	bh=C17MI6rx4oXMJKcGmdqHqYU8ry9fA6NGeOV3I5Bann0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jw1H0k8HV+fsVCTO/O0wslMZTEz0joqJ+B9DogkIdEoc98dVGJDysv6ZCvjceXJNV
	 DnlXfMh4+PpQEMrPEJJHIWGczRWe8JYzBJqi9gDgKv2GPDmWplSblz4mi0NKIZkBXq
	 ZuB7DHH82EbruXtB5gwAcQVIrv8YBQuxQHCIlcWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAaVmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgAaVmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:42:14 -0500
Received: from localhost (unknown [83.216.75.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA7420707;
        Fri, 31 Jan 2020 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580506933;
        bh=C17MI6rx4oXMJKcGmdqHqYU8ry9fA6NGeOV3I5Bann0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmVNHpXI9SnOfNYrVXDKT0MZ9IAGFFTAm9rdeypN3aQDIApgkwqQrCVFF5xFnzlfc
         2MRY8smR65sd8LaUuwmOUqT94J1sDz2Cq8AaPsMnYdbT3nXTd8GZkCZzH68iVQAN9M
         tguTUcUuyUe+nedHcDFx9xx2lxscfYcG/9+Ui8NE=
Date:   Fri, 31 Jan 2020 22:42:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
Message-ID: <20200131214211.GB2280058@kroah.com>
References: <cover.1579007786.git.andreyknvl@google.com>
 <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <87ftfv7nf0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftfv7nf0.fsf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 03:42:11PM +0200, Felipe Balbi wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> 
> V2 only

Nope, this is ok, see the kernel license documentation, that means the
same thing.

> > +MODULE_LICENSE("GPL");
> 
> v2+. Care to fix?

What?  No, read module.h, this is fine.

thanks,

greg "I talk to too many license lawyers" k-h
