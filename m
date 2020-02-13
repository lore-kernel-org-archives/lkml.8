Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB34C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD81217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBMSmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:42:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:46966 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:42:24 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F245B740;
        Thu, 13 Feb 2020 18:42:23 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:42:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: userspace: ioctl-number: remove mc146818rtc
 conflict
Message-ID: <20200213114222.220060b3@lwn.net>
In-Reply-To: <20200209203304.66004-1-alexandre.belloni@bootlin.com>
References: <20200209203304.66004-1-alexandre.belloni@bootlin.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Feb 2020 21:33:04 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> In 2.3.43pre2, the RTC ioctls definitions were actually moved from
> linux/mc146818rtc.h to linux/rtc.h
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 2e91370dc159..f759edafd938 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -266,7 +266,6 @@ Code  Seq#    Include File                                           Comments
>  'o'   01-A1  `linux/dvb/*.h`                                         DVB
>  'p'   00-0F  linux/phantom.h                                         conflict! (OpenHaptics needs this)
>  'p'   00-1F  linux/rtc.h                                             conflict!
> -'p'   00-3F  linux/mc146818rtc.h                                     conflict!
>  'p'   40-7F  linux/nvram.h
>  'p'   80-9F  linux/ppdev.h                                           user-space parport
>                                                                       <mailto:tim@cyberelk.net>

Applied, thanks.

jon
