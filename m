Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1712206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilWBNL6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFBUGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:06:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D2C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:06:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so14046028eju.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=2cvL0+Yd9yN39Q4W3Qqy3Rcpep61FLY3/TIOy09PrYQ=;
        b=ilWBNL6s/oqv/pCLSUhL8IL831D81QGaeiNVKp0LalmXfcBuxutdTlF0Cc5SKaDDl6
         tdO/hoPcG61TPtpylyPK3kBVMD/f1XfPjgfZr9ZO0wxs55mwF7xFscZ+9Pkz0m9MCRpS
         0TqpEQ7+odCILe4DjqorpWyhIhJnKNV2GaeF4kuk0OBrB+2Silo7pL0hJvQ1pa74Go90
         3TtFVFoJc7dGV3BLpr/raidOS4rfGoICmxCxgotaMjst7psccsp0blAyVko+xGS66rCM
         TU4gK+zRCT6bbyG9kC9nO3loifidqpus0Angr7i6i1D8h8h47bA8WUiCM5RuJyfQ4wI/
         f3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=2cvL0+Yd9yN39Q4W3Qqy3Rcpep61FLY3/TIOy09PrYQ=;
        b=EZZOE1ZhBNTTaQ/uSJCboOAokhG0rhA5Qf9eZ00HTFeHC/MOcpAycvpLvIMTWcpSPk
         S4RXH8lOpmuI45rlLxwVhOcDKV1HokJ/NSu28T4bOXBzTWeywBmwsapRkd65MSDiNzW5
         xdSG6NxsxLLUrBoWFG3ivgdRRrIfVrh3e+p6bg7VAiFsOkalHBvnnMc7MJuwT0mlgp2X
         rG/zGrKNB8qG0OCDCZF24QLs2Hy8KzIk1APfjn0n+Lix5N/j9N++2TrWDTGRh748gG65
         zn9yrkqu5wETqB5oBomEI1P60O2U94M0Xhf2d7kIthOAGKKB0IF79zjAqE/laGirOdU1
         7Wgw==
X-Gm-Message-State: AOAM532kARGtDkQCDm8eya6DBokipKogXYD2VGnZft5aq0qHxiE+hZum
        cZt1JEuBbR3UhQFAdCLjhWpvdUYDvP3/rWOUD00=
X-Received: by 2002:a17:906:ae85:: with SMTP id md5mt16518436ejb.213.1591128388033;
 Tue, 02 Jun 2020 13:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200602200407.320908-1-konradybcio@gmail.com>
In-Reply-To: <20200602200407.320908-1-konradybcio@gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Tue, 2 Jun 2020 22:05:52 +0200
Message-ID: <CAMS8qEUOYuLfWTm4y9a2ZPJ2KyRs287jfkka0XntSWXyeZhgtQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] soc: qcom: smd-rpm: Add msm8994 compatible
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interestingly enough, this compatible has been used in lg-bullhead DTS
for a long long time, even though it has never existed upstream.
