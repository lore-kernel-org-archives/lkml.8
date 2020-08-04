Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D692C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33028206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVExCt4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgHDOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgHDOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:47:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:47:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so3212431wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=r6kGfPE/KsV7nTfH/d4o6yMleyqMBQteeLYhE/uXEe8=;
        b=aVExCt4oLxLR9aFvpeWEL25FVcXyMBmA32sEnExxpKELRADyd/9R8grqfipU4KCnal
         xw/mDJ1vB99SSCGocIuUpjfn/n+6sq37uzwOBd9mLMKkVAI+lqriN5bX9rydaC5fOnbj
         0JtNaK5ZOpnv/jS7GrAf3KIXRvmO0w8y8UIlljMRS32B26TgTdXAdQygC7MBMHn5lvoP
         AxItZMMHNLnLZ4HD7gvVz87UAMtI4b+WfUKZPyuyAhPhQZn3H0V7TXQuP4XID2r4pBE8
         0WVBskw0itNLwIU1bhZ/+0X4da9muIyp02S9F8OzsA8dAJ6ZSM4dlKp55if4+eS/15qd
         3g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=r6kGfPE/KsV7nTfH/d4o6yMleyqMBQteeLYhE/uXEe8=;
        b=JykkNRri3vqwOp2AeQ/Y3xMt7tCimskGHb0utOpoUPrRkub+xmD8z8LjYuezw5Xwb2
         bMPI5srlRdPcmzPjD5YFg3iqLSuTleGMq76QARniD9fqgeBcHmtzoaUhJJN+W2JdxbSU
         TFqcD57VhfXo2ecbCk8Nc98lgIi/rLKUOl6G8kG34NAZmafgjEBrRNWkNea8/rPzYI/L
         SOtb2lkwHnEUzVesgl0iZyRBnH7/95Aa6hngYTJhMdVmT3grDpxJBbfU9WICfJWKRtZ8
         kHPnVAN6Yi/mlB3umHQmQhu+xoFitlsqJNjwvUgVqx+PDera4PQ81Vf8tvy9Y6zvH/Cy
         SSkw==
X-Gm-Message-State: AOAM530ci28JkLyRyBbLxoY6OKiGIMGG4lxLawtk8oVnPpZiZQf3wEp5
        lIKbpzOErXseygjRE97YyvQ4ew==
X-Google-Smtp-Source: ABdhPJygwsnCNO92emQNPWtLheZnx+hxAUxJL5JREQ4YEEZj8ftsQfnryzZlL6jATdGaMqcJvVKRKw==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4306747wmc.26.1596552430480;
        Tue, 04 Aug 2020 07:47:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id t25sm4403673wmj.18.2020.08.04.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:47:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 48B801FF7E;
        Tue,  4 Aug 2020 15:47:08 +0100 (BST)
References: <20200804124417.27102-1-alex.bennee@linaro.org>
 <CAMj1kXErSf7sQ4pPu-1em4AM=9JejA_-w3iwv4Wt=dgbQHxp-g@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kvm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Subject: Re: [RFC PATCH v1 0/3] put arm64 kvm_config on a diet
In-reply-to: <CAMj1kXErSf7sQ4pPu-1em4AM=9JejA_-w3iwv4Wt=dgbQHxp-g@mail.gmail.com>
Date:   Tue, 04 Aug 2020 15:47:08 +0100
Message-ID: <87o8nqmpsj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 4 Aug 2020 at 14:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Hi,
>>
>> When building guest kernels for virtualisation we were bringing in a
>> bunch of stuff from physical hardware which we don't need for our
>> idealised fixable virtual PCI devices. This series makes some Kconfig
>> changes to allow the ThunderX and XGene PCI drivers to be compiled
>> out. It also drops PCI_QUIRKS from the KVM guest build as a virtual
>> PCI device should be quirk free.
>>
>
> What about PCI passthrough?

That is a good point - how much of the host PCI controller is visible to
a pass-through guest?

AIUI in passthrough the driver only interacts with the particular cards
IO window. How many quirks are visible just at the device level (rather
than the bus itself)?

That said I think the last patch might get dropped as long as the user
has the option to slim down their kernel with the first two.

>
>> This is my first time hacking around Kconfig so I hope I've got the
>> balance between depends and selects right but please let be know if it
>> could be specified in a cleaner way.
>>
>> Alex Benn=C3=A9e (3):
>>   arm64: allow de-selection of ThunderX PCI controllers
>>   arm64: gate the whole of pci-xgene on CONFIG_PCI_XGENE
>>   kernel/configs: don't include PCI_QUIRKS in KVM guest configs
>>
>>  arch/arm64/Kconfig.platforms    | 2 ++
>>  arch/arm64/configs/defconfig    | 1 +
>>  drivers/pci/controller/Kconfig  | 7 +++++++
>>  drivers/pci/controller/Makefile | 8 +++-----
>>  kernel/configs/kvm_guest.config | 1 +
>>  5 files changed, 14 insertions(+), 5 deletions(-)
>>
>> --
>> 2.20.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=20
Alex Benn=C3=A9e
