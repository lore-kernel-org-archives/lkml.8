Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A77C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:02:31 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:53332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726241AbgHXUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:02:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 801F0180A9F52;
        Mon, 24 Aug 2020 20:02:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: front11_580342427055
X-Filterd-Recvd-Size: 1408
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 20:02:27 +0000 (UTC)
Message-ID: <e69a12f09a9550320ca9d9ae65a892722bde96fd.camel@perches.com>
Subject: Re: [likely PATCH] media: lmedm04: Fix misuse of comma
From:   Joe Perches <joe@perches.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Date:   Mon, 24 Aug 2020 13:02:26 -0700
In-Reply-To: <d4b13e5d-6c97-2594-0ca6-346bb2129b88@gmail.com>
References: <e6cd92faf09722fe729a7de03e7bde592f62499c.camel@perches.com>
         <d4b13e5d-6c97-2594-0ca6-346bb2129b88@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 21:01 +0100, Malcolm Priestley wrote:
> Good catch the interrupt URB is not running because usb_submit_urb is tangled with it.
> 
> It only really affects signal strength.
> 
> add
> 
> Fixes: 15e1ce33182d ("[media] lmedm04: Fix usb_submit_urb BOGUS urb xfer, pipe 1 != type 3 in interrupt urb")
> Cc: <stable@vger.kernel.org>

If that's a request for me, I won't as I can't test.

As the maintainer, you should do that.


