Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A0C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0702087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="P8NO8aVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAQQhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:37:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44107 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgAQQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:37:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so11911264pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=RNWWCVGYKHQRdgXeUqzs/1Y+g1VA0PpgKrmxIK9jS8k=;
        b=P8NO8aVK+8d8HJdB+5SLjrKA/pLZ17eYnFolIiM3tC3xrkZggLUs8XCqbSujMhPM6M
         vcr740r8nahQv5xCuNzRpGX1y3GJc5kc1zRTMKgi6trOcfZQyity5gISTlYdeWXIdMZo
         V+crmzvSXj+v5NfibZ0PoagCISYKMibMFRFF9BJl2EFIRcwAC1+acP1auuFzCVyId3e9
         IH9MGHJRrSUS+7gXN8x9KSvxPv9W2WFtAp0GaDlSkDEjF6hYsS6Jg1NkPdnzV9rwILTD
         JIug5rE9e8QsYnYUCUzSgGy6wg4s7M0QUDTTsYjUYTPpdlX70Q3M4jHflEFbbwT6WlZy
         3Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=RNWWCVGYKHQRdgXeUqzs/1Y+g1VA0PpgKrmxIK9jS8k=;
        b=ib8AFK8wC2vBuosX7qfqPTb6b4rvFdPob2DkVblSL2DbKfNDta58e8msnmD+PbWikI
         ONu5Y7EKy3wKAJN4Crg3DDoZ0/aORCDn5f+UjkJjAYq587X16fS8Kuu6oJFxmxbbCKcR
         1fqcnhwvt6ho3LSpUctRXPGoHWlSo8d9/HvAWCcrQyBhXOIlCMGviWrlwW9h7noTPypt
         K5NmFD5Ka5Z/+fi5sGvHC+m7l9qlx70CIhuMr8kyVYGRFS1lIV7wWOZdtkKYvm7V/i8f
         5emTvg3A9DXuBaSQz1xRXLx1Zh7ya6WM/3APfdN0tobVHKWapGZWakKgj/AXXkHLg8N2
         0yMA==
X-Gm-Message-State: APjAAAVfkX/gYtI9E2n8vgmBgwrFcbzmd6mWjW6Fd3wxdEeMJmW0mZEv
        0RaRUXTdSemhFApT33Lb7Oe72Q==
X-Google-Smtp-Source: APXvYqxbIl26+BtOx2oym3NWETV0agA+tNXWMAOyCMbGeapPo96d25B0qRyxq4Be+EVMN4ekBdUsZA==
X-Received: by 2002:a63:1344:: with SMTP id 4mr47566362pgt.0.1579279035198;
        Fri, 17 Jan 2020 08:37:15 -0800 (PST)
Received: from ?IPv6:2600:1010:b02e:cd00:cd8d:20c9:ed2e:d844? ([2600:1010:b02e:cd00:cd8d:20c9:ed2e:d844])
        by smtp.gmail.com with ESMTPSA id y7sm30806645pfb.139.2020.01.17.08.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:37:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/tsc: Add tsc_tuned_baseclk flag disabling CPUID.16h use for tsc calibration
Date:   Fri, 17 Jan 2020 08:37:12 -0800
Message-Id: <6BFAC54D-65CA-4F8A-9C5B-CEFB108C90FD@amacapital.net>
References: <9rN6HvBfpUYE7XjHYSTKXKkKOUHQd_skSYGqjXlI0jTIk4nqLoLUloev1jgSayOdvzmkXgRNP8j_mgcikMJy6L_JN_vJhUJn9vD9xm_ueSo=@protonmail.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "malat@debian.org" <malat@debian.org>,
        "mzhivich@akamai.com" <mzhivich@akamai.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <9rN6HvBfpUYE7XjHYSTKXKkKOUHQd_skSYGqjXlI0jTIk4nqLoLUloev1jgSayOdvzmkXgRNP8j_mgcikMJy6L_JN_vJhUJn9vD9xm_ueSo=@protonmail.com>
To:     Krzysztof Piecuch <piecuch@protonmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 7:21 AM, Krzysztof Piecuch <piecuch@protonmail.com> wr=
ote:
>=20
> =EF=BB=BFChanging base clock frequency directly impacts tsc hz but not CPU=
ID.16h
> values. An overclocked CPU supporting CPUID.16h and partial CPUID.15h
> support will set tsc hz according to "best guess" given by CPUID.16h
> relying on tsc_refine_calibration_work to give better numbers later.
> tsc_refine_calibration_work will refuse to do its work when the outcome is=

> off the early tsc hz value by more than 1% which is certain to happen on a=
n
> overclocked system.
>=20

Wouldn=E2=80=99t it be better to have an option tsc_max_refinement=3D to inc=
rease the 1%?


