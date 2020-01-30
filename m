Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E121C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46962206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgA3KXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgA3KXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:23:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EAD206D5;
        Thu, 30 Jan 2020 10:23:02 +0000 (UTC)
Date:   Thu, 30 Jan 2020 11:23:00 +0100
From:   Greg KH <greg@kroah.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] USB: serial: relax unthrottle memory barrier
Message-ID: <20200130102300.GA927405@kroah.com>
References: <20200130100658.683-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130100658.683-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:06:58AM +0100, Johan Hovold wrote:
> Commit a8d78d9f3856 ("USB: serial: clean up throttle handling")
> converted the throttle handling to use atomic bitops. This means that we
> can relax the smp_mb() in unthrottle() to smp_mb__after_atomic(), which
> for example is a no-op on architectures like x86 that provide fully
> ordered atomics.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
