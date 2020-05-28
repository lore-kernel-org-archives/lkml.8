Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7AB2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590676395;
	bh=UN2rnZyWpLMqF8ExVnHsDsnDlZA39XDQP/BvQVtEDTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1bqJvIGJv757kQMbb06OptTgqKC2PzIsIc1WgsN0lVl4+Q/2MhIzUKrZ1IQ+yKtpJ
	 ZvW6OPTR6FfpwoUFUrJhrpQNjZUwfi7HMTsDy0z0rbOI+IBCBxaNyi5DvR20xTvhds
	 xd8trAcfipzdJwKUnhMy6aPl5rnzW1QtNGp2SNbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391205AbgE1OdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391060AbgE1OdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:33:11 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159F2208DB;
        Thu, 28 May 2020 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590676391;
        bh=UN2rnZyWpLMqF8ExVnHsDsnDlZA39XDQP/BvQVtEDTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b+vldjs4gnjLoWxmvcqq5AyLYuS5kZtIwnn6GUD7lv0/EVgVH5QvYHaHIH4okfxxE
         jWafMsKhTdQxjZBr+xr/yGkBFyOu4z0hlYzwxdkavv0guaQM663BHhp7sQRwGCJa9Q
         lthAll+uCepibhP0gjK4Hy/3z3rgfcgIEMQva0t4=
Received: by mail-ot1-f53.google.com with SMTP id b18so2525533oti.1;
        Thu, 28 May 2020 07:33:11 -0700 (PDT)
X-Gm-Message-State: AOAM531DsH3xq6ZnWPVM2Lvor0fRlVsMZw8K4JA4LWco3DKefBRFoqjj
        6Oh5k9y/jJkLKt7uEnFi53mQeQalTjKstn71gA==
X-Google-Smtp-Source: ABdhPJzSac9fblEg4fvh1xMALOim19c1Ul+G+BxgigsqfG3+dwRkFMrik7yaQaER/EVzB2pW8mIWcXlAZrXsUMHziys=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr2288369ote.107.1590676390311;
 Thu, 28 May 2020 07:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200526200917.10385-1-dmurphy@ti.com> <20200528140525.GA4166160@bogus>
 <23500301-1076-ac47-327e-f7731525657c@ti.com>
In-Reply-To: <23500301-1076-ac47-327e-f7731525657c@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 May 2020 08:32:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPDahwYakepLP4b-Cf4fRAYrGoW0qit_ET3AKbYOYERg@mail.gmail.com>
Message-ID: <CAL_JsqLPDahwYakepLP4b-Cf4fRAYrGoW0qit_ET3AKbYOYERg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: tlv320adcx140: Add GPI config property
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:20 AM Dan Murphy <dmurphy@ti.com> wrote:
>
> Rob
>
> On 5/28/20 9:05 AM, Rob Herring wrote:
> > On Tue, May 26, 2020 at 03:09:16PM -0500, Dan Murphy wrote:
> >> Add an array property that configures the General Purpose Input (GPI)
> >> register.  The device has 4 GPI pins and each pin can be configured in 1
> >> of 7 different ways.
> > Dan seems to have trouble running get_maintainers.pl and Cc'ing the DT
> > list. Running 'make dt_binding_check' also seems to be a problem. Now
> > linux-next has these warnings:
>
> I don't have an issue with doing get_maintainers.  All the maintainers
> listed were added to the patch.
>
> And devicetree@vger.kernel.org was cc'd.

Indeed, sorry for my rant. Some reason my search didn't find it.

Not sure why my tester didn't flag this either...

Rob
