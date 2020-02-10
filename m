Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF3C47409
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005C92070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcoSNlc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBJVfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:35:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45027 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBJVfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:35:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so3334313plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pgc2HVuzTlOApbzWYuf2GztwyECo8PvV+6g1YsZKtqs=;
        b=FcoSNlc8G46a88gf7LS2JXGZXa8BZmfldccNMAMTh3HMkmZOR4Y8ND7XRhLaQj5h0I
         WZqK/wAnvKP6Y48qAfNScuBN+HWy/nLxY+XY+oabNXOWTfDqZ7Xevxd5K+s+7wr5es1C
         U41MhQ+QE9oECxJt6BnWNJNQEvJlsFTjNqClM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pgc2HVuzTlOApbzWYuf2GztwyECo8PvV+6g1YsZKtqs=;
        b=f8mD3pe1xpVc8Dqq8KdT53uzPyBywiCEaKG8bew0J4rODweKypkl2ASRBrgO6Fgubb
         nWXmZMhFgvw80U/P4SwO+sdH2OVMWrkwaJn3SY1ufjaSFC9VJL0UDP1y1zySt2GYNoOE
         j8sqcP/CrL+v5BpD3/BdA3xCXoR6VRV3UhFnJhyY8cmcomKIVzrc/wUnkA1y1jujQsM9
         j0oc5CwRTKEEwGLlE5IpUea/ZiImFuBjcL6sKkPBrcMoMt3gtvjNQzI6vyt1UmTC2Z51
         Gr9/41AAckXagVku/sytLbmTL44vNvEHfESe6tYTw23JdXQjwO6sv8/1VzPkwvw9wcDW
         yUGw==
X-Gm-Message-State: APjAAAVE+qqbFy8/Ae7K4R0ShfBXHKKKGrJgaVpfyv/GteEYCzOj+eLS
        8NjYHmsiEucGZP27mfhX4FgG9A==
X-Google-Smtp-Source: APXvYqzWAJ6Ldly+R57YNfK4lMRkzu3aoVy8A/bfws1EkVQVTJVWLD4vAGFwyFhESIze/ueYbw7EZw==
X-Received: by 2002:a17:902:6184:: with SMTP id u4mr15038014plj.198.1581370523419;
        Mon, 10 Feb 2020 13:35:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p18sm622130pjo.3.2020.02.10.13.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 13:35:22 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:35:21 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Add QMP V3 USB3 PHY support for SC7180
Message-ID: <20200210213521.GD18972@google.com>
References: <1578486581-7540-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1578486581-7540-1-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

this series has outstanding comments, do you plan to respin it soon?

Thanks

Matthias

On Wed, Jan 08, 2020 at 05:59:38PM +0530, Sandeep Maheswaram wrote:
> Add QMP V3 USB3 PHY entries for SC7180 in phy driver and
> device tree bindings.
> 
> changes in v2:
> *Remove global phy reset in QMP phy.
> *Convert QMP phy bindings to yaml.
> 
> Sandeep Maheswaram (3):
>   phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180
>   arm64: dts: qcom: sc7180: Remove global phy reset in QMP phy
>   dt-bindings: phy: qcom,qmp: Convert QMP phy bindings to yaml
> 
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 201 ++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 227 ---------------------
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   5 +-
>  drivers/phy/qualcomm/phy-qcom-qmp.c                |  38 ++++
>  4 files changed, 241 insertions(+), 230 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
