Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D9C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A412F215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AWpMVeNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEGSxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgEGSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:53:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE2C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:53:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so579272qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HdnkYkSkwpLh+orrApa7Rm9CqGAa5Q8eU7irYvG3X2E=;
        b=AWpMVeNZtOcDehpQv6YuIjQbfY2hoFmZeODxYBSwYnNCPscHVRQK1TfnTzoJ3IejYj
         9sQQIK2kcFod+PFjfSF4IyqyWYNywT0GmAfJwJTEA+8n+DH25ZlBk1ZeQDdsGoUaCF0S
         0EasjR5EywfSB6e5oZ4dg3aejrGFDmxnv24t+WwCji3bKD8DiOgJFDNIVx5RCidj3ecI
         ToHY3lm1/HKg/+1n1cVTgMbN8JrBQwlCZIma6JeMIGO4bZBE2QFRhwRMVw77DUwcSh+n
         cPfffJde16piheXEnT3pr3SBVXVIcyFxhq3o3oGVwAlDGvxhmTXRLhfM8h86M2IDVsEk
         EJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HdnkYkSkwpLh+orrApa7Rm9CqGAa5Q8eU7irYvG3X2E=;
        b=kprFjRJa8z2QHqWmJ/Cjj/i9Sm3dKkeFA2d/6W4MVWhVSqXz6Tm5i6J6YY3WFWLOAQ
         OziGZSS8eKGy1gJf7AWdrJLO5X+eNxeji5bwD6Uab/s/K57aMnarFytwb786+9rRr5df
         e5RCl0J0CWUM6myhTOES5jeB6YznktUWbCrGCry0laHbWw7CIQ4at+S2Wlrh5+VhcN7b
         2h8P0hRsLIGwHY7p5xo90coBvnW41VwS12pg/lMEEcUWkkNnzlzwgQJ93TppIWCvFHI8
         hHgBx0Qhk6sDenYgxtRtOiznh1ucMxCiXdxei7FXnfo5H7QvJKSyzuODUUjwHLi0pwCj
         j2DA==
X-Gm-Message-State: AGi0PuY3hsZ3QMA+zQFtJw3ptur6i+8CpvtMLylcIZ9wkFhEDJnDHwWa
        2HpW+iZTysU8r0csw4ieeDxpOQ==
X-Google-Smtp-Source: APiQypI3RGmKJcNRWmEz8e03pNcyFWvkIc5Dug+RCrqXfLu381OE9XW+rZkkPmVn+2A+AIVLYEV/CQ==
X-Received: by 2002:a05:620a:2fa:: with SMTP id a26mr8474627qko.295.1588877625313;
        Thu, 07 May 2020 11:53:45 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q207sm146330qka.13.2020.05.07.11.53.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 11:53:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Clang and UBSAN: member access within null pointer of type
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAKwvOdmMjwoTZFSp2DnzeKePxgczfOJyOH_T-vyzHGcm5cFXgA@mail.gmail.com>
Date:   Thu, 7 May 2020 14:53:43 -0400
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3E33F8C-D9DF-4029-B03E-3E7DDFD572BF@lca.pw>
References: <CA6078C3-3489-40E4-B756-A0AF6DB3A3A5@lca.pw>
 <CAKwvOdmMjwoTZFSp2DnzeKePxgczfOJyOH_T-vyzHGcm5cFXgA@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2020, at 2:30 PM, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
>=20
> On Thu, May 7, 2020 at 6:42 AM Qian Cai <cai@lca.pw> wrote:
>>=20
>> Running a Clang (9.0.1) build kernel with UBSAN generated a few =
warnings during boot,
>=20
> Very cool, these reports are so nice! They hand you everything on a
> silver platter.  Thanks for testing/sending!  Let's take a look.
>=20
>>=20
>> [    0.000000] UBSAN: null-ptr-deref in =
drivers/acpi/acpica/tbfadt.c:459:37
>> [    0.000000] member access within null pointer of type 'struct =
acpi_table_fadt'
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted =
5.7.0-rc4-next-20200507 #2
>> [    0.000000] Call trace:
>> [    0.000000]  dump_backtrace+0x0/0x22c
>> [    0.000000]  show_stack+0x28/0x34
>> [    0.000000]  dump_stack+0x104/0x194
>> [    0.000000]  handle_null_ptr_deref+0xdc/0x10c
>> [    0.000000]  __ubsan_handle_type_mismatch_v1+0x64/0x78
>> [    0.000000]  acpi_tb_create_local_fadt+0x104/0x6ec
>=20
> ok so acpi_tb_create_local_fadt() dereferenced a `null pointer of type
> 'struct acpi_table_fadt'` in null-ptr-deref in
> drivers/acpi/acpica/tbfadt.c:459.
>=20
> That line number doesn't line up with linux-next; which tree was this?
> That will probably help track these down faster.

It is linux-next indeed as in the signature.

next-20200507

# ./scripts/faddr2line vmlinux acpi_tb_create_local_fadt+0x104/0x6ec
acpi_tb_create_local_fadt+0x104/0x6ec:
acpi_tb_convert_fadt at drivers/acpi/acpica/tbfadt.c:459
(inlined by) acpi_tb_create_local_fadt at =
drivers/acpi/acpica/tbfadt.c:388

This line,

        if (acpi_gbl_FADT.header.length <=3D ACPI_FADT_V2_SIZE) {

acpi_gbl_FADT was defined in,

.//include/acpi/acpixf.h:266:ACPI_GLOBAL(struct acpi_table_fadt, =
acpi_gbl_FADT);

#ifdef DEFINE_ACPI_GLOBALS
#define ACPI_GLOBAL(type,name) \
	extern type name; \
	type name



#define ACPI_INIT_GLOBAL(type,name,value) \
	type name=3Dvalue



#else
#ifndef ACPI_GLOBAL
#define ACPI_GLOBAL(type,name) \
	extern type name
#endif



#ifndef ACPI_INIT_GLOBAL
#define ACPI_INIT_GLOBAL(type,name,value) \
	extern type name
#endif
#endif

I looks like DEFINE_ACPI_GLOBALS should be set in =
drivers/acpi/acpica/utglobal.c.


