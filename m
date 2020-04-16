Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87ECC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A168421841
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587069949;
	bh=yO3atKf6wvfWgm+UsqQ3nafLr0brm1A+2/kreqKzl6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=My0+hA2CoAOKnQDxy2bl+Ps4x0sOcGV0fC70fEbrs7+8XBWY/yDIEPGeOgIekKoH/
	 z7mjg8RRjBRp+FfLi6zQhkTR+yy3QlVxwV7VO3PbQm3F3xITiLN0On8gH+4l09Gsnb
	 FwII5iGnt7Dd68FOVBqPInQO98N+MECXMnttfkSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgDPUpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:45:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43152 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgDPUpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:45:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id g14so4233531otg.10;
        Thu, 16 Apr 2020 13:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNp2FEE1PLVvPcRli4Kxfk/uC3bIO5nhdJmFaCVvZ8Y=;
        b=i1YjojYHHnAIATVcPzzcwz+2X/tQwCqulyG8vDqYH3apIB0pI8iXEKuPqH/zmfNrZ5
         54s7LrkzkVU68EnbNAAw29RZ0JcOfEyQMyNfrLuOB7lP4XNWOxnStBV/Fbr8EXad+JLD
         PX/BrFnE0iDNT+JHMLKV7J+VnoRBwXdWyrCHd0SAtWYjQUnpnVSM6PU6QTjwBnRUc3RE
         b90OC9ZcLWup61RkOe61+nj2+mdOO4xEHZlULMoOgar2Cy+F+oEFOoCO/wRU9hxHoyAs
         RO+M3ob0e1IkmU8rIDg2AxH98gWJz08HydHw1S+4OzFxGi76JA7xBg1SQpbwF5Dz87Uv
         YTLA==
X-Gm-Message-State: AGi0Pub0G0jeYFdfOvdmOPQo34pfbXhKEFoO2ajl+nKkdLnp/B05d9wB
        I4SdGjbGia9YDIiYFqX14Q==
X-Google-Smtp-Source: APiQypK5AKz1ujNN52aZa37611roc3sbyihjxaYggNSCUvmDTZoTUNxSsPeEJfql3QtvsIAeOCVY9A==
X-Received: by 2002:a05:6830:1599:: with SMTP id i25mr2759otr.188.1587069947265;
        Thu, 16 Apr 2020 13:45:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f45sm7402999otf.30.2020.04.16.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:45:46 -0700 (PDT)
Received: (nullmailer pid 19615 invoked by uid 1000);
        Thu, 16 Apr 2020 20:45:45 -0000
Date:   Thu, 16 Apr 2020 15:45:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anthony Huang <anthony.huang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Anthony Huang <anthony.huang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: Add document for mmdvfs
 driver
Message-ID: <20200416204545.GA19079@bogus>
References: <1586949506-22990-1-git-send-email-anthony.huang@mediatek.com>
 <1586949506-22990-2-git-send-email-anthony.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586949506-22990-2-git-send-email-anthony.huang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 19:18:25 +0800, Anthony Huang wrote:
> This document describes the properties what mtk mmdvfs
> device node support.
> 
> Signed-off-by: Anthony Huang <anthony.huang@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mmdvfs.yaml   |  198 ++++++++++++++++++++
>  1 file changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mmdvfs.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.example.dt.yaml: example-0: opp-table-mm: {'compatible': ['operating-points-v2'], 'phandle': [[1]], 'opp-0': {'opp-hz': [[315000000]], 'opp-microvolt': [[650000]]}, 'opp-1': {'opp-hz': [[450000000]], 'opp-microvolt': [[725000]]}, 'opp-2': {'opp-hz': [[606000000]], 'opp-microvolt': [[825000]]}} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.example.dt.yaml: example-0: opp-table-mm: {'compatible': ['operating-points-v2'], 'phandle': [[1]], 'opp-0': {'opp-hz': [[315000000]], 'opp-microvolt': [[650000]]}, 'opp-1': {'opp-hz': [[450000000]], 'opp-microvolt': [[725000]]}, 'opp-2': {'opp-hz': [[606000000]], 'opp-microvolt': [[825000]]}} is not of type 'array'

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.example.dt.yaml: mmdvfs: 'clock' is a required property

See https://patchwork.ozlabs.org/patch/1271100

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
