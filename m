Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18D5C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9027F214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BaYtENHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCDEzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 23:55:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCDEzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=zZ95sC6ESS0QhN0JHJfKIym5VQhesm719+mrTV98NRM=; b=BaYtENHVlBBx+P3jxQAqYnjr5l
        /pKrseDRTciCjk8MPBktRWz6Hx8MxyTGHj+nM5EuobxbVCDrd5LdpaBfcSfS9Q1kUCQYcc4qVVij3
        glDdUwUsy2ogwR3JSYP2c9k0KO5e5BEV80kMYuzVtb6zwLIGILTHzcWhPy0Y8dn8lTvV+WXxJiK5Q
        A2MBxdBSrdXZ7WTw6AkBGs2yNz/fhzYr8IfDOoA/XMFIjrvj1ENCGbZbutGlnO+VrjsSRVXuVvWAS
        mmSMPL8045gTsMIJPoXX66j3uYTxzVoMwNSfrui4BjJ2a2rELo+bOaSpsoaduuAIgUKu2MrRc2IMu
        WS2hmHIg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9M4J-00062P-ND; Wed, 04 Mar 2020 04:55:39 +0000
Subject: Re: [PATCH v4] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
 <158322635301.31847.15011454479023637649.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
Date:   Tue, 3 Mar 2020 20:55:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158322635301.31847.15011454479023637649.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,  :)

On 3/3/20 1:05 AM, Masami Hiramatsu wrote:
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
> Changes in v4:
>  - Remove O= option from examples.
> Changes in v3:
>  - Specify that comments also count in size.
>  - Fix a confusing sentence.
>  - Add O=<builddir> to make command.
> Changes in v2:
>  - Fixes additional typos (Thanks Markus and Randy!)
>  - Change a section title to "Tree Structured Key".
> ---
>  Documentation/admin-guide/bootconfig.rst |  181 +++++++++++++++++++-----------
>  Documentation/trace/boottime-trace.rst   |    2 
>  2 files changed, 117 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index cf2edcd09183..b719b257b579 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -11,19 +11,99 @@ Boot Configuration
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
> +scalability (up to 32 KiB configuration data including comments), readability
> +(structured configuration with comments) and compact expression of option
> +groups.
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
> +Also, some features may depend on the boot configuration, and it has own

                                                             and each such
feature has its own root key.

> +root key. For example, ftrace boot-time tracer uses "ftrace" root key to
> +describe its options [2]_. If you want to use such features, you need to
> +enable the boot configuration.
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

              boot loader or the kernel image itself.

> +
> +To do this operation, Linux kernel provides "bootconfig" command under

                                      provides the "bootconfig" command under

> +tools/bootconfig, which allows admin to apply or delete the configuration
> +file to/from initrd image. You can build it by the following command::

        to/from an initrd image.

> +
> + # make -C tools/bootconfig
> +
> +To add your boot configuration file to initrd image, run bootconfig as below

                                       to an initrd image,

> +(Old data is removed automatically if exists)::

                                      if it exists)::

> +
> + # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
>  
> -The boot config syntax is a simple structured key-value. Each key consists
> -of dot-connected-words, and key and value are connected by ``=``. The value
> -has to be terminated by semi-colon (``;``) or newline (``\n``).
> +To remove the configuration from the image, you can use -d option as below::

                                               you can use the -d option as below::

> +
> + # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
> +
> +At last, add ``bootconfig`` on the normal kernel command line to tell the
> +kernel to look for the bootconfig at the end of the initrd file. For example::
> +
> +  GRUB_CMDLINE_LINUX="bootconfig"
> +
> +
> +Boot Configuration Syntax
> +=========================
> +
> +The boot configuration syntax is a simple structured key-value. Each key
> +consists of dot-connected-words, and key and value are connected by ``=``.
> +The value has to be terminated by semi-colon (``;``) or newline (``\n``).
>  For array value, array entries are separated by comma (``,``). ::

             values,
or just
   For an array, its entries are separated by


>  
> -KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
>  
>  Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
>  
> @@ -39,11 +119,11 @@ you can not escape these quotes.
>  There can be a key which doesn't have value or has an empty value. Those keys
>  are used for checking if the key exists or not (like a boolean).
>  
> -Key-Value Syntax
> -----------------
> +Tree Structured Key
> +-------------------
>  
> -The boot config file syntax allows user to merge partially same word keys
> -by brace. For example::
> +The boot configuration syntax allows user to merge same parent key using

                                 allows the user
although I am having problems with the rest of that sentence.

> +braces as tree structured key. For example::
>  
>   foo.bar.baz = value1
>   foo.bar.qux.quux = value2
> @@ -80,19 +160,17 @@ you can use ``+=`` operator. For example::
>  In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
>  
>  However, a sub-key and a value can not co-exist under a parent key.
> -For example, following config is NOT allowed.::
> +For example, following configuration is NOT allowed.::

       example, the following

>  
>   foo = value1
> - foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
> + foo.bar = value2 # !ERROR! sub-key "bar" and value "value1" can NOT co-exist
>  
>  
>  Comments
>  --------
>  
> -The config syntax accepts shell-script style comments. The comments starting
> -with hash ("#") until newline ("\n") will be ignored.
> -
> -::
> +The boot configuration accepts shell-script style comments. The comments
> +starting with hash (``#``) until newline (``\n``), will be skipped.::

no comma.  or 2 commas:

                                                               The comments,
beginning with hash (``#``) and continuing until newline (``\n``), will be skipped.::

>  
>   # comment line
>   foo = value # value is set to foo.
> @@ -100,74 +178,45 @@ with hash ("#") until newline ("\n") will be ignored.
>         2, # 2nd element
>         3  # 3rd element
>  
> -This is parsed as below::
> +This is parsed as below.::
>  
>   foo = value
>   bar = 1, 2, 3
>  
>  Note that you can not put a comment between value and delimiter(``,`` or
> -``;``). This means following config has a syntax error ::
> +``;``). This means following description has a syntax error. ::

           This means the following

>  
> - key = 1 # comment
> + key = 1 # !ERROR! comment is not allowed before delimiter
>         ,2
>  
>  
>  /proc/bootconfig
>  ================
>  

[snip]

>  Config File Limitation
>  ======================
>  
> -Currently the maximum config size size is 32KB and the total key-words (not
> -key-value entries) must be under 1024 nodes.
> -Note: this is not the number of entries but nodes, an entry must consume
> -more than 2 nodes (a key-word and a value). So theoretically, it will be
> -up to 512 key-value pairs. If keys contains 3 words in average, it can
> -contain 256 key-value pairs. In most cases, the number of config items
> -will be under 100 entries and smaller than 8KB, so it would be enough.
> +Currently the maximum configuration file size (including comments) is 32 KiB
> +and the total number of key-words and values must be under 1024 nodes.
> +(Note: Each key consists of words separated by dot, and value also consists
> +of values separated by comma. Here, each word and each value is generally
> +called a "node".)

[blank line would be nice here]

> +Theoretically, it will be up to 512 key-value pairs. If keys contains 3
> +words in average, it can contain 256 key-value pairs. In most cases,
> +the number of configuration items will be under 100 entries and smaller
> +than 8 KiB, so it would be enough.
>  If the node number exceeds 1024, parser returns an error even if the file

                                    the parser

> -size is smaller than 32KB.
> -Anyway, since bootconfig command verifies it when appending a boot config
> -to initrd image, user can notice it before boot.
> +size is smaller than 32 KiB.
> +Anyway, since bootconfig command verifies it when appending a boot

           since the bootconfig command

> +configuration to initrd image, user need to fix it before boot.

                 to an initrd image, the user needs to fix any errors before boot.


-- 
~Randy

