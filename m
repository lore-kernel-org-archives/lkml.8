Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D07C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA832469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJ5yBLp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgB1EuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:50:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1EuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=s+QeEHYSNi44+hIO/8Apj4mw7x3KWr0g5BcyFCnqi+s=; b=aJ5yBLp8XFs2+ptHMnR8pdSRrR
        D9z0gqDLHni+NJct/om5lD6wRQzjxCNtIoXut7UDYgtIUDIBpllTDUzXlMcLBrNB05af4mS/q4HSD
        cIvsgLOu2yNKeJmW2xe1UWdHzgyXUQzYMlEj3DTtOCGVpU40Ik2B7FVUFfRa1S4HC2Q1BJUrIi+4S
        rIxADQT5/NEVz8HQZZ2kNP/QzikKuWSaGM2rsMLRw2Uxx7lNw/FkiBvs8R+eF5DE768hB8hzzBH/H
        tj6xB4BLACEK2NFHiohlqmyhhmAuxDr/1VgYkr1j/ryX3dKf/CTt4DHYINv3CP31X/x3i/zaQNu+Z
        qhy/jcMA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7XbQ-0007eT-EV; Fri, 28 Feb 2020 04:50:20 +0000
Subject: Re: [PATCH 1/2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
 <158278835238.14966.16157216423901327777.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c8494bca-a5f7-0bc6-63f5-b9ec056eb894@infradead.org>
Date:   Thu, 27 Feb 2020 20:50:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158278835238.14966.16157216423901327777.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A few more comments for you:

On 2/26/20 11:25 PM, Masami Hiramatsu wrote:
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
>  Documentation/admin-guide/bootconfig.rst |  172 +++++++++++++++++++-----------
>  Documentation/trace/boottime-trace.rst   |    2 
>  2 files changed, 112 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index cf2edcd09183..4bac98250bc0 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -11,19 +11,98 @@ Boot Configuration
>  Overview
>  ========
>  
> -The boot configuration expands the current kernel command line to support
> +Boot configuration expands the current kernel command line to support
>  additional key-value data when booting the kernel in an efficient way.

                maybe      s/when/while/

> -This allows administrators to pass a structured-Key config file.
> +This allows administrators to pass a structured-Key configuration file
> +as a way to supplement the kernel command line to pass system boot parameters.
>  
> -Config File Syntax
> -==================
> +Compared with the kernel command line, the boot configuration can provide
> +scalability (up to 32 KiB configurations), readability (structured

This makes it sound like bootconfig supports 32 thousand configurations, but
(I think) it allows up to 32 KiB of configuration data.

> +configuration with comments) and compact expression of option groups.
> +
> +When to Use the Boot Configuration?
> +-----------------------------------
> +
> +The boot configuration supports kernel command line options and init daemon
> +boot options. All sub-keys under "kernel" root key are passed as a part of
> +kernel command line [1]_, and one under "init" root key are passed as a part

                                 ones  {or those}

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
> +configuration file or want to comment on each options, you can use this

                                         on each option,

> +boot configuration. If unsure, you can still continue to use the legacy
> +kernel command line.
> +
> +Also, some subsystem may depend on the boot configuration, and it has own
> +root key. For example, ftrace boot-time tracer uses "ftrace" root key to
> +describe their options [2]_. In this case, you need to use the boot

            its

> +configuration.
> +
> +.. [1] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
> +.. [2] See :ref:`Documentation/trace/boottime-trace.rst <boottimetrace>`


-- 
~Randy

