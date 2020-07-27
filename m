Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A53FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282DE206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595849101;
	bh=drHPhSD0jJfk/z9wwjoZaV/N+C/C6uB4xTn1Ihfva5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EDNy7bWyJ8FEQGpLTz/Ny521t1MB8Rh9miM6+8w6kO/saCzBQVKIIivKbpL9BrHRE
	 LIq+Eqv2dBuYuiZWW5+WJZtAg6p3e7gilYBwpW44g1g9c60pbC8a/X7yI+76qKvHVJ
	 ruYaCW2mbr2Ze50QYsuZg0zzxyvTNAE9ss5v2Uyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgG0LY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgG0LY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:24:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:24:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id by13so11813181edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVi4ci9r11iJZabvuK+KNAiYWVzMLwehv9ewIXbDGvM=;
        b=dfnfcBE6Yer3PftNB0mQkFcdpQxmYW+IAxCT1L7YYGg40QLgJIxlPRaitzNSbYHI2J
         Ua1KreJbpjZUCWqdZ5tRBs4Kae+7xdizoBUycqxkjCrkdXflATo1qFrW/NKGW3VuLksh
         aoufBsNLCw84ngyFvga395rF6HeZ+bcBMAmIpeElC5zQZOdR7gXMsSI0sIgPdmoccDOf
         uCma2h06EdedbuF9LTZbhb2/y7YWaQv0MD0tMZwYncTHRZzWnRTWpL4zlL95cQOdatS9
         xL0/IPtgx3SnqIvhQNY4fXMoTtf+tRewou/ecsvGltm3lQwOfhkgOOvq7MypRhfLsoDm
         JCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KVi4ci9r11iJZabvuK+KNAiYWVzMLwehv9ewIXbDGvM=;
        b=pwd6eg+0JdMq2qUF5C3Yq6FnfiWmem2D9zPT/JIaBaTcN1JRYPnYHJoDMR4Ub/xa2X
         9hJu26G6/9QbGUQgDfZeLDAmoxVewlePlj+U6HQmFmeijNkB/4o6VTvY7vyMw8wAkuFw
         VTn52V/1VfltkSk7ZJnAH1eOlz+aqkI8mI+rOGY72vSuUZ6Lf7fGjd9Gp3yMWebPVEOr
         uRfrBWdX4XIzSPZz43j4YkS8ohC/VQhw628vG3wdIVPAhH/WIxC8dt0tx0xN20DuC827
         fbrl+nQa3cTla3Qy3ESbx+tfVIOpnCvJ8vm6Bp268jBsR4/O/tPHfV+BQWcwrLbsVPqE
         J5ww==
X-Gm-Message-State: AOAM533LS0b+2e5RzGemo+QySE+/Rsc8w/UZy7CFDG9/o6ZeokIvCcPP
        h0MR4/lnUoEDvN1VQ7ZOkz0=
X-Google-Smtp-Source: ABdhPJxBqgF5ZegS8JvKjGK4iLDDSjijDGanOkVWxVEKsWvZu/6aXcQPq1GqtUHxarRZ3mCaDkWaqw==
X-Received: by 2002:a05:6402:b4c:: with SMTP id bx12mr20224476edb.157.1595849097185;
        Mon, 27 Jul 2020 04:24:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i5sm6689345ejg.121.2020.07.27.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:24:56 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:24:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     vincent.donnefort@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200727112454.GB55660@gmail.com>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* vincent.donnefort@arm.com <vincent.donnefort@arm.com> wrote:

> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Introducing two macro helpers u64_32read() and u64_32read_set_copy() to
> factorize the u64 vminruntime and last_update_time read on a 32-bits
> architecture. Those new helpers encapsulate smp_rmb() and smp_wmb()
> synchronization and therefore, have a small penalty in set_task_rq_fair()
> and init_cfs_rq().
> 
> The choice of using a macro over an inline function is driven by the
> conditional u64 variable copy declarations.

Could you please explain how "conditional u64 variable copy 
declarations" prevents us to use an inline function for this:

> +/*
> + * u64_32read() / u64_32read_set_copy()
> + *
> + * Use the copied u64 value to protect against data race. This is only
> + * applicable for 32-bits architectures.
> + */
> +#if !defined(CONFIG_64BIT) && defined(CONFIG_SMP)
> +# define u64_32read(val, copy)						\
> +({									\
> +	u64 _val;							\
> +	u64 _val_copy;							\
> +									\
> +	do {								\
> +		_val_copy = copy;					\
> +		/*							\
> +		 * paired with u64_32read_set_copy, ordering access	\
> +		 * to val and copy.					\
> +		 */							\
> +		smp_rmb();						\
> +		_val = val;						\
> +	} while (_val != _val_copy);					\
> +									\
> +	_val;								\
> +})
> +# define u64_32read_set_copy(val, copy)					\
> +do {									\
> +	/* paired with u64_32read, ordering access to val and copy */	\
> +	smp_wmb();							\
> +	copy = val;							\
> +} while (0)
> +#else
> +# define u64_32read(val, copy) (val)
> +# define u64_32read_set_copy(val, copy) do { } while (0)
> +#endif
> +

Thanks,

	Ingo
