Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF5C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE21720774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585311370;
	bh=/2HMPORZ12E8OERO6OoSoK6K05k7eyq73faR8OPKxfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fv0WNuV6J734gc9zUbUk926qWuDJBesw4d5i2RVQfDOoRHCpjVLmtrJaSzMMi2IAP
	 6v6BMPfXGBM3FAtAzj8ozeHPgPcNfmKJWBWdUXsNo4/5xFEI1twZ6Okt7CHLw/zk49
	 fRw/DNZBdwVrCyra+VZsQOnd1adMekJAhtVDvOOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0MQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgC0MQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:16:09 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5CF020787
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585311369;
        bh=/2HMPORZ12E8OERO6OoSoK6K05k7eyq73faR8OPKxfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xA/vyeexZuSQ7/a6cRtGnGJWJBvB60XeijO/mgEYeru5BovhhXZeWIvDQ3RmgU1Mm
         3G0dL9JQkVEWj/lWk/jzsBWijwDtIBnjaEgUJDx9MXa5DhMJ9gCDf5NaYhQgAomnB3
         o0zroopYZegnvlluYSPNkRh63XjwoHG/bWc/EpGk=
Received: by mail-wr1-f42.google.com with SMTP id h15so11117985wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:16:08 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3y2sCWHLLOvFZmHtBQ9uO0wS0FHn9XolvtqKKH9XBsRIGds+ed
        ziBt4UVAcMRP2o+57jOox2chaNmAK2ywd8s3t7Q=
X-Google-Smtp-Source: ADFU+vvcUOv53tgiW4AvEma9SKV84qzuLQblzC1TPmgmBJHgDj8wMXy6C+BdlFl+bzbXobFqKfuFsZF1/2Rc7E7lh/I=
X-Received: by 2002:a5d:4146:: with SMTP id c6mr14141722wrq.181.1585311367249;
 Fri, 27 Mar 2020 05:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200327030414.5903-3-wens@kernel.org> <8bfb3237-4bd3-8452-1860-ac05f3a23503@gmail.com>
In-Reply-To: <8bfb3237-4bd3-8452-1860-ac05f3a23503@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 27 Mar 2020 20:15:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v65CL_K-c=fej=5UNseJvApusj7Q1AjZETs-q70kOwey8w@mail.gmail.com>
Message-ID: <CAGb2v65CL_K-c=fej=5UNseJvApusj7Q1AjZETs-q70kOwey8w@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: rk3328: Replace RK805 PMIC node
 name with "pmic"
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 8:12 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Chen-Yu Tsai,
>
> The Documentation/ portion of the patch should come in the series before
> the code implementing the binding.

The name is not part of the binding.

> If you like, could you convert the binding as well and fix the example?
>
> Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt

I can send an extra patch to fix the example.

ChenYu

> > Example:
> > --------
> > rk805: rk805@18 {
> >       compatible = "rockchip,rk805";
>
