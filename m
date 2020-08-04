Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E043722D00
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvCtsbAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgHDOpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgHDOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:45:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B0C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:45:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so3204899wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vrgymxZSQXp65WBXBttM1JLkMuaQfRe8wtjepY95tOo=;
        b=FvCtsbAcTet/H4EtE/tlCenlm0kupTJUjVY5BAvOKP8h+7HD+fwbBGKRl+3mTUg2P3
         AOLJFJtqhWheJUnHcvV2gRZZl/e5Hwd0KeJvJKWc6fBfuwnqM5MEHPr9l8kuKh9SEzc6
         JwGUa13Gg4QLl+aX7y0+3wbedQ8FXbbdDg7njlKIw3vrnYglMl8Bbg0Dt8/9Xfr0mIjx
         S7QXNV28j7r4ilqWIXx2d4FkaJUSigF4jIsFiLcXgKIAPIVfUNgI0SeLCt/aTUHz4Zqd
         0FYNtKC4edmbJ2m6bxrgNQ0j/HY3t7uf/ktMC6ppPzM+H2oXHMrmQYNo7acLaSaE5m8W
         VzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vrgymxZSQXp65WBXBttM1JLkMuaQfRe8wtjepY95tOo=;
        b=G/TE0ivbKDTBTkgMRAiHOSfPBUzea5HDDJQ9aciQdp7s7g+0wsFa6yR6T51V2xf24g
         ohq8zQ041R9AfamCLasKLDJbMfBlBkxPYM4caBGschSchwi/KfK8cp8ruMVgedFR2B6d
         OysI2iV/RYEqFJ4E6tB24yIouA4qREs7u3v8iTwD7QwzF95UNbhoqL/g7VaBN8w48MNJ
         h8DJ9YFoxJ5IMqFXu8OrYAdhhSj37DGmcBADwlNeXQDjBeACaPyn/OXrF3AmKu/OirxW
         1hBbXLOO16as3CWFweVTUanj4S2kggT7LmXDanaK1UlAeZc0WHV4F+JK1fBv60jqmgSp
         OYGw==
X-Gm-Message-State: AOAM531DAHmfWjRSIfbTBOFwargYOkl17jim2NMtKiWBsrzW4EeDKPVj
        oDmE+o0kzKkdFBh+z5F7zaj3eQ==
X-Google-Smtp-Source: ABdhPJw2+EzPdKAw2t92FR+NukQ9ba0kagdIlf7j4tHEEt17qfb38xGsjZPDOkvrMuYeiS4q2cG8RA==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr4399867wme.77.1596552300706;
        Tue, 04 Aug 2020 07:45:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id z11sm29149417wrw.93.2020.08.04.07.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:44:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id A1F311FF7E;
        Tue,  4 Aug 2020 15:44:58 +0100 (BST)
References: <20200804124417.27102-1-alex.bennee@linaro.org>
 <20200804124417.27102-4-alex.bennee@linaro.org>
 <f80cfa932a650d8f7e8fc02a1656b4c2@kernel.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        christoffer.dall@arm.com
Subject: Re: [PATCH  v1 3/3] kernel/configs: don't include PCI_QUIRKS in KVM
 guest configs
In-reply-to: <f80cfa932a650d8f7e8fc02a1656b4c2@kernel.org>
Date:   Tue, 04 Aug 2020 15:44:58 +0100
Message-ID: <87r1smmpw5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Zyngier <maz@kernel.org> writes:

> On 2020-08-04 13:44, Alex Benn=C3=A9e wrote:
>> The VIRTIO_PCI support is an idealised PCI bus, we don't need a bunch
>> of bloat for real world hardware for a VirtIO guest.
>
> Who says this guest will only have virtio devices?

This is true - although what is the point of kvm_guest.config? We
certainly turn on a whole bunch of virt optimised pathways with PARAVIRT
and HYPERVISOR_GUEST along with the rest of VirtIO.

> Or even, virtio devices without bugs? Given that said device can
> come from any VMM, I'm not sure this is the right thing to do.

Perhaps this patch is one too far. I don't mind dropping it as long as I
can still slim down the kernels I know don't need the extra bloat.

>
> Thanks,
>
>          M.
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  kernel/configs/kvm_guest.config | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/kernel/configs/kvm_guest.config=20
>> b/kernel/configs/kvm_guest.config
>> index 208481d91090..672863a2fdf1 100644
>> --- a/kernel/configs/kvm_guest.config
>> +++ b/kernel/configs/kvm_guest.config
>> @@ -13,6 +13,7 @@ CONFIG_IP_PNP_DHCP=3Dy
>>  CONFIG_BINFMT_ELF=3Dy
>>  CONFIG_PCI=3Dy
>>  CONFIG_PCI_MSI=3Dy
>> +CONFIG_PCI_QUIRKS=3Dn
>>  CONFIG_DEBUG_KERNEL=3Dy
>>  CONFIG_VIRTUALIZATION=3Dy
>>  CONFIG_HYPERVISOR_GUEST=3Dy


--=20
Alex Benn=C3=A9e
