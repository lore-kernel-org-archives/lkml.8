Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5160C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D5520679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFBJwy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:52:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40011 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:52:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id s13so389118otd.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/qnzz8eAvVXM0t8xViTdW3C6S3mOm/agGju+G6wCw7c=;
        b=sMAxwPtH+EOkRkySLR+KRFGHC3Gm/8VPpbMDYngJf6vLol8sjucSkhTqooRhHH/lI2
         Tp2ZyVlloCVdE18p2xkUETstO+mFA7sM9LQpNuR35EHMpWuoWCw2O97wDZLkZptkUb1D
         vcCwfmww6SeCnECu6GSU1a190A+fx0xyyFv0UEBNDZoFcp8hB1/ILaZUwFH0AgHFh7wX
         RiM4u9q96s3r1XGqQXPipQUrWCyspphzQDGwJ36F1vUt4Qt2/ToSerjoykbYgSpeKxbH
         8/azZ3H8EQ93BQRUf+0HiVvpPWvmWnt7CdKnKdLgRSxkDreTkoLfJAkJi+ONCskQh/Di
         8crQ==
X-Gm-Message-State: AOAM53043QTdIhtRFQwdYaAGI1rD8JS7CglUkdiYQj9KId0E28Q92l4k
        IwBxY1VhyM4ka5G0hFbYyb9p3yuo17t5+0BEtog=
X-Google-Smtp-Source: ABdhPJzk4/oPUr1k9Vv4rWvYdP659RLVNsOZG/pg9WtOGV1cJqcPrPRILMzVbHFVnNJbTYtkQydo+0SO2bhoMZCaNwk=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr19370952otp.145.1591091573535;
 Tue, 02 Jun 2020 02:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200417040245.66382-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20200417040245.66382-1-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jun 2020 11:52:41 +0200
Message-ID: <CAMuHMdVotxhP54LuKOuNOhM=kUj9TM6LyHubWiFzCHfGYHhzPw@mail.gmail.com>
Subject: Re: [PATCH -next] rcuperf: Fix printk format warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 6:03 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Using "%zu" to fix following warning,
> kernel/rcu/rcuperf.c: In function ‘kfree_perf_init’:
> include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
