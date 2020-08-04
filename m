Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3D207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhxrF8BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHDPkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgHDPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:40:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAEC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 08:40:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r4so34871235wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+xqFoCQQoa6eAiMo50Uy9HC91LgUQEIMjIx3DBlCRwg=;
        b=UhxrF8BWf2l+4DIHmMKF00sQXo8svgIiLw4wfiT0UFAkEZGCKIqFtslV1c2kRtGlqQ
         nObO2HKC3Mj6IC+86y8xR8g+5888z59r/fHaEqxFhzK+3oWbidT5LallCb9JyDmgB9zS
         +ngxNEdKVlV3KMiZJ4ZMqrD8ew6SRgICco4g0fPoAYtGL4FxOZYROuRumhj1W7GqZckv
         7dmBPTMLO1R8Ei/Z8q55dDEP6OJc+R52TXXYErh7advHtW34287efJjtaZlKyTvm4TOY
         h5GmRLoCvngNzxR/BHnJxFbtL/yhw/IwGqibGjaIMr6h9rPOZTGy75dl3HwKRPYr2ijR
         eUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+xqFoCQQoa6eAiMo50Uy9HC91LgUQEIMjIx3DBlCRwg=;
        b=eE5teEFVd+66jobJ4doVyzq5PpXWHHIaJEP9ckzXnFKYQKDqeFIHTD2VspqzSubd9W
         mz0Q6+Y8Iyqb1lIHVT1OJxBRP39v5JqeBTTzp/VaP/BYVREMRfpbR31P8i2mpA3KLMep
         7idF71W3KxfQ+KY2uOHhr/QOXMX8V9z6mFU+98xqsoVDyG6Dmr+bz1GoLGRUG/aNWduA
         f46gBYPFqsHC73i3feW8L9vBdPFyNOSbsyQwQ8YrrjPtGi66akgeYLaqfd713NAXNajC
         dhx6l2pkE5X4bbNYgZXEpB0G2Li9SaLhPu97gR+HYIp1wUUUrGA5BOdLyQR8UP+vpCA3
         5F1Q==
X-Gm-Message-State: AOAM532CUZc9j2DU4oN7U/5hDYtxLIUZtIFN9ORzhX5rnZWNHryp41oG
        8tiapvADnbhTpscKOqvoYRsmIdXaxzQ=
X-Google-Smtp-Source: ABdhPJzJKsRHYbdxphNd2Y+U/MaVHkKnNns4heTa05XV+GsGcSREvqMNGKYzebFV5HdOfY82dOrLMA==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr20350026wrv.104.1596555610319;
        Tue, 04 Aug 2020 08:40:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id a10sm30539397wrx.15.2020.08.04.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 08:40:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id A1FA31FF7E;
        Tue,  4 Aug 2020 16:40:07 +0100 (BST)
References: <20200804124417.27102-1-alex.bennee@linaro.org>
 <20200804124417.27102-4-alex.bennee@linaro.org>
 <f80cfa932a650d8f7e8fc02a1656b4c2@kernel.org> <87r1smmpw5.fsf@linaro.org>
 <b78f8715bbaec8fc728a85d614b00688@kernel.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        christoffer.dall@arm.com
Subject: Re: [PATCH  v1 3/3] kernel/configs: don't include PCI_QUIRKS in KVM
 guest configs
In-reply-to: <b78f8715bbaec8fc728a85d614b00688@kernel.org>
Date:   Tue, 04 Aug 2020 16:40:07 +0100
Message-ID: <87lfiumnc8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Zyngier <maz@kernel.org> writes:

> On 2020-08-04 15:44, Alex Benn=C3=A9e wrote:
>> Marc Zyngier <maz@kernel.org> writes:
>>=20
>>> On 2020-08-04 13:44, Alex Benn=C3=A9e wrote:
>>>> The VIRTIO_PCI support is an idealised PCI bus, we don't need a bunch
>>>> of bloat for real world hardware for a VirtIO guest.
>>>=20
>>> Who says this guest will only have virtio devices?
>>=20
>> This is true - although what is the point of kvm_guest.config? We
>> certainly turn on a whole bunch of virt optimised pathways with=20
>> PARAVIRT
>> and HYPERVISOR_GUEST along with the rest of VirtIO.
>
> Most of which actually qualifies as bloat itself as far as KVM/arm64
> is concerned...

So here is the question - does the kernel care about having a blessed
config for a minimal viable guest? They are certainly used in the cloud
but I understand the kernel is trying to get away from having a zoo of
configs. What is the actual point of kvm_guest.config? Just an easy
enabling for developers?

>
>           M.


--=20
Alex Benn=C3=A9e
