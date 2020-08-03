Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F35C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE5920781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kArTRLvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgHCQUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:20:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39C3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:19:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so142096wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tLldRhiZuUDIQWR4Dezuv3wy8y8ie+Yklp9pb5zDPYU=;
        b=kArTRLvhvEX48jCt3FGfAjBk5q2jKd9B5OHtI2t2LNYcIwOE9g/YdRTu0Qv2/tKSjZ
         lY/8hKN+3rz/dF3zh17SF08NDzr2v5tDF/bmP2o3etZF2ZPLCzZHQcwvFYvP6duA+NJ3
         6za7Y2F5OxqbdFHHrY1qkFYEnEsvOLhqBgPImgSNCH+YWCrqy1GbmClVWNkQttM0crWO
         C4IQK3mx0BVlHvD4+D5Htf5fo+OiwQlVb3itNqCmv/ZX4igDhj4tmx5+XJdBG4sPULc7
         qxE59tZVZk2eDk6LpYf2ts74W/NPd1IpRDd0Trdw+2MgpJu1EV4Jsb0p42NlJh7mWqSo
         Hyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tLldRhiZuUDIQWR4Dezuv3wy8y8ie+Yklp9pb5zDPYU=;
        b=B2J6XUwAmjF79DLCAg3IzPvOCEGSV/KY25oY9urw6ra5DQ5NEXBjYcYB4BBmcsvmOw
         Cc1/FfGUWPnpcUgS485cB5XakomVI2SOHA1QYGEfThjnZ/1cJTku6ji6VFZRs20uHqJL
         gZ/MuWF2a68e080EK9l1xynRrs6h2qvIakjLPSG1ky8idDSEA7NwzciHynJhlOLZX3a7
         j1Bit+h6AvAcssnN0icscl74qwyuElkHNtJ6Z4I+B62+Kjzvspb53+JX6XlrsCCq9PEW
         2F/ZHXWFT60evojvp8has3/F2MdfUfgjDmwey8nCD4BSsCQzoaCEbv398BzCYcFcNqWP
         DJbw==
X-Gm-Message-State: AOAM532HCSg19yP9uq9+GpE00y/2VjOlpcqO2xMHBbq2LkEROguINS29
        8Ut0ZTXGXqdS6TRbDyKaBV98CSwdWLM=
X-Google-Smtp-Source: ABdhPJwr62vqUeTs6iQr9eNHND5kn34UOVopsNwuHjXV/v7cCCABUDW1VP7TMG9bsneq4IGE55YcAg==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr56952wmh.23.1596471598552;
        Mon, 03 Aug 2020 09:19:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id n24sm50772wmi.36.2020.08.03.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:19:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id A8FBE1FF7E;
        Mon,  3 Aug 2020 17:19:56 +0100 (BST)
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
 <87ft973d0b.fsf@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     "Pincus, Josh" <Josh.Pincus@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
In-reply-to: <87ft973d0b.fsf@linaro.org>
Date:   Mon, 03 Aug 2020 17:19:56 +0100
Message-ID: <87wo2fn1lf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pincus, Josh <Josh.Pincus@windriver.com> writes:
>
>> Hi,
>>
>>=20=20
>>
>> We were looking into a similar enhancement for the Virt I/O MMIO transpo=
rt and came across this project.
>>
>> This enhancement would be perfect for us.
>
> So there is certainly an interest in optimising MMIO based virtio and
> the current read/ack cycle adds additional round trip time for any trap
> and emulate hypervisor. However I think there is some resistance to
> making MMIO a re-implementation of what PCI already gives us for "free".
<snip>
>
>   - Quantifying the memory foot-print difference between PCI/MMIO
>
>     PCI gives a lot for free including a discovery and IRQ model already
>     designed to handle MSI/MSI-X. There is a claim that this brings in a
>     lot of bloat but I think there was some debate around the numbers.
>     My rough initial experiment with a PCI and non-PCI build with
>     otherwise identical VIRTIO configs results in the following:
>
>     16:40:15 c.282% [alex@zen:~/l/l/builds] review/rpmb|=E2=80=A6 + ls -l=
 arm64/vmlinux arm64.nopci/vmlinux
>     -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
>     -rwxr-xr-x 1 alex alex 86368080 Jul 31 16:33 arm64/vmlinux*
>
>     which certainly implies there could be a fair amount of headroom for
>     an MMIO version to implement some features. However I don't know if
>     it's fully apples to apples as there maybe unneeded PCI bloat that a
>     virtio-only kernel doesn't need.

Just following up after cutting the Xgene and ThunderX PCI bloat from
the kernel the margin is a little smaller:

  -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
  -rwxr-xr-x 1 alex alex 85639808 Aug  3 17:12 arm64/vmlinux*

--=20
Alex Benn=C3=A9e
