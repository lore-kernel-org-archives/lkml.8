Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EDC38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E60921974
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588985824;
	bh=4yUVtrpxoQBIJBTheEsMFv5lta2YpekhvrR7qBnK398=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tLtiJah3zTtbvhmLPtx2JuVHZGJ95+E+yzpijEDDWIvY+pkivS7AYggcdWH9xWeC+
	 7fI8WhjLrt0SxHe1Ut5iisy6O6RRz3Py9M9tNfUPFbYcND5FaAn8WBwAyezlnJijbr
	 gEqUQhOjvO5KCRIfIlnlMGEmmCvszfajuRHHnUbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgEIA5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgEIA5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:57:03 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAFB216FD;
        Sat,  9 May 2020 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588985823;
        bh=4yUVtrpxoQBIJBTheEsMFv5lta2YpekhvrR7qBnK398=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ko9Oe0HO0up7Glh3WC/NxoguOR31RW5qkjDhgnToBwtnBNdRv31Q9uJ+9xosFNedZ
         D4zoiR6/1Lt6deZevPX6A/903dGfcn0h3OleUbPuQHugTHeDacN2gxAHASVGXcNZZ/
         KQNA8eYcWRYzQGTmxHDTHFZqcDSti+dskRHuKTW8=
Date:   Fri, 8 May 2020 17:57:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, fthain@telegraphics.com.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
Message-ID: <20200508175701.4eee970d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:
> Only macsonic has been compile tested. I don't have the needed setup to
> compile xtsonic

Well, we gotta do that before we apply the patch :S

Does the driver actually depend on some platform stuff, or can we 
do this:

diff --git a/drivers/net/ethernet/natsemi/Kconfig b/drivers/net/ethernet/natsemi/Kconfig
@@ -58,7 +58,7 @@ config NS83820
 
 config XTENSA_XT2000_SONIC
        tristate "Xtensa XT2000 onboard SONIC Ethernet support"
-       depends on XTENSA_PLATFORM_XT2000
+       depends on XTENSA_PLATFORM_XT2000 || COMPILE_TEST
        ---help---
          This is the driver for the onboard card of the Xtensa XT2000 board.
 
?
