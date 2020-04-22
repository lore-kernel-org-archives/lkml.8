Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D95C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DAF20738
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJdTLMo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgDVHLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:11:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbgDVHLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587539473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+t4qriF4LAISoIYo0LzOgKybIeKJK2PEbk6hqnZTPw8=;
        b=NJdTLMo3+Fdf9Q7S+DHffgNMNmqh/JolTQb8JK5469MA9Qnu2HEo7/sOQ8EkLrpw7ZsACx
        tovO8ghqMJuJCBNhcV8NjD8xecgjtO92Fg8wwbaJcBVBNIJNU1kvaQ5nyHmihBEsgWmWcQ
        vab+IpRkMUTa8jJvA1Ek/GQvmRoTWTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-iUd4OEIsPYyEpLJUbET4Qw-1; Wed, 22 Apr 2020 03:11:08 -0400
X-MC-Unique: iUd4OEIsPYyEpLJUbET4Qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 020C5DB64;
        Wed, 22 Apr 2020 07:11:07 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27813B3A76;
        Wed, 22 Apr 2020 07:11:02 +0000 (UTC)
Date:   Wed, 22 Apr 2020 15:11:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tony Fischetti <tony.fischetti@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, dave.hansen@linux.intel.com,
        linux@roeck-us.net, keescook@chromium.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/setup: Add boot messages about cmdline builtins
Message-ID: <20200422071100.GS4247@MiWiFi-R3L-srv>
References: <20200422042007.4836-1-tony.fischetti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422042007.4836-1-tony.fischetti@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22/20 at 12:20am, Tony Fischetti wrote:
> While the ability to override or append to the boot command line has
> been added, the boot messages contain no information as to whether the
> cmdline was manipulated by the build-time options. This patch, for x86,
> adds boot messages specifying whether the cmdline was manipulated and
> waits for the potential changes to take place before printing the final
> boot command line.
> 
> Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
> ---
>  arch/x86/kernel/setup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 4b3fa6cd3106..28d77f01fd0d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -828,7 +828,6 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	__flush_tlb_all();
>  #else
> -	printk(KERN_INFO "Command line: %s\n", boot_command_line);
>  	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
>  #endif
>  
> @@ -904,10 +903,12 @@ void __init setup_arch(char **cmdline_p)
>  
>  #ifdef CONFIG_CMDLINE_BOOL
>  #ifdef CONFIG_CMDLINE_OVERRIDE
> +	pr_info("Overriding command line with builtin\n");
>  	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>  #else
>  	if (builtin_cmdline[0]) {
>  		/* append boot loader cmdline to builtin */
> +		pr_info("Appending command line to builtin\n");
>  		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
>  		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> @@ -916,6 +917,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  
>  	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> +	pr_info("Command line: %s\n", command_line);

Yeah, adding info to tell there's action on overriding or apending
command line looks good to me. Maybe keep the printing of the original
command, we can get the final command line from '/proc/cmdline' after
system boot, or just get it from the original cmdline + CONFIG_CMDLINE.
Or print the original cmdline and the final cmdline both.

Personal opinion.

>  	*cmdline_p = command_line;
>  
>  	/*
> -- 
> 2.20.1
> 

