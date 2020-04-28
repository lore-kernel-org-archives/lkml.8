Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA47BC83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E169206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="mJpP6O5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgD1FXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725885AbgD1FXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:23:48 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672BDC03C1AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 22:23:48 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id v10so3276470ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 22:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=soKXOGTdHIofr3Yf+54NHNG9tiLfeyhq6J/nrePKJX4=;
        b=mJpP6O5PXac54J0K+dRqMwRctOq1kyiNf5Rflc9J5ziICtKvPVvnVShRSIzCq3BSuH
         Pd7+KKoUUkdSgBwnOKkq1NevWCaFLNbhut7RF7n9e6rbcKnfCYkqW3xjPfJcZsuvHjqX
         vXjnZHhym4PYvc3SVxmFDq9xQdVrNamtkrCWGa5Qwl6i1a8H28BS9Ht59J3UJeH4jHQC
         wB4sdIIQRqTprEvDyausggtLo4G4CUnh5lCeCZfur+AEG2cQNnzdmnrZpMQG72adqDZ9
         Yny6YR1Ci2ap+Ek6/nmP1FANSuEF2aTMpfdQ40tAsDQ7skn+eTJU60arnDD+V2mtsJIq
         7/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=soKXOGTdHIofr3Yf+54NHNG9tiLfeyhq6J/nrePKJX4=;
        b=sInQaeeDDzjNOt+ten89emFsyPgFVr4YAO9pnUBgGUl8q04GM1stJYrJF+05RV56k3
         3r9WMIiUrYceNElDi8RS82uVjzQ2kYAaonJ/3r24pl6AWyAKvT71Ozn6ZsUkZfMWQY58
         wxkPuypGm2JLE0Hd8H4RWHky5/6Vflez+rGq8cGQvSJ3KwvZt5QjHxueOrLv14uNCuBj
         NjuoAmrhri6ahl0/opeWXk829r9c286rukI5pPlT7KF37ZtUe7CeRK5QKh79oGQpxPVl
         O4i7S1shgCa0JZ/nrYUs/HOvccf7g52NvQqKOlWGPwHr9q84GSbAY+KQtRldPFKNAwD/
         Z32g==
X-Gm-Message-State: AGi0Pua7ZaepSV5PXNYJEBGD0m+l9fv4KXF9dhOcxbFWWG6l7Zzhnrah
        6eLdzuPkcnvDen79Kv0KJBR2/QAGaLYO04CO/7D8Sg==
X-Google-Smtp-Source: APiQypI8lc33BnS/i6tpuW4cnEXzEeQUq7XaUs2oTS8y6bUkrFrtA9hkhaQWD5JgqpSDqBkta9JkVGHW3yeCz1VLG7U=
X-Received: by 2002:a25:bcc8:: with SMTP id l8mr32743079ybm.225.1588051427543;
 Mon, 27 Apr 2020 22:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e84:0:0:0:0:0 with HTTP; Mon, 27 Apr 2020 22:23:46
 -0700 (PDT)
X-Originating-IP: [24.53.240.163]
In-Reply-To: <CA+G9fYtuzvLSyqSkG8kCPk7exz16P4f5tYf-DTqV2p+eucKOLA@mail.gmail.com>
References: <20200418144047.9013-1-sashal@kernel.org> <20200418144047.9013-38-sashal@kernel.org>
 <CA+G9fYtuzvLSyqSkG8kCPk7exz16P4f5tYf-DTqV2p+eucKOLA@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Tue, 28 Apr 2020 01:23:46 -0400
Message-ID: <CADyTPEyHmxwskNAru-6asz-YYQZnzkMwJ1Rp1pFK+a8QHDRacQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 38/78] nvme: fix compat address handling in
 several ioctls
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        lkft-triage@lists.linaro.org, Basil Eljuse <Basil.Eljuse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On Sat, 18 Apr 2020 at 20:24, Sasha Levin <sashal@kernel.org> wrote:
>> From: Nick Bowler <nbowler@draconx.ca>
>>
>> [ Upstream commit c95b708d5fa65b4e51f088ee077d127fd5a57b70 ]
[...]
>> +static void __user *nvme_to_user_ptr(uintptr_t ptrval)
>> +{
>> +       if (in_compat_syscall())
>> +               ptrval =3D (compat_uptr_t)ptrval;
>
> arm64 make modules failed while building with an extra kernel config.
[...]
> 72 ../drivers/nvme/host/core.c:1256:13: error: =E2=80=98compat_uptr_t=E2=
=80=99
> undeclared (first use in this function); did you mean =E2=80=98compat_tim=
e_t=E2=80=99?

Probably commit 556d687a4ccd5 ("compat: ARM64: always include
asm-generic/compat.h") is required to be backported to 5.4 as a
prerequisite for including this fix in the 5.4 stable series.

Cheers,
  Nick
