Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB920674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bzgnsWX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbgHQTcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732288AbgHQTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:31:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9DEC061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:31:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so8301690pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yLDTTqMkKvyQoGCAd2tBT6ow8BC5kwAIMSYl/rsC3Ig=;
        b=bzgnsWX6JN7NV6RKPm3/XJjM04WPFUgcs1wtGhs1vDTOxeZhtDj7fuyAu2vXQLBDwf
         NunOGlqU6ZO3tUOM6cYIKz91z1a0JFYpj3NUNbRaX/q3jIer+Wkvt/KvKPaONP97Crry
         jsU4TA572eaUbNcIoBNzEbO/z39hgO2qIc6nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yLDTTqMkKvyQoGCAd2tBT6ow8BC5kwAIMSYl/rsC3Ig=;
        b=R2AITEwNhZ5s0sj9x9ehWPQgGiPhDSiAvnTaG65c3Dw0w35IdVK3QRiFcHurx4djdd
         9shrbQ1x8bJ1iNS1eqZJiuyAKfbaFnbcDnwWc6gqpZFtI3pWl7x+9fBxMmJidWzNRNkj
         h/D9fQAic1REMExhsEz3egPhz6BTc36whL42gaVQEnSRWmzcuwwqiBcXgOqExd4V7rYw
         ZxBAsWdqbeY28Dz1x6s3iaqNBrHFmE7vxte2SZVIrg9qAisezEdVH3Nv84/bAoJRxqbM
         Ee2kJabwmFDafEPscdb1j4b5TAOE7mplHdf3MHDD+eVWdZvXqq2Asgw0AnViRQ88l5jb
         lsnA==
X-Gm-Message-State: AOAM533XePmdmrQtBFugvXz0ujwWXnXVhUU2DB2FZamCHCWkhmpC0jW4
        OOvoxRvHdPBEhsDIWfnN5D+/3Q==
X-Google-Smtp-Source: ABdhPJzCi15gvOenOB0TavTHTfEnkEdWPrPF4SLQpHGX34K4lsCi5WBzkUNgqv4diadl5ikP7WbgjA==
X-Received: by 2002:a17:90b:4b0c:: with SMTP id lx12mr14431013pjb.117.1597692717183;
        Mon, 17 Aug 2020 12:31:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hi13sm18644138pjb.26.2020.08.17.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:31:56 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:31:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Allen Pais <allen.lkml@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Alex Dubov <oakad@yahoo.com>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        inux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 00/10] mmc: convert tasklets to use new tasklet_setup()
Message-ID: <202008171230.D576430C56@keescook>
References: <20200817083508.22657-1-allen.lkml@gmail.com>
 <CAK7LNAQ=t-6aA80FW+7PKfb36yuhMKBW9_kCdTrmkWiWi9k-9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ=t-6aA80FW+7PKfb36yuhMKBW9_kCdTrmkWiWi9k-9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:53:13PM +0900, Masahiro Yamada wrote:
> On Mon, Aug 17, 2020 at 5:35 PM Allen Pais <allen.lkml@gmail.com> wrote:
> >
> > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > introduced a new tasklet initialization API. This series converts
> > all the mmc drivers to use the new tasklet_setup() API
> 
> 
> I did not know this was the direction to invest efforts
> because I thought the threaded-irq was supposed to replace
> the tasklet.

Both can happen. It seemed to me that mechanical conversions from
tasklet to threaded-irq was not possible, though, so best to convert the
old API away from being a exploit target (saved arguments on the
heap) while conversions to threaded-irq can happen on a case-by-case
basis.

-- 
Kees Cook
