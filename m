Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EDDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E1B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597346180;
	bh=/fM6ISgbN4xJUdb/xm5DXg3T4ibnd6Tnpvoa20+/yL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xPQWRdkjw4MGNGmFL2DRQgEUSTs50A7TQ8C6MI6tvg96m7gFtXvUm4HOS7semaGdY
	 /qXpKh78hBkIdid9DwVLbY9QFUE5t28SgzZHyaVuYyzSKdMi5UiCt3MKYzzHDzCplO
	 zpDlZt9gPpjY2M3hh4T2KU8Rt6JB7aFLScQYW77c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMTQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHMTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:16:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FDAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:16:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a14so5027775edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ex0l1wXymD5ywnIvCajw3qddPqP7h4+eXBBmwahiauQ=;
        b=HaIHoNz/xwtoyjOp72VVGhI3bKayl/oFVvKWhxs8rn1OxXnmXj0xpPHcjp1EfqKIAH
         6kDCxd37bpVobOWetig0pWZ1K9sMlW6OC9bGIWa+6/CWNzeCchd9FTmWgke69+CFpzAw
         Ere7pRVH4K0DlAH0pc6sZWX8hmF9a3L+bt8HdYvwWme7mdkLKRoL/B7NDRPF39XSln+G
         p3knj+k7qWKwlJOb57LBSc5MbPMOViiLzvjKbgg2NHg8d+vteAIfPg2QLg0gYuk/60pp
         AbA14KER7lTQ0zqMUQZo99QNNQbop9ue7D/kX5DAtqeqneIKN8tsEP2E1d5mowb0QD6c
         +uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ex0l1wXymD5ywnIvCajw3qddPqP7h4+eXBBmwahiauQ=;
        b=Fawnxo+GfOTFalMZMH7iAg8o2kOP978bicjuPyw2/+pFHaTYrCJIHSV8Ti1cD5Wd8e
         g29yHydz6b5jW/QTnm67Fihr4doZX6LT+ZQW7C1D74/X6Yht7lMDHCgMkkaJmifL6mtM
         Xng/gIw5FDFXOLMmHVLHPuztTLuksEZBP9L3TPpVhv2YpfNr6PKGhs9NkGG4VrfVBJuP
         dRxTw2oqjd4rUM1FHo+xdx/KAfomCu/uH5hAWkDwLjkky9sapcShqC5Ta+VEebWI26es
         /OijV5pGHSxvsO5Vt7IJOy6oBDd4C0pk2VI9BvRJZkclIAPgiEj3aPOasGZWwnnwGJe3
         6i0Q==
X-Gm-Message-State: AOAM532XyHjFRx9LAcEiH6vBwDBl5/4H0RfPBI3DHtWMdeQSKsfI47Mo
        uUmooEWt5ss1i2/qgN3BWeLeGSq4
X-Google-Smtp-Source: ABdhPJzlj7ysRvPRWENtG9v6S762mxLHu00pUXf+v26xRtgEc+x8Tzq3FIr0VdeGIOop9jmJ3qUldA==
X-Received: by 2002:a50:ee93:: with SMTP id f19mr6066374edr.31.1597346176838;
        Thu, 13 Aug 2020 12:16:16 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h8sm5093707ejj.104.2020.08.13.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 12:16:16 -0700 (PDT)
Date:   Thu, 13 Aug 2020 21:16:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v5 02/17] ARM: Revert back to default scheduler topology.
Message-ID: <20200813191614.GB2337490@gmail.com>
References: <20200812125300.11889-1-valentin.schneider@arm.com>
 <20200812125300.11889-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812125300.11889-3-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> The ARM-specific GMC level is meant to be built using the thread sibling
> mask, but no devicetree in arch/arm/boot/dts uses the 'thread' cpu-map
> binding. With SD_SHARE_POWERDOMAIN gone, this topology level can be
> removed, at which point ARM no longer benefits from having a custom defined
> topology table.
> 
> Delete the GMC topology level by making ARM use the default scheduler
> topology table. This essentially reverts commit
> 
>   fb2aa85564f4 ("sched, ARM: Create a dedicated scheduler topology table")
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Minor changelog nit, it's helpful to add this final sentence:

    No change in functionality is expected.

( If indeed no change in functionality is expected. ;-)

Thanks,

	Ingo
