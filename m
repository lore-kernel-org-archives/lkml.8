Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79424206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oJhNIxjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCES5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:57:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51948 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCES5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:57:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id l8so2866867pjy.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E18amESejxX3SO9T1u/Ey86tZ4T9qm09N4I6qlp3t+E=;
        b=oJhNIxjkqCp00rgv7+T6qNzQ1Y4wBZqD21uHULGW2pzerjXJTGGcIWh06lvbzlHq8S
         kM8h76cFQ5LOb1x4kFLSSW2u9+2r2RmdwbDxzS3i/LkqfbRYwGgLDNGSv8KbB44Dxc1A
         Q7reKw2bg/dUDV8mjQ7bFCfGy+E3do9yOjAA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E18amESejxX3SO9T1u/Ey86tZ4T9qm09N4I6qlp3t+E=;
        b=ZgueKA86sV95AZve4qfG5h8VFLOSs42ToWFCM8LWTu6qgnVPzOZXPv3r8YwpPUI6on
         2Io2qIGGB0ZnNqdiPK4yvDqikamPIWdt4aVoswlTVCs2q3xZQ/zk7pOZ4dNCXFgVOqTd
         r78MLinW9BXuZaaK/WdKL/Lrv51TKgzbFRKCSuwwiY0A/8R4UPD08pUFKuqbKD/FSKuk
         +GBYDJ90w+d1hkwUqY2j0aOQZj9X2K7zh+gLb6KThAsTKLYI5oxppspxCgh2GSZixvbe
         VZYzWabTikwLxCSqABN5TiJQS9nIAizujZfM1C+W8m4odHU6mc0raiHzJC9rwTq1+aXK
         nGBg==
X-Gm-Message-State: ANhLgQ2iKgDypVKyLHRRXpco8UAP/S5qSyEzSemKprYT9i7iCSAASNTJ
        sfv0muRJVGz1+U/McRUHcm96Hg==
X-Google-Smtp-Source: ADFU+vv289MpugXlGsG6o7w2uERW2NVWNqrzvR82E0YfS1myAamsIGSEDKT1hLNOBGj6yz67f8OzdA==
X-Received: by 2002:a17:902:76c8:: with SMTP id j8mr9175038plt.273.1583434630838;
        Thu, 05 Mar 2020 10:57:10 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id r198sm35307970pfr.54.2020.03.05.10.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 10:57:09 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:57:08 -0800
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
Subject: Re: [PATCH v3 0/4] Add QMP V3 USB3 PHY support for SC7180
Message-ID: <20200305185708.GU24720@google.com>
References: <1581506488-26881-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581506488-26881-1-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

this series has a few minor outstanding comments that prevent it from
landing. Do you plan to respin it soon?

Thanks

Matthias

On Wed, Feb 12, 2020 at 04:51:24PM +0530, Sandeep Maheswaram wrote:
> Add QMP V3 USB3 PHY entries for SC7180 in phy driver and
> device tree bindings.
> 
> changes in v3:
> *Addressed Rob's comments in yaml file.
> *Sepearated the SC7180 support in yaml patch.
> *corrected the phy reset entries in device tree.
> 
> changes in v2:
> *Remove global phy reset in QMP phy.
> *Convert QMP phy bindings to yaml.
> 
> Sandeep Maheswaram (4):
>   dt-bindings: phy: qcom,qmp: Convert QMP phy bindings to yaml
>   dt-bindings: phy: qcom,qmp: Add support for SC7180
>   phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180
>   arm64: dts: qcom: sc7180: Correct qmp phy reset entries
> 
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 287 +++++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 227 ----------------
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +-
>  drivers/phy/qualcomm/phy-qcom-qmp.c                |  38 +++
>  4 files changed, 327 insertions(+), 229 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
