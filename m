Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15C4C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B632469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582822508;
	bh=8tFv7ty4at8VD8BqQBZUEu3FQT7FLqyU0DmDiNypens=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fgurW3KVxQ2O2UWBDRjcLwwE68fqK9rJJ/YJoDflruPEhj/VavrVucgS+bcsFXBLP
	 qaAsml89MTjhosEOK6BkA9HRegqWeHO75gdzeSE0kdP/ejAOgF5evlwffqPKwryQcw
	 ruKV4rhcPk4yR1um5j7BuxE0h7RYPiG86lANXCbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgB0QzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:55:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39518 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgB0QzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:55:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id x97so953835ota.6;
        Thu, 27 Feb 2020 08:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jM1fH5xptzMBpP8MrWjvM0f+YCk8pWFrR+DV7+cjhQ=;
        b=XTzRIPNFUxaHIaoL92Hc3GDM9cGlOmzyesQQZijsI8DE5JOrEmHHBEWEviwvt/utnZ
         bv3DPY6PQykFTNeW5Vb9dkQzfcUGRm6hNyUaWU3Eeg/FcQEiJX6+npguFVYHHEWzdXg2
         XDk25/OF+0btaSoIC+tQa/h8kM5o3LndfS29MM12S6yGmlKsJnImT6siEkrGcmUD6xiH
         aX7JbS4I/zFqp4sNxpVLVmf0/Om22tTMtoa/9j6rAM8cT7Ee5rviB5Kh46yAC9GB5bb/
         sTIWUnuZgpTR8cwSyAmaOd9X2fvneHln8IF/R12MZ3UY79hszT1sRHbrHfZ7LkGM8MHE
         oKDw==
X-Gm-Message-State: APjAAAWR66zURewIhDIHbP97Z88BtvpmX65Nl3spywoYDv2taboDzz2+
        pC5yd+Upu2if2H4kHvhckQ==
X-Google-Smtp-Source: APXvYqxUUYsXBRlfK0ElzZkJeLYyKOPBFssLLcfLZAR3mlJo/cftCdxWtn252vKiBhlDns37QVqKcg==
X-Received: by 2002:a05:6830:20c2:: with SMTP id z2mr527059otq.228.1582822506104;
        Thu, 27 Feb 2020 08:55:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k17sm2154899oic.45.2020.02.27.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:55:05 -0800 (PST)
Received: (nullmailer pid 19462 invoked by uid 1000);
        Thu, 27 Feb 2020 16:55:04 -0000
Date:   Thu, 27 Feb 2020 10:55:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     rentao.bupt@gmail.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com, Tao Ren <rentao.bupt@gmail.com>
Subject: Re: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200227165504.GA26955@bogus>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-8-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226230346.672-8-rentao.bupt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 15:03:46 -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add device tree binding documentation for aspeed usb-vhub driver.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  No change in v2/v3/v4:
>    - the patch is added to the patch series since v4.
> 
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub@1e6a0000: 'aspeed,vhub-downstream-ports' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub@1e6a0000: 'aspeed,vhub-generic-endpoints' is a required property

See https://patchwork.ozlabs.org/patch/1245388
Please check and re-submit.
