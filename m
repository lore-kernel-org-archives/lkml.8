Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7A820739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2GB7LupH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgFOVSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:18:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA18C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:18:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so449132pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=K+cMiKrRga91vCTBmD8D5XGxUlsSQ1EKO7QoeTvwQ14=;
        b=2GB7LupHwlZ6MZtJPWSNxp3apFXotPM40suzbHcMbHpAtfxMDlfoT68CSyoFNL8a5W
         Z0tAhownZcTP8TRk6IoslRw8BJAf1OXzJREAwoj7wWd3V14OSBwEBVF70E7hminRlU56
         2VsxRj20OP0xyXqNS18gd25MtW6DEU2un5q7P64tYWB4Fs7qzeb27Scj4voailQZlsxX
         kibSCzCnlI3uAzFI7DH/O+JIlSgCq0aVl2WDsd7HhTrTfAWwnO/iAvwlYH/1TAJRTivU
         y1ZhI4gCO2NoAYrkyYozZCRaczRqz8a/Xr9GEbYWOyr3GPdZ6rbRamLSMm4DX8QTnYXG
         f0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=K+cMiKrRga91vCTBmD8D5XGxUlsSQ1EKO7QoeTvwQ14=;
        b=BnX58WuLjPUoO9AHOjepSbkbE2k0PDOA0JWGuB0H/XCOXJ0IGV1pVJBWHFk7b117z3
         zl5BOV8bfKQZMO3DmAJv7jgaFc1IT+TJTOMP/oNCzGhvP++GVdc6h482rhg8LA4BlcOk
         QmhyjD9Vy/WWPR7wXqApnjPCAvO3Rp8kiqMUeJAYpuRvgVq0qn/rQa8FPP9choBxW8oq
         CIdH3XHCUy4gdTeypz/wKn3pSzUJAvHfYDqJOaZPyeaiLOeQ02bP25gBN5GGm5B9qFzY
         7I4/EBT7FfY7Z4knmjGovOiA1CC3pSwja5BQlRs0rwJR0ZVIA2xFR8zGXyMFCLXjWFZ/
         bMDQ==
X-Gm-Message-State: AOAM5324OK1FfcZY9SaEfvWdMCM8ArlI8Cp1dr6b+LM6H/EA1gSPIXU0
        pWNQPoKd+P6tXv8kZRyb1YkCUQ==
X-Google-Smtp-Source: ABdhPJyk8XIeff9RCB4w5FuIJDrmQLNmbSUdiTI79aWKrOQ2lLPVa5D7eCOAxgksAA4QZIZRamSHVA==
X-Received: by 2002:a17:90a:e509:: with SMTP id t9mr1153242pjy.189.1592255922875;
        Mon, 15 Jun 2020 14:18:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d2f:b9d:749:9ce5? ([2601:646:c200:1ef2:d2f:b9d:749:9ce5])
        by smtp.gmail.com with ESMTPSA id g65sm14766552pfb.61.2020.06.15.14.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 14:18:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date:   Mon, 15 Jun 2020 14:18:39 -0700
Message-Id: <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 15, 2020, at 1:56 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> Are we planning to keep PASID live once a task has used it once or are we=
 going to swap it lazily?  If the latter, a percpu variable might be better.=

>=20
> Current plan is "touch it once and the task owns it until exit(2)"
>=20
> Maybe someday in the future when we have data on how applications
> actually use accelerators we could look at something more complex
> if usage patterns look like it would be beneficial.
>=20
>=20

So what=E2=80=99s the RDMSR for?  Surely you
have some state somewhere that says =E2=80=9Cthis task has a PASID.=E2=80=9D=
  Can=E2=80=99t you just make sure that stays in sync with the MSR?  Then, o=
n #GP, if the task already has a PASID, you know the MSR is set.=
