Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7098F22C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGTNiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:38:05 -0400
Received: from verein.lst.de ([213.95.11.211]:47003 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGTNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:38:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8AB5368BFE; Mon, 20 Jul 2020 15:38:00 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:38:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200720133800.GA3084@lst.de>
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de> <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de> <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:12:33AM +0200, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> I have applied Christoph's full series on top of Linus' tree and I can confirm that
> the kernel boots fine on my SH-7785LCR board.
> 
> Thus, for the whole series of patches:
> 
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Any chance we get the patches queue up while you're all sorting out
totally independent issues?
