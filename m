Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC9C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC30721927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ofvWS/in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBZEqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:46:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39009 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgBZEqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:46:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so1741536oij.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 20:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKUyDP4lZW18OTJVqKNfcbTr/pNluBP+Ac8mA7k4evM=;
        b=ofvWS/inAusVCo3l1y8QovhX4A7p7BrHR3o/38cH5h/oY+oPPGklAZwzipfIf14QU6
         potN5ZirnfbpuqlD3FbwCDt68S2VNziAe29j031oaTGqS5jme9cfqbcq9aS2Ev3tHZ+Y
         4l+XyIFM0jvqUyCko5LHBk01vlk6v3SmOhxMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKUyDP4lZW18OTJVqKNfcbTr/pNluBP+Ac8mA7k4evM=;
        b=e33e+m2Gmlv1s22F8lDyLst+RoIBwpHGBcT68XiB9L/ytMJHoTqCcoSZB100oI+CEh
         A0OhIeiAHCl9Gkw2FEazjzhbUy38lYIdX5bkKEjLt5AZhvi6aA/UV/kalqTenosOly95
         3pKDHOwjXMY0sLIrVbaDYATxiwxCL8fX+wkg5O7CrbPEFO5nX2vio+0W8JSapf3Bnc4W
         PqzNlwF7fvO+PbJg8PxuPwA1MVRa7crbSEZJFZ1G3P14WOKTfxjb2GwMvqNcjmEqQ3Qz
         MGEFgkRaMSz0JMff7SxZwNmJQcQc8zudOJEtnQ7e4YA97Ipjf3d+2CpRFN4g8Tb5CWBf
         PrSg==
X-Gm-Message-State: APjAAAU3DBV9G71fet7WnA0ba2QyhO2RWNsXY9Yxs74IshqwMsJ44Pah
        0EueW5dfd1sD4sm18JwUTQX7z39ox1NRVQ==
X-Google-Smtp-Source: APXvYqwRwXNrCvdnxdC8P7xCZzkdYvLZ0VmBaGwMtWrlQQxigAlqfpshbjQDyFI4F8N7Sfpqi/hx1A==
X-Received: by 2002:aca:44c1:: with SMTP id r184mr1581187oia.151.1582692359698;
        Tue, 25 Feb 2020 20:45:59 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id m69sm318463otc.78.2020.02.25.20.45.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 20:45:59 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id i6so1773939otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 20:45:58 -0800 (PST)
X-Received: by 2002:a05:6830:13da:: with SMTP id e26mr1449424otq.97.1582692357955;
 Tue, 25 Feb 2020 20:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20200226033646.20949-1-gtk_ruiwang@mediatek.com>
 <20200226033646.20949-2-gtk_ruiwang@mediatek.com> <CAPBb6MWN6bXfYvpBJ6XyPCuvJSpdxNOf4Z9RbY0jbnB5=JX_sQ@mail.gmail.com>
 <1582690790.6276.19.camel@mhfsdcap03>
In-Reply-To: <1582690790.6276.19.camel@mhfsdcap03>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 26 Feb 2020 13:45:46 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWcoSjvxj5tHvWTiQWqY5CdgTemCmyhmio0yZMEq-4VWQ@mail.gmail.com>
Message-ID: <CAPBb6MWcoSjvxj5tHvWTiQWqY5CdgTemCmyhmio0yZMEq-4VWQ@mail.gmail.com>
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

On Wed, Feb 26, 2020 at 1:20 PM gtk_ruiwang <gtk_ruiwang@mediatek.com> wrote:
>
> Dear Alex,
>
> Do you mean to create two symbolic link?
>
> lrwxrwxrwx  1 gtk_ruiwang gtk_ruiwang      25 Feb 26 11:52 vpu_d.bin ->
> mediatek/mt8173/vpu_d.bin
> lrwxrwxrwx  1 gtk_ruiwang gtk_ruiwang      25 Feb 26 11:52 vpu_p.bin ->
> mediatek/mt8173/vpu_p.bin

Yes, otherwise older kernels will become unable to use the firmware. I
don't know whether these are supposed to stay forever or whether we
can remove them after a while... presumably the former.

Also the WHENCE file should probably be updated to list the new files.

>
> we create them at the linux-firmware root folder.
>
> Thanks
> Best Regards
>
> On Wed, 2020-02-26 at 12:41 +0900, Alexandre Courbot wrote:
> > On Wed, Feb 26, 2020 at 12:38 PM <gtk_ruiwang@mediatek.com> wrote:
> > >
> > > From: gtk_ruiwang <gtk_ruiwang@mediatek.com>
> > >
> > > Currently vpu_d.bin and vpu_p.bin are at the root of
> > > linux-firmware git tree, it's not appropriate so we move
> > > them to subfolder mediatek/mt8173
> > >
> > > Release Version: 1.1.4
> > >
> > > Signed-off-by: Rui Wang <gtk_ruiwang@mediatek.com>
> > > ---
> > >  vpu_d.bin => mediatek/mt8173/vpu_d.bin | Bin
> > >  vpu_p.bin => mediatek/mt8173/vpu_p.bin | Bin
> > >  2 files changed, 0 insertions(+), 0 deletions(-)
> > >  rename vpu_d.bin => mediatek/mt8173/vpu_d.bin (100%)
> > >  rename vpu_p.bin => mediatek/mt8173/vpu_p.bin (100%)
> >
> > This is nice as it removes some stuff from the root, but for
> > compatibility with older kernels that don't know about the new path
> > shouldn't we at least temporarily create a symbolic link between the
> > old location and the new one?
>
