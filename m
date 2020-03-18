Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E36C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A120772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584571128;
	bh=cj77KJI2g3gNsfOIkifrEx2FO9HePVuMfCHiT2A3g4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oj4AUdjba7eghsVM37PsU11o5ZjvcuHC0eShBkVMsucF/j53s6unPg9m7FYZgltS8
	 QdzsXCkfoN0Ei2ZW2jFkx+x+gzgAm30XyTlqm3ipua8Y8enEQy5eqABKqy+9DR/WeA
	 6uPCU92XrwW7fUEzHWtYay1TO545qFkHIspdBWiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCRWiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:38:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35102 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCRWiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:38:46 -0400
Received: by mail-io1-f66.google.com with SMTP id h8so276270iob.2;
        Wed, 18 Mar 2020 15:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hjd4cWdqxb7vqLIGudSEI03tN+skbBZc4IaGVCWe4bE=;
        b=Zz2jKlW5sJ9GuCj0KoknSaW9kXeZXmeWitNKJ51/MjyeOlt2GrZTXwHaMpcXoQuniB
         6AhDT4GIah9N8/i9v5hALFgFBE2AiJPzTUf7UtgCTO0sA0lAj2hxF3UKk698ouYK528D
         QvmH2EuOhNhiki2vdMuqiJV1CIqVbcog1rbOL+tKZ8QiWw1Wx7nIipbovu3bNyOEuWY1
         VN2m0EFXLz+PTTDbyDcFZdT+d17nKdeOXE9bfOp4Th4KD9c8D+2wKnDH8bbr32jIQ66V
         mGwgon9KIfrhxOLzREytWyooMFX9RSjrllajzTjV3h+Pa59PsZ1uhPfx0GUrcWke55/B
         3zrA==
X-Gm-Message-State: ANhLgQ36v8ENLxxyevqHdsqEE5m3k+DHbcH9IrYvFozwJwvMO+TDZxjj
        UStz5B/Ic+wcrPjkY0GV9w==
X-Google-Smtp-Source: ADFU+vuWOZ5C5oLxE9dB/U/jglteCOUaH90nZHmvZdWYJLWdri0o66f9VabHUrjNFihG7WzqU2uzrA==
X-Received: by 2002:a5d:958f:: with SMTP id a15mr70087ioo.170.1584571125436;
        Wed, 18 Mar 2020 15:38:45 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h29sm96397ili.19.2020.03.18.15.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:38:44 -0700 (PDT)
Received: (nullmailer pid 31930 invoked by uid 1000);
        Wed, 18 Mar 2020 22:38:42 -0000
Date:   Wed, 18 Mar 2020 16:38:42 -0600
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
Subject: Re: [PATCH v3 1/6] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
Message-ID: <20200318223842.GA31707@bogus>
References: <1584454007-2115-1-git-send-email-hanks.chen@mediatek.com>
 <1584454007-2115-2-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584454007-2115-2-git-send-email-hanks.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 22:06:42 +0800, Hanks Chen wrote:
> From: Andy Teng <andy.teng@mediatek.com>
> 
> Add devicetree bindings for MediaTek MT6779 pinctrl driver.
> 
> Change-Id: I92586369564948f2628f70421bcd70668f132c4f
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> ---
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |  208 ++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml:  while parsing a block collection
  in "<unicode string>", line 28, column 5
did not find expected '-' indicator
  in "<unicode string>", line 29, column 5
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dts] Error 1
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1256429
Please check and re-submit.
