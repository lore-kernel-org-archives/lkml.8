Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D72C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68184208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582768042;
	bh=EhbPTAq2+zqs54JknkB4TtP1mqM3H+asTHVsefTWFOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ktgw2S+D7cOAw4pq42IJb7fyEJIm9BvxbMCTZJ1HDTDQKdwdlcsCqogbWbBXljIzL
	 ZhQimEVhkYw1d5n1GTy6zbTduar5Lw1c03XcqPz1ntU8AxFleLjDqGN4EpwZ6QfZvg
	 moGDIMi1s4TD6CBzqcjBIyq4SrB1cftFS+cVWdJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgB0BrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:47:18 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59202 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgB0BrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:47:18 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 01R1kxMJ021932;
        Thu, 27 Feb 2020 10:47:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01R1kxMJ021932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582768020;
        bh=gka4nv6hoOzbwfb7j4YlBZPR1X9FHcvBUbW+Bllno6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rng4mTvuC3n3GOagnxVc5mUyTu39YpuSpd23P+VVp4+Hk20cofBKVJFKUOOQv5Y3G
         K+qS0GK60XrSZNlmEARCRT5qTrKZgDAuo5ngBom4Ob88b13IBA4xoxKoAWDMQCR9v8
         yxtTRzXTz8IE3qN0WdrSZi2xSiSeJMtIcxlB5vpqpxAdBic9qLZItkcLes/fIyC7vL
         C8G+HU5MMiUbpuELUlSJWUJFkfQoTWKM+Al5yzcwuzvjY4MM4z/vPN1CQBEEqwJwau
         GOwGdkcxAVSEWr9l1crmT/z6GFNg/l2zS9f+iYA0theiV5LbHgXrQQXHKCmzEXuJnS
         xKMugWpiyRAPg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id p14so802503vsq.6;
        Wed, 26 Feb 2020 17:47:00 -0800 (PST)
X-Gm-Message-State: APjAAAX0RHM/+CsF3Mi4SSJYejY13j/sLrkTfRY9vGEfrHHpkcbsjBr9
        pQZmyZITs0+3b4DPYY7NtTdpLsvJ6bTAQDNgsWU=
X-Google-Smtp-Source: APXvYqz2gMdIqZp6jmEWo6V6bYnkSsv9Pt66yn+koMjv2AHfNxu7UVya7JTzAMd1ZsC9wZAXV3G/f2BuvBQMLkd3Qw4=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr1167903vsh.179.1582768019168;
 Wed, 26 Feb 2020 17:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20200222110435.18772-1-yamada.masahiro@socionext.com> <20200226221325.GA19817@bogus>
In-Reply-To: <20200226221325.GA19817@bogus>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Feb 2020 10:46:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQGQu8bWR5ybcfdWckZ_TsXKBqi3kxtO4=9=WDm4BMuQ@mail.gmail.com>
Message-ID: <CAK7LNATQGQu8bWR5ybcfdWckZ_TsXKBqi3kxtO4=9=WDm4BMuQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert UniPhier
 AIDET to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 27, 2020 at 7:13 AM Rob Herring <robh@kernel.org> wrote:

<snip>

>
> It all looks fine, so I'll drop the questions and apply.
>
> Rob

Thanks for your answer!

Yes, please drop the questions.

I just want to put them below '---' marker.
(You can see some questions in my patches)

I use a tool that automates this, but I made a mistake
in scripting for this one.




-- 
Best Regards
Masahiro Yamada
