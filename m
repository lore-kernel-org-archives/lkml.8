Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE4F214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586551097;
	bh=Jwd7+bpe1SIQcdL6R7LZyMhh+O+5rSVAOt78pIxPBDo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dhGllhSZ7dMb+W+xSDEThuQw+vKsSZNmUy2yODuJJnG6NDMQY2gFfnT9JTe19eVJc
	 ft4n7meJk4mv0ylBx0EweXD3rrZT6wWYaTaTMto1ppE5g1y+bj/1JvmEoYOMbGLG1a
	 tVcoiPYikSW1O5K+OuBLGWUklUDS7i9WeYsnhBDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJUiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgDJUiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:38:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8798B20936;
        Fri, 10 Apr 2020 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551095;
        bh=Jwd7+bpe1SIQcdL6R7LZyMhh+O+5rSVAOt78pIxPBDo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wqLWQQm3In8Q1L3xWTZ7/HFW7+etSGFgoS1VlknT1qU5kAm+E+Sl2HwrvMj6sz8dV
         AZVzX4guXnpoMnulNV7F+42QmJkCvhGix39/wh6uiRWlpX49h2WLhw2z9WU2XgIqu8
         Fjdwf+DVSjCAtOiLMKhs9QMyfjReSFw5AhJHOCMg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5D62B35226A3; Fri, 10 Apr 2020 13:38:15 -0700 (PDT)
Date:   Fri, 10 Apr 2020 13:38:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kcsan: Fix function matching in report
Message-ID: <20200410203815.GV17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200410164418.65808-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410164418.65808-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 06:44:17PM +0200, Marco Elver wrote:
> Pass string length as returned by scnprintf() to strnstr(), since
> strnstr() searches exactly len bytes in haystack, even if it contains a
> NUL-terminator before haystack+len.
> 
> Signed-off-by: Marco Elver <elver@google.com>

I queued both for testing and review, thank you, Marco!

							Thanx, Paul

> ---
>  kernel/kcsan/report.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index ddc18f1224a4..cf41d63dd0cd 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -192,11 +192,11 @@ skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
>  		 * maintainers.
>  		 */
>  		char buf[64];
> +		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
>  
> -		snprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
> -		if (!strnstr(buf, "rcu_", sizeof(buf)) &&
> -		    !strnstr(buf, "_rcu", sizeof(buf)) &&
> -		    !strnstr(buf, "_srcu", sizeof(buf)))
> +		if (!strnstr(buf, "rcu_", len) &&
> +		    !strnstr(buf, "_rcu", len) &&
> +		    !strnstr(buf, "_srcu", len))
>  			return true;
>  	}
>  
> @@ -262,15 +262,15 @@ static const char *get_thread_desc(int task_id)
>  static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
>  {
>  	char buf[64];
> +	int len;
>  	int skip = 0;
>  
>  	for (; skip < num_entries; ++skip) {
> -		snprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
> -		if (!strnstr(buf, "csan_", sizeof(buf)) &&
> -		    !strnstr(buf, "tsan_", sizeof(buf)) &&
> -		    !strnstr(buf, "_once_size", sizeof(buf))) {
> +		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
> +		if (!strnstr(buf, "csan_", len) &&
> +		    !strnstr(buf, "tsan_", len) &&
> +		    !strnstr(buf, "_once_size", len))
>  			break;
> -		}
>  	}
>  	return skip;
>  }
> -- 
> 2.26.0.110.g2183baf09c-goog
> 
