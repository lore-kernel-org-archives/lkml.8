Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735B9C3F2D8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC1024677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583192320;
	bh=GmVpdDvSvGwaC9UlxJmyj/gbr9qRgxuQNKKE80vKQAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1iODfG02VI8zMUIKS2n+m70kTrzRn29BVbLUaUCNhTH5SzeajtB1LQgEvjvSPmCI2
	 mQFv3YquqwDgGNnI4gvC+S6PvpCogDFXWnF/ALFPC9J60con1FCVTMOGIAozFHO8VB
	 LEeVTwQNTvuvTPD6qqogtBqkmBQYCwmdM0bXNOOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCBXij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:38:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45576 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:38:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so1068273oic.12;
        Mon, 02 Mar 2020 15:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8XhrBfpdeYVeW1pNRFkev10cOhTus7KbN5tnNyTByWU=;
        b=kaYlC3NAYG5vZKwNeHhnLMykGmN1KYlUQFTxOMzTq8tbZUNda4SAL1Wpa9rHLsKLne
         z78fHQiP6+fLQJtTudUHvKe4GStVL27dEGfjhl7U6HPUFt2qoGLgfWUZZLKS1dpM4alx
         L3MxtZLhEpw5LVApaMf1nEgCGUO7v+EuvX9xQQodKOz8N/cHvqKiEyOs/qgRj72FSdi9
         Ow6xDeaMbNfVsQqetLTKb9qWYGuMC4zDG1mGHEikHtYRBtTuJwXe0PsphNSWuHfd+aas
         jTtyEmuvDFqSpVC/6MRsexyZf4LfGLi5QKJPLdPgUX50dp+1ZfMyNldS5WUG88Io8r0H
         EFag==
X-Gm-Message-State: ANhLgQ2wBwKDvXkcmOjCckf5nmelI57ahJDGbBJ5KLDgKxE5JGPgSrnO
        KvfDsMwBypPUzTJJYJ+Mjw==
X-Google-Smtp-Source: ADFU+vuhlOl6on/xI93yhKRinPGhkp/CPia34CJHv4KuiNms9QQzJ4jdxXzYrkiqTRtqOQIlBZ9/wA==
X-Received: by 2002:a05:6808:64e:: with SMTP id z14mr582889oih.79.1583192318164;
        Mon, 02 Mar 2020 15:38:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm3156087oiw.43.2020.03.02.15.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:38:37 -0800 (PST)
Received: (nullmailer pid 17952 invoked by uid 1000);
        Mon, 02 Mar 2020 23:38:36 -0000
Date:   Mon, 2 Mar 2020 17:38:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com
Subject: Re: [PATCH v11 2/6] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
Message-ID: <20200302233836.GB5639@bogus>
References: <20200228081441.88179-1-jitao.shi@mediatek.com>
 <20200228081441.88179-3-jitao.shi@mediatek.com>
 <20200302232903.GA4460@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302232903.GA4460@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:29:03PM -0600, Rob Herring wrote:
> On Fri, 28 Feb 2020 16:14:37 +0800, Jitao Shi wrote:
> > Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. Set
> > the dpi pins to gpio mode and output-low to avoid leakage current when dpi
> > disabled.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt  | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Sorry, not Acked. Wrong patch. On this one, please address my comments 
on v9.
