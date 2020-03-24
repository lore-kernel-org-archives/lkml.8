Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DEAR_SOMETHING,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F17AC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D157320870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585047968;
	bh=2LvE4EYXx6S7St3XOfLekrr0TlyAbuI62HGedV7PVfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jBeF4ywFDPb0kJ0iQ5T5ZlC7x2RsPK0jk8POq1N49i2RL9MeaWnyIAIeLxvpcXRFY
	 307DfiYOkiFVh2vZgH97RMkhdgnuiO1tGuSJHgTjieDxT8+iNFFg3V6ff0vP3X0+sJ
	 SPsUPgf0R9LJ3CcyED+fqMU0/aFKd2qnAEvQqyls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCXLGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgCXLGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A02F20786;
        Tue, 24 Mar 2020 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585047967;
        bh=2LvE4EYXx6S7St3XOfLekrr0TlyAbuI62HGedV7PVfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BMhjKYnTWQPLqClRhwzeajd6cZLTTFORXjkcvfQmEmIVUg7JPlcZsMrANTFof7NHd
         wlWlxdOGa8LS/D11JaFVyXerSDI6CgWlFZtnDC2IKK2L+gWLquXQla4/5eWmsPKoTQ
         WgB2JPDT362mDWfTZOs1hyoYL2NDudE1kUbt6Hoo=
Date:   Tue, 24 Mar 2020 12:06:04 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        cernekee <cernekee@gmail.com>, balbi <balbi@kernel.org>,
        "f.fainelli" <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] usb: gadget: bcm63xx_udc:remove useless variable
 definition
Message-ID: <20200324110604.GA2225782@kroah.com>
References: <20200324062932.8364-1-tangbin@cmss.chinamobile.com>
 <5f67315d-18c1-e444-03e7-a79a21d48b02@cogentembedded.com>
 <202003241719218101862@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003241719218101862@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:19:22PM +0800, 唐彬 wrote:
> Dear Sir：
>         I'm glad for you replay。Yes。I think the variable assignment here can be deleted。

Great, can you please fix up your patch to say that?

thanks,

greg k-h
