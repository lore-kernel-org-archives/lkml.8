Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB12C35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7FC20842
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580030295;
	bh=nEEdcHdiaxn0c3QjTCUa7y45tZSSnjihAh7JWpFqZlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XyhVccqYXC+3kR0aHwDTeJzFnWbFTEIU0v44A6d2vPvEj3nHyy2C3H1h6Fx/dtoF4
	 4WSUlxwb4ootnojIKTyL+4w8OL40NMVSVTz8Nya2ncMxv3FahMXleZQ4hOIccGp65h
	 79lts2iikrMmzjoThs+dhv6g71IcIYvrm6rqyFLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAZJSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 04:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAZJSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 04:18:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C12D2071E;
        Sun, 26 Jan 2020 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580030293;
        bh=nEEdcHdiaxn0c3QjTCUa7y45tZSSnjihAh7JWpFqZlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ssb4+wBX0Tda3Kh9rks3ybMyRqRFbKYV3MwiefXJU6uIxpSPn3GXUmKMIrDLvmdi4
         fN2VmsdtueoC7Dg2ig5EcTiDbanv9+syKlD+b8WRUU8JJJAjBoP9CSzrJtORutcusU
         mTjLglKi0873hqnQaKdYImiAvZoeNz0XwCbUii9o=
Date:   Sun, 26 Jan 2020 10:18:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: [PATCH 4.19 014/639] leds: tlc591xx: update the maximum
 brightness
Message-ID: <20200126091811.GB3549630@kroah.com>
References: <20200124093047.008739095@linuxfoundation.org>
 <20200124093048.912391801@linuxfoundation.org>
 <20200124231826.GA14064@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124231826.GA14064@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 12:18:26AM +0100, Pavel Machek wrote:
> On Fri 2020-01-24 10:23:04, Greg Kroah-Hartman wrote:
> > From: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > 
> > commit a2cafdfd8cf5ad8adda6c0ce44a59f46431edf02 upstream.
> > 
> > The TLC chips actually offer 257 levels:
> > - 0: led OFF
> > - 1-255: Led dimmed is using a PWM. The duty cycle range from 0.4% to 99.6%
> > - 256: led fully ON
> > 
> > Fixes: e370d010a5fe ("leds: tlc591xx: Driver for the TI 8/16 Channel i2c LED driver")
> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Its a new feature, really and quite unusual one: 257 brightness levels
> is not usual. It is theoretically safe, but...
> 
> Lets not do that for -stable.
> 
> (I'm a LED maintainer).

Ok, now dropped from 4.19 and older, thanks!

greg k-h
