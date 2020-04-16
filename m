Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0EC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122B1206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkzxHgIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391751AbgDPA3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391714AbgDPA3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:29:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8476C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:29:12 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x10so5773222oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeXd8f9J30PgVFJ7Z+WgbUhdu7rs2z9sqFP5jQ5Rms4=;
        b=fkzxHgIOqEjwuIosHr9XmQjcVbxGyuyyncMmIKtBRy2n1ATDf9hSL8qMF8+8CCdDyA
         wououMrcJsN/rDXNRAzh59RbkXQpLrJ0BNFC4X1fEwtKE8izrLemCYJZsVeRrPfxJITu
         wkI5ti8qldm3gUdm95Zq5S+B6IleEGfxZ31au8kCUg+w39Fq8riSYOHkd1CyGMzPjQXL
         9l9Z8YgX35Q1cIQgH0i9nYi0TXXTbgLFEsAd4/mId92Z6HWufi2SVoucENSPZOK5Z30q
         HiErD0IrYQ8+hAlaLCpqdV/U/1SEpWoRWOsgu4IzMphWBg7nJRo5hw6Td0LQDZ3PdnUh
         5dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeXd8f9J30PgVFJ7Z+WgbUhdu7rs2z9sqFP5jQ5Rms4=;
        b=HvF37PTr3CXbVquanWLNdSLQ+4dTkgEbhEhJEL5ebdeo3B4f9/GxR+Hd/WuXIDzi3v
         gtKpRV723/i4BhlGmqdtEm5FNDoSaziEb+iSx4bqBtvNv6Ab5Y/Gmps/EjCDk7hYSUWV
         mv6wuP2S3RXtvh0vY7obxjxu68aQVd/sIKuM3r/KNM3z3xn3lb+7Z/j0e011afBBZLWu
         jMXXDaYEjlhgflf15ub/B2PDcLSQGADgl8w8g+sBFGAj3Pxq1Pv1fJ7ZmhsZ/gLHtb3/
         ZS5Yf6FXa7yIy5vexWcodpIyeeF1CJDuU0+qSJoaPTaScIU5jHBe/+ycxurmDhvjfS9a
         puww==
X-Gm-Message-State: AGi0PuYgJ7EtvYWsMOhHXz/TaX7SOdpQuYxQ9Swv1zoo2Df4NcUBRZlh
        YGpa+KI7DYceHzPsv+06rjVyaogZ16gUcKOpL0RQhQ==
X-Google-Smtp-Source: APiQypKqxX1Fl3V2SnfLeZZgj6SmNm3X1EEdrsgQfCYgSGa09GLLNNURx+AKzwqwjs7SlbDusY22alHpQpyRzJdkTLk=
X-Received: by 2002:aca:5d83:: with SMTP id r125mr1414954oib.8.1586996951792;
 Wed, 15 Apr 2020 17:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200416002616.1456-1-rcampbell@nvidia.com>
In-Reply-To: <20200416002616.1456-1-rcampbell@nvidia.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 15 Apr 2020 17:29:00 -0700
Message-ID: <CAHS8izNenS4ZW3fxFtJ-jzZ9QwP192N3KPB7n6qQrVcoP8PNgg@mail.gmail.com>
Subject: Re: [PATCH] hugetlb_cgroup: remove unused variable 'i'
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-kselftest@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 5:26 PM Ralph Campbell <rcampbell@nvidia.com> wrote=
:
>
> Compiling tests in tools/testing/selftests/vm/ results in a C compiler
> warning:
>
> write_to_hugetlbfs.c: In function =E2=80=98main=E2=80=99:
> write_to_hugetlbfs.c:77:16: warning: unused variable =E2=80=98i=E2=80=99
>    77 |  unsigned long i;
>
> Delete the unused variable.
>
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation test=
s")
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Whoops, sorry about that.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/vm/write_to_hugetlbfs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/test=
ing/selftests/vm/write_to_hugetlbfs.c
> index 110bc4e4015d..6a2caba19ee1 100644
> --- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> @@ -74,8 +74,6 @@ int main(int argc, char **argv)
>         int write =3D 0;
>         int reserve =3D 1;
>
> -       unsigned long i;
> -
>         if (signal(SIGINT, sig_handler) =3D=3D SIG_ERR)
>                 err(1, "\ncan't catch SIGINT\n");
>
> --
> 2.25.2
>
