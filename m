Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF5EC43332
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F015620752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VOGW/Dj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCRV3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:29:18 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51365 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:29:17 -0400
Received: by mail-pj1-f66.google.com with SMTP id hg10so8253pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vPxunhAC+58vvctmoFp0mN4mjw3S+0eezQoOCor4cGs=;
        b=VOGW/Dj8fGjI99TmvzepftNCpO4/MF0xNVIWEVCFGM5msDgWmk9GbdMjLQF38bAiXe
         5gagPr9toHAfEAsPQwMfnuXDZQf7H3CatTnOsFNOsCOhbmACF/ZMzZCRZSSciBpOPJSC
         Q7K91OtcK/hEVFs79ZF4SKleT6de5W7BC03o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vPxunhAC+58vvctmoFp0mN4mjw3S+0eezQoOCor4cGs=;
        b=cDBwlL2el3ub6C01EIaa6MAnGwZtuaSlkKtfrwxRTg478M7zPIM3LDfrzrBSQhovyo
         CXwc83ak/2IVLvfpDH2dZ2YOlc5wMy2FXliCvErzACV973lsPifQFdSctYn76LrH0Yad
         5m4rU8FQXDhTmXWc4fQXXY5jRkAW/lZUN4CSnq8DmQYI+aWqBXPZEU++IVVYg528/20r
         iafmKBs0U/yYBVI17+NPmROEB2KIeF+otbFSrTLN/QZNYpbCCB71qRI+6/3jcGhhs4Um
         PP3cpwHWuwFIQwYyBBDO74EFllNNZpLJ0PAqDBFxeu8LoBILuG9hyE/sAiBqL8u8wcYI
         S3+g==
X-Gm-Message-State: ANhLgQ3TagcY8uAANInvGoge/JgE6zHcTSTBNPpRKxbgIYd5TXyFrd/Q
        uAZiw3Wn7ANWQ6DpRqc6vvby6AN3to8=
X-Google-Smtp-Source: ADFU+vuNwz5zB7ybsEb07TyGdEuZebQPsPh4F6LxTKWUK7RBgfUFTMHmwsHSGC2pOB6twp7ci+pDew==
X-Received: by 2002:a17:902:aa98:: with SMTP id d24mr221832plr.74.1584566955402;
        Wed, 18 Mar 2020 14:29:15 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w6sm9144pfw.55.2020.03.18.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:29:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584505758-21037-2-git-send-email-mkshah@codeaurora.org>
References: <1584505758-21037-1-git-send-email-mkshah@codeaurora.org> <1584505758-21037-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: Introduce SoC sleep stats bindings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Wed, 18 Mar 2020 14:29:13 -0700
Message-ID: <158456695397.152100.7669140417826227943@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-03-17 21:29:15)
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>=20
> Add device binding documentation for Qualcomm Technologies, Inc. (QTI)
> SoC sleep stats driver. The driver is used for displaying SoC sleep
> statistic maintained by Always On Processor or Resource Power Manager.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Two nits below.

> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.y=
aml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> new file mode 100644
> index 0000000..d0c751d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> @@ -0,0 +1,46 @@
[...]
> +
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    rpmh-sleep-stats@c3f0000 {

I would think 'memory' would be a more appropriate node name, but OK.

> +      compatible =3D "qcom,rpmh-sleep-stats";
> +      reg =3D <0 0xc3f0000 0 0x400>;

Please add a leading 0 to the address to pad it out to 8 digits.

> +    };
