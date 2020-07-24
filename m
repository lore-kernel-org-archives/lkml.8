Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E6DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD2A2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595633142;
	bh=5bB1/Mh3Ub21Y60uMLotb8RHeDsZbyyS5UwIgT6fSEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TJLxWxwqn4eOxaPAieJnDMXFa58i/EtR6c3KIO8ckcZDjsCJPpBC+hfFZstYt2756
	 qXN0u/ieSerpsIi6K2oYvgY11uK3/c6FOFUT4mm+r3dBqwKuQOC86FtDNDkYuBckRV
	 wqz0KriOIWZ1bHLZHLblbe/ZWG2BxKG+M7+O8+hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXXZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgGXXZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:25:40 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC5A206EB;
        Fri, 24 Jul 2020 23:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595633140;
        bh=5bB1/Mh3Ub21Y60uMLotb8RHeDsZbyyS5UwIgT6fSEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPPs5sEE0LcqRw+8gt+42AOZPaUloFrluGDlfwP2FhjokrsOGHKTARUlbLqEy/wiu
         lzpaEV1f6DIPdHGQrtNFO7+Yan560WdEupvgPdpouc0sqoWBDb69ujUJL780aDYV6p
         AQQaOJ4kYU4wtp7SJifrQuub3Tfhcm/ixsRoF1vU=
Date:   Fri, 24 Jul 2020 16:25:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <20200724162539.13cd9efa48d50368f63d7b5a@linux-foundation.org>
In-Reply-To: <20200724194423.GJ6949@brightrain.aerifal.cx>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
        <20200722023840.GA55317@roeck-us.net>
        <20200722225239.GX14669@brightrain.aerifal.cx>
        <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
        <20200724194423.GJ6949@brightrain.aerifal.cx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 15:44:23 -0400 Rich Felker <dalias@libc.org> wrote:

> Andrew, could you drop your copy of this
> patch? 

I have done so, thanks.
