Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA69322B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596475269;
	bh=jGN7xhLfLhvidfL47wcuIKF2cDWQoBJ68JRX9J/3CaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uPpsgTLpfaUkl+eqfvd68Q0P+CIoo/BFXSGl8opmPUYJvr0wPKQhy8ygLzVDMjyks
	 oOeX3v5XuQ77NXQhopMW26n8wrydgspQ9anx52sMGpyP6svIEfaUBGg52zR2azujgJ
	 YDfLVRkRRHPiXGBYanj1rttYANOTq8dkJPq2vjWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgHCRVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgHCRVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:21:06 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71D220792;
        Mon,  3 Aug 2020 17:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596475265;
        bh=jGN7xhLfLhvidfL47wcuIKF2cDWQoBJ68JRX9J/3CaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cjkusXf5uipTXfA/Efb96S/p2wf7pAsFsMItD6wYfAAJJmSLoo4cdCHrAU079Wjh
         y6qiyjYKGGuZdAabq3/coHxCq+UPL0UySp+aNGwuH02cS7DDuOoUrkabk/N+2y4N4U
         rD3yvkQGYDWnYz+xkdRbbW15H/1NHVF8dRFlM5/k=
Date:   Mon, 3 Aug 2020 10:21:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     syzbot <syzbot+24ebd650e20bd263ca01@syzkaller.appspotmail.com>,
        davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in hci_le_meta_evt
Message-ID: <20200803172104.GA1644292@gmail.com>
References: <000000000000a876b805abfa77e0@google.com>
 <20200803171232.GR1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803171232.GR1551@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 06:12:33PM +0100, Russell King - ARM Linux admin wrote:
> Dear syzbot,
> 
> Please explain why you are spamming me with all these reports - four so
> far.  I don't understand why you think I should be doing anything with
> these.
> 
> Thanks.

syzbot just uses get_maintainer.pl.

$ ./scripts/get_maintainer.pl net/bluetooth/hci_event.c
Marcel Holtmann <marcel@holtmann.org> (maintainer:BLUETOOTH SUBSYSTEM)
Johan Hedberg <johan.hedberg@gmail.com> (maintainer:BLUETOOTH SUBSYSTEM)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT)
linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)
