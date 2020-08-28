Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D9920C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598602810;
	bh=jTtvgXdgXo0t3/MzOxayXmzAhJPI6E7YTJCyNfRKXZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NFar+1hTPdF9brhEbc6WpfjMp2C7txKgzPTOp9lSKUFbjnU5AGvbCZL25YBTcdQF6
	 UThnAkGgRbnTkHthcsn+7OMn91PbdbvHOnuBl7dKkJJSjjrtYeA7UZ7KaI+1PkhQk3
	 NpiuKC2DbMqD9mRvBEyHSpafiI7NlzTTMBK7m5Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgH1IUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH1IUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:20:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E34D20C56;
        Fri, 28 Aug 2020 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598602803;
        bh=jTtvgXdgXo0t3/MzOxayXmzAhJPI6E7YTJCyNfRKXZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQPJ1Diht17PhVRyodHgjYDLiIGXl6vC4HNWLdpVIqrKPv44aRpZ28FF6gNA1SoF1
         NWuahBBcoV87EAbwbklx431kD7hwqR/Aa0FI/2G1xiDey+eltETQfqWoRw10qk5VpC
         aLU+8mqECl5kiCS/GA2agjbB6JIXiYMmAS2Zr+wI=
Date:   Fri, 28 Aug 2020 10:20:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     jirislaby@kernel.org, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] tty: serial: earlycon dependency
Message-ID: <20200828082015.GA1052883@kroah.com>
References: <20200818162556.6621-1-ztong0001@gmail.com>
 <20200818185458.84418-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818185458.84418-1-ztong0001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:54:59PM -0400, Tong Zhang wrote:
> parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
> in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
> should automatically select SERIAL_CORE, otherwise will result in symbol
> not found error during linking if SERIAL_CORE is not configured as builtin
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
> 
> Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")

This should be up above your signed-off-by line.

Can you fix that up and resend?

thanks,

greg k-h
