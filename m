Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE8BC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4402071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BpEFviSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgCSKFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:05:12 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39021 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCSKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:05:10 -0400
Received: by mail-qt1-f170.google.com with SMTP id f20so1243244qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DZKMSyu0caMbSHPp7LnrnLmiKn3lBRmEg4h+wkqOnUU=;
        b=BpEFviSRmooc9XZIQNWWcH56jXjByIMgvkaAFQ8cvH4lLZgxhGwaXzIl60zP8DRmwn
         DPPm0k2Az7W4mL8BLhW+M3R9K6nigcnlPxOsGCW/oaCTtjVjyZeEr0vO/aPehoS01/Oh
         ENo//dV32jTSAB72ljRG8jgA7TvBlNUXtvNV4+mTO65GuQ5ieB6OqF24QmV5JtXr8Dz8
         CcEi4GhrbSs/LflvZSTxhG1YIOrrN5jblo3f2g4rn5oIYyUIkLHWCD6xAvMAd8dDcOVC
         dhldwlMQg7t/hzJqrNLCOsqAsojrxQUH5dXsYtJPI8Azh5GBB9y9GWtCtF+nJ4qYYu6y
         Wcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DZKMSyu0caMbSHPp7LnrnLmiKn3lBRmEg4h+wkqOnUU=;
        b=fD4/bI6YTlXv697Vy2wTARnIqm/E5a7pNCdkq0Po6YWrWRvsuA89o2kd06Fa5tUucs
         aoykJd3ztHqs5+sQd1wHVKAx1laVVR6ZnM/YVOrLDeb3G7ibaVHNK6dzoNxSqCFqxL82
         jtb48oS1EPZd36s143/8l+TBdAb3q5NoBg1yR1o+NndgU9qYN9mIE2g7OeYLyVuhWXfG
         AD5qmpyjVbOILVqPdzhxFRf7yummhXKKMQcKDmcIntdnQI+SJpe+UicwGIWyvmElhkmV
         aIlzWkZY1HrzhouqQowav775Hd7vv9BNUUN6twN2nK2G2otgqrr4aSQPJLGVbkAyHUr1
         CkRw==
X-Gm-Message-State: ANhLgQ0Hq8RQQpWpYSKZ1m0hwkf52FB14KnKNe7Zr+kQ3v1Tdr5b+9sh
        z7ZmEqYXl1m1LOJaM4sgJ3iEDR7eF61JF3pjn/uwSQ==
X-Google-Smtp-Source: ADFU+vuMZUNmHuO8pA2eRmRUw3dUYphV88bMzvu8AMT32PjuSE/flAciWm7En4pGfMzvNUmL9llFoxs481vC/LegKOc=
X-Received: by 2002:aed:3346:: with SMTP id u64mr1865938qtd.333.1584612308921;
 Thu, 19 Mar 2020 03:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319190613.36d687a6@canb.auug.org.au>
In-Reply-To: <20200319190613.36d687a6@canb.auug.org.au>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Thu, 19 Mar 2020 18:04:57 +0800
Message-ID: <CAHCEehJS-6ECNccFfLqoVhLQfpD4_c0qCyatVzpbHDuLpo2hUw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the risc-v-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> =E6=96=BC 2020=E5=B9=B43=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:06=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi all,
>
> In commit
>
>   3384b043ea15 ("riscv: fix the IPI missing issue in nommu mode")
>
> Fixes tag
>
>   Fixes: b2d36b5668f6 ("riscv: provide native clint access for M-mode")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: fcdc65375186 ("riscv: provide native clint access for M-mode")
>

Sorry. That's my bad.
Yes, I meant Fixes: fcdc65375186 ("riscv: provide native clint access
for M-mode")
