Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E0C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E62A24650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgBMSiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:38:15 -0500
Received: from ms.lwn.net ([45.79.88.28]:46940 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbgBMSiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:38:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E37B72D8;
        Thu, 13 Feb 2020 18:38:14 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:38:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc:     "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: admin-guide: Add description of %c corename
 format
Message-ID: <20200213113813.356ca854@lwn.net>
In-Reply-To: <OSBPR01MB4006A82736539529EDC8EB37951C0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
References: <OSBPR01MB4006A82736539529EDC8EB37951C0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 11:01:07 +0000
"d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com> wrote:

> There is somehow no description of %c corename format specifier for
> /proc/sys/kernel/core_pattern. The %c corename format specifier is
> used by user-space application such as systemd-coredump, so it should
> be documented.
> 
> To find where %c is handled in the kernel source code, look at
> function format_corename() in fs/coredump.c.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def0748..4557907 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -213,6 +213,7 @@ core_pattern is used to specify a core dumpfile pattern name.
>         %h      hostname
>         %e      executable filename (may be shortened)
>         %E      executable path
> +       %c      maximum size of core file by resource limit RLIMIT_CORE
>         %<OTHER> both are dropped
> 
>  * If the first character of the pattern is a '|', the kernel will treat

Applied, thanks.  A couple of notes:

 - The patch was whitespace corrupted; I worked around that.
 - There is no need to resend after five days; it can take me a little
   while to catch up sometimes.

jon
