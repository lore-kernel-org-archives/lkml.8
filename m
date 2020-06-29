Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9D7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0862063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qJAG6HdH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/Dnl0lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgF2SmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:42:13 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56949 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgF2SmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 34EB0B40;
        Mon, 29 Jun 2020 02:23:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 29 Jun 2020 02:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=62elEdlP6x2ddcxnJcAEZnSvZ9H
        SDNzcszxZZAT5pX4=; b=qJAG6HdHGWfCTzYDdMelv5U2v6p5Kcn4/vgR8L5/Yq6
        4qAXeCitm6wCl5ThMVa4CCT3RKMIxa7O76xkLKesiLGvyaaGJgxhHqbNcrvxlRj6
        KLDVakdV8H7OJWFdR/nRTk1O8MwYWsNhV+GBtmzDnAn+qcJuC6LYEnf5CWFZ9WTj
        py6z6h0CaOp1wYUOUAO7nXJ9poJziWmUKRMpXo9tBGQ7nTTIBEf16dTWRxaE9+zM
        eTLUluJq53Q5reaOnzK2Tuq9LTAIQlU82CCiGw67fDdWKzrCek11L0YoSUHzJY3o
        CQQe7eMSN+Jhh47NDkVhdCg5f7U9/mS2CLSueGiZoNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=62elEd
        lP6x2ddcxnJcAEZnSvZ9HSDNzcszxZZAT5pX4=; b=s/Dnl0lEXb6qTuQBzdKkhN
        +SpNL8nuLs6ePUuNnpcgngK3KIM5dQVkOQg79k1BjzTfe1/TPQstYMoqc03WxX0A
        DLqJHikNS5o0xBkFJuoTTCr0HzOtcauTWXYbqQsLUQafmBNereP8ruQeWiKgAqxX
        ilEg5JoJmM4n0Q4/Huty+J/9lCCLKxxTmkrMatwG3yTtUk4hjI3+WNr9AmM6nZch
        afNg2v8ARGLOFuh9oCY/TDT/9AkpodyrlDfdeT3IjeSBECLI0ssNXIrpYwcXj0Aq
        NVkqXws5hBSx8/TAMRkJ+FWDQiATvsq3DGC4lxJrGFhuvpAjwelLozWlxknVVUow
        ==
X-ME-Sender: <xms:8Ij5XgqS8VjhlYXoagASF8q1oM12XCVA90BptRe5Urj0NWA_JbGNNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeljedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:8Ij5XmpGPn0hdLuQ9mmeGGVhmCGBFyFhYNUFwlaWma8oitWFcQ7PFw>
    <xmx:8Ij5XlOP3xP4NRVNB3K315rHsG-ECyNagkqTiGycebKepFlK5MuJug>
    <xmx:8Ij5Xn4EXLDqTxzfwPuTHxx_1AG-3LmIw0Lk-ZOeCl_Yjx1B8fykwA>
    <xmx:8Ij5XsgjItYgHuMOcCRTBo2Cbn40xwk_HBsRBwZ0yZR5O_3Byo3abw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 048683067C47;
        Mon, 29 Jun 2020 02:23:43 -0400 (EDT)
Date:   Mon, 29 Jun 2020 08:23:33 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20200629062333.GA223877@kroah.com>
References: <20200626132910.73031f1f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626132910.73031f1f@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:29:10PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/cdns3/ep0.c
> 
> between commit:
> 
>   c0e2a0341cd8 ("usb: cdns3: ep0: fix the test mode set incorrectly")
> 
> from the usb.current tree and commit:
> 
>   62fb45d317c5 ("USB: ch9: add "USB_" prefix in front of TEST defines")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/usb/cdns3/ep0.c
> index 61ec5bb2b0ca,04a522f5ae58..000000000000
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@@ -327,12 -327,11 +327,12 @@@ static int cdns3_ep0_feature_handle_dev
>   		if (!set || (tmode & 0xff) != 0)
>   			return -EINVAL;
>   
>  -		switch (tmode >> 8) {
>  +		tmode >>= 8;
>  +		switch (tmode) {
> - 		case TEST_J:
> - 		case TEST_K:
> - 		case TEST_SE0_NAK:
> - 		case TEST_PACKET:
> + 		case USB_TEST_J:
> + 		case USB_TEST_K:
> + 		case USB_TEST_SE0_NAK:
> + 		case USB_TEST_PACKET:
>   			cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
>   					       USB_CMD_STMODE |
>   					       USB_STS_TMODE_SEL(tmode - 1));

This is now resolved in my tree, thanks!

greg k-h
