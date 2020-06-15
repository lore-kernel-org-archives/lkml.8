Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0BBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BBC2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CAVO4gWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgFOUvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgFOUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:51:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:51:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so7303284plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NEGpBhzajRvF6MnLoS3/tW4o+xI54R1ORmU7+pXtHgE=;
        b=CAVO4gWs4evuqxTXK2KCGxd4s8FQi+TTDSLN297LSL3es1KODeKbGPV9mlrfjetsXf
         v0HKTGVYLoAqhJhrwOd5Vk0N5GOco/ahrHy/bgts2ivjvsbkW6XgnzOHmBrYE+Pp2Y1J
         nGdFYpsbdrlQlebSLBTotHPvmRSjaUsVZqye4Dd2PA0OURe3oRw0zP2eMBDcd6VQZihT
         FRcuywOs/douthqwTVN6eo7mcBIE7qXFhbRpBk2SHNXj25Qi3MP8jltZVZIXtbslMuaB
         VD3oaozewaoKV4crG14zN+9m85zBgfwiDTmWyKTBDDSH261G6U1wYGLJwtEtYDDK+7kb
         c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NEGpBhzajRvF6MnLoS3/tW4o+xI54R1ORmU7+pXtHgE=;
        b=BOQ2aHAGf8amOMCzoEb5AgpKsKMgjFsC3W+EXvmTaMwRcJfUou0UOLtoCRrBS0epF5
         viEH5I0aT8awGz/6nd4+DlLKUvdRwcxgCRbH1YCOTJTQpNb3TgLV29ll2DydDaoLrh8W
         lVsgKHqneFuY9vEtIsmE5jmGsyOoWThQ9l1GZRY3FoJXNzFklYarlW+wsjYiauDD9VK3
         0maPtwjXDsrbkXLmyVcwc8wlfyvwtZMEm6n4qge96+MYcN7Wgwn+AuxTFbTOnEZap7KY
         x1bbAhxHGOe1JB+vkb1Rdvfdu5pp/8b/I40SStlXLN7wt0W23jekCUHecnzvWrZXfero
         lTLg==
X-Gm-Message-State: AOAM530YLMhYzTitu/ZoX+mtgURgbnl2OVB1lXHMkqs1obx2zGqQChLY
        +o0E1iA2+uHmVGolaLyceda80w==
X-Google-Smtp-Source: ABdhPJzJVNx7nQtAyuRZTQv2cHaZxJpL+9jFfYmiZnjQELc31r77D7nEgtShc/qKvBOxL6bGQEnZAg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr13701253pll.338.1592254306139;
        Mon, 15 Jun 2020 13:51:46 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:bdcc:b60c:73b8:18ca? ([2601:646:c200:1ef2:bdcc:b60c:73b8:18ca])
        by smtp.gmail.com with ESMTPSA id i5sm14721024pfd.5.2020.06.15.13.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 13:51:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date:   Mon, 15 Jun 2020 13:51:39 -0700
Message-Id: <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
References: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 15, 2020, at 1:17 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFHi, Peter,
>=20
>> On Mon, Jun 15, 2020 at 09:09:28PM +0200, Peter Zijlstra wrote:
>>> On Mon, Jun 15, 2020 at 11:55:29AM -0700, Fenghua Yu wrote:
>>>=20
>>> Or do you suggest to add a random new flag in struct thread_info instead=

>>> of a TIF flag?
>>=20
>> Why thread_info? What's wrong with something simple like the below. It
>> takes a bit from the 'strictly current' flags word.
>>=20
>>=20
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index b62e6aaf28f0..fca830b97055 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -801,6 +801,9 @@ struct task_struct {
>>    /* Stalled due to lack of memory */
>>    unsigned            in_memstall:1;
>> #endif
>> +#ifdef CONFIG_PCI_PASID
>> +    unsigned            has_valid_pasid:1;
>> +#endif
>>=20
>>    unsigned long            atomic_flags; /* Flags requiring atomic acces=
s. */
>>=20
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 142b23645d82..10b3891be99e 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -955,6 +955,10 @@ static struct task_struct *dup_task_struct(struct ta=
sk_struct *orig, int node)
>>    tsk->use_memdelay =3D 0;
>> #endif
>>=20
>> +#ifdef CONFIG_PCI_PASID
>> +    tsk->has_valid_pasid =3D 0;
>> +#endif
>> +
>> #ifdef CONFIG_MEMCG
>>    tsk->active_memcg =3D NULL;
>> #endif
>=20
> The PASID MSR is x86 specific although PASID is PCIe concept and per-mm.
> Checking if the MSR has valid PASID (bit31=3D1) is an x86 specifc work.
> The flag should be cleared in cloned()/forked() and is only set and
> read in fixup() in x86 #GP for heuristic. It's not used anywhere outside
> of x86.
>=20
> That's why we think the flag should be in x86 struct thread_info instead
> of in generice struct task_struct.
>=20

Are we planning to keep PASID live once a task has used it once or are we go=
ing to swap it lazily?  If the latter, a percpu variable might be better.

> Please advice.
>=20
> Thanks.
>=20
> -Fenghua
