Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07210C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6504206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584039760;
	bh=eYzh45zilCzLug6sFmSKwmAuydhCaoGaxJyNW6ck37Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BD9i6cdErKqfx++l5wsDlOnDANy1gm92JyOMkafigbFCEFMu4wBjcn7QsIBaKLPdY
	 B8DY3dRYcjGSdaN2zwXUrvbnWeepK9sG+6UgqE8Q4qnklQ3zHs/CV9R9DuEGQP/VHW
	 BC9BTkG/qzSRtuMpz9XVjjiY/MNMYvFJdES3GvS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCLTCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:02:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42896 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:02:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so7437116otd.9;
        Thu, 12 Mar 2020 12:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qszn8t/TXMEw8klBhLWYzin7BjJynR0x9wt3vKldKkI=;
        b=oQjsSJZdx/5xWwRvf7guQ9XaBUYxVhOIdThOQGlmdvmz1uOmYGlwPc7p3+2VSCEU8a
         wLGqq3oTS2DL2xc8PwAbqJdLpTPoJ1vMAw6InEfAsxAwTlF2v7TXr1ekj7YqBcc5f+1H
         NeHsTgoPWhWT/1ODG2JYpEVMoXfBIQRSQ67rhUM3KMCAnulMIA2tw7iZ8+by7mhGPs3w
         l9MrAUpnQ1gyzkTYHOPwoNlErHrQr3CpNToKVb3qQ/8UxsxbhlwuBmFOFtiEUtCTwRRa
         D8T+eixENC6mkjtBsK1n1Ns5GNuSbrOssdM5UIb86IhFUoG8CQ8rXS1RRCt360fR0BiH
         Dxew==
X-Gm-Message-State: ANhLgQ24A5NQEa4cselaOPtybvIum8n2mpWsPeGSrHBdfKKUt68YcpAc
        4gbgb70MGbtiPthQFGVs1A==
X-Google-Smtp-Source: ADFU+vtDTbuZErAslJQLMpArXJZf6snkXd794nOxeCf/BKZvRnoCio76FeXOXlwzNhrd+bsC58+mfw==
X-Received: by 2002:a05:6830:18c2:: with SMTP id v2mr7729860ote.350.1584039758461;
        Thu, 12 Mar 2020 12:02:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e4sm8462394otb.23.2020.03.12.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:02:37 -0700 (PDT)
Received: (nullmailer pid 26970 invoked by uid 1000);
        Thu, 12 Mar 2020 19:02:36 -0000
Date:   Thu, 12 Mar 2020 14:02:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     devicetree@vger.kernel.org, bleung@chromium.org,
        swboyd@chromium.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com,
        Prashant Malani <pmalani@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] dt-bindings: Convert usb-connector to YAML format.
Message-ID: <20200312190236.GA26911@bogus>
References: <20200305222732.133047-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305222732.133047-1-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Mar 2020 14:27:28 -0800, Prashant Malani wrote:
> Convert the usb-connector.txt bindings file to YAML format. This allows
> it to be used in dt_bindings_check verification. This patch was
> born out of a patch series for the addition of a Type C connector
> class port driver[1].
> 
> An attempt has been made to maintain the same documentation text and
> example structure as was in the .txt file, but wherever needed
> modifications have been made to satisfy dt_bindings_check.
> 
> Also, update all references to usb-connector.txt to now use
> usb-connector.yaml.
> 
> [1]: https://lkml.org/lkml/2020/2/19/1232
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v3:
> - Updated maintainer list.
> - Fixed grammatical errors in descriptions.
> - Reworded "type" description based on review comments.
> - Added more info to OF graph binding for port@2.
> - Removed address from DT nodes in examples.
> 
> Changes in v2:
> - Added type references for some properties.
> - Removed pinctrl properties.
> - Updated power-role, try-power-role and data-role properties to be in
>   valid schema format.
> - Added OF graph data bus binding property according to reviewer
>   suggestions.
> 
>  .../connector/samsung,usb-connector-11pin.txt |   2 +-
>  .../bindings/connector/usb-connector.txt      | 135 ------------
>  .../bindings/connector/usb-connector.yaml     | 206 ++++++++++++++++++
>  .../devicetree/bindings/usb/fcs,fusb302.txt   |   2 +-
>  .../devicetree/bindings/usb/generic.txt       |   2 +-
>  .../devicetree/bindings/usb/mediatek,mtu3.txt |   2 +-
>  .../devicetree/bindings/usb/mediatek,musb.txt |   2 +-
>  .../bindings/usb/richtek,rt1711h.txt          |   2 +-
>  .../devicetree/bindings/usb/ti,hd3ss3220.txt  |   2 +-
>  .../devicetree/bindings/usb/typec-tcpci.txt   |   2 +-
>  .../devicetree/bindings/usb/usb-conn-gpio.txt |   4 +-
>  11 files changed, 216 insertions(+), 145 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.yaml
> 

Applied, thanks.

Rob
