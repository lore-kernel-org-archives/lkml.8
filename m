Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D08F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="eUJFmJDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZHQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHZHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:16:15 -0400
X-Greylist: delayed 744 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Aug 2020 00:16:15 PDT
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4641::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B269C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 00:16:14 -0700 (PDT)
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 07Q73N8G024392
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Aug 2020 09:03:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1598425404; bh=JSuM4dKUM2nfywxTFJ0hWSXUwcdiL5ludU2CopjahqY=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=eUJFmJDSPFK1jgdbN2iYYyLcENd+E373WgO9hlVhHhEsORapOdeEamKR3VaMY2siS
         HyLzxCYK53OT5U+fMuRBBrChG8rEwz+Q5s3cOPgkW+esFa+ViA5bHdbZnULxuXh4aa
         hivXqjsBwKJXqBHICDBq6Bsbwk5mtmXarUugplrM=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94)
        (envelope-from <bjorn@mork.no>)
        id 1kApSt-0001tZ-4K; Wed, 26 Aug 2020 09:03:23 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <masahiroy@kernel.org>,
        <miguel@det.uvigo.gal>, <linux-usb@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: cdc_ncm: Fix build error
Organization: m
References: <20200826065231.14344-1-yuehaibing@huawei.com>
Date:   Wed, 26 Aug 2020 09:03:23 +0200
In-Reply-To: <20200826065231.14344-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 26 Aug 2020 14:52:31 +0800")
Message-ID: <87k0xl7utg.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.102.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> If USB_NET_CDC_NCM is y and USB_NET_CDCETHER is m, build fails:
>
> drivers/net/usb/cdc_ncm.o:(.rodata+0x1d8): undefined reference to `usbnet=
_cdc_update_filter'
>
> Select USB_NET_CDCETHER for USB_NET_CDC_NCM to fix this.

Ouch.  For some reason I assumed that was always selected with usbnet.
Thanks for fixing.



Bj=C3=B8rn
