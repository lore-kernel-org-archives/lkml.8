Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC22C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B660B246AD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvAC7ZQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFTVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:10:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41533 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgFTVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:10:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id 9so15271669ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gc9tdvMm5I7FJ9/c9wizyx0mIG41qGeqGwmlr+DZXMs=;
        b=IvAC7ZQ3rsnPQbRpe/zhqJX5h5DHKg2O/MrnfYfjr9Zce7psVaMRbv9AhkaSnbgzO9
         +WaPbgTnjvGnVJKwiLI8WAKGc6kWyYMwchzqviYciYEfZcPQ9D5xtRFr5tgz2Oq+16k0
         DFIafeLVdCK3BP4iid2OzKBZViODJZYG5DNZaqPnzFzSsuGxIeKBSHBk6Dcwi72cNcen
         u2bC9fuNz6HlM9G/ZJrKeg0F8THM+Gl1vS4O4q/YqnNsiKCStMLriluy51nB6rNwOtOI
         tcnMd2RvUpAmKCH1xk0vtXcZ33/12atFQif1nAM/XxmRQMDxkQYKXqTTEvtI7pXawhfc
         y9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gc9tdvMm5I7FJ9/c9wizyx0mIG41qGeqGwmlr+DZXMs=;
        b=MwYVhnCcMFtor/pB6VsrLXXhEYPlKj4kUzKYREhAyvMjQrlJvsujwALHZVmUMdAoI0
         NHmI0VWCGpmH2fUoN6+BRjtCNefEttA4xxZ9fru3MooUMLSjrj1hRJbGjP5Ec4ZC+qyQ
         srY+/Aq+gNyoV1gd4XGHPkhVXZp789Ejv6bf7OEV/Z1IX6qLU/5bHMIvI4nsOAmWzeOE
         xp+J5WUvZtLdLiP8H3JjLiSRiTxshRIAY1Mpx2Z0UzcDYB6Wy9v9iEA5oHXHT+Qy+t6A
         OHIo/Hx+VhXJh2WF98MM4sOIEyEy+Cnm7lKm/zxI37TmzKvks3npj5JYtcieKJ3JNbhP
         bB+w==
X-Gm-Message-State: AOAM531NhDQwpM8zJ1VZSW7SRNAf8CPSxFoH3ng+8DpLOcr1cqrb/dqO
        uSeN1wTMNt6eVISCTamqdnpb7vS2el/Kva+KHNadnQ==
X-Google-Smtp-Source: ABdhPJwdgpgs+ay+WZjD/XkBsiAdpaLbdadabai2iJjIEJzxZyOWnj/D/DOGj5KOcwe67T4FZfBDGzbpDtr8cOH+enA=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr5207917ljc.100.1592687338273;
 Sat, 20 Jun 2020 14:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200615125951.28008-1-alexandre.torgue@st.com>
In-Reply-To: <20200615125951.28008-1-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:08:47 +0200
Message-ID: <CACRpkdbgMRW6Jqde6AOcjJ9=T-d5fTO02N19YsrVL+iaZiKXwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: stm32: Add possibility to configure only one pin
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:59 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Currently stm32 pinctrl driver offers only the possibility to configure pins
> groups thanks "pin_config_group_set" callback. To configure pins thanks to the
> GPIOlib (i.e. GPIO_PULL_UP ...) this driver needs also to support
> "pin_config_set" callback.

Nice feature growth!
Patches applied.

Yours,
Linus Walleij
