Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D54C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321B320774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597320384;
	bh=st+ZZPEZNLMRcB4dWVw2s7KfAWhEwQAt4jahZwwVrZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1UlBuTYsG/OBZ9GANrKbLRhigOZX40BfVzzxK9uznWMW2AwDeZB6mK9CEeqbtsrns
	 us8TsgkqUIGaE42j8WHXjM2t2KYXEq4+sQdlwtupUe7lQIW7phlQFc5gjemuxS8G8k
	 MNch1H2SH2Dajq0v/cWfeSziTl+yZGt54vn1SCk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHMMGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgHMMF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:05:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B452120866;
        Thu, 13 Aug 2020 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597319237;
        bh=st+ZZPEZNLMRcB4dWVw2s7KfAWhEwQAt4jahZwwVrZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CP/ObbMctMPM3r9rVqSbqkqy4LHRQVBbqKV1BxOr9spCYysSMcmVJrxLzyjkFNWvA
         P/ccRpJBmfKeZuLE+Wwle5uIOAZrPcmzMeigqVgnTh3ZUtJ8ocVgr8mIWRbhwW7Wkc
         Py30Ty4Z3yBW1lvJJZ2VKdfgUdPyPCEP+ioOchtc=
Date:   Thu, 13 Aug 2020 13:47:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Message-ID: <20200813114726.GA3852402@kroah.com>
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAFmMkTE+2Qxo43bZkwCszEYbXFV22YdpLJD40gB6LgvnPbvdSA@mail.gmail.com>
 <20200813090105.GC3452881@kroah.com>
 <CAFmMkTFgjW+9gNfx=2SU7B0foww=SLiiyVi+P-hZpEFDbMTf2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFmMkTFgjW+9gNfx=2SU7B0foww=SLiiyVi+P-hZpEFDbMTf2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 08:42:57AM -0300, Daniel Gutson wrote:
> El jue., 13 ago. 2020 6:00 a. m., Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> escribió:
> 
> > On Wed, Aug 12, 2020 at 12:41:35PM -0300, Daniel Gutson wrote:
> > > ping
> >
> > What does that mean here?
> >
> 
> I didn't get an answer from Arnd Bergman who expressed concerns. I want to
> know if my answer was enough or there are more potential changes I have to
> do.

No need to wait for anyone, it's not our job to always respond :)

Take what you feel is correct, fix up your patch along those lines, and
resubmit, that's all you can do.

good luck!

greg k-h
