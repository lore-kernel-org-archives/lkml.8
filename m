Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63086C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FB20715
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589859858;
	bh=S5y0IyDpVW3EYw//xQGmNpU37sUGpiHPq5/R1PtuFK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=x5ArLz6JxB50GG34kZYo/f06zEFXU+ISZ1gvxMOvgW529ibj+69Kv9xyLNT9PdKaF
	 qOUWXVqpDP46yfokwQkKOV1voD1wtVgVrsbEommfbSxo7E5CkCPBCXlrpAB36+PXsb
	 TRve5uyXyjCtoBeR30RtdQazOo4kHc1Pk9auraLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgESDoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgESDoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:44:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF5420708;
        Tue, 19 May 2020 03:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589859856;
        bh=S5y0IyDpVW3EYw//xQGmNpU37sUGpiHPq5/R1PtuFK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x9MFc7RfaziLEN4aadMIoei7QP+yH3Yci+wyG0G7HnkNkA0/hyEOyl+dRKe349/Lx
         D+tjsXx+k9zzzcPjApD7XRkXc2rvE5xUXG1iLXo/Ja09HC1IUkkefbftirsgtjdk0r
         R+/E6hoWtWAwdgh8d4g9xelTS+hqe+qmfB26J+c0=
Date:   Mon, 18 May 2020 20:44:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?546L56iL5Yia?= <wangchenggang@vivo.com>
Cc:     "'Masami Hiramatsu'" <mhiramat@kernel.org>,
        "'Steven Rostedt \(VMware'" <rostedt@goodmis.org>,
        "'Kees Cook'" <keescook@chromium.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Dominik Brodowski'" <linux@dominikbrodowski.net>,
        "'Arvind Sankar'" <nivedita@alum.mit.edu>,
        "'Mike Rapoport'" <rppt@linux.ibm.com>,
        "'Alexander Potapenko'" <glider@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel@vivo.com>
Subject: Re: [PATCH] init/main.c: Print all command line when boot
Message-Id: <20200518204415.d1a3adaba597ce5b232b4b2a@linux-foundation.org>
In-Reply-To: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
References: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 11:29:46 +0800 王程刚 <wangchenggang@vivo.com> wrote:

> Function pr_notice print max length maybe less than the command line length,
> need more times to print all.
> For example, arm64 has 2048 bytes command line length, but printk maximum
> length is only 1024 bytes.

I can see why that might be a problem!

> --- a/init/main.c
> +++ b/init/main.c
> @@ -825,6 +825,16 @@ void __init __weak arch_call_rest_init(void)
>  	rest_init();
>  }
>  
> +static void __init print_cmdline(void)
> +{
> +	const char *prefix = "Kernel command line: ";

const char prefix[] = "...";

might generate slightly more efficient code.

> +	int len = -strlen(prefix);

hm, tricky.  What the heck does printk() actually return to the caller?
Seems that we forgot to document this, and there are so many different
paths which a printk call can take internally that I'm not confident
that they all got it right!

> +	len += pr_notice("%s%s\n", prefix, boot_command_line);
> +	while (boot_command_line[len])
> +		len += pr_notice("%s\n", &boot_command_line[len]);
> +}

Did you really intend to insert a \n into the output every 1024'th
character?

And what effect does this additional \n have upon the code logic? 
Doesn't this cause the printk() return value to be one greater than
expected each time it is called?

>
> ...
>
