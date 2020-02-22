Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_RHS_DOB,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E30C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B320707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBVSSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:18:06 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:44742 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:18:06 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j5ZLl-0006OE-Ua; Sat, 22 Feb 2020 18:18:02 +0000
Received: from [151.251.251.9] (helo=[192.168.14.3])
        by jain.kot-begemot.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j5ZLj-0005tN-3P; Sat, 22 Feb 2020 18:18:01 +0000
Subject: Re: [PATCH] Documentation: update UserModeLinux-HOWTO.txt
To:     Manbing <manbing3@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-um@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1582391968-3960-1-git-send-email-manbing3@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys Limited
Message-ID: <9e8a47ca-bc82-496c-dc32-a5cde0d26fe9@cambridgegreys.com>
Date:   Sat, 22 Feb 2020 18:17:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1582391968-3960-1-git-send-email-manbing3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2020 17:19, Manbing wrote:
> Original content is obsolete. Which is based on kernel 2.4.0-prerelease.
> Updating content according to kernel 5.5.1.
> 
> Signed-off-by: Manbing <manbing3@gmail.com>
> ---
>   Documentation/virt/uml/UserModeLinux-HOWTO.txt | 42 +++++---------------------
>   1 file changed, 8 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/virt/uml/UserModeLinux-HOWTO.txt b/Documentation/virt/uml/UserModeLinux-HOWTO.txt
> index 87b80f5..08ee28d 100644
> --- a/Documentation/virt/uml/UserModeLinux-HOWTO.txt
> +++ b/Documentation/virt/uml/UserModeLinux-HOWTO.txt
> @@ -1,6 +1,6 @@
>     User Mode Linux HOWTO
>     User Mode Linux Core Team
> -  Mon Nov 18 14:16:16 EST 2002
> +  Mon Feb 10 08:27:24 EST 2020
>   
>     This document describes the use and abuse of Jeff Dike's User Mode
>     Linux: a port of the Linux kernel as a normal Intel Linux process.
> @@ -215,26 +215,17 @@
>   
>   
>     Compiling the user mode kernel is just like compiling any other
> -  kernel.  Let's go through the steps, using 2.4.0-prerelease (current
> +  kernel.  Let's go through the steps, using 5.5.1 (current
>     as of this writing) as an example:
>   
>   
> -  1. Download the latest UML patch from
> -
> -     the download page <http://user-mode-linux.sourceforge.net/
> -
> -     In this example, the file is uml-patch-2.4.0-prerelease.bz2.
> -
> -
> -  2. Download the matching kernel from your favourite kernel mirror,
> +  1. Download the matching kernel from your favourite kernel mirror,
>        such as:
>   
> -     ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2
> -     <ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2>
> -     .
> +     wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.1.tar.xz
>   
>   
> -  3. Make a directory and unpack the kernel into it.
> +  2. Make a directory and unpack the kernel into it.
>   
>   
>   
> @@ -255,31 +246,14 @@
>   
>   
>          host%
> -       tar -xzvf linux-2.4.0-prerelease.tar.bz2
> -
> -
> -
> -
> -
> -
> -  4. Apply the patch using
> -
> -
> -
> -       host%
> -       cd ~/uml/linux
> -
> -
> -
> -       host%
> -       bzcat uml-patch-2.4.0-prerelease.bz2 | patch -p1
> +       tar xvf linux-5.5.1.tar.xz
>   
>   
>   
>   
>   
>   
> -  5. Run your favorite config; `make xconfig ARCH=um' is the most
> +  3. Run your favorite config; `make xconfig ARCH=um' is the most
>        convenient.  `make config ARCH=um' and 'make menuconfig ARCH=um'
>        will work as well.  The defaults will give you a useful kernel.  If
>        you want to change something, go ahead, it probably won't hurt
> @@ -293,7 +267,7 @@
>   
>   
>   
> -  6. Finish with `make linux ARCH=um': the result is a file called
> +  4. Finish with `make linux ARCH=um': the result is a file called
>        `linux' in the top directory of your source tree.
>   
>     Make sure that you don't build this kernel in /usr/src/linux.  On some
> 

I am rewriting the whole thing at the moment.

I will publish the finished sections for review at some point during the 
coming week.

It needs to be rewritten from scratch, fixing a few things like this is 
not enough.

Brgds,

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
