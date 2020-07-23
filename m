Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F42C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2F22063A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGWUZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:25:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:42466 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgGWUZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:25:18 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 481C72BA;
        Thu, 23 Jul 2020 20:25:18 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:25:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     jens.wiklander@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] docs: staging/tee.rst: convert into definition list
Message-ID: <20200723142517.4a6e17c5@lwn.net>
In-Reply-To: <20200718165107.625847-4-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-4-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 13:50:58 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

>  TEE bus infrastructure registers following APIs:
> --  match(): iterates over the client driver UUID table to find a corresponding
> -   match for device UUID. If a match is found, then this particular device is
> -   probed via corresponding probe API registered by the client driver. This
> -   process happens whenever a device or a client driver is registered with TEE
> -   bus.
> --  uevent(): notifies user-space (udev) whenever a new device is registered on
> -   TEE bus for auto-loading of modularized client drivers.
> +
> +match():
> +  iterates over the client driver UUID table to find a corresponding
> +  match for device UUID. If a match is found, then this particular device is
> +  probed via corresponding probe API registered by the client driver. This
> +  process happens whenever a device or a client driver is registered with TEE
> +  bus.
> +
> +uevent():
> +  notifies user-space (udev) whenever a new device is registered on
> +  TEE bus for auto-loading of modularized client drivers.

Just FWIW, this could have been fixed by adding a blank line between the
two bulleted entries.  This fix is fine too, though, applied, thanks.

jon
