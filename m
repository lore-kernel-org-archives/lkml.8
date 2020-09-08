Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9436F2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586611;
	bh=nS0DnW4s01jgNMRrlByGFOMTsm9v8EwcKUyTzX+ckU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KqAJW4TCuxFQiy0Kl5CfcN0UpTxfA85PCWImDGGvlbm2TpeoPXOcjAi3Ymqafexj7
	 FnJ2ZzfSHwZLMzndddAbnfOo2bZCnZr7Ajpl6rc+844xRq6TujbJxVDV+gz0A/zzpv
	 la3y6I98jIp/iMiofvukW62QYlEPPk5JszmPHna8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgIHRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731714AbgIHRfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:35:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3168E205CB;
        Tue,  8 Sep 2020 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599586530;
        bh=nS0DnW4s01jgNMRrlByGFOMTsm9v8EwcKUyTzX+ckU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wb/rQpwrpp7DxJ1XepaUvRZ8Bn2q5gRTrnoD6mhshK7gbr8hLKzPsYnAXnzyqZaq1
         0033ZXzHEVjCwhR6N2CxNCq1TSxO97tmariUaB+zbEL6Rldna4qkQ7eYqyz61dI+ez
         3EbJ3aaJPUNdcc4vS/ojSabLkNbK3u/njhap4ov4=
Date:   Tue, 8 Sep 2020 19:35:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 031/129] mmc: sdhci-acpi: Fix HS400 tuning for
 AMDI0040
Message-ID: <20200908173542.GA220950@kroah.com>
References: <20200908152229.689878733@linuxfoundation.org>
 <20200908152231.250461330@linuxfoundation.org>
 <CAHQZ30B5JzOwUhiyLsbbYpFJdWQeH6vR3Ze-Gtr5-BCnw1AVBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30B5JzOwUhiyLsbbYpFJdWQeH6vR3Ze-Gtr5-BCnw1AVBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 09:56:43AM -0600, Raul Rangel wrote:
> So this patch had a bug in it. It was fixed with
> https://patchwork.kernel.org/patch/11747031/
> Commit d9fcc7130245d79a75e3f0348d3ef7297055cfd4 from
> https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
> 
> Should we pull that in too, or is it fine to wait for the next merge?

It depends on wha tyou want to do.  I can drop this now and add both
later, or just be "bug compatible" with Linus's tree until this patch
gets merged into it, and then I can take it.

Your call...

thanks,

greg k-h
