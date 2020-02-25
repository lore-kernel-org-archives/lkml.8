Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE990C35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CEA2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582605233;
	bh=QwKVAlPJ8ev/mgVhD7DDQOICW8Td3Y75wCsP3U1iprE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cdbGo0kd516j/MINrcDwedihUsnJuwiW/X6z0v4zUF5X3qh5INiZxvk59aL080KWT
	 VLJBnEYzGF7xfv1AE6zfq4OE2KxgZMvUIspBRsa7JH8ew3hhuVuhNAUeYeuAcX7xaI
	 2qlfkzPTD8AvVDgkRv65Seh8rFzKPYEwduHK02PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgBYEdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:33:50 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:47025 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYEdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:33:50 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 01P4XZED025736;
        Tue, 25 Feb 2020 13:33:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01P4XZED025736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582605216;
        bh=Ng4ZmnLemNq5HjpNISMW41r8nXw0jtXn8ANbKHl6dz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I48WcS7sqWVKbe3yArFzR4syEgMwUwzgIN61iX3Yq1CNxXsQu1P8ZKz7oPbyjWRmp
         zSP+HYOMYmByFELhHZcFAaimaEmvFcUBkZa3cjJY7F5xSR5K4FcOkZEmiEAvdLjvEk
         NDoOjMPw1jrfomDehoBL9diyHDtaMkv3TgB7iP8b99GXlfUoBWj7u91jedKMZ2o0m4
         r6gJCV55cTOIqknbLQH62BpRz3Amp+KsWNi2rrNHqRXX3j4naawVZVdjcd1zl6QtIf
         YDrHV3Kiv5cUHU1rDJU6qWnC/HR7Ef+xkFYbDMBNzQu57oDMz6TfgQXyCVYg7YhPaF
         VxNVNMrVNO8vw==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id b2so3149315vkk.4;
        Mon, 24 Feb 2020 20:33:35 -0800 (PST)
X-Gm-Message-State: APjAAAUWW5gs7clz/k8ablCltNc1/Sw6yIrn5chTRaQwK9wLu3JpLssp
        6ac5HcGSezCgIEdazBic4s9NZtvACDI2O3Bg1Hs=
X-Google-Smtp-Source: APXvYqy/vZEgOpeqqB8D4Pt8x5+U+blcwh6ycIWwV7z+ewuRUMKrQz/xrr83GFfUl4itdlwuCnUaS4R7PUtP0p5OO3Q=
X-Received: by 2002:a1f:1bc3:: with SMTP id b186mr25874045vkb.96.1582605214678;
 Mon, 24 Feb 2020 20:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20200222190435.11767-1-masahiroy@kernel.org> <20200224225253.GA27948@bogus>
In-Reply-To: <20200224225253.GA27948@bogus>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 Feb 2020 13:32:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+iOAonhxN2BK4D8TSb8F-BqPxDGFU0AOv9fZ2So4iqA@mail.gmail.com>
Message-ID: <CAK7LNAS+iOAonhxN2BK4D8TSb8F-BqPxDGFU0AOv9fZ2So4iqA@mail.gmail.com>
Subject: Re: [PATCH 1/5] kbuild: fix DT binding schema rule to detect command
 line changes
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Feb 25, 2020 at 7:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Feb 23, 2020 at 04:04:31AM +0900, Masahiro Yamada wrote:
> > This if_change_rule is not working; it cannot detect any command line
> > changes.
> >
> > The reason is because cmd-check in scripts/Kbuild.include compares
> > $(cmd_$@) and $(cmd_$1), but cmd_dtc_dt_yaml does not exist here.
> >
> > For if_change_rule to work properly, the stem part of cmd_* and rule_*
> > must match. Because this cmd_and_fixdep invokes cmd_dtc, this rule must
> > be named rule_dtc.
> >
> > Fixes: 4f0e3a57d6eb ("kbuild: Add support for DT binding schema checks")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.lib | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> For the series,
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> I'm assuming you will take these? If not, I can in the DT tree.

Yes, I will queue these to kbuild tree.





-- 
Best Regards
Masahiro Yamada
