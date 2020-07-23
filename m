Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E57C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AD520888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ewi7Gb4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgGWNQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgGWNQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:16:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA91C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:16:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so3160965pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ePu2DQifrSypcKw3c6HDysOl6wZIG3mL9ysnlkjPzpE=;
        b=Ewi7Gb4wAt29Y1el687HjMUlmBNi0VZIMdhklA/O/vcmU3tD45R50AO9Q80T+OTOm9
         c+4LstGwg00MY4C6qBcinL9fAPsI3RxCxikAbXfC8G2uZtdQQ1GrXyIaf6SDtmhN3yR3
         j7v2zgArlooh2K3TaXEuD5+4MvI7fZIZ4n1deAYC/51SO6x5IQklaYy2slaIbFUkczU9
         cTs8W6qTDds4v0A+wz17iitfv3XQV1g0kbUrLKndLFywDkXdoCx6Lfg97Bra24RZsR1P
         expVFr7rLA4lpnnZlD0FJrok+I19gx3LHgdoo0PGXBdFSOrbB7DbaC3pEO7aznatwWR3
         UvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ePu2DQifrSypcKw3c6HDysOl6wZIG3mL9ysnlkjPzpE=;
        b=hsp+4WbOy9LSysG6du7OCZLBq+cycIbM07qvdagGvOPZidCgQkPP6ZpwGJTn9fuj47
         HOjDxQdpTXgeTizES04b+TPPCo4E5AjI1wA8kBCPcyXs8kCDBeVqCD4kI1Lr2+xQ30D/
         lPGzlv91YlAGfnA8oAB4gAH381zYhTDVJAK3nGE7kFXksVj+YWpvaecyG8BACOKf1A0M
         Cn3GpTQygKGd9V4tsY8rimZ6IYAAdVMkIa8lVPl/YHf24IDq1pMGbljEJftuBAc3e2xM
         yN17VrB1zmIKRAEMFrWjOWmeWCPKmaPeTvCr9S8uSGPLqDnqoEEe9EbGtKlj3rMqeGwf
         Fybg==
X-Gm-Message-State: AOAM532WYzeBHq8iKk/hx/b6VNVtZHptFG0qyWxehH/djbCPXp9V9Xig
        kr0rJgeIgS4+YpA5Mlij4zkCKw==
X-Google-Smtp-Source: ABdhPJxJpfqGOnbg0xA8HsHA154EtCmp9G7TiNwpsst4qATzbOdPWrKM3zxg4Lw4KSO6gB0TVCTDZw==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr377489pju.62.1595510177991;
        Thu, 23 Jul 2020 06:16:17 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 129sm3085243pfv.161.2020.07.23.06.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 06:16:17 -0700 (PDT)
Date:   Thu, 23 Jul 2020 06:14:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sivaprak@codeaurora.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3 0/4] Add frequency / voltage scaling support for
 IPQ6018 SoC
Message-ID: <20200723131426.GK1218486@builder.lan>
References: <1595225543-12127-1-git-send-email-kathirav@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595225543-12127-1-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19 Jul 23:12 PDT 2020, Kathiravan T wrote:

> IPQ6018 SoC uses the PMIC MP5496. SMPA2 and LDOA2 regulator of MP5496
> controls the APSS and SDCC voltage scaling respectively. Add support
> for the same.
> 

Picked up patch 1-3 for v5.10

Thanks,
Bjorn

> changes since V2:
> 	- Rebased on top of linux-next 20200717 tag
> 	- Addressed Rob's comment to drop the 'syscon' node in qcom,smd-rpm.yaml
> 	- Picked up the Reviewed-by tag for qcom,smd-rpm-regulator.yaml
> 	- Regulator patches part of V2 was picked up by Mark and it's available in linux-next tree
> 
> changes since V1:
> 	- Moved YAML conversion to the last as per Mark's comments
> 
> Kathiravan T (4):
>   dt-bindings: soc: qcom: Add IPQ6018 compatible
>   soc: qcom: smd-rpm: Add IPQ6018 compatible
>   dt-bindings: soc: qcom: convert the SMD-RPM document to YAML schema
>   dt-bindings: regulator: convert QCOM SMD-RPM regulator document to
>     YAML schema
> 
>  .../bindings/regulator/qcom,smd-rpm-regulator.txt  | 321 ---------------------
>  .../bindings/regulator/qcom,smd-rpm-regulator.yaml | 106 +++++++
>  .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |  64 ----
>  .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |  87 ++++++
>  drivers/soc/qcom/smd-rpm.c                         |   1 +
>  5 files changed, 194 insertions(+), 385 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
