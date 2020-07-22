Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2BEC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D151E20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alnd3LC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgGVUMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbgGVUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:12:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACA9C0619DC;
        Wed, 22 Jul 2020 13:12:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so2616575edb.11;
        Wed, 22 Jul 2020 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLTkTEgt4xUndPHOWAIycnFkBJ6E45HfBo7NtTWjQFQ=;
        b=alnd3LC7bZF88GYjqDHdUOdzWFQohQLO9Zvh+1FMMZ/ID4cWZFhRotTy+TXlkoXEcf
         /R/ehmAb7jpmit194UXGc9oHqec/B+O6xg0Xi4GOVYWeopAdz+GgbJH4mtBQ3L/F/m/7
         6nuEk1jyoebnggTXW43/6lCtVcqTkYhJqL9NfUvfcg4Y3Zkp/E7L6EyLalgH29DAEicz
         2QuLDQthO5ZatNjafPEkj3YXlG8nab81KYeYJ8FrgNaJNJTNOCjhCCUfRCUI3LM5jZRr
         eQSYhuGhZTnw9eyUG6mJd6PFKgfPsTZBfG6nZJh+blW6cQC6zcwQVNjVtrQtUgKEYDh8
         /E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLTkTEgt4xUndPHOWAIycnFkBJ6E45HfBo7NtTWjQFQ=;
        b=soLDqKv7qXux48AyLsDhwsm25+tvt8r+dxM/DAU0BgHFt45HEhcmaGvzN9/AS7U/ji
         CbtrQkrbqa8Rq1T/UGl3ZGxjn9Wd+4pPMdM6+e02HA+9ajfTCthTuJlkMn642fR16OZ7
         XiJlwa0Knac9HNgPhl66zDBb71BtzVdT7htYzaLjevCYZeGP5YTvHsvkTLnJ/CwbCFvx
         ipuYzxE9aTdXi3b3cF9oqrfGrg4N+q6SpAyQVsx0qH8rD35+tT9nt4QhnaFVLrUuoiY1
         bcIJYpWuWw3D7TFGjsVgO9N9IIh9/ebtpA1hM2xAasJOBqRq0BiYIVzLnc81kUMACqfe
         yOuA==
X-Gm-Message-State: AOAM531VtVWZe+hLnsVmBZ9iLAkg+YwscEkG+GBXCzjxJ18q5CXMsoaT
        Uepj8wQKYNNd7CT8PpbxAn9K/YcTzJEdCa9btNI=
X-Google-Smtp-Source: ABdhPJwD6t4bQXAbY3FRXxsABN08L0GguqxGCWf0AiDRNWyt939YcTYR9qUzVbF6BmoonWaoJpBlCZjucX05l9KQJZ4=
X-Received: by 2002:a05:6402:1ade:: with SMTP id ba30mr1031198edb.231.1595448729790;
 Wed, 22 Jul 2020 13:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200704122809.73794-1-konradybcio@gmail.com> <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan> <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com> <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
 <20200721235650.GN388985@builder.lan>
In-Reply-To: <20200721235650.GN388985@builder.lan>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Wed, 22 Jul 2020 22:11:34 +0200
Message-ID: <CAMS8qEVXGddTdbrPwK3NJMx71HH0hoVyqiJG6-g9tiBRMRYZ8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Is the problem on SDM630 that when you write to SMR/S2CR the device
>reboots? Or that when you start writing out the context bank
>configuration that trips the display and the device reboots?

I added some debug prints and the phone hangs after reaching the
seventh CB (with i=6) at

arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);

line in arm_smmu_device_reset.

Konrad
