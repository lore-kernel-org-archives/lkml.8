Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD6C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471B520730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ZK2uy6zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBFBI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:08:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42920 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBFBI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:08:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so1831895pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 17:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=1HZcNHl+ZiGpLzKAil0t0TkdkIzFUKmP524EuuoH/Ck=;
        b=ZK2uy6zAf8SYDYMAseyEf2T3wvNO+N2p6rIMpZuapl0EwOuRCnXCf7qbzcpV+ygIJs
         s4CKahRf2Zf/LvTzUkSzrvLGKir2UE7XQeUeFVyAE0SJyBVvuMr61s+n8KUO2bYd2jj7
         uRFoPW+KlauWDInVKrYj7T6+hNn/769D5xKBVbkLZ4vGEp+T8ch5erkam4ZEpsxO1yGo
         66bcJmvHujD5Sw5RzuJxxzXcLmFJ8ciSuEkXRyH+/jAFvIMo0QK8F7zSfxhdCUtVtwM+
         AI+fMDki0M6jbxBG2DcDaYxN85rripRxj/9okSc0/AwRvqine/4J70GkJUTbFacTBY9B
         vy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1HZcNHl+ZiGpLzKAil0t0TkdkIzFUKmP524EuuoH/Ck=;
        b=gBJYbmqHhu1R8bwirM36XqbjfEnSL4z0XKLhztqjPVcfXRs3iLYqtg/NmCN827w/qV
         bDpejhSIEdlMNPjPwQmeXtrO0/VUadn9I+gMinu3UcUgfZm1PTfXTP0xLMiuUC+Dv817
         PK5u2LvCHI6M9Pkf1DWvud7+FaS7tDGOVq/zRQERJYpV4iKgYetBUBCsqXAfV3Ka/Gez
         zuF4onPuXmTOlSeQadFZoHa2s9YOLEyXN0qhNMdNg7q77mI+uC9nrxbv9K7+VQgyfFpd
         zCzVvevH77qw2utYtMjEExB+sN8yN0nzQGo5vXv3R1rBda3Yhd2cNQLymVU55CYAUcA/
         tVdQ==
X-Gm-Message-State: APjAAAUtTQPqkG1aE97THnICanrvOSc9bFzfRKwwWCZUzv7jxvuOhVH5
        9nBEnKaBN+8uXmmgdiI567Zvmg==
X-Google-Smtp-Source: APXvYqy7pvBZcO+eOecBxTvLL58gD0rbga7ewLCu2hhFz6QVLOGxlNzZCUEXzcvCOMf0LBZkgSqn3w==
X-Received: by 2002:a63:e243:: with SMTP id y3mr710289pgj.361.1580951337276;
        Wed, 05 Feb 2020 17:08:57 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:39b0:37ac:a612:685e? ([2601:646:c200:1ef2:39b0:37ac:a612:685e])
        by smtp.gmail.com with ESMTPSA id y2sm706571pff.139.2020.02.05.17.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 17:08:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 03/11] x86/boot: Allow a "silent" kaslr random byte fetch
Date:   Wed, 5 Feb 2020 17:08:55 -0800
Message-Id: <B173D69E-DC6C-4658-B5CB-391D3C6A6597@amacapital.net>
References: <20200205223950.1212394-4-kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
In-Reply-To: <20200205223950.1212394-4-kristen@linux.intel.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 5, 2020, at 2:39 PM, Kristen Carlson Accardi <kristen@linux.intel.c=
om> wrote:
>=20
> =EF=BB=BFFrom: Kees Cook <keescook@chromium.org>
>=20
> Under earlyprintk, each RNG call produces a debug report line. When
> shuffling hundreds of functions, this is not useful information (each
> line is identical and tells us nothing new). Instead, allow for a NULL
> "purpose" to suppress the debug reporting.

Have you counted how many RDRAND calls this causes?  RDRAND is exceedingly s=
low on all CPUs I=E2=80=99ve looked at. The whole =E2=80=9CRDRAND has great b=
andwidth=E2=80=9D marketing BS actually means that it has decent bandwidth i=
f all CPUs hammer it at the same time. The latency is abysmal.  I have asked=
 Intel to improve this, but the latency of that request will be quadrillions=
 of cycles :)

It wouldn=E2=80=99t shock me if just the RDRAND calls account for a respecta=
ble fraction of total time. The RDTSC fallback, on the other hand, may be so=
 predictable as to be useless.

I would suggest adding a little ChaCha20 DRBG or similar to the KASLR enviro=
nment instead. What crypto primitives are available there?=
