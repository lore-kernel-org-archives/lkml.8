Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E9FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F0220738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGb3OAA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgH0I2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgH0I2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:28:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB42C061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:28:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so5429924ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0v2ljzAsS/Xt/cCoXDfRSkq8ULfQZGldE7AEfFXvCjs=;
        b=aGb3OAA9CcMElaoxNxXqL502T3CzkOt/Emegbls6A1q3+vz8iFJYTVWQ1I0MCSHoen
         FAwR3s782EZtnWWA11bKcdJ4Nw1PaqALzNgJNViMSdPjeIKiB+Rh6AV8YZQZqTdJHD3I
         ne8iSox3RFG2m/ks2Qqf8MD/pkaW8YHcY9/dFycMhmEeGR+h5kyUaDiYzXrXa88c4aKn
         LSBOi0C9xzg5xE08iId/LiSJmEjqYy5936QZf9L4IqWdBLrmX6ha3SOcdx5BpWMXPJC5
         Ht/WFvAHKTSargOBhkp6f/T2RdgG2PLnE+/9bwhd7w1gqtzqwsUf2Ueuo8FkYOx5AOIZ
         FEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v2ljzAsS/Xt/cCoXDfRSkq8ULfQZGldE7AEfFXvCjs=;
        b=B+HRPGDNH3eU584RPOAbN/hXU5oPnZW22tXbMl83wY14FCpQ6fLKIJJcj7H149L+KR
         zonD6QPRAWSXoSTklM6XD+8T80gWTFTVBES1sVbPlhLNrFnGOyAIfh3IBohkxV9CplDC
         H8612LC8kEPJiyXPRr0J7AhwRe71VYT/yS9pUj0rFu5VEncCkOOzHLxd0Z/Ybd8De3WY
         HMpAu/OYlR/3mbTYzlWjb71G0acEkPsoDaw8WIiFdJHVzLHedvxmXMmu7qjacMPN6Qtl
         fAlR2bYrspPHglGzEHCX+uhiSvTPV7yxXG9sVPwYUD1JF1MgibnvUoueWVKx59nc9+ZA
         01kg==
X-Gm-Message-State: AOAM533r+T01Dmp2NWiDJUpLwChlLLD1SGHLudAiEscfl2oq2U4AW/fE
        C1Pnn8fdtwHXqUhQTytx4fFlAVqKpQ2WZ8kv2/Q+TQ==
X-Google-Smtp-Source: ABdhPJySYjCmw8sP+FL4orhUpQLDoKe3n6IZoSSGVjYtA1A+pVw5tpNelFvp4lYWQi3L48xAg5EJevvcWh5wGXaVZXQ=
X-Received: by 2002:a2e:6a17:: with SMTP id f23mr8349136ljc.338.1598516893837;
 Thu, 27 Aug 2020 01:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200716205530.22910-1-bartosz.dudziak@snejp.pl>
In-Reply-To: <20200716205530.22910-1-bartosz.dudziak@snejp.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Aug 2020 10:28:02 +0200
Message-ID: <CACRpkdY7GgKGvsZtL-Wc4vRbN7pTAoXSAgym31QM8bJvxNkn_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Qualcomm MSM8226 TLMM binding and driver
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:29 PM Bartosz Dudziak
<bartosz.dudziak@snejp.pl> wrote:

> Binding and driver for the Qualcomm MSM8226 TLMM pinctrl block
>
> Changes in v2:
>  - Changed node name pattern to '-pins$' in qcom,msm8226-pinctrl.yaml binding
>  - Expanded example in yaml binding with a 'serial-pins' node sample

No comments on this for a month and uncontroversial so patches
applied!

Yours,
Lnus Walleij
