Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E57E224D1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594738742;
	bh=WTDH37LSxb4tW3N4uDpNpX6+nBm9o23/Nk/fecgHtQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Lxn7zNWm8cSUql6iDKjmwdu4pqkosnzJYie7Z6/nFL511SvB1ANtjU4GJ+kjUUJiD
	 ja+kViHfUP8nQup9IoNU0H+LAXUhKBMhM8o//9jdiff5a7dY1S1jUiFu4RhrhwS9uY
	 AVIkK8Ya3GPJEL1BoV5kFzTcZS6H2ATW2kOl58Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGNO7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNO7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:59:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CED822473;
        Tue, 14 Jul 2020 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594738739;
        bh=WTDH37LSxb4tW3N4uDpNpX6+nBm9o23/Nk/fecgHtQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d1ZJLlUvkttBJjAiyFzSlC/Ulr1sEl+WefHnOv+PRHp9M8VxFclPVlraBpvnT3iMk
         kRPE8Wb7XT46BbOooroS7n2JwCuNFJ3A4j66zsWQEz6MUCOb5l/KyhDJ1TPvGG5uZz
         xxpg+X3omKnGMfhTFRpc9HFw8uPMq5hajw8Cp9zw=
Date:   Tue, 14 Jul 2020 23:58:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "glider@google.com" <glider@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] bootconfig: Make symbol 'xbc_namebuf' static
Message-Id: <20200714235854.e93f1365ca84613887306f62@kernel.org>
In-Reply-To: <20200714142504.34803-1-weiyongjun1@huawei.com>
References: <20200714142504.34803-1-weiyongjun1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 22:25:04 +0800
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fix sparse build warning:
> 
> init/main.c:305:6: warning:
>  symbol 'xbc_namebuf' was not declared. Should it be static?

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 9127b240fd26..6a24981c727f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -302,7 +302,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
>  
>  #ifdef CONFIG_BOOT_CONFIG
>  
> -char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> +static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
>  
>  #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
