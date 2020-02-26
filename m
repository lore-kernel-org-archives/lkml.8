Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443DC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56C420838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582730330;
	bh=ho9k8ZDhdOZKx8aFmHPYKjqYTIjb/zWyKhJROGtz4AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J5MWqoim/kb1InahXsQKoZ+9xNzkLkNsioxQ+8fAZM0ZoBoWpYfdGGWhPPsxG6atE
	 sNsVxtFm20i8c8fLbwaXqs+hl4QFVqoSz0K0eJS9LyrGx/kseO1TnwT9Y76obfRsPP
	 92Lj4gbQSePVmwKWICg/iDCdFNBsdhHvwP0HVYeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBZPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:18:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47044 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBZPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:18:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so3212118otb.13;
        Wed, 26 Feb 2020 07:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/6qDOCrFaT70GMrXC62oODapAv06LXpjcPH50sFJvcw=;
        b=fK9FDL30qD6FYpOIj90QZqGrY61nBCYkEHjqRqtOE1mhhJqHuSCP91u3REC6zrzlPo
         e6VcOv/VRCwCafMYNYhF+oPGJitoziq5eHa1Mi8K9WYJ8zHpz3CzvOWVyRivruIsK/xH
         u3adX+qGFehXp72Evy6wsEcYIiBpXNoWcwetRqrxTLel4/UmwtCOo9AU1ZB+hqkI0/rl
         EDMVEU7iND1kL7pUF0b+CBaOypDU4hRJLsGGw0HKeVd2ugRtGmu/eS36eLNL8NYepMMA
         /WIpOPBOj8Hj7g2vLMmQQET234waDHGa6s0S2n5nI9Kv0T+2Z2rMDqD/R4bOVWWoLcl/
         mW9A==
X-Gm-Message-State: APjAAAXPk+1ipkTji+a6CSp3U9vnNgu/rsIFOutaNrDRgKeamuYzBdVM
        ZoCO0Sm4LdhbUXDhmQf14Q==
X-Google-Smtp-Source: APXvYqxBufLVc2f4vqiKPF5cMNUCr0xqWnYB6+zcMOrJYU0lwVw8DbBaOxQKyHF5SXgHCNdsMk2NOg==
X-Received: by 2002:a9d:638a:: with SMTP id w10mr3650110otk.130.1582730328475;
        Wed, 26 Feb 2020 07:18:48 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m68sm886194oig.50.2020.02.26.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:18:47 -0800 (PST)
Received: (nullmailer pid 22097 invoked by uid 1000);
        Wed, 26 Feb 2020 15:18:47 -0000
Date:   Wed, 26 Feb 2020 09:18:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: Re: [PATCH v1 1/3] dt-binding: gce: remove atomic_exec in mboxes
 property
Message-ID: <20200226151847.GA22046@bogus>
References: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
 <20200217090532.16019-2-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217090532.16019-2-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 17:05:30 +0800, Bibby Hsieh wrote:
> There is not any client driver using this feature now,
> so remove it from binding.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
