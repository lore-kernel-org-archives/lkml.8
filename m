Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DDC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D2206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n8Aslr0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBFI0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:26:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36321 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgBFI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:26:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5884023wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=97BIRK5RGZCfZuJeDSFhTb2bxAVUveLxpXvHfjaGgSY=;
        b=n8Aslr0lLw9jLwjqQepYhcW3j6MLyQY+XVzKTiFLrrdxsRHKCu9qVzalQy1RYDoAit
         toeGhtEGswPD4Y33rDFSIeNKlrkcfGFdvNDfDfQnbnREMtIjyfVtiPGr3fIHb2NQxjFK
         nptHPqbudM6I+P3oqAH18mwJjnrTGA+zzkf0/CvzmeWp9a7FBOB7qwBm+1St8D9/0iVv
         /4qjzU2s4VEQk2q6c7489oKKKsFMFhbrT7cb5FQJbWz6VIEmwiZy+ghHiA2yJNrKzmav
         +RKR9HIuZcCC2YySLAQ6imangA/bP2ObK+tGj4hpAltBw4s+N/9tq1Tn4vgAc3raQmHD
         a3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=97BIRK5RGZCfZuJeDSFhTb2bxAVUveLxpXvHfjaGgSY=;
        b=K8tIe+NCBaF/FhdDk2W7g8nNVEcJiDKkPFEI/B4CZGsQeD1EuiszvdnFDym3WRalct
         bE5GiLV9VK6M4zhwoA/8BtXkDJTPua06I5AHof0a6NpUBjx5alUBeeOBTF4F535mIXPF
         pktI9rn1ozIn+lY9YeI13htOuM9UHhzZYVFAKwpMSOTDR4rP7m0wBk8qemhW1jqaBCe7
         Aj/XUztVYTuxqmY7rR+IysGQSXIqbvOlknxCCSaLvI/bMYVRDZgOvONTFh12hesVM1ph
         3qJ3nPwmEoVzjjuhbf0Lwg2RcBnT60zZMEpUS2u4BK9Wh2KL3GOmWGIiqrpfClWUNAXO
         85+w==
X-Gm-Message-State: APjAAAWoqPd/uP+LQtbSnJNDL4IbowU6Kjzeql8wZPE8IWg1y3s/ojgg
        O2bDe1C6UY4+++aGY0ma5qJJZ8gHobY=
X-Google-Smtp-Source: APXvYqytRZnInsW54r+Ha5yXhQPuvlr0nJBRRhewjndeHYzcvddDJz1JkgqvvG9CJzg/n3JZCGDH3Q==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2947022wmg.136.1580977567997;
        Thu, 06 Feb 2020 00:26:07 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id i11sm3176299wrs.10.2020.02.06.00.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:26:07 -0800 (PST)
References: <20200205232802.29184-1-sboyd@kernel.org> <20200205232802.29184-2-sboyd@kernel.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/4] clk: Don't cache errors from clk_ops::get_phase()
In-reply-to: <20200205232802.29184-2-sboyd@kernel.org>
Date:   Thu, 06 Feb 2020 09:26:06 +0100
Message-ID: <1jv9okazq9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 06 Feb 2020 at 00:27, Stephen Boyd <sboyd@kernel.org> wrote:

> We don't check for errors from clk_ops::get_phase() before storing away
> the result into the clk_core::phase member. This can lead to some fairly
> confusing debugfs information if these ops do return an error. Let's
> skip the store when this op fails to fix this. While we're here, move
> the locking outside of clk_core_get_phase() to simplify callers from
> the debugfs side.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 48 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d529ad67805c..26213e82f5f9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2660,12 +2660,14 @@ static int clk_core_get_phase(struct clk_core *core)
>  {
>  	int ret;
>  
> -	clk_prepare_lock();

Should the function name get the "_nolock" suffix then ?

> +	lockdep_assert_held(&prepare_lock);
> +	if (!core->ops->get_phase)
> +		return 0;
> +
>  	/* Always try to update cached phase if possible */
> -	if (core->ops->get_phase)
> -		core->phase = core->ops->get_phase(core->hw);
> -	ret = core->phase;
> -	clk_prepare_unlock();
> +	ret = core->ops->get_phase(core->hw);
> +	if (ret >= 0)
> +		core->phase = ret;
>  
>  	return ret;
>  }
> @@ -2679,10 +2681,16 @@ static int clk_core_get_phase(struct clk_core *core)
>   */
>  int clk_get_phase(struct clk *clk)
>  {
> +	int ret;
> +
>  	if (!clk)
>  		return 0;
>  
> -	return clk_core_get_phase(clk->core);
> +	clk_prepare_lock();
> +	ret = clk_core_get_phase(clk->core);
> +	clk_prepare_unlock();
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_get_phase);
>  
> @@ -2896,13 +2904,21 @@ static struct hlist_head *orphan_list[] = {
>  static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
>  				 int level)
>  {
> -	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
> +	int phase;
> +
> +	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
>  		   level * 3 + 1, "",
>  		   30 - level * 3, c->name,
>  		   c->enable_count, c->prepare_count, c->protect_count,
> -		   clk_core_get_rate(c), clk_core_get_accuracy(c),
> -		   clk_core_get_phase(c),
> -		   clk_core_get_scaled_duty_cycle(c, 100000));
> +		   clk_core_get_rate(c), clk_core_get_accuracy(c));
> +
> +	phase = clk_core_get_phase(c);
> +	if (phase >= 0)
> +		seq_printf(s, "%5d", phase);
> +	else
> +		seq_puts(s, "-----");
> +
> +	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
>  }
>  
>  static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
> @@ -2939,6 +2955,7 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
>  
>  static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
>  {
> +	int phase;
>  	unsigned long min_rate, max_rate;
>  
>  	clk_core_get_boundaries(c, &min_rate, &max_rate);
> @@ -2952,7 +2969,9 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
>  	seq_printf(s, "\"min_rate\": %lu,", min_rate);
>  	seq_printf(s, "\"max_rate\": %lu,", max_rate);
>  	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
> -	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
> +	phase = clk_core_get_phase(c);
> +	if (phase >= 0)
> +		seq_printf(s, "\"phase\": %d,", phase);
>  	seq_printf(s, "\"duty_cycle\": %u",
>  		   clk_core_get_scaled_duty_cycle(c, 100000));
>  }
> @@ -3434,14 +3453,11 @@ static int __clk_core_init(struct clk_core *core)
>  		core->accuracy = 0;
>  
>  	/*
> -	 * Set clk's phase.
> +	 * Set clk's phase by clk_core_get_phase() caching the phase.
>  	 * Since a phase is by definition relative to its parent, just
>  	 * query the current clock phase, or just assume it's in phase.
>  	 */
> -	if (core->ops->get_phase)
> -		core->phase = core->ops->get_phase(core->hw);
> -	else
> -		core->phase = 0;
> +	clk_core_get_phase(core);
>  
>  	/*
>  	 * Set clk's duty cycle.

