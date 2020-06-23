Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60208206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFWGcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:32:23 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:58798 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730645AbgFWGcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:32:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9B796180A7FDA;
        Tue, 23 Jun 2020 06:32:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gold31_1f13a3726e39
X-Filterd-Recvd-Size: 1435
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 06:32:20 +0000 (UTC)
Message-ID: <b7636799383bfb85c59d27e140a3c0e56d4af87d.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: use my kernel.org address
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 23:32:19 -0700
In-Reply-To: <20200623061138.14694-1-jslaby@suse.cz>
References: <20200623061138.14694-1-jslaby@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 08:11 +0200, Jiri Slaby wrote:
> There were enough problems with suse.{com,cz} MTAs recently. I am bored
> by restoring lost e-mails from public archives. Let's switch (all) my
> MAINTAINERS addresses to @kernel.org and forward it there as I wish.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -2881,7 +2881,7 @@ S:	Supported
>  F:	drivers/net/wireless/ath/*
>  
>  ATHEROS ATH5K WIRELESS DRIVER
> -M:	Jiri Slaby <jirislaby@gmail.com>
> +M:	Jiri Slaby <jirislaby@kernel.org>
[]
>  TTY LAYER
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> -M:	Jiri Slaby <jslaby@suse.com>
> +M:	Jiri Slaby <jirislaby@kernel.org>

Add .mailmap entries as well?


