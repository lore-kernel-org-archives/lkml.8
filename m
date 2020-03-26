Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA95C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360C212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585240124;
	bh=HyCcTeKZjpOHL4u7VdwAUC4Mmt1TEUG129zZgdDHfCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JCyMrUr1VAgySH8Wtd9jh/AorWiPn4w5+RyPkOiHVfiqBVxpxn/Qadi5vzAjI4aHl
	 bsihCGSwUhQgjTKbhF4UFuJ6uCl4jHPphcQ4Qxa6OF9FD8sgsGTSTQFRve5T9UV192
	 3Rf+Tzt9PHtof5j/Cz/s2WziqZpFtGnJtdlsS5Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgCZQ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:28:42 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45096 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:28:42 -0400
Received: by mail-il1-f194.google.com with SMTP id x16so5902881ilp.12;
        Thu, 26 Mar 2020 09:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bVlPuJGOkEhy8wUjtWWTKaIM8+WWF/4LOBG59hrlu0Q=;
        b=YHGmx2Z0aYlvGhVyrXmj+IG0+9n4VfZ3FuCiV8NydVIpIqlWUIDtPiSSEngYHRKuBN
         YX21b6DuEmqWcPebqyMREAQx8gfMPbK+nOi+mEXWJBKOlEx1CmMTXLQk3Yms5vE4whOz
         m4ALq9ItrGwFQH3vgNxZIUmvUgX139ExZt7LL8XnjYiLTSx+Q0Fzf3DjqmPAMr8/NNNY
         qMch2paBiEpnCSwYgHn6OTXWxi5xLgdBdx7SIpjrj3ZwK/YOtBYdfUbnFKkw1jdpqvYs
         VS+JQ9pS46ptMlHjPsnPVRgWFoXhUZsTDTzeTGHBKKpIdlhZ3SIBuvZ/U1iglSWblxc3
         atAA==
X-Gm-Message-State: ANhLgQ2olep/+ZekO9xuRHNSw8Ve9/D8sPCRfQZ459sFn6XQGCtbs7Kc
        6lbMMLlBUzzLFOLXGQehRQ==
X-Google-Smtp-Source: ADFU+vv9v63mvl8nbL3d+kPz17rDcePdFHGMay9b2YDWdFNR1yprO8F2JIv29ubqXRzM95IVux8Eig==
X-Received: by 2002:a92:8fcd:: with SMTP id r74mr9905848ilk.39.1585240118456;
        Thu, 26 Mar 2020 09:28:38 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o23sm972322ild.33.2020.03.26.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:28:36 -0700 (PDT)
Received: (nullmailer pid 2135 invoked by uid 1000);
        Thu, 26 Mar 2020 16:28:35 -0000
Date:   Thu, 26 Mar 2020 10:28:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v5 1/6] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
Message-ID: <20200326162835.GA1429@bogus>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
 <1585128694-13881-2-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585128694-13881-2-git-send-email-hanks.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 17:31:29 +0800, Hanks Chen wrote:
> From: Andy Teng <andy.teng@mediatek.com>
> 
> Add devicetree bindings for MediaTek MT6779 pinctrl driver.
> 
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> ---
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |  208 ++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dts:19:18: fatal error: dt-bindings/pinctrl/mt6779-pinfunc.h: No such file or directory
         #include <dt-bindings/pinctrl/mt6779-pinfunc.h>
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1261248

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
