Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC90C4BA28
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6AD21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582748118;
	bh=3tFcTe88lQOibSndfvHEW4Wvwzw8xZeBYiYlQD4TChg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tu/n/Acbtdv4LKyqFOJgEUdPjPOPsV9BWmaNN7tnVQa0RBL5KIxnFPUgwS/92+4r3
	 qbl5tXZgPha8gAS6ek9MVYtnnqTj/K4TRr2ijq2ddiEpS7gyM7+AKpCC36RKIj9cEP
	 77366geeDZaP+9/pX675c85pVwopl0aamcl6ZA+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBZUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:15:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43093 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgBZUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:15:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so822244oif.10;
        Wed, 26 Feb 2020 12:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQF8x8EL9Iw62X5whExL3LnIV7r+UiOPvcN0XmWfobM=;
        b=SdiyfnWfB42nt5Cc2SGnMVoyoFzNMfwNWpeIjHprCc8B4JCr5w3G9/x2HEtsarOULp
         jfjyIE4dgvS3jY9xbNC1hFy4AUgn0Qhh4B1EpmVLmQBDWJomBbAIBskGDahoCyD5ocxi
         mIo6/CHJqv6wrAxEU4QwvMYblWYyzk6NugqSITRXmMMk2ZI6zX+F+ntGyGEMD9UuGr4t
         PUEdN5Ez3bOrUetGSXgD/zg3/KDoORoaPaDIJtshwOvmYZUjt45n1URxY5B0Pg84HkZz
         kLV1o07e7bdX8hzs4c+rYvGW3J9t2n18rqA6NyUpEJxI7Av+K3qddVKfwTL24REIsKub
         PUsQ==
X-Gm-Message-State: APjAAAU0FV/ZfG/bzIRVok0KS4jB/rITjdbL5PKJz9Z4a0KWENFYr7Ym
        WF+QxBg9SdDYnenke8HcEg==
X-Google-Smtp-Source: APXvYqzsmy77xTW6N6DsWtgxWAfgoYTUvEH+Ph/SNmuOR8ic4AabsTV0RsAJBzgOMNn/hLeBuz46Eg==
X-Received: by 2002:a54:4e8d:: with SMTP id c13mr594836oiy.27.1582748115485;
        Wed, 26 Feb 2020 12:15:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t22sm1149383otq.18.2020.02.26.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:15:14 -0800 (PST)
Received: (nullmailer pid 18502 invoked by uid 1000);
        Wed, 26 Feb 2020 20:15:14 -0000
Date:   Wed, 26 Feb 2020 14:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: clock: mediatek: document clk bindings
 for Mediatek MT6765 SoC
Message-ID: <20200226201514.GA18452@bogus>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
 <1582278742-1626-2-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582278742-1626-2-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 17:52:18 +0800, Macpaul Lin wrote:
> This patch adds the binding documentation for apmixedsys, audsys, camsys,
> imgsys, infracfg, mmsys, pericfg, topckgen
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt     | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,audsys.txt         | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,camsys.txt         | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,imgsys.txt         | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,infracfg.txt       | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,pericfg.txt        | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,topckgen.txt       | 1 +
>  8 files changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
