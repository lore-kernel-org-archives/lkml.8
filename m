Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CF0C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE28221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQbpfTRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHFWcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHFWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:32:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C1C061574;
        Thu,  6 Aug 2020 15:32:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f24so13615ejx.6;
        Thu, 06 Aug 2020 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIR5gjbU+Mwah1iH8pBqwUm77E/30L+bDjha2zH7UhE=;
        b=tQbpfTRkaS+EXC5hy7iflWYywPq7iEufj6aXlB0TgQTb4TQkXon9cRnEm8WosLXENG
         hdHnfb26i3aqMVgLEjcrgp73pcoJsU8vcW57sHbqIDrCa7UWxIbPy4MnSiJzPQ1NBnjF
         UqEnuoFt0nmCRpawn+xt8Pu31IdHy7zdY1TOsmivMXYv0Rhl/vEKtE5nTu/31c7rYvHm
         uugsPVaTXaRJD6HPrLbm0GOm3IH9DjnGJqfNGFo0KAsyex1lXpx4nJ5tC+eAUEiKjfhl
         LsXVt3QEWWVyAXDwWthkhGRnHT1jdufUAqDPedjmVy3CkqDRAnnqcenv2g67L1CojxtY
         rXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIR5gjbU+Mwah1iH8pBqwUm77E/30L+bDjha2zH7UhE=;
        b=BpSJrZqgl47Q3qnvblLH0L/dSyJvJ6ODTGgaXI35n3Ltf/U1XOHiXlhuPqKeS+xdAs
         +IWkaoaAmsKM7535P6sys/uMsmzeYPitIHGoJIHF7LIAPBy6LeqRPfguYWDCLxQyEuVc
         FWl4krsbc5jzwmtAhWcROXAGlDL3HuYN1+M+I2SJpvcg78L/uSLCv/n4Kfn06I6gcFoB
         4pM71cEY4SZmeUTPPOgCbDpQC0cBnrW0kU2J1x4WeedaIQ2aeuQbZL4CqEhhtWEDaH89
         I3teGwrPuVif4HgcdJN6xQQOxCGjHpcA+avylAbKMscSWRF3xT2nOm27TtqBrxKQomNw
         ywyg==
X-Gm-Message-State: AOAM531S+qVnNAFxjcNeiVix/NtHU77yDkKMjHwp2DMMaP3zJ5W9XIHr
        mcsSAlSl0EFgzGNDksM9rm4=
X-Google-Smtp-Source: ABdhPJyOMmGi6mKgUkgfCV3kgswvOuijmfxLZUafhcyHeXGR/0cNk7pXbcQl3AoLWZikRuoaTya/0Q==
X-Received: by 2002:a17:906:1f53:: with SMTP id d19mr6408582ejk.327.1596753119566;
        Thu, 06 Aug 2020 15:31:59 -0700 (PDT)
Received: from localhost.localdomain (abae50.neoplus.adsl.tpnet.pl. [83.6.168.50])
        by smtp.googlemail.com with ESMTPSA id k22sm4411316edo.24.2020.08.06.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 15:31:59 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     amit.pundir@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, john.stultz@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sumit.semwal@linaro.org,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: 
Date:   Fri,  7 Aug 2020 00:31:34 +0200
Message-Id: <20200806223134.42748-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAMi1Hd3Dv_T7kgThLTk2QLtfS7LBvhJ5R=6C3seUYK0GvNV6eA@mail.gmail.com>
References: <CAMi1Hd3Dv_T7kgThLTk2QLtfS7LBvhJ5R=6C3seUYK0GvNV6eA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH v4] arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)

>// This removed_region is needed to boot the device
>               // TODO: Find out the user of this reserved memory
>               removed_region: memory@88f00000 {

This region seems to belong to the Trust Zone. When Linux tries to access it, TZ bites and shuts the device down.

Konrad
