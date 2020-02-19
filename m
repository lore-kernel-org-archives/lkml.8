Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E3C3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDCB24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582137695;
	bh=y154k2uuTbGD94Zlk02vS2B19qqnUVB2EVKv7l94kNw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Q+fnhHeOQK7+XVcEc+QOyGHQSYz4P5Ob/sTni5Sbc8BKDdnfTFMzAzncFjD9NMfao
	 eo+g8gGbKid5vBEFPdeMZEKughutZlFoaW1c1Z294mtHy1AvtnXhEDe583VKOzC10L
	 4yAB1PxhYPkw0VONMPLvpJRPO3J534rcoDeQdCbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBSSle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgBSSle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:41:34 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A62B24670;
        Wed, 19 Feb 2020 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582137693;
        bh=y154k2uuTbGD94Zlk02vS2B19qqnUVB2EVKv7l94kNw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Pg2nZ4uoohWZjP+BIMtpi2NMG9sPU8dIIUTvOC22OSIqGA70OfJB/rzFiJCYjpeww
         DvQL878DwOMYisPb3aPKrLmjbuIOnIjYLwJaVOs1g/vlRJxfuyG+hZApM+W0rTipbe
         QcDbarV7quXlg7jGtGql29sX3o8CfyG29JO0ztAU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2c6728a5-7789-4ca2-a173-67df57fe5f1e@gmail.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com> <158155109134.184098.10100489231587620578@swboyd.mtv.corp.google.com> <bf5e1a64-1aaa-e1e0-00bf-c0e750dd27ed@gmail.com> <1581999138.19053.21.camel@mtkswgap22> <2c6728a5-7789-4ca2-a173-67df57fe5f1e@gmail.com>
Subject: Re: [PATCH v7 0/7] Add basic SoC support for mt6765
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Joerg Roedel <jroedel@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        mtk01761 <wendell.lin@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Wed, 19 Feb 2020 10:41:32 -0800
Message-ID: <158213769281.184098.14491216159423631295@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2020-02-18 08:45:42)
>=20
>=20
> On 18/02/2020 05:12, Macpaul Lin wrote:
> > On Sat, 2020-02-15 at 02:47 +0100, Matthias Brugger wrote:
> >=20
> > Hi Stephen,
> >=20
> >> Hi Stephen,
> >>
> >> On 13/02/2020 00:44, Stephen Boyd wrote:
> >>> Quoting Macpaul Lin (2020-02-07 01:20:43)
> >>>> This patch adds basic SoC support for Mediatek's new 8-core SoC,
> >>>> MT6765, which is mainly for smartphone application.
> >>>
> >>> Clock patches look OK to me. Can you resend them without the defconfig
> >>> and dts patches and address Matthias' question?
> >>>
> >>
> >> I'm not sure if I understand you. Do you prefer to have just the clock=
 parts
> >> send as an independent version so that you can easier apply the patche=
s to your
> >> tree?
> >>
> >> Patch 2, 5, 6 and 7 should go through my tree.
> >> So do you want a series with patches 1, 3 and 4?
> >>
> >> Regards,
> >> Matthias
> >=20
> > Yup, I've got a little bit confused, too.
> > Should I separate and resend these patches into 2 patch sets?
> > The 1st patch set includes #1, #3, and #4?
> > And the other includes #2, #5, #6, and #7?
> >=20
>=20
> Yes please do so. I think that's what Stephen referred to.
>=20

If those are the ones that aren't dts or defconfig patches sounds good
to me.
