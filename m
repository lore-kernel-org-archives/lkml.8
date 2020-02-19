Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F11C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24085208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582097834;
	bh=B/ZA3VaaY86Ch+VeIeHZ1KK6etb24wKrAlye/s2lurk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U2DwbvW/gNXihjyR1kfyrY5u7YT323q1DccgbMDbfX3JleOLTQ67SqheRHgBi6lw5
	 /Fe5sfFHRrHqRuJpJHtYlRMkLIb6Zngqk6YUj0b9SCqHlPY06bYjQS0pJKNlxEK9Qv
	 tVV0J0OHT9oLua9iaXK1Fyj05gGzOl7ODs3Onm9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSHhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgBSHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:37:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FF1208E4;
        Wed, 19 Feb 2020 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582097831;
        bh=B/ZA3VaaY86Ch+VeIeHZ1KK6etb24wKrAlye/s2lurk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwraLWEhEJcUQKdiHq4N4NvZDDo4Ytp4HIKJkfYBRo0xDchl0kD6hgQfT0Pon2dPW
         zfKxTSe/xFvetiWvcJDSbZwqMfsoucH1ml1HD8KW6GjfucpQEevTFbwnCEFNaxoOIw
         cj7bnst12LSPm868uPMC/vJcVUAMiDdmdXzbVkmo=
Date:   Wed, 19 Feb 2020 08:37:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20200219073709.GB2728338@kroah.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
 <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:20:42AM +0100, Vitor Soares wrote:
> +config I3CDEV
> +	tristate "I3C device interface"
> +	depends on I3C
> +	help
> +	  Say Y here to use i3c-* device files, usually found in the /dev
> +	  directory on your system.  They make it possible to have user-space
> +	  programs use the I3C devices.
> +
> +	  This support is also available as a module.  If so, the module
> +	  will be called i3cdev.
> +
> +	  Note that this application programming interface is EXPERIMENTAL
> +	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.

Hah, no, we don't get to say stuff like that.  It's hard to write good
apis, but once this is merged, we need to support what is there, right?

kernel programming is hard :(

