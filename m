Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A27C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8C42084E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581854792;
	bh=lj7ZTxv/npbHV4KVzblAHdNDotXt560iH11Zbuy9Z6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pj/F2LwJ9hhGbmw7rdwYZoOGnMwcn5Dmefuiem22oG7mnL44mvuGkIrrXDzj7JD3q
	 51+whRcuNx+i30I0jArQrjoFyXUhkrHCr1mqJKhiNE+ICXm0XHf1EyOqho8F/nmLc0
	 4FhNP5ZdRUdVC1caTtBJrxJYKqQUQ5MVp4kvxroE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgBPMDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 07:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgBPMDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 07:03:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B5820857;
        Sun, 16 Feb 2020 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581854620;
        bh=lj7ZTxv/npbHV4KVzblAHdNDotXt560iH11Zbuy9Z6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LZ1FDdnM30i3Q5YKwt/DoUotiLpQaPAn2jIh/wtCEGKRsI+i4MG1glYufqsMHguLV
         5mICwHAGUqtCowcCr6QIteAoFz6KYn/0DtTinanK9TvPYCwLcuRwo0s8+aDTkaRrmP
         7XMeV84cBiYzggNpRDNOE5lxDgf1nUE74PnMUNRQ=
Date:   Sun, 16 Feb 2020 21:03:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org,
        rostedt@goodmis.org, keescook@chromium.org, rppt@linux.ibm.com,
        linux@dominikbrodowski.net, nivedita@alum.mit.edu,
        nadav.amit@gmail.com, glider@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c: mark boot_config_checksum static
Message-Id: <20200216210333.b5e911feafb3acfae4a1b89b@kernel.org>
In-Reply-To: <1581852511-14163-1-git-send-email-hqjagain@gmail.com>
References: <1581852511-14163-1-git-send-email-hqjagain@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2020 19:28:31 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> In fact, this function is only used in this file, so mark it with 'static'.

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index f95b014..534589f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -335,7 +335,7 @@ static char * __init xbc_make_cmdline(const char *key)
>  	return new_cmdline;
>  }
>  
> -u32 boot_config_checksum(unsigned char *p, u32 size)
> +static u32 boot_config_checksum(unsigned char *p, u32 size)
>  {
>  	u32 ret = 0;
>  
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
