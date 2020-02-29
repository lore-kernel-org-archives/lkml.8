Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16F4C3F2D6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 05:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D132087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 05:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ekh6UTfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB2F7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 00:59:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2F7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 00:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ohlSJGQzr6OomkRSMJ0q0CC7j3gpUcVQAsjMXoqgXwQ=; b=Ekh6UTfWNnb6YYQ06cQVM+HiXS
        G9yRyeiIHZpWLxLqgwxhd1jSvJaGh3PR5Hvp9wRGbyW92wqNyQ1oa1XCBnrY+kbmV2omumyBDcmry
        VjfVqwHtWqcpErDyZdG8TcJudBcDu/GeWByU14bzNWvm+sgqiTs+uhv9yyg0hnzA3oAmRmAB47LCi
        t198Y7kT8KjUmET8Z4ra4C3L4Vr5lAY4kZMnmPl5SD6W7nm53+Ex8KHCN8SSH8FCoBpovS8HDIq4N
        2YFxRx/tbTTAzOVPIFvRGQiiC6Jqpa+l2AR9DOoFf9Fj2/K/XCztOC1LqoViZcwZCpWuuuVnlV+iI
        NBizwiYQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7vAB-0002cD-Pi; Sat, 29 Feb 2020 05:59:47 +0000
Subject: Re: [PATCH v2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
 <158287862131.18632.11822701514141299400.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <972ba3a8-9dd7-e043-d2f0-8fa8620686f7@infradead.org>
Date:   Fri, 28 Feb 2020 21:59:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158287862131.18632.11822701514141299400.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 12:30 AM, Masami Hiramatsu wrote:
> Update boot configuration documentation.
> 
>  - Not using "config" abbreviation but configuration or description.
>  - Rewrite descriptions of node and its maxinum number.
>  - Add a section of use cases of boot configuration.
>  - Move how to use bootconfig to earlier section.
>  - Fix some typos, indents and format mistakes.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
> Changes in v2:
>  - Fixes additional typos (Thanks Markus and Randy!)
>  - Change a section title to "Tree Structured Key".
> ---
>  Documentation/admin-guide/bootconfig.rst |  180 +++++++++++++++++++-----------
>  Documentation/trace/boottime-trace.rst   |    2 
>  2 files changed, 116 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index cf2edcd09183..6a58d5e64896 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -11,19 +11,98 @@ Boot Configuration
>  Overview
>  ========
>  
> -The boot configuration expands the current kernel command line to support
> -additional key-value data when booting the kernel in an efficient way.
> -This allows administrators to pass a structured-Key config file.
> +Boot configuration expands the current kernel command line to support
> +additional key-value data while booting the kernel in an efficient way.
> +This allows administrators to pass a structured key configuration file
> +as a way to supplement the kernel command line to pass system boot parameters.
>  
> -Config File Syntax
> -==================
> +Compared with the kernel command line, the boot configuration can provide
> +scalability (up to 32 KiB configuration data), readability (structured
> +configuration with comments) and compact expression of option groups.

Do the comments count in the 32 KiB of data?  I.e., is the max bootconfig
file size 32 KiB?

> +
> +When to Use the Boot Configuration?
> +-----------------------------------
> +
> +The boot configuration supports kernel command line options and init daemon
> +boot options. All sub-keys under "kernel" root key are passed as a part of
> +kernel command line [1]_, and ones under "init" root key are passed as a part
> +of init command line. For example, ::
> +
> +   root=UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82 ro quiet splash console=ttyS0,115200n8 console=tty0
> +
> +This can be written as following boot configuration file.::
> +
> +   kernel {
> +      root = "UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82" # nvme0n1p3
> +      ro       # mount rootfs as read only
> +      quiet    # No console log
> +      splash   # show splash image on boot screen
> +      console = "ttyS0,115200n8" # 1st console to serial device
> +      console += tty0            # add 2nd console
> +   }
> +
> +If you think that kernel/init options becomes too long to write in boot-loader
> +configuration file or you want to comment on each option, the boot
> +configuration may be suitable. If unsure, you can still continue to use the
> +legacy kernel command line.
> +
> +Also, some subsystem may depend on the boot configuration, and it has own
> +root key. For example, ftrace boot-time tracer uses "ftrace" root key to
> +describe its options [2]_. In this case, you need to use the boot
> +configuration.

Does this say that "ftrace" requires use of bootconfig?
It seems to say that.

> +
> +.. [1] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
> +.. [2] See :ref:`Documentation/trace/boottime-trace.rst <boottimetrace>`
> +
> +
> +How to Use the Boot Configuration?
> +----------------------------------
> +
> +To enable the boot configuration support on your kernel, it must be built with
> +``CONFIG_BOOT_CONFIG=y`` and ``CONFIG_BLK_DEV_INITRD=y``.
> +
> +Next, you can write a boot configuration file and attach it to initrd image.
> +
> +The boot configuration file is attached to the end of the initrd (initramfs)
> +image file with size, checksum and 12-byte magic word as below.
> +
> +[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
> +
> +The Linux kernel decodes the last part of the initrd image in memory to
> +get the boot configuration data.
> +Because of this "piggyback" method, there is no need to change or
> +update the boot loader and the kernel image itself.
> +
> +To do this operation, Linux kernel provides "bootconfig" command under
> +tools/bootconfig, which allows admin to apply or delete the configuration
> +file to/from initrd image. You can build it by the following command::
> +
> + # make -C tools/bootconfig

Please make that honor O=builddir instead of building in the kernel
source tree and ignoring O=builddir.

> +
> +To add your boot configuration file to initrd image, run bootconfig as below
> +(Old data is removed automatically if exists)::
> +
> + # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
>  
> -The boot config syntax is a simple structured key-value. Each key consists
> -of dot-connected-words, and key and value are connected by ``=``. The value
> -has to be terminated by semi-colon (``;``) or newline (``\n``).
> +To remove the configuration from the image, you can use -d option as below::
> +
> + # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
> +
> +At last, add ``bootconfig`` on the normal kernel command line to tell the
> +kernel to look for the bootconfig at the end of the initrd file. For example::
> +
> +  GRUB_CMDLINE_LINUX="bootconfig"


thanks.
-- 
~Randy

