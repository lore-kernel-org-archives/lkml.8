Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65DC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C15222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgAOVoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:44:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60462 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgAOVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:43 -0500
Received: from localhost (unknown [62.21.130.100])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE16315A0E51F;
        Wed, 15 Jan 2020 13:43:41 -0800 (PST)
Date:   Wed, 15 Jan 2020 13:43:39 -0800 (PST)
Message-Id: <20200115.134339.199447041886048873.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wan/hdlc_x25: make lapb params configurable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200114140223.22446-1-ms@dev.tdt.de>
References: <20200114140223.22446-1-ms@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Jan 2020 13:43:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 14 Jan 2020 15:02:22 +0100

> This enables you to configure mode (DTE/DCE), Modulo, Window, T1, T2, N2 via
> sethdlc (which needs to be patched as well).
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

I don't know how wise it is to add new ioctls to this old driver.

Also, none of these ioctls even have COMPAT handling so they will
never work from a 32-bit binary running on a 64-bit kernel for
example.

Also:

> +static struct x25_state* state(hdlc_device *hdlc)

It is always "type *func" never "type* func"

>  static int x25_open(struct net_device *dev)
>  {
>  	int result;
> +	hdlc_device *hdlc = dev_to_hdlc(dev);
> +	struct lapb_parms_struct params;
>  	static const struct lapb_register_struct cb = {

Please make this reverse christmas tree ordered.

> @@ -186,6 +217,9 @@ static struct hdlc_proto proto = {
>  
>  static int x25_ioctl(struct net_device *dev, struct ifreq *ifr)
>  {
> +	x25_hdlc_proto __user *x25_s = ifr->ifr_settings.ifs_ifsu.x25;
> +	const size_t size = sizeof(x25_hdlc_proto);
> +	x25_hdlc_proto new_settings;
>  	hdlc_device *hdlc = dev_to_hdlc(dev);
>  	int result;

Likewise.
