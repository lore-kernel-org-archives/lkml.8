Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83BCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCEB207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592227730;
	bh=/+74QMbLc4Z35NdYHsOfcfgE113k/JpcDBMJIYlRods=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zax6ynHTKkTbqTPfOnZEA7pUUvCWqDCKwtBej3QlmCs65JyO7T2ipn6dW+0e88nxi
	 4jYlV/Bo0Q9YkFdp+doIaO1Ly9xjOyQ5KCe5lD4Eae7MUXPgSYd+T9nbR7ZoaRxuIl
	 tFWn4kqFqQl6oj+j/r6atqa/kXmOspHjmg/WEt6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgFON2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:28:49 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44946 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbgFON2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:28:48 -0400
Received: by mail-ej1-f65.google.com with SMTP id gl26so17406749ejb.11;
        Mon, 15 Jun 2020 06:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vefsXLolZ4KEgKux1juVdaI94qPEnW4zxWpy0+NwH54=;
        b=iO1NQlOXDvezBxN/GCeg9QuzyATWQ8h6Wuq3nfKrR374K/yCRLBZB7ngqmnQvwDVvm
         8/ZNrJhfxogdH9rze/s68B4aBkOQWH/+s9QUKl3P4bjcfYl2uRdMFQiWLm2DvtS/kzw7
         c/tyXV1J9ZlmGN+4vOeHMrNtBRZ+tyhwBxL6wBhtpPWvlO9d9mVjzCD1xf3+TGg5Lun2
         agARA83yhZKuK4B1OWSxfUEfT723E6YgtP5gS1oY12iiW63n3l8VjbC3CYXIK8Ij+ysp
         BK80sJAPI+HhHhawzYr0T2S8WBZnJFk1MMnJEFX052md1b5MvfLu2oBz2rLR7q4BhJfd
         /7Zw==
X-Gm-Message-State: AOAM533GUC7F+fvnzC+4HC0tRHtDJfe05nyq6blSVZlmbiDj//vM/84x
        3qZMma0ricW2Ad5nPtXbS3E=
X-Google-Smtp-Source: ABdhPJzSAC7ZhJnFw/VscXsQM1RH7v57q/LBmb8O4EjaRK9nQQemXbp15Kb/XCh3EC145OU36RpKxg==
X-Received: by 2002:a17:906:c452:: with SMTP id ck18mr13780562ejb.116.1592227726460;
        Mon, 15 Jun 2020 06:28:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id ce14sm9095920ejc.3.2020.06.15.06.28.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 06:28:45 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:28:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>, stable@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] spi: spi-fsl-dspi: Fix external abort on
 interrupt in exit paths
Message-ID: <20200615132842.GA3321@kozik-lap>
References: <1592208439-17594-1-git-send-email-krzk@kernel.org>
 <e1f0326c-8ae8-ffb3-aace-10433b0c78a6@pengutronix.de>
 <20200615123052.GO4447@sirena.org.uk>
 <CA+h21hqC7hAenifvRqbwss=Sr+dAu3H9Dx=UF0TS0WVbkzTj2Q@mail.gmail.com>
 <20200615131012.GB2634@kozik-lap>
 <CA+h21hoCUC-UqHKLOsMhiEZdyTctUwNC6pqijpD9X96ZZq4M7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+h21hoCUC-UqHKLOsMhiEZdyTctUwNC6pqijpD9X96ZZq4M7w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:14:06PM +0300, Vladimir Oltean wrote:
> On Mon, 15 Jun 2020 at 16:10, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> 
> >
> > It is a slightly different bug which so this patch should have a follow
> > up.
> >
> > Best regards,
> > Krzysztof
> >
> 
> Why is it a different bug? It's the same bug.

One bug is using devm-interface for shared interrupts and second is not
caring about suspend/resume.

Best regards,
Krzysztof

