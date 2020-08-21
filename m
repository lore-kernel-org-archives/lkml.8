Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E5F20838
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dchd+cFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHUVeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:34:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726599AbgHUVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598045642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgmuzKXgcjBcRgoPDChBvhGV7hX/eWB5I9mkSmfnUJ8=;
        b=Dchd+cFpZivxP+wA0OdqRTk4o24t/7K3dEB3QMacUt+HXmFPVacXKGlSGOet7kRamRi2f6
        5DO07W8U6vyHaYa2WpfFq/enj1B3nGyURH0SqZ7CSrLmicByNf6v8uXWeetwOCjErYhKGU
        1futwZpzsGK4cAczb203ksHnUfjLxnY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-bU5B_oRoMWCXy1NZGFrKkQ-1; Fri, 21 Aug 2020 17:34:00 -0400
X-MC-Unique: bU5B_oRoMWCXy1NZGFrKkQ-1
Received: by mail-ej1-f70.google.com with SMTP id e22so1234790ejx.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vgmuzKXgcjBcRgoPDChBvhGV7hX/eWB5I9mkSmfnUJ8=;
        b=g02qDWchY/zJXcT01W4y4UW2n12kP3BQdSPxu/9uIOiSYlEcSpDk+nWrPNacz1p9d+
         miEYrYAxB5MPQC8zX6tQ2Kselz0jxgewBlY+iuQZn+AM3Zx0a3wHvUfmr+0TEfKWMhUN
         j52FtPXbEqkxGnZCGxuUhvMtmNr37bgY05ag+HSQur/cs9hEn+mzxT9zDsEyd7Z4oQXn
         1nnZlIzgybm6CPOggYJTfdePjVW1WApR47Ywe7iu6xpXjIOuNlkFo1gQItCAQR5/Bh5e
         5N5W7kw6w9fMU7sF9mZi6YPAAFJjtO9njf7511mfnYaiqybcXnGI2yvDXwVeon3J8KSa
         ExSw==
X-Gm-Message-State: AOAM530rj++F2yYthbN37DQ2qZBuwpyO/MsZ1ghZ4GPZadPeo2BQ8BDN
        WKIsz8ClE1gRUQRMcClXJbCTeGF7+DRejXKuyC86bxW2ZGYmSdsLZCPp4XHUKxo6Qqa5MoulBBD
        YlpD8qjpCo9eAK7/HSSM4QJEO
X-Received: by 2002:aa7:db10:: with SMTP id t16mr4670989eds.196.1598045639010;
        Fri, 21 Aug 2020 14:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsY3HWTjNmnI8n64swZ39edXjTL651Y7phqEaxt8pR/mpnMiF2k94JkzZc4axtZWxBWkdbNw==
X-Received: by 2002:aa7:db10:: with SMTP id t16mr4670942eds.196.1598045638810;
        Fri, 21 Aug 2020 14:33:58 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6231.dip0.t-ipconnect.de. [91.12.98.49])
        by smtp.gmail.com with ESMTPSA id j21sm93193eja.109.2020.08.21.14.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 14:33:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
Date:   Fri, 21 Aug 2020 23:33:57 +0200
Message-Id: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
References: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
In-Reply-To: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 21.08.2020 um 23:17 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Fri, Aug 21, 2020 at 11:30 AM David Hildenbrand <david@redhat.=
com> wrote:
>>=20
>>> On 21.08.20 20:27, Dan Williams wrote:
>>> On Fri, Aug 21, 2020 at 3:15 AM David Hildenbrand <david@redhat.com> wro=
te:
>>>>=20
>>>>>>=20
>>>>>> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is n=
ot
>>>>>> automatically used in the buddy during boot, but remains untouched
>>>>>> (similar to pmem). But as it involves ACPI as well, it could also be
>>>>>> used on arm64 (-e820), correct?
>>>>>=20
>>>>> Correct, arm64 also gets the EFI support for enumerating memory this
>>>>> way. However, I would clarify that whether soft-reserved is given to
>>>>> the buddy allocator by default or not is the kernel's policy choice,
>>>>> "buddy-by-default" is ok and is what will happen anyways with older
>>>>> kernels on platforms that enumerate a memory range this way.
>>>>=20
>>>> Is "soft-reserved" then the right terminology for that? It sounds very
>>>> x86-64/e820 specific. Maybe a compressed for of "performance
>>>> differentiated memory" might be a better fit to expose to user space, n=
o?
>>>=20
>>> No. The EFI "Specific Purpose" bit is an attribute independent of
>>> e820, it's x86-Linux that entangles those together. There is no
>>> requirement for platform firmware to use that designation even for
>>> drastic performance differentiation between ranges, and conversely
>>> there is no requirement that memory *with* that designation has any
>>> performance difference compared to the default memory pool. So it
>>> really is a reservation policy about a memory range to keep out of the
>>> buddy allocator by default.
>>=20
>> Okay, still "soft-reserved" is x86-64 specific, no?
>=20
> There's nothing preventing other EFI archs, or a similar designation
> in another firmware spec, picking up this policy.
>=20
>>  (AFAIK,
>> "soft-reserved" will be visible in /proc/iomem, or am I confusing
>> stuff?)
>=20
> No, you're correct.
>=20
>> IOW, it "performance differentiated" is not universally
>> applicable, maybe  "specific purpose memory" is ?
>=20
> Those bikeshed colors don't seem an improvement to me.
>=20
> "Soft-reserved" actually tells you something about the kernel policy
> for the memory. The criticism of "specific purpose" that led to
> calling it "soft-reserved" in Linux is the fact that "specific" is
> undefined as far as the firmware knows, and "specific" may have
> different applications based on the platform user. "Soft-reserved"
> like "Reserved" tells you that a driver policy might be in play for
> that memory.
>=20
> Also note that the current color of the bikeshed has already shipped since=
 v5.5:
>=20
>   262b45ae3ab4 x86/efi: EFI soft reservation to E820 enumeration
>=20

I was asking because I was struggling to even understand what =E2=80=9Esoft-=
reserved=E2=80=9C is and I could bet most people have no clue what that is s=
upposed to be.

In contrast =E2=80=9Epersistent memory=E2=80=9C or =E2=80=9Especial purpose m=
emory=E2=80=9C in /proc/iomem is something normal (Linux using) human beings=
 can understand.

But anyhow, just details, and you=E2=80=98re telling me that that ship alrea=
dy sailed. So no further comments from my side.

Thanks for all the info!=

