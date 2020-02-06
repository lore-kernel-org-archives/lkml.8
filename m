Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2337FC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB0F21927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Luey5zHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBFThK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:37:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgBFThJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:37:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so2750835plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rKTvlvWyi8MG0YmfjREezL+sDnmmMkY4ULQZDe7XKuE=;
        b=Luey5zHoxj6esRIvL6Pt376gxqW6K6LoCYn2YfW/AUsKavFVKAQb4yZv5jrrN1oaO/
         xvmWXthtMLcI+EIgAZOXD4vNmSw/P1SR1h1HD8faleytiWTezXxggiK3i+pUZL/B37eP
         pF7DVuYKz1MhmKp2/PUl0z7AgQmWH6d+mlDF1lYYqPpmAE4O4mbTShNCdiIr/nj8ZNvW
         q/9d5ignoX4uEL6osYOGS+foEU2Xfx63a/Fs6zSWH2Wd/aZ3OscMYT0JFmF3AFdFO6GB
         bavwPuOP5r+u5lVNiC4ovGmHOhZ0R1j6LgvxXjkkE5BjMxj+O72CBnxBhDdmA1tneaGS
         +XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rKTvlvWyi8MG0YmfjREezL+sDnmmMkY4ULQZDe7XKuE=;
        b=dB00TET4SNFxk93l03A+V+Ym3fAMIcv5Wida3yKBacnytOv6z8qwtrvfJ/cidKcX3e
         4cV6a8/qGW4bgv+V4zP368PZiaNPH8QdiKKGgyRB/QxunWZUA0Jc96u1/sg8qXHGGH9i
         mI80iOtEwQJfQ7/Kvpz11UzsQyLduDBKiPNiPvl+KeMJePL4MaQF/l6Fw+zqOoQcK4bs
         wLkm4mqxDjOXbuVfsPZJGW++sIfrz03lh57pnZwNNwsbRuTFJ06EnXL4/yVvdRX0e1AI
         vG4KrWcsfpTHFFvM913EfyKAs7XSy8JO/sT2g3XTaez2QX7pdpxE9CAlqsVTm3dRYAEG
         KpWw==
X-Gm-Message-State: APjAAAX4QboGmd3pYi0ApeLJq73HXuvNmZbxgL4DF5s1tC+fZRlur+QD
        eMtxI8ZCxDzkR6NjpWbk5X86QA==
X-Google-Smtp-Source: APXvYqz3Xs9Mr5Nc/buTnZT64APYXm+duBPZG+BIkJErZl09ghXH3nQmK34YrlsgLTsFMzivXxDDZQ==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr6452821pjs.73.1581017829153;
        Thu, 06 Feb 2020 11:37:09 -0800 (PST)
Received: from ?IPv6:2600:1010:b01f:241b:9d8d:a655:f13f:191f? ([2600:1010:b01f:241b:9d8d:a655:f13f:191f])
        by smtp.gmail.com with ESMTPSA id k1sm195149pfg.66.2020.02.06.11.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 11:37:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
Date:   Thu, 6 Feb 2020 11:37:04 -0800
Message-Id: <6735A646-3817-4030-B9B9-11492BB1B8F0@amacapital.net>
References: <20200206164614.GA20622@agluck-desk2.amr.corp.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20200206164614.GA20622@agluck-desk2.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 6, 2020, at 8:46 AM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BFOn Wed, Feb 05, 2020 at 05:18:23PM -0800, Andy Lutomirski wrote:
>>> On Wed, Feb 5, 2020 at 4:49 PM Luck, Tony <tony.luck@intel.com> wrote:
>>>=20
>>> In a context switch from a task that is detecting split locks
>>> to one that is not (or vice versa) we need to update the TEST_CTRL
>>> MSR. Currently this is done with the common sequence:
>>>        read the MSR
>>>        flip the bit
>>>        write the MSR
>>> in order to avoid changing the value of any reserved bits in the MSR.
>>>=20
>>> Cache the value of the TEST_CTRL MSR when we read it during initializati=
on
>>> so we can avoid an expensive RDMSR instruction during context switch.
>>=20
>> If something else that is per-cpu-ish gets added to the MSR in the
>> future, I will personally make fun of you for not making this percpu.
>=20
> Xiaoyao Li has posted a version using a percpu cache value:
>=20
> https://lore.kernel.org/r/20200206070412.17400-4-xiaoyao.li@intel.com
>=20
> So take that if it makes you happier.  My patch only used the
> cached value to store the state of the reserved bits in the MSR
> and assumed those are the same for all cores.
>=20
> Xiaoyao Li's version updates with what was most recently written
> on each thread (but doesn't, and can't, make use of that because we
> know that the other thread on the core may have changed the actual
> value in the MSR).
>=20
> If more bits are implemented that need to be set at run time, we
> are likely up the proverbial creek. I'll see if I can find out if
> there are plans for that.
>=20

I suppose that this whole thing is a giant mess, especially since at least o=
ne bit there is per-physical-core. Sigh.

So I don=E2=80=99t have a strong preference.=
