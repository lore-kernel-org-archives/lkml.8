Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA285C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA8B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGIR/NgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgENOKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgENOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:10:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B76C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:10:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so20968437wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hoAYDgtRggFxMiZjO1bVW1903dGoWfRGsSFbkYw4jm4=;
        b=oGIR/NgZPhgsGNIQ8Zk5BnAdNRaUEMX0VgrvEYjok/yp4Q8NKg2exbRNOfezD+isVV
         V4tXhdggfj4apHIDb05+IdKTkWgRKBHBKcJLF44Ot6PWxQf/t0VPyOxku1zh/OwkQ1if
         W6wiDDyKwHfUZSxMHLpJHXm9iDYF5biGg5fKMDQCUciWgFamxGj7QLwsaj4YCF8V5sQ5
         GCxNOdSMn2B2wVPBPwGiJ6TqNyq/t9xdfpfyOSrEycW6XyhF2E8L98ytJI36ukMmUA9F
         YBDMnfx6qy7rIrkEdY6atGqEMbjLvks/WkcjWXq5k8Pg64slciI4bBkMMQNwiGciBqgc
         pmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hoAYDgtRggFxMiZjO1bVW1903dGoWfRGsSFbkYw4jm4=;
        b=Wahq1UaJ2TvSmICYX5apWfJLGAqQE8MpwwAa6yjtl0fga4bFhBhkDOpJSkPz1dgRlc
         L+3j6dma7ZpaPztx0iPmDyohd8FX8sU3FHR/stmy6s0aWtWqh3NSIr3sAIMibVzepE2d
         nb/K9dbuxKWQbWfxdzCAqVCNAEuglXx5ulMWub1btk/3/SC60Hycc9G+9vQxH8UFoAqi
         RAh5FlvXgATmyxXrilw/ITASXU1Pj9pPoR+dkRePpuhaxRFdLOpPY7+WrTy1PCgzd/kp
         DsXXlnamgDCbliWsEe2geZG/iNRztGS840PWIfAQQuojy7JrVTII+OYNmRb+OdkdxzkL
         qJxw==
X-Gm-Message-State: AGi0PuZuzoHWqkqCSKuRgCwp/KdVcfRZ4/4obbz7G3nQW109+Exev8GJ
        TASO7Sz2FRafZipoq1Gv3Mrj4Q==
X-Google-Smtp-Source: APiQypLK4m/UIQG/wE+O0YZKAmuvLLyiAggfiVqRnl6+26HL/7yIPecMv61BfyYTxYq4PpvRanuwAA==
X-Received: by 2002:a7b:caf2:: with SMTP id t18mr26185465wml.35.1589465452810;
        Thu, 14 May 2020 07:10:52 -0700 (PDT)
Received: from localhost.localdomain ([37.120.32.219])
        by smtp.gmail.com with ESMTPSA id n9sm4315672wru.90.2020.05.14.07.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:10:51 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     Anson.Huang@nxp.com, catalin.marinas@arm.com, dinguyen@kernel.org,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcin.juszkiewicz@linaro.org, maxime@cerno.tech, olof@lixom.net,
        shawnguo@kernel.org, will@kernel.org,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: arm64: defconfig: Enable Qualcomm SC7180 pinctrl and gcc
Date:   Thu, 14 May 2020 16:10:48 +0200
Message-Id: <20200514141048.1344235-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200116045457.2489704-1-bjorn.andersson@linaro.org>
References: <20200116045457.2489704-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Enable the Qualcomm SC7180 pinctrl and gcc driver, in order to allow the
> kernel to boot to console.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
