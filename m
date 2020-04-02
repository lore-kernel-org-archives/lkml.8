Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5437206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585834556;
	bh=uAmdNWARr1zvbILl9dUIq13b5ZCkuxPovxTpcde9KHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SULt7CpLxvp0hvnkerKWUpLoUw0ShesISIigYw36EKaj8wTk0wYWDKHX7loFEfqZ0
	 RMGOTViHtpvyN0fTtXA/8+kty9d4RYrDBkfm6EV77AMCQnByJ98v9DOGrs0DVAvSoK
	 pF1OK9pC4yL/EHjG/CAMwe+mDeIpm0UgJFz99+Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbgDBNfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387752AbgDBNfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:35:55 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9067920784
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585834554;
        bh=uAmdNWARr1zvbILl9dUIq13b5ZCkuxPovxTpcde9KHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUFN/0N8l+/Y0yi+ECu2yLRLlyMzd2I5BDGEjg0wH2fK8LOXOjCxjg3phhh0kTd5u
         Njj5u/15heBFxq4Me9UV36sx+yIylp5Rn3qAgASWdOzKj2zy5LXv4AXbHFQr9yOIRZ
         i9IzU1eof1QFBlC5gVFKItrJHPK5qIYKZAsrlIXs=
Received: by mail-qk1-f178.google.com with SMTP id u4so3802003qkj.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:35:54 -0700 (PDT)
X-Gm-Message-State: AGi0Pua4/zJ/ogfPRzKohd6xO3B3BH/az0TQ0izSqKADLYndG+8q5b7Z
        IeGaphP1tgfHFdXDX04dRCZ+QqaIBp7Nwl/ahA==
X-Google-Smtp-Source: APiQypJC0IUfpiZoDOhBhaVQIVgV+X1sdemcV9zsqlUAS73jp31au9BoJRb+Kuy/+LjKTLYx6G87MWh9ivgWxe6MSog=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr3600485qka.152.1585834553670;
 Thu, 02 Apr 2020 06:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200402033640.12465-1-f.fainelli@gmail.com> <20200402081346.GA2548@willie-the-truck>
In-Reply-To: <20200402081346.GA2548@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Apr 2020 07:35:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+uSdk9YNbUW35yjN3q8-3FDobrxHmBpy=4RKmCfnB0KQ@mail.gmail.com>
Message-ID: <CAL_Jsq+uSdk9YNbUW35yjN3q8-3FDobrxHmBpy=4RKmCfnB0KQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dt-bindings: Document 'rng-seed' for /chosen
To:     Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <swboyd@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 2:13 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Florian,
>
> On Wed, Apr 01, 2020 at 08:36:40PM -0700, Florian Fainelli wrote:
> > The /chosen node can have a 'rng-seed' property read as a u32 quantity
> > which would contain a random number provided by the boot agent. This is
> > useful in configurations where the kernel does not have access to a
> > random number generator.
> >
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/chosen.txt | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
>
> Thanks for doing this; I realised it was undocumented the other day when I
> tried to look it up myself.

Already documented here[1]. I've been meaning to delete chosen.txt so
that's a bit more obvious.

I realize it's a bit harder to find what's documented where. Long term
we'd like to generate documentation from the schema and integrate as
part of the spec. Short term, it would be quite trivial to make a 'am
I documented' utility.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml
