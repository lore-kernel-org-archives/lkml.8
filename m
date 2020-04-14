Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65021C352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CB920575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="jNALwbuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406520AbgDNHT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406487AbgDNHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:19:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9791C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:19:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t8so6336914ilj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g9r4EcstBBSCdem5nrPjtuIPy/foYH/WRJ4Lrw6qkzE=;
        b=jNALwbujMFrtEjjDpoR6hxcist0AftqsK2r2N5wdI/fCe4BB7T1oJsgW0/GfxF3pgj
         otQO55inAwZnkeZN7VSgqSMFpRs9yIS/hC0ZRG1TmaJ2kgq+nZ0kNCkcLjCvEJzgE/pY
         g60rU0OgrCF5H2sYpqAkkkFK4OxEdXgw2MPT3D6xrNOTjpCpnF0zgmp3mDGvT/X4MYSh
         uqdWLGZ16CYiUKC2Z7NG1v/ZA++tQX1K4goycN6u/WMbc3w+vvrNdDU+Hk9ONk83+qrR
         iINNwURxkr4Y2BOckyutoh8aDmgNfnEeJrQCX1zqBQ9ahzGcrFglrv3LyMNHUX+tD0CB
         4PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g9r4EcstBBSCdem5nrPjtuIPy/foYH/WRJ4Lrw6qkzE=;
        b=P6kOLL0WaM6GJvlHPz/gIpMZDTw9YcGEFh1l4OpWZwi8zs6AQrXVKuqGIuuZxb51J2
         wXdJjszJxMeAe4wyBVt+ROKT3qTHxrSCyQEPFQipLP6nrT/aalP6TZKhvzwv/gKAPYZt
         oIFVo5v/aACc3L2vHRs7bYKg5fh7KaISEvbN0ZTfqMgiY78kS1g1z5Vb81f1f7nBj/iT
         xI7+O0GJqAdlkJKeXAwMeRa/110Pv7TcejG47B48tA0fEoQdDUkv19APjHxM+GVcIgSD
         5lN9WPkVk6Zdks79ytSfoK+IrqheMqznCNreDU3gvpi/wJsWUfMVeiufDKwSAXcgKDa7
         iMeA==
X-Gm-Message-State: AGi0PuauM03nTi9B5T7XcmJ8T2Eprfl2Ds4o0X/jpFiT24vjZojDAFYS
        qEA4jCLJNPzJAWobrXSLcPGZUsMFnBEahObJGIFkDQ==
X-Google-Smtp-Source: APiQypJuPkpZJXeDJaPvW5wUMjvf3d+aMXFteAuJ/LWSjGJDWJMYvOfbfdhn86YIOubDytW2NuGvRhCnH24LIAtIahU=
X-Received: by 2002:a92:5b56:: with SMTP id p83mr21363706ilb.70.1586848793186;
 Tue, 14 Apr 2020 00:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <740ca6b2-d3c9-02a2-9d81-c212bf9772e2@web.de>
In-Reply-To: <740ca6b2-d3c9-02a2-9d81-c212bf9772e2@web.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 15:19:17 +0800
Message-ID: <CAMZfGtWEGuGCP1hNK7o82B_R_JQHFt7hfn+mRP+pOfUF7ygmZA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/ksm: Fix a null pointer dereference
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Xiongchun duan <duanxiongchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 3:14 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > The find_mergeable_vma can return NULL. In this case, it leads
> > to crash when we access vma->vm_mm(which's offset is 0x40) in
>
> I suggest to improve the commit message.
>
> * Wording alternative:
>   to a crash when we access vma->vm_mm (its offset is 0x40) in
>
> * Can a function name be nicer than the information =E2=80=9Cat 000000000=
0000040=E2=80=9D
>   in the patch subject?
>
> * Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change des=
cription?
>

Thanks for your suggestion. I will send a v2 patch later.


--=20
Yours,
Muchun
