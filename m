Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D6C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB46920702
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581925076;
	bh=ImZ7KOpW9bhzx35dUGgIAiEpuXpVAYDFUcemWAW+ago=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tL/kBtYnTQWfZErWhBp+hIJ3wMQxI3NuxpnT5iURCvd1sXsxRmOB9/Wlincl8OGbv
	 QDDevXHK2VgmUQCPj4LcgzOISjshZ77YfUCgyzwglgenu/9Tc+45wNfQ3B5IGxxIVd
	 jqWmAehhQ6wCFZ5t+Nq5JJwTDO+7mpOR6UJtgvSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBQHhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgBQHhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:37:54 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0079206D5;
        Mon, 17 Feb 2020 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581925074;
        bh=ImZ7KOpW9bhzx35dUGgIAiEpuXpVAYDFUcemWAW+ago=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAl5fV9ZPQ14nNwhr70prYJ1XhjxiUAqDk8UUZusYSFbS0yki1KBItzm9RhszKsXt
         I6cZ0jk2YkSY/qLbBfPaUCUxTQT/eq1U/faLOlFY/wT/SLssFxYOYxuFLLJNQfaR++
         leypCnIj+QobI8WOFRAY7M0DkCAhKLAGErI6xmjM=
Date:   Mon, 17 Feb 2020 15:37:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        kstewart@linuxfoundation.org, rfontana@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: imx: Remove unused includes on mach-imx6q.c
Message-ID: <20200217073747.GJ7973@dragon>
References: <1581660406-24463-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581660406-24463-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:06:46PM +0800, Anson Huang wrote:
> Many includes are NOT used on mach-imx6q.c now, remove them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
