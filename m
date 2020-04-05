Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B6EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 22:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8495920672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586127109;
	bh=+qkpE/VzZVJjNYp14D0CGe0j5+UI5EbcqBZ0isMWYz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c8wYAQBowQoAgIX+gHSdGkcuOdsaZGQBYiHYw0m4pQ4KK012idX5EW2xZxXs27Iew
	 Eo/zOnYSTEdRgHSDLaUW8Wz/Rw/EP0f4kGc305GAlWTqgJy5Q8+MAoqWcZHpExq9GW
	 hb6JxtrPVJULXZ62X26Fa1sXChBOCZ8AakwbzP/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgDEWvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 18:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgDEWvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 18:51:42 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAF7206F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Apr 2020 22:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586127102;
        bh=+qkpE/VzZVJjNYp14D0CGe0j5+UI5EbcqBZ0isMWYz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f7N8j9bTEuX2pG7W41IR6FqaiigUcXyvSGQ66YOVJA02bYSkh6emWYqiN4GluXnBm
         sO7A1MZJJpNwgiFW/AV4zpbaScDAR/kEqwGHOAJzBqArfyuiGi9RTiwfzU0y0NNwFz
         7uWbIv7/7cx76niUT/3fD8KvowuBbWTTSAtl05e0=
Received: by mail-wr1-f50.google.com with SMTP id k1so5788266wrm.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 15:51:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuZPN5BmZot42mnAmkjMivNiA0dva7QmTeLlhKDsYYy2AfGZnAyJ
        wUlaFl9VUa0fybu7VrfrtPMFlvgoD0pCis11pCFmow==
X-Google-Smtp-Source: APiQypIZZeGyy9AWnrPYhspWabgLmcetsyynlVwx/fKVCTu+hT5tJ8/0bFBFj8nmq1k3Wvg5vUMIUVBAH8TL7+FgBpw=
X-Received: by 2002:adf:aad7:: with SMTP id i23mr20451094wrc.184.1586127100363;
 Sun, 05 Apr 2020 15:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
 <CALCETrXcFrR9V_yjPRh9eJ1=1efo_DCCwGTeusmo2CQXpFFdrw@mail.gmail.com>
 <20200405180510.GD6313@kunai> <20200405214059.91F97899799@corona.crabdance.com>
In-Reply-To: <20200405214059.91F97899799@corona.crabdance.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 5 Apr 2020 15:51:29 -0700
X-Gmail-Original-Message-ID: <CALCETrVUWEOwpMOLAPieU5mffaA6vJPWQov5N82gtcBo04JsyA@mail.gmail.com>
Message-ID: <CALCETrVUWEOwpMOLAPieU5mffaA6vJPWQov5N82gtcBo04JsyA@mail.gmail.com>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host controller.
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Andrew Lutomirski <luto@kernel.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 2:41 PM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> Hello Wolfram,
>
> > > > This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> > > > https://lkml.org/lkml/2016/4/28/926. It never made it into the kernel. I hope
> > > > this rewrite will:
> > > >
> > > >
> > > > Overview
> > > >
> > > > Modern Intel memory controllers host an SMBus controller and connection to
> > > > DIMMs and their thermal sensors. The memory controller firmware has three modes
> > > > of operation: Closed Loop Thermal Throttling (CLTT), Open Loop Thermal
> > > > Throttling (OLTT) and none.
> > > >
> > > > - CLTT: The memory controller firmware is periodically accessing the DIMM
> > > >   temperature sensor over the SMBus.
> > > >
> > >
> > >
> > > I think this is great!  One question, though: what happens if the
> > > system is in CLTT mode but you disable CLTT and claim the bus for too
> > > long?  For example, if there's an infinite loop or other lockup which
> > > you have the tsod polling interval set to 0?  Does the system catch
> > > fire or does the system do something intelligent like temporarily
> > > switching to open loop?
> >
> > Any news on this question?
>
> Thank you for your interest in this patch. You can read my reply here
> https://lkml.org/lkml/2020/3/1/216

I think it could make sense to upstream this driver but to require a
scary boot-time option to enable it.  Maybe i2c_imc.dangerous=1?

>
>  Stefan
