Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A0C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BCD20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vaHSEXrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgIEW7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgIEW7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:59:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F28C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=f90W80hQ28lIF5OQ4LUv4gqljn8+jRHIdXfT/P9SWyM=; b=vaHSEXrZK8H8xnghEX5aEzm7p1
        fqLru59ckPuc0uj107yJFuUwB+OMRhXGVgNvdtQa7vu9ihiAju1yHHU6CiCLIy46q4HX+StxYlQcj
        b3kqIiFHRwIJqwLIFRoUX6QbpRLCHIuDJq/q0EwV5j6dr47XsZTHlfIuh4cdOfRAK/KZViWP/3ctC
        CaXPbUCfxum5rpSHg5dpunzlJeNN9m3UrQCQushmCrijARs5c/Re7MBDBsQrEBfhakNetHrwCJnVH
        KzyvFtuvck8OBWdHd7EFaO9L6JWZZigN4ADjX79R1dI7giQt8T7OIdOzOBtrCdzCzAHJCH4NeWv+J
        6ZkY/1MQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEh9I-0002Ad-0O; Sat, 05 Sep 2020 22:59:08 +0000
Subject: Re: [RFC PATCH 2/2] x86/cmdline: Use strscpy to initialize
 boot_command_line
To:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        kasan-dev@googlegroups.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
 <20200905222323.1408968-3-nivedita@alum.mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5a29e70-7d11-16ec-8d72-ed71da4124c1@infradead.org>
Date:   Sat, 5 Sep 2020 15:59:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200905222323.1408968-3-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/20 3:23 PM, Arvind Sankar wrote:
> The x86 boot protocol requires the kernel command line to be a
> NUL-terminated string of length at most COMMAND_LINE_SIZE (including the
> terminating NUL). In case the bootloader messed up and the command line
> is too long (hence not NUL-terminated), use strscpy to copy the command
> line into boot_command_line. This ensures that boot_command_line is
> NUL-terminated, and it also avoids accessing beyond the actual end of
> the command line if it was properly NUL-terminated.
> 
> Note that setup_arch() will already force command_line to be
> NUL-terminated by using strlcpy(), as well as boot_command_line if a
> builtin command line is configured. If boot_command_line was not
> initially NUL-terminated, the strlen() inside of strlcpy()/strlcat()
> will run beyond boot_command_line, but this is almost certainly
> harmless in practice.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Hi,
Just for my enlightenment, what would be wrong with:

(which is done in arch/m68/kernel/setup_no.c)

> ---
>  arch/x86/kernel/head64.c  |  2 +-
>  arch/x86/kernel/head_32.S | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index cbb71c1b574f..740dd05b9462 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -410,7 +410,7 @@ static void __init copy_bootdata(char *real_mode_data)
>  	cmd_line_ptr = get_cmd_line_ptr();
>  	if (cmd_line_ptr) {
>  		command_line = __va(cmd_line_ptr);
> 		memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
> +		boot_command_line[COMMAND_LINE_SIZE - 1] = 0;
>  	}
>  
>  	/*


thanks.
-- 
~Randy

