Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE16C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889D72186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592469497;
	bh=3ocF7+GLmpDVpQX16fWYL1OE2jm4wEz2XdAmLhpY/2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wmda3Bu1pfn0dz/KQ2CqzvlHlyzXzgFZyGD8Zi8H0vwUIUDknjstaDpt1yV26ZwqB
	 jak6UN6ocEgqCec/eOuhjtRNGTbOvkC4C3ncaxdE3uvsXRlbflxrcep+ddnA6ARgMo
	 lsF2ZTWWVBcdPVhS0sX3lUuyCA/+ZHvf4QBd0Z1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgFRIiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgFRIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:38:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23565214DB;
        Thu, 18 Jun 2020 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592469493;
        bh=3ocF7+GLmpDVpQX16fWYL1OE2jm4wEz2XdAmLhpY/2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4f8agUjMMdUM6uamE0KPoPanCJ6nphtBKROJE7lr/Ql+YsN1xglvJeaDPvGrJQiX
         66+MJHgRoutyhpcj4WFRjkEyw3/OWHGICQ4HAJwCvFoEy5cg0h/AmoQP0d6zHN8Szx
         N0HBzF24IguKA3dfyq3zD9sMj9F1hvr4AzDdV12U=
Date:   Thu, 18 Jun 2020 10:38:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register optional charger
Message-ID: <20200618083806.GA1073084@kroah.com>
References: <20200413122543.73846-1-paul@crapouillou.net>
 <9KB7BQ.BH9P6TT11PEH2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9KB7BQ.BH9P6TT11PEH2@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 05:12:09PM +0200, Paul Cercueil wrote:
> Hi,
> 
> Any feedback on this patch?

Seems to have fell through the cracks.  Please rebase and resend,
thanks.

greg k-h
