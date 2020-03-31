Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C00C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDE52080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgCaWGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:06:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgCaWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:06:42 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJP1q-0000ht-Ne; Wed, 01 Apr 2020 00:06:39 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AFC61103A01; Wed,  1 Apr 2020 00:06:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Add debugfs support
In-Reply-To: <20200331214045.2957710-1-thierry.reding@gmail.com>
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
Date:   Wed, 01 Apr 2020 00:06:37 +0200
Message-ID: <87lfnguqky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry,

Thierry Reding <thierry.reding@gmail.com> writes:
> Add a top-level "clocksource" directory to debugfs. For each clocksource
> registered with the system, a subdirectory will be added with attributes
> that can be queried to obtain information about the clocksource.

first of all this does tell what this patch does but omits the more
important information about the WHY.

What's even worse is that the changelog is blantantly wrong.

> +static int clocksource_debugfs_counter_show(struct seq_file *s, void *data)
> +{
> +	struct clocksource *cs = s->private;
> +
> +	seq_printf(s, "%llu\n", cs->read(cs));
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clocksource_debugfs_counter);
> +
> +static void clocksource_debugfs_add(struct clocksource *cs)
> +{
> +	if (!debugfs_root)
> +		return;
> +
> +	cs->debugfs = debugfs_create_dir(cs->name, debugfs_root);
> +
> +	debugfs_create_file("counter", 0444, cs->debugfs, cs,
> +			    &clocksource_debugfs_counter_fops);
> +}

It does not provide any information about the clocksource, it provides
an interface to read the counter - nothing else.

Try again.

Thanks,

        tglx


