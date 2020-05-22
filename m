Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B49C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED80C204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgEVOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:46:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgEVOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:46:33 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MplPh-1jGolW1bDB-00qBfc for <linux-kernel@vger.kernel.org>; Fri, 22 May
 2020 16:46:31 +0200
Received: by mail-qk1-f169.google.com with SMTP id f13so10955775qkh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:46:31 -0700 (PDT)
X-Gm-Message-State: AOAM533Xvy54bNuJ2f5pzevaee7ls6/C10KoORXZYTkEIP9dClJddvSc
        kmip8z+mgeumRHXhKz4qAFdMX0lCYcAPfNsi94Q=
X-Google-Smtp-Source: ABdhPJwmy6G1wj6rGXkLGjuBlUbBUGagMMbZcrCm8GJrsSSbymy5nqhhK5vv/LW4p6M6tI7x1VRfvM/WVypzvcohCls=
X-Received: by 2002:a37:434b:: with SMTP id q72mr16186729qka.352.1590158790247;
 Fri, 22 May 2020 07:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200522124951.35776-1-sudeep.holla@arm.com> <20200522124951.35776-3-sudeep.holla@arm.com>
In-Reply-To: <20200522124951.35776-3-sudeep.holla@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 16:46:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1t6BrB_Gti138VDRbmaiR_TjwR9d6qMstLBFDWxZ1kjQ@mail.gmail.com>
Message-ID: <CAK8P3a1t6BrB_Gti138VDRbmaiR_TjwR9d6qMstLBFDWxZ1kjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        harb@amperecomputing.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francois Ozog <francois.ozog@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eUgxqSzEZfnXE/1hGmbTVnvsKP2q4WegGufvE2inKA1u4Nkwrz2
 Q0Qi4Jgx90YiqsEQP3fBIPunYbP1JsbKbz0QdIWmQy0tLxgThaWdqmtG0noQL7q4OSj2bvR
 XXouDtPCvz0g8wYVDBsl4obqFjLUGaHEUr0H+jJOYKNbE/kJCjKUE+om3RmmHj37ifWXHZD
 P0fwZagr4k/luCc5H09ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R1yk67n4mYc=:91k32ihezTulJxhTAjnkam
 dkjanHvL/foC9H2C+JCdTX5HtDxyj1F7x1/fSPv7J1/PmYMQhX0nrW8grLg3bua7FM+EyX3mS
 j67ESIQbdxhAx0cLlqWDGSJit0Po1RWQ9LfepcSCy9hx68cDsVhuUwStylItkob7DD6RVrQ0K
 q/wIQrq/f49wAJTWbxoTQ8MrexDsMmySxarpdRthVmnOT9hvX0H7Ew2yRohqXiWX3lSZ3KUQe
 oVUzEpOq8+MsKV44Yc1qNiVaiMreiG51NNVsrTCN1ya6nbxpN3IVLkmmIdiJWKUU9b5IG5bQC
 2HlnSBkDn11Nw0vE1FGlPcKGcVooRberJi3evUchdv+mNR7tqcOYEEHxsf5yLH1dvITIALFO6
 2dsFIk1ofo54ZO8jUA3WnDunZLMHynLZJLDZvdZAKx1brQi4yRh3nDqUhdXqj7NrwqBsZTmYL
 95aiKerJcvVK4s0UBi0I/zdnm5F1q5j4SRuBtCK/L4Zk8cbARt5fS/6uBIDlW0ZLQhS8RDcw8
 JEU1IAzA+IbiVejzfU0VbdhnMMDHS7uEaTOkX4IeUCaKopejdzieyQAcqmXoD/II9WKN6OWZ/
 pjndVZ1dideDikugWpTHhTtYdorn9BvXhie/VOdSE4vG+VAxyKsFfPPZJ7YM4EKbK8u6QjdxZ
 Z9zsTscHPb0+GgWNYfxOTJlO3MUVh7S34FlVhLk/zOhzTOHT0k4ziBffOv/s8VbCXPbhrkU9v
 C2FFC1b7qHSZg+Ef9z81E9jbqULaDozwOWhI88pKUiIG95MdvyDop6Ou+joi0lUEc6t2Jtx3j
 KT84NjWvRjBXcGNdwYjKlO/7lfHaLHj64R2pUuS2BYT+IJHTMY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 2:50 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> +
> +       soc_id_rev = res.a0;
> +
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (!soc_dev_attr)
> +               return -ENOMEM;
> +
> +       sprintf(soc_id_str, "0x%04x", IMP_DEF_SOC_ID(soc_id_version));
> +       sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> +       sprintf(soc_id_jep106_id_str, "0x%02x%02x",
> +               JEP106_BANK_CONT_CODE(soc_id_version),
> +               JEP106_ID_CODE(soc_id_version));
> +
> +       soc_dev_attr->soc_id = soc_id_str;
> +       soc_dev_attr->revision = soc_id_rev_str;
> +       soc_dev_attr->jep106_id = soc_id_jep106_id_str;

Ok, let me try to understand how this maps the 64-bit ID into the
six strings in user space:

For a chip that identifies as

JEP106_BANK_CONT_CODE = 12
JEP106_ID_CODE = 34
IMP_DEF_SOC_ID = 5678
soc_id_rev = 9abcdef0

the normal sysfs attributes contain these strings:

machine = ""
family = ""
revision = "0x9abcdef0
serial_number = ""
soc_id = "0x5678"

and the new attribute is

jep106_identification_code = "0x1234"

This still looks like a rather poorly designed interface to me, with a
number of downsides:

- Nothing in those strings identifies the numbers as using jep106
  numbers rather than some something else that might use strings
  with hexadecimal numbers.

- I think we should have something unique in "family" just because
  existing scripts can use that as the primary indentifier

- It seems odd that there is no way to read the serial number through
  the same interface and publish it the usual way. Francois Ozog
  recently asked for a generic way to find out a serial number for
  inventory management, and this would be the obvious place to have it.
  It can of course be added later when the next revision of the spec
  is there, it just seems like a surprising omission.

How about making the contents:

machine = "" /* could be a future addition, but board specific */
family = "jep106:1234"
revision = "0x9abcdef0
serial_number = "0xfedcba987654321" /* to be implemented later */
soc_id = "jep106:1234:5678" /* duplicates family but makes it unique*/

That would work without any new properties, dropping the other patch,
and be easier to use for identification from user space.

    Arnd
