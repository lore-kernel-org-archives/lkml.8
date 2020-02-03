Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F322087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoUFZ7B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgBCSCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:02:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41829 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgBCSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:02:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id t14so6149242plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z4xw4BeflaOTebZuwoiVPM7Ym0RVfiYJ39j1NuVvqM=;
        b=KoUFZ7B+ZrJt1l8ZOQJoXPkMIL95ryAMqyfdGFP8KeWeeRp1lMU13TMLACrG0ChiL5
         plhUgDce0INjw957wBXRRQJ6OfeY5B8dQnK+0bZ2wABNsI9oU8WoscZYJ4OI8AogQB1X
         dQMQbWN7cAHjrt+ZZnQ8CsI9hXZ89Fd2GkiVmtq/GXRMBEw3ivkQyrWPHa2eu1JSbWPc
         v+g8XSCRbzHACgfW7M2fdOIDnX8jS8yB3Kh9pWAz1lgZXqBowMJyuWmYEW1OvWEOscCs
         DnBxP0ITR5Oxk0U74JhdG+KATDqnpLnVuLAiEBaRFPsXBWdwpAnIYd3kkf3VtrVEty2C
         I06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z4xw4BeflaOTebZuwoiVPM7Ym0RVfiYJ39j1NuVvqM=;
        b=dvqV87lKvECwsLzCyHEUlWNBX5UrtI7M6ynhvz186UVf4W9daHWR5VL7o3V21VLa/7
         sXZ3UqjRGd9KvaGUujKjVGnxcV7IOLL5ABa2tFTFBrPDm26mmOxuPAlkdKbVB0scX2vz
         hpvTtH1MZbLvsL1tvxIp4wgZ7uoat+pmS8aj8oyAxLQX9TrH43Ywtfelc/AVu9H8lwRV
         vOk3TtmP35PbcshlmMNm3wJAuMLi5OrqqY8pMZ3TRVg42v/jx9cZdpJNXtSev7JbYWiZ
         p0x/RxZ2G4EiVxSMOerYflY3pouBsB1rqjaO748DM2PcHdO6kAulc8cUX1/PoHnxC+Fr
         xYBw==
X-Gm-Message-State: APjAAAVYBMXNnrYsW3sin+I3dpY/7fSo3i6ITRfV9xINo3IE5efJbEX5
        HP46gtRJJWzOMPeDzbMGN5br2UoDAgQ=
X-Google-Smtp-Source: APXvYqy4E3aojhy38aJZFfYOHvNBw5Qdycb8SsmfK816pdRuDYZmSaC0IYSB5EQqbt8rPJC5X8xjjw==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr24520456plp.89.1580752963506;
        Mon, 03 Feb 2020 10:02:43 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 10sm21441424pfu.132.2020.02.03.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:02:42 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:02:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
Subject: Re: [PATCH V4 0/4] Enable video on sc7180
Message-ID: <20200203180240.GD3948@builder>
References: <1579006416-11599-1-git-send-email-dikshita@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579006416-11599-1-git-send-email-dikshita@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Jan 04:53 PST 2020, Dikshita Agarwal wrote:

> Hello,
> 
> Changes since v3:
> 
>   - addressed DT and DT schema review comments.
> 
>   - renamed DT schema file.
> 
> v3 can be found at [1].
> These changes depend on patch series [2] - [6].
> 
> Thanks,
> Dikshita
> 

Picked up the dts patches for 5.7, with Stan's acks

Regards,
Bjorn

> [1] https://lkml.org/lkml/2020/1/2/267
> [2] https://patchwork.kernel.org/project/linux-media/list/?series=219021
> [3] https://patchwork.kernel.org/project/linux-media/list/?series=214797
> [4] https://lkml.org/lkml/2019/12/27/73
> [5] https://lore.kernel.org/patchwork/project/lkml/list/?series=418681
> [6] https://lore.kernel.org/patchwork/project/lkml/list/?series=424054
> 
> Dikshita Agarwal (4):
>   arm64: dts: sc7180: Add Venus video codec DT node
>   dt-bindings: media: venus: Add sc7180 DT schema
>   venus: core: add sc7180 DT compatible and resource struct
>   arm64: dts: sc7180: Add Venus firmware subnode
> 
>  .../bindings/media/qcom,sc7180-venus.yaml          | 144 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   6 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |  36 ++++++
>  drivers/media/platform/qcom/venus/core.c           |  45 +++++++
>  4 files changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> 
> -- 
> 1.9.1
> 
