Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7910AC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F16B2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJDoUvS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgBZDmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:42:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35500 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgBZDmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:42:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so1709706otd.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhbMFZH9TV9xXX3bi0AiULw9sla8JatRwgZ0NfA605c=;
        b=kJDoUvS6OOJk+ypY1EujEwgsPIKGLXE6pkmbSfiESFefGeQ4Nl1/uklyaEW0ZctjRf
         /BuGku1pbGbTJQkAKdFDT07ofldpcOno6F37PivyZNi0+RxqwzT/xWZ+7mdmIjlguqAH
         zHSYv7AFcb+vycN05DI991TYsea4JG/1ynAGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhbMFZH9TV9xXX3bi0AiULw9sla8JatRwgZ0NfA605c=;
        b=WhPraFsbG81HWwVLP4Z80bq2UaPSi4Gw+q6R3JY8gJEU3XqlWDCZxnjM5TU+8vk5Xc
         2cwDey/crOhSX4HKf+rFamR72eYVBlFaXQi0toSLc2CmuKCIJ443KfwrMj/+dq7VtwTk
         pZDpSb9BpLzrvWTIAUS4Lu9Bb7sGdupAeVdSDNRov32HPjkMmEszJeLVUv3hZ2dGQKfH
         YR0hpHwJHqoyqX0LbhH3SjgwVRQ4DcckOdIraYzz5TJIskDUSKCwCealWdj4s9W45zd5
         yAgqpLSGTV57ohzZmfYDnP7Fc8sxDLOewRtrFRvTiVnQPDABdSzA7txeqBAMv563Ja7e
         kvEA==
X-Gm-Message-State: APjAAAWbCCSHFJhoniKxqO7xAv2RTrHqNKPu/Bhrb4SVn+4POtlvkjnh
        ofaoKJuA+svxsXaNhGlN34GUnnZ95IU=
X-Google-Smtp-Source: APXvYqwu/7Cg5/db+aNRnUKnXn1HnVT42ZOIVtb9USet8b9BGzIFw2LcKpu67GnK+NYK4NxsFvo7GA==
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr1318214otq.221.1582688531429;
        Tue, 25 Feb 2020 19:42:11 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id g5sm282576otp.10.2020.02.25.19.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 19:42:10 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id q84so1638610oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:42:10 -0800 (PST)
X-Received: by 2002:aca:ab53:: with SMTP id u80mr1537577oie.94.1582688529944;
 Tue, 25 Feb 2020 19:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20200226033646.20949-1-gtk_ruiwang@mediatek.com> <20200226033646.20949-2-gtk_ruiwang@mediatek.com>
In-Reply-To: <20200226033646.20949-2-gtk_ruiwang@mediatek.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 26 Feb 2020 12:41:58 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWN6bXfYvpBJ6XyPCuvJSpdxNOf4Z9RbY0jbnB5=JX_sQ@mail.gmail.com>
Message-ID: <CAPBb6MWN6bXfYvpBJ6XyPCuvJSpdxNOf4Z9RbY0jbnB5=JX_sQ@mail.gmail.com>
Subject: Re: [PATCH] mediatek: move MT8173 VPU FW to subfolder
To:     gtk_ruiwang <gtk_ruiwang@mediatek.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Tomasz Figa <tfiga@chromium.org>, PoChun.Lin@mediatek.com,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:38 PM <gtk_ruiwang@mediatek.com> wrote:
>
> From: gtk_ruiwang <gtk_ruiwang@mediatek.com>
>
> Currently vpu_d.bin and vpu_p.bin are at the root of
> linux-firmware git tree, it's not appropriate so we move
> them to subfolder mediatek/mt8173
>
> Release Version: 1.1.4
>
> Signed-off-by: Rui Wang <gtk_ruiwang@mediatek.com>
> ---
>  vpu_d.bin => mediatek/mt8173/vpu_d.bin | Bin
>  vpu_p.bin => mediatek/mt8173/vpu_p.bin | Bin
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename vpu_d.bin => mediatek/mt8173/vpu_d.bin (100%)
>  rename vpu_p.bin => mediatek/mt8173/vpu_p.bin (100%)

This is nice as it removes some stuff from the root, but for
compatibility with older kernels that don't know about the new path
shouldn't we at least temporarily create a symbolic link between the
old location and the new one?
