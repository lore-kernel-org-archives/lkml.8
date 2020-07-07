Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669FFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CDD2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594114905;
	bh=RBwXDbkxkjvhcjaR8b3AzukUIIlW1vbcbUAuSiqXJA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHl/qTApeRLOrTRGm7w2yVpsbM8iYQ1bgXdpdZ7gpUUu2pfvL7dZXhx366HvfEu9Q
	 sZWjc+L56vm1bmbRma4+Ru5FrcuvJy/a0h/sdxWouu27JGNPBe+XO5PFxekLX4ajqg
	 g9y601Rbt+Wl+0qcKpnYnaP1Smc0hQ1/I0Ewx/F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGGJlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgGGJln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:41:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10A52065F;
        Tue,  7 Jul 2020 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594114902;
        bh=RBwXDbkxkjvhcjaR8b3AzukUIIlW1vbcbUAuSiqXJA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIY95owAI/ozE55P33WG/59Xos9pQNKsMXxjB+3cI0UYPuhh1F0aCjJn/1rhyvkzi
         uQGDsDfFUcfg8YZmrLeYWlLHkqBLZtgb3zhFaBbyiaxadFRr6R2DsQ9ziissCJQcd6
         FUhD6MNf/pEFTkB7NR1PhTrA0F/NIvyzWmr2VPaE=
Date:   Tue, 7 Jul 2020 11:41:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID
 IFX0102")
Message-ID: <20200707094140.GB2639362@kroah.com>
References: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:53:42PM +0300, Jarkko Sakkinen wrote:
> Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
> and tpm_infineon use the same device ID. Revert the commit and add a
> remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
> module parameter").
> 
> Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
> Reported-by: Peter Huewe <peterhuewe@gmx.de>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

As the original was asked to be applied to the stable trees, this one
should have as well.

I'll go drop it from the stable queues right now, thanks.

greg k-h
