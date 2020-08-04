Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5212076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596528842;
	bh=DpS29X/mtixAIjU9aeJH8I1HAvoHLfOugZsToDvZTeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enhRc0yv5Wkr0b8qgyNji+41VWt4qy0q04R+vL0znph3X8tgoNLCsyQ6MjQQa+fml
	 J1a2d5O6O89VSCYOc9weNlIlcET0PIA/pbXOYfXwxPU0sWo8cHEtHTLpqtnBSDBqE9
	 /zqsDO2TN/sj4ycWVjytoTgCOOP7US+xmICmRTIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHDIOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgHDIOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:14:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3B32076C;
        Tue,  4 Aug 2020 08:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596528840;
        bh=DpS29X/mtixAIjU9aeJH8I1HAvoHLfOugZsToDvZTeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvVlkDksXWLKOFTVfjN+qexQq1DTHwJN6EubfgGWG/auXrANvEoSZSjyFWZFGjCbR
         29zozlINCqdUEDKK7mDM0zYArSGz1fDfRwrbuG93/7w6qIc+zN648ss8ZNOMywd1b0
         xQgJZp4CnFzZuD8wdEjDyscOAu58gKr/igLT/NXg=
Date:   Tue, 4 Aug 2020 10:13:36 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
 on Intel NUC boxes
Message-ID: <20200804081336.GA1766718@kroah.com>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:08:10AM +0000, 吳昊澄 Ricky wrote:
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, August 04, 2020 3:49 PM
> > To: 吳昊澄 Ricky
> > Cc: Chris Clayton; LKML; rdunlap@infradead.org; philquadra@gmail.com; Arnd
> > Bergmann
> > Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
> > Intel NUC boxes
> > 
> > On Tue, Aug 04, 2020 at 02:44:41AM +0000, 吳昊澄 Ricky wrote:
> > > Hi Chris,
> > >
> > > rtsx_pci_write_register(pcr, FPDTL, OC_POWER_DOWN, OC_POWER_DOWN);
> > > This register operation saved power under 1mA, so if do not care the 1mA
> > power we can have a patch to remove it, make compatible with NUC6
> > > We tested others our card reader that remove it, we did not see any side effect
> > >
> > > Hi Greg k-h,
> > >
> > > Do you have any comments?
> > 
> > comments on what?  I don't know what you are responding to here, sorry.
> > 
> Can we have a patch to kernel for NUC6? It may cause more power(1mA)
> but it will have more compatibility

I do not understand at all, sorry.

greg k-h
