Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAAF215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583303954;
	bh=etnCL/zRmgdNa1IlpbE+pMZF9X1/uAAONZvLvu7gdrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zXGfsy8DhEN6B5A6emKljgLX1/oFUE3tZroBd/Ur5UWb8sBY82t60zz7k7m1rWF2U
	 GCNsIUOhzS85LLc4G4jwwi92S+iAMkoC2w2ULEVhZ3fFcUJkQ0k57eM7wd6nXSwSi/
	 XhVFSUWDvRfzvYl8jA5Uga+Lq6YAgwootObuApBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgCDGjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgCDGjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:39:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A1F2146E;
        Wed,  4 Mar 2020 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583303952;
        bh=etnCL/zRmgdNa1IlpbE+pMZF9X1/uAAONZvLvu7gdrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2M1E6ifaNigQT7OE5HcfBwvDJ3Vh2xHEfSHu/Al1V19B7BCfZkCxOu2jfepo+0Mj
         kP3vO+d1h5d+cOtbR6H/IGCvy2Fl0QBBxwkZtYxBu65ieu3koYmCjYZ0Uj0TsTwzlr
         YmGKNmQixmbjpvLfhcz3tU3DgdtxeizsxALNEChE=
Date:   Wed, 4 Mar 2020 07:39:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     YunQiang Su <wzssyqa@gmail.com>
Cc:     devel@driverdev.osuosl.org, Paul Burton <paulburton@kernel.org>,
        linux@roeck-us.net, linux-mips <linux-mips@vger.kernel.org>,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ralf Baechle <ralf@linux-mips.org>, dan.carpenter@oracle.com
Subject: Re: [PATCH 0/6] Re-instate octeon staging drivers
Message-ID: <20200304063910.GA1203555@kroah.com>
References: <20200205001116.14096-1-chris.packham@alliedtelesis.co.nz>
 <20200212215200.GA2367959@kroah.com>
 <CAKcpw6VczRuMC_KRzP6VRPeZPtmEpVOJE5Fc+JhDH4mWU7jUVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKcpw6VczRuMC_KRzP6VRPeZPtmEpVOJE5Fc+JhDH4mWU7jUVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:48:46AM +0800, YunQiang Su wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2020年2月13日周四 上午5:52写道：
> >
> > On Wed, Feb 05, 2020 at 01:11:10PM +1300, Chris Packham wrote:
> > > This series re-instates the octeon drivers that were recently removed and
> > > addresses the build issues that lead to that decision.
> > >
> > > I've approached Cavium/Marvell about taking a more active interest in getting
> > > the code out of staging and into their proper location. No reply on that (yet).
> >
> > Good luck with talking to the companies, hopefully that will work.
> >
> > Anyway, I've applied this series, thanks for this, let's see what breaks
> > now :)
> 
> Did you meet any problem to merge Chris's patchset?

They are all in linux-next, so you can see for yourself :)

greg k-h
