Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B6C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595286320;
	bh=ZxVOav+5rxeh+TMvje4gJyGp/T2f05FWzE/7cbRi1zY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J0tjHOhGoRtwNfJULMmUnZCTujGJHZkGYwtrk/xn/Vby5zJF6udpg9enIRI0m4deq
	 KwB7WhzKmGoWtPLXSB3F+Soeuz0EknYPCcgRShj5kGz6NPzF3iCPL8x/tpcsc9DiIG
	 p8ytSd26PsB5TyU/dcea5Z/Lz9b+VBk0BOvSugLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGTXFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgGTXFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:05:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53879208E4;
        Mon, 20 Jul 2020 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595286317;
        bh=ZxVOav+5rxeh+TMvje4gJyGp/T2f05FWzE/7cbRi1zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XBJ6RkoElE3gr9sVzKY2zeU00Y4VBrwEiLxb9H9p92f+PYRi6lqXvqaq7KX0/Knbv
         JIX9qoB7WxgmnP5jXAV/CF0grgLQ/9vnrJ1edrqp7v6JTbQUuyxR5r0ixL7qY2s6HZ
         ae4LCzmKxPDSP9jSSe5VXYmHKp+e7xC4f/QubmO0=
Date:   Mon, 20 Jul 2020 16:05:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Shik Chen <shik@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] scripts/decode_stacktrace: strip all base path prefixes
Message-Id: <20200720160516.9e53d2c3cc4c68fb4a6d2dd4@linux-foundation.org>
In-Reply-To: <20200720074429.29359-1-jslaby@suse.cz>
References: <20200720074429.29359-1-jslaby@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 09:44:29 +0200 Jiri Slaby <jslaby@suse.cz> wrote:

> When addr2line returns more than one location, decode_stacktrace does
> not currently remove base path from the paths. So the result might look
> like (line wrapped here):
>  ptrace_stop (include/linux/freezer.h:57
>  /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../include/linux/freezer.h:67
>  /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../include/linux/freezer.h:128
>  /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../include/linux/freezer.h:173
>  /home/abuild/rpmbuild/BUILD/kernel-default-5.8.rc5/linux-5.8-rc5/linux-obj/../kernel/signal.c:2217)
> 
> Make sure all the lines are processed, so the result now looks like
> (line wrapped here again):
>  ptrace_stop (include/linux/freezer.h:57 include/linux/freezer.h:67
>  include/linux/freezer.h:128 include/linux/freezer.h:173
>  kernel/signal.c:2217)

hm, I just merged
http://lkml.kernel.org/r/20200720082709.252805-1-pihsun@chromium.org. 
Which is preferable?

> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -140,14 +140,15 @@ parse_symbol() {
>  		return
>  	fi
>  
> -	# Strip out the base of the path
> -	code=${code#$basepath/}
> -
> -	# In the case of inlines, move everything to same line
> -	code=${code//$'\n'/' '}
> +	declare -a output
> +	while read LINE; do
> +		# Strip out the base of the path
> +		LINE=${LINE#$basepath/}
> +		output+=("$LINE")
> +	done <<< $code
>  
>  	# Replace old address with pretty line numbers
> -	symbol="$segment$name ($code)"
> +	symbol="$segment$name (${output[@]})"
>  }
>  
>  decode_code() {
> -- 
> 2.27.0
