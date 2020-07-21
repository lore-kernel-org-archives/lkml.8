Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4794D207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymm00dD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgGUQVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGUQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:21:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F063C061794;
        Tue, 21 Jul 2020 09:21:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so15697284edb.3;
        Tue, 21 Jul 2020 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OHn7hEjFb/8SBXPDh1+DgoRQWsuvdjNe2+U9AyALG4o=;
        b=Ymm00dD9F2MasO44D8/wTfY1on9EmII3e6c5icTnGDjY49MsIFNKckv4IZwX+ryogf
         GRb1dqFZQCLJj0kOlfQ+/ioq9eSG3gXCeDvzxIkQ3XhNVRYELEvEWCTRfL41X2oFvkFJ
         6B+e20IzO63huP1rpSd2WjArWZ25Qb3gIIWlfNwKP5mOav3z7CoBOoIoQhiYBALvUL52
         BYB+4ZQb63i8kAb2LtDh/0/iF3bUWc3Th+eULyeWS+cGaSLe5tkqpkhazu1sKFawBxHm
         fQZv5FoabAu9gg8akYzMCY6Fw5v7Hb5iimAkyb1YL8YKZPr0UHqJfXw85J3Bl5e2ND/y
         4o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OHn7hEjFb/8SBXPDh1+DgoRQWsuvdjNe2+U9AyALG4o=;
        b=o32R44laedXCQoK+YjeInT50P1QspspQ/j9TIEET6qf9tqvrb5rnxYQ/mIUGYgihGf
         Zk7RMGw/otBjbnOezMldrpt5/CRsJXWVqtcUpSvlTe0xH8U0PPembi5F9Fovat/gdGlI
         1xbGVzy5iluOuA7G6KVKox/KTOOv9iDkuaqdGPqWYnEtLEMooGfc5j2m7gWc+YypVYpZ
         ssyx26b5dcCvtMFQgrOR3Fjp4ZPxURxWmTHI5alqgwOiMQADtdviQPpRbNVH/6rHkRLG
         nXMYTBzKyNwKEMvf5dj8ikOWFAF4HxBVo0WFNiyzVgJx8QY1UkVoWbDhHXw1iMZrRIXu
         x6BQ==
X-Gm-Message-State: AOAM533q43LJthqcqI0IRoEnOJvscHsSb7b2HVWwjpa4RGOjzdRbcXE0
        VemRosHxSzjDadPQAcB29eG5Pq3AKa6gP4p2BUno+zTqnZw=
X-Google-Smtp-Source: ABdhPJwlkQdsmXiGVJuT5fBMSRufgvGnNFQJWXPQYp7JmU26Bood8ogKvJRBt/XX6NId4d0K7v9nUTgHvmnJoTuh4oY=
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr26654583edb.233.1595348465062;
 Tue, 21 Jul 2020 09:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200704122809.73794-1-konradybcio@gmail.com> <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan> <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Tue, 21 Jul 2020 18:20:29 +0200
Message-ID: <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
To:     Konrad Dybcio <konradybcio@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
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

>The current
>focus has been on moving more of the SMMU specific bits into the arm-smmu-qcom
>implementation [1] and I think that is the right way to go.

Pardon if I overlooked something obvious, but I can't seem to find a
clean way for implementing qcom,skip-init in arm-smmu-qcom, as neither
the arm_smmu_test_smr_masks nor the probe function seem to be
alterable with arm_smmu_impl. I'm open to your ideas guys.

Konrad
