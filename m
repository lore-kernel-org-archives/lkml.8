Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1BEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BF020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583750051;
	bh=ao64/qUT1rpGZ/rmL662JsOeZdZMwEP42kkAUncoX0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0SvoG07vzHmK25qF9bGnEaQES9O3ytQmggJ+V+bh77EDNXiW4+VOnWZKw2lrE7YiE
	 TBBJPt8P4zrM1r5mWL/3aBJZEiDeyXQ5uDLJQRMpveML2sfi4XKz0m2EwGTYfWMNtK
	 fXw8vXp/+r0dDX+G+Tg+yAQHVc4Gn+scIg7s18+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCIKeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgCIKeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:34:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CE120409;
        Mon,  9 Mar 2020 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583750049;
        bh=ao64/qUT1rpGZ/rmL662JsOeZdZMwEP42kkAUncoX0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTRL1IoAkzN1gScTp8yMTqKZx82AUvLN2Y2SHs3VFVdDIpyTmjRE6PRegArzgn4n4
         FrOtd+gx+7+T2I2wRcSGYNfjkI8MFGx3kaNG/3p7QrpEqST/f77qisnzelynJ4T6LI
         TfHRdPcxB2PIPAfrAhTfNPcpa3aMmKN86bzscuCI=
Date:   Mon, 9 Mar 2020 11:34:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200309103407.GB180589@kroah.com>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
 <20200301122514.GA1461917@kroah.com>
 <20200301131701.GA7487@ubuntu>
 <20200301150913.GA1470815@kroah.com>
 <20200307082906.GA2948@ubuntu>
 <20200309093210.GA7693@qd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309093210.GA7693@qd-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 09:32:10AM +0000, Quentin Deslandes wrote:
> On Sat, Mar 07, 2020 at 09:29:06AM +0100, Oscar Carter wrote:
> > On Sun, Mar 01, 2020 at 04:09:13PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Mar 01, 2020 at 02:17:01PM +0100, Oscar Carter wrote:
> > > This is a USB driver, performance is always limited to the hardware, not
> > > the CPU location of variables.
> > 
> > Thank you for the explanation.
> > 
> > >
> > > Please always benchmark things to see if it actually makes sense to make
> > > changes like this, before proposing them.
> > 
> > I'm sorry.
> > 
> 
> I've been removed from CC list on Greg's answer, so I haven't seen the
> explanation earlier and reviewed the patch the next day. I should have
> know better, won't happen again.

You weren't on the original list of people on the patch, so I didn't
remove anything here that I can tell.

thanks,

greg k-h
