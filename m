Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DBAC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FDB2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582058394;
	bh=1M7sJyKek2vzcD+WMBztTe3Vke3hE8g33/8xU4GekOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwXkVpNEVLhDk6q4SMxSjqlMvHg+mSPdOy601LDmPkoeAKnj0skW30KIqYDRd5Cua
	 8Q1mbIFE5GVY453eCm0XUnKQ1FOMiuq0w1W498HPXr2vhBEIY+rOJARk9+gQa1DB4g
	 Lvxrys89DUlI88RBjUV3tPfXryipqkgTm9bpl/M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBRUjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:39:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41520 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:39:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so20852454otc.8;
        Tue, 18 Feb 2020 12:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C8j0O76ayqbfqE0bVu8zQXNeOaxgxzZC+4WywF7J+iw=;
        b=WloVHiBsfD/pptWSgH0gzkPztMIEUfHpyFJaQEM/4z5HB4tKR4QXpnESbtGGwn+Y/B
         BzwqI8OwTeWwOGCOCoYiDiDpasjPLFwdcIMBsrh4tTRe/cwuvvN+2xYr2gG6Jz9s3LL5
         jNJAY4siQikOD+fHAaKblz7zNco5FOfnblcMuynJsEVpB79YV11UplKkJSI4h5Fr37ca
         ntSY/sh7J0sdQjMXB8tOva4XT2u3WsF31ch09KdVys/kW1CMC3/zBc/wvQDulu4SBqMf
         EwXJcaFKyCeK2NzdHQMSW4iwVtHf0Qjaf7Tmp5gxehHHhZBJUabKQzLLzkvcsrPkVSdw
         EEiQ==
X-Gm-Message-State: APjAAAWyjdbCYUOTIfaC8UCbxIxjuih+kOD5N1RfBCP7vE2ANs+yQtUu
        nbinY6FEFzKpNZNv2nNTZw==
X-Google-Smtp-Source: APXvYqyH1p5MWdMBardwNwTmNs1F6hhPi3TUJe8KGhFk/oPzVltIMKXI9kg6VgPOTDZoEaMQDFRXnA==
X-Received: by 2002:a9d:116:: with SMTP id 22mr16069633otu.149.1582058390424;
        Tue, 18 Feb 2020 12:39:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w197sm446590oia.12.2020.02.18.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:39:49 -0800 (PST)
Received: (nullmailer pid 31148 invoked by uid 1000);
        Tue, 18 Feb 2020 20:39:48 -0000
Date:   Tue, 18 Feb 2020 14:39:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH v7 1/7] dt-bindings: clock: mediatek: document clk
 bindings for Mediatek MT6765 SoC
Message-ID: <20200218203948.GA28003@bogus>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
 <1581067250-12744-2-git-send-email-macpaul.lin@mediatek.com>
 <d606aeb2-5327-ff13-0043-e70ef37522f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d606aeb2-5327-ff13-0043-e70ef37522f5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:47:25PM +0100, Matthias Brugger wrote:
> 
> 
> On 07/02/2020 10:20, Macpaul Lin wrote:
> > From: Mars Cheng <mars.cheng@mediatek.com>
> > 
> > This patch adds the binding documentation for apmixedsys, audsys, camsys,
> > imgsys, infracfg, mipi0a, topckgen, vcodecsys
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > ---
> >  .../arm/mediatek/mediatek,apmixedsys.txt      |  1 +
> >  .../bindings/arm/mediatek/mediatek,audsys.txt |  1 +
> >  .../bindings/arm/mediatek/mediatek,camsys.txt |  1 +
> >  .../bindings/arm/mediatek/mediatek,imgsys.txt |  1 +
> >  .../arm/mediatek/mediatek,infracfg.txt        |  1 +
> >  .../bindings/arm/mediatek/mediatek,mipi0a.txt | 28 +++++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,mmsys.txt  |  1 +
> >  .../arm/mediatek/mediatek,pericfg.txt         |  1 +
> >  .../arm/mediatek/mediatek,topckgen.txt        |  1 +
> >  .../arm/mediatek/mediatek,vcodecsys.txt       | 27 ++++++++++++++++++
> 
> I think it's OK to put all the bindings, that only add one compatible in onw
> patch. But I think mipi0a and vcodesys should each go into a separate patch, as
> we will need a Ack by Rob for that.

Yes, and DT schema for the new ones.

Rob
