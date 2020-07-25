Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B10206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGYCyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgGYCyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:54:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B512C0619D3;
        Fri, 24 Jul 2020 19:54:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 79A8F1277A0AA;
        Fri, 24 Jul 2020 19:37:57 -0700 (PDT)
Date:   Fri, 24 Jul 2020 19:54:41 -0700 (PDT)
Message-Id: <20200724.195441.1368606642401001205.davem@davemloft.net>
To:     trix@redhat.com
Cc:     kuba@kernel.org, masahiroy@kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cdc_ncm: USB_NET_CDC_NCM selects USB_NET_CDCETHER
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200723142210.21274-1-trix@redhat.com>
References: <20200723142210.21274-1-trix@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Jul 2020 19:37:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: trix@redhat.com
Date: Thu, 23 Jul 2020 07:22:10 -0700

> From: Tom Rix <trix@redhat.com>
> 
> A link error
> 
> ld: drivers/net/usb/cdc_ncm.o:
>   undefined reference to `usbnet_cdc_update_filter'
> 
> usbnet_cdc_update_filter is defined in cdc_ether.c
> Building of cdc_ether.o is controlled by USB_NET_CDCETHER
> 
> Building of cdc_ncm.o is controlled by USB_NET_CDC_NCM
> 
> So add a select USB_NET_CDCETHER to USB_NET_CDC_NCM
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Please indicate the appropriate target tree ('net' or 'net-next') in
your Subject line f.e. "[PATCH net-next] ..."

Please provide an appropriate and properly formatted Fixes: tag.

Thank you.
