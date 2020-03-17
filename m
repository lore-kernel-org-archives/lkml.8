Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B8C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E120724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584450922;
	bh=B4e1Q1kI4RIAmKUGfbdCGsnqz+dA4ShcbdE/OxSJvHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DrWuCBMI3LyE8GUVj/BW/8JjIwtP1AF3/km5uvJ5tTSoxujlfHjAFMMnLQgQFZKW6
	 3vA7YjYzhJPfmXZFTuorjBTH66eguOs7jYxSDJV2Hy0irZpANT/zgS83j/5RGwVQBS
	 yDUDEm5GxnuxT4O7aM19Ar2tsi/paiODzvYAEoWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCQNPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgCQNPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:15:20 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C3320754;
        Tue, 17 Mar 2020 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450920;
        bh=B4e1Q1kI4RIAmKUGfbdCGsnqz+dA4ShcbdE/OxSJvHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tHvjHdpUH6UPznBLfwZhBrheswuKufoAlZL1H2FgWppUmLBpva37eTQMozHBJW/F8
         qM7YLt1/gfF18yaaoLegobHvQptFw18Tpi7HnppkVs2nyN1Fu/7te72ux7TnXmVkhw
         GqWyCcDZMhEcAPspSBISMfdLmdwDNPgESzGGZAI8=
Date:   Tue, 17 Mar 2020 22:15:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adriana Kobylak <anoo@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, anoo@us.ibm.com
Subject: Re: [PATCH] tools/bootconfig: Makefile: Create destination
 directory
Message-Id: <20200317221516.25d92373a0194c9237b1ee38@kernel.org>
In-Reply-To: <1584373766-3509-1-git-send-email-anoo@linux.ibm.com>
References: <1584373766-3509-1-git-send-email-anoo@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 10:49:26 -0500
Adriana Kobylak <anoo@linux.ibm.com> wrote:

> From: Adriana Kobylak <anoo@us.ibm.com>
> 
> The DESTDIR path may not be available to the caller, such as
> compiling the bootconfig tool from a Yocto native recipe. Have
> the Makefile create the directory instead.

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> ---
>  tools/bootconfig/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index a6146ac..470b6f0 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
> @@ -14,6 +14,7 @@ bootconfig: ../../lib/bootconfig.c main.c $(HEADER)
>  	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
>  
>  install: $(PROGS)
> +	install -d $(DESTDIR)$(bindir)
>  	install bootconfig $(DESTDIR)$(bindir)
>  
>  test: bootconfig
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
