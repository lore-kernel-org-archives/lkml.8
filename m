Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3918DC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14963206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8qgkmXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502303AbgDPJU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390940AbgDPJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:20:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE48CC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:20:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu11so1108878pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=ISswPnrNrNb7nFmczeJsSdHsuzmn6GJTNiO2AA6ZMvY=;
        b=L8qgkmXkYeu5jJTg+ipIJY8BQF5APB04ZGGEk43KAKB0lojbpQytpa19pr5OsPtK3r
         u0gE4p2/Sm7ipWuK8kmQLOm/OFyF5ubhyH5b5GpTxa/OYaK4NRrvY9Fql9R0cd717HbX
         Remjjhg2Y7P1uqUZZJlb3MxqGVrRV+FoGhLYW9icz2UWTSKwJ1nE/OYAIwmpPqcZfLOM
         U7LlkemoVeiNYs4FpIggxNz+yeMHdZin7xrdISnv77d8dGRH6vJokPQnH+fF5jzZYN48
         dhk4jkhYGQwFPqCyMjI1SxcuZkGPWc1g96C9E3iDo0eZ32YYPwtkN+HkyWovgvqf72ne
         A16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ISswPnrNrNb7nFmczeJsSdHsuzmn6GJTNiO2AA6ZMvY=;
        b=pq4g7J+aClInBI/1mOqzAhgq7/BanjtQoZwDYA0yb3U4q50F5EQ0ypDNvVM2JZ+4qu
         Qc0RktzpaTtBCgHIJtCLliIPT/U22bJiXTqDVeYeQFKj2HhO+VazNihAlhAJ9naK5GEF
         p9wccH+0mERodhvvpL3LLCR8UdQVj+DgbM/kHFtB4UaD40LAJWi4MOIvTjuztRMwUNTv
         glY617WOjjoY3efoA6lRFdYMtyEzDskFLrEl9B2xcXUq5FqYrx1da5eOpfB0bn7M2dSe
         m7dtESdVlZbsdzd2mCyOmb585XUWsEYDBHLw3WJq1wjvOvyqO/HDe+gQPQULEesdz3Qn
         Fwwg==
X-Gm-Message-State: AGi0PuaO1+4ZKjBivEBA18nrUMTYcKlWvOhPgZCv2zHuNBimkIv00m1z
        R+yZCTik9CHuvc4ndOWTR8poG6x6
X-Google-Smtp-Source: APiQypIfIWa7ne5B8iyA/iiIAXtW+KwIwjFSYx6zfx/UL24qnf0VWGrY9kqZvVTlfGCEuBUTUc5CVQ==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr4064190pjz.45.1587028849247;
        Thu, 16 Apr 2020 02:20:49 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id i128sm7106767pfc.149.2020.04.16.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 02:20:48 -0700 (PDT)
Date:   Thu, 16 Apr 2020 19:20:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Skiboot] [PATCH v7 0/4] Support for Self Save API in OPAL
To:     ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, linuxram@us.ibm.com, mpe@ellerman.id.au,
        oohall@gmail.com, pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        skiboot@lists.ozlabs.org
References: <20200416075341.75268-1-psampat@linux.ibm.com>
In-Reply-To: <20200416075341.75268-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1587026695.tnsg4h9617.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of April 16, 2020 5:53 pm:
> v6: https://lists.ozlabs.org/pipermail/skiboot/2020-March/016645.html
> Changelog
> v6 --> v7
> 1. Addressed comments from Gautham for reporting warnings and errors
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The power management framework on POWER systems include core idle
> states that lose context. Deep idle states namely "winkle" on POWER8
> and "stop4" and "stop5" on POWER9 can be entered by a CPU to save
> different levels of power, as a consequence of which all the
> hypervisor resources such as SPRs and SCOMs are lost.
>=20
> For most SPRs, saving and restoration of content for SPRs and SCOMs
> is handled by the hypervisor kernel prior to entering an post exit
> from an idle state respectively. However, there is a small set of
> critical SPRs and XSCOMs that are expected to contain sane values even
> before the control is transferred to the hypervisor kernel at system
> reset vector.
>=20
> For this purpose, microcode firmware provides a mechanism to restore
> values on certain SPRs. The communication mechanism between the
> hypervisor kernel and the microcode is a standard interface called
> sleep-winkle-engine (SLW) on Power8 and Stop-API on Power9 which is
> abstracted by OPAL calls from the hypervisor kernel. The Stop-API
> provides an interface known as the self-restore API, to which the SPR
> number and a predefined value to be restored on wake-up from a deep
> stop state is supplied.
>=20
>=20
> Motivation to introduce a new Stop-API
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The self-restore API expects not just the SPR number but also the
> value with which the SPR is restored. This is good for those SPRs such
> as HSPRG0 whose values do not change at runtime, since for them, the
> kernel can invoke the self-restore API at boot time once the values of
> these SPRs are determined.
>=20
> However, there are use-cases where-in the value to be saved cannot be
> known or cannot be updated in the layer it currently is.
> The shortcomings and the new use-cases which cannot be served by the
> existing self-restore API, serves as motivation for a new API:

Thanks for writing this up, it goes some way to help think about the=20
feature.

> Shortcoming1:
> ------------
> In a special wakeup scenario when a CPU is woken up in stop4/5 and
> after the task is done, the HCODE puts it back to stop. The value of
> PSSCR is passed to the HCODE via the self-restore API. The kernel
> currently provides the value of the deepest stop state due to being
> conservative. Thus if a core that was in stop4 was woken up due to
> special wakeup, the HCODE will now put it back to stop5 thus increasing
> the subsequent wakeup latency to ~200us.
> A mechanism is needed in place to update the PSSCR value each time the
> core is woken up due to special wakeup.

This seems like a shortcoming of the wakeup firmware that shouldn't need=20
any APIs to the kernel to solve, but the whole deep sleep wakeup seems=20
like a shortcoming so let's assume they won't do that for whatever=20
reason, then how much of a problem is this really? Are special wakeups=20
that frequent?

> Shortcoming2:
> ------------
> The value of LPCR is dynamic based on if the CPU is entered a stop
> state during cpu idle versus cpu hotplug.
> Today, an additional self-restore call is made before entering
> CPU-Hotplug to clear the PECE1 bit in stop-API so that if we are
> woken up by a special wakeup on an offlined CPU, we go back to stop
> with the the bit cleared.
> There is a overhead of an extra call

This is a self-restore call when we offline or online a CPU? That's not=20
a real problem either, is it?

> New Use-case:
> -------------
> In the case where the hypervisor is running on an
> ultravisor environment, the boot time is too late in the cycle to make
> the self-restore API calls, as these cannot be invoked from an
> non-secure context anymore
>=20
> To address these shortcomings, the firmware provides another API known
> as the self-save API. The self-save API only takes the SPR number as a
> parameter and will ensure that on wakeup from a deep-stop state the
> SPR is restored with the value that it contained prior to entering the
> deep-stop.
>=20

If the ultravisor is deployed in production only systems where we don't=20
use runtime deep-stop states, do we need to handle this case?

Thanks,
Nick
