Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB76C43446
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696EE20775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595007823;
	bh=FlddXETDbcCI+jX+Y9DK4+rIepVuWv5hMCWZBOLVowY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hSbPfFWHKYXuf5r8WwaRQfUACYm1HC8dNQrHFFeOrQSI4UXa+eWhQOXYV8Ss7PzxF
	 kxBxwson1fVGEoDFHtDhtffjFOskvJwRtce5uODlwm7NqS5Jp+5TOyT7M5JQ3ln7tv
	 rmuC4mdsrYm4E74heOCW5y8pJLIs3zgH0RQpCX18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgGQRnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbgGQRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:36 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A8A2173E;
        Fri, 17 Jul 2020 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007815;
        bh=FlddXETDbcCI+jX+Y9DK4+rIepVuWv5hMCWZBOLVowY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y5Pi2lIQnfdBOI//84bhdjQC3IY36B9tgfvuVgsGZFH1r7DPsQXC2SQz4ouUB9Ls2
         xtaiOcZ2NF1EwIU/1DLWZrH854jy1zcG/o380BeunFx9u7Cu9OL/qVcg2nzb8gwBRv
         laBOx6/Z5OWb/sdAmhjUYJ0Jx42F1aVVjhR+Pbqg=
Received: by mail-oi1-f180.google.com with SMTP id r8so8658126oij.5;
        Fri, 17 Jul 2020 10:43:35 -0700 (PDT)
X-Gm-Message-State: AOAM530TMrPAeEJeJqnv2X2YoMe3YF8bbX47RDDj0Gv9VRjUAx1O6ArS
        elCS83YHBz3/6MdJzuIvdqi85nEJL+jBqbBx9g==
X-Google-Smtp-Source: ABdhPJxdEZTKZdDAtsUce5PttY07qOuwXdkHitKzJaeRFO0Ux7K7UV3QZV8Lp1Bc30tXd9ZMF4/9alh+Z0BcnZznP+o=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr8705283oiw.147.1595007815168;
 Fri, 17 Jul 2020 10:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200702191322.2639681-1-helen.koike@collabora.com> <20200702191322.2639681-4-helen.koike@collabora.com>
In-Reply-To: <20200702191322.2639681-4-helen.koike@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Jul 2020 11:43:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLduaH=F0G8+15PM+1GGmKBjgn7ddP+__ACezLd+ivp5w@mail.gmail.com>
Message-ID: <CAL_JsqLduaH=F0G8+15PM+1GGmKBjgn7ddP+__ACezLd+ivp5w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] media: staging: dt-bindings: rkisp1: re-order properties
To:     Helen Koike <helen.koike@collabora.com>
Cc:     devicetree@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Collabora Kernel ML <kernel@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>, karthik.poduval@gmail.com,
        Johan Jonker <jbx6244@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:13 PM Helen Koike <helen.koike@collabora.com> wrote:
>
> Organize properties order in dt-binbings to move it out of staging.

typo

>
> On top: compatible, reg and interrupts.
> Then alphabetical order, then properties starting with '#'.
>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>
> ---
>
> V2:
> - this is a new patch in the series
> ---
>  .../bindings/media/rockchip-isp1.yaml         | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
