Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D4A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhRozuqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQPpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:45:24 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35252 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:45:24 -0400
Received: by mail-vk1-f196.google.com with SMTP id g25so4689012vkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqwE0LST7bQrMlS1npkM81NgJLaEPEMndv6Fs6jOD0Q=;
        b=PhRozuqb3/yllPbcOt9nm5DoWkHAVkcVOmhTNXefUe95wiUC+Gohh8hKoKtKTraQic
         M6WN6kZOkNRD/QkU4T2xreIdRfS6+zMAMZx2ji+PADf5Gz0Y/t22K7QQJ4Uqg3cbsO8u
         Dsj1v5tUrR3OR7cFyZoqgKR8efGtBn9eC3Hzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqwE0LST7bQrMlS1npkM81NgJLaEPEMndv6Fs6jOD0Q=;
        b=StzoL5Zg6slR6Dn/Zf8V4dgS/viU2K9CVmIjDK4evjzak68+Vu4yqmasyY6JhOGJD3
         oHqQzL8AeoYnd/A/M5p0mGqsfnKSVPDbuS4jgL4+/5ppvIkVotjr5z7++YOMtYlcXTjI
         8HpPfDQIRBAYzCUDVHbnC7F1mjZpSVJZn4ArFBtjSkCciEjmGpnemDonNyxLV4mbkgEu
         kuhIjbY2qth5J/qUvq6oM11M+yLlYvJFpFBGU34QURuaBIeWdel+pVVY0gRURMLF1gfn
         KFBtjNGBWjSo5rZJ+w6bBJUNETFLADI0RyL16tnwM9iO0A25ZQskG/k/B0V1NK53Xrev
         M55Q==
X-Gm-Message-State: ANhLgQ1QsTXIb1174QEUy2C+oyzMZhGcTbdEel9Nb9RdEet9nZfpdYku
        yC9rOI3pEgSnDc2IBoBWXO7AI+KXSkM=
X-Google-Smtp-Source: ADFU+vtHBONuk1xQKOzpvt+MDpZxolTdxbCSh33W3ulwP0Xdzv+5nzrG/MfZoyAltzqUeSSRiInGVw==
X-Received: by 2002:a1f:934d:: with SMTP id v74mr4413449vkd.3.1584459923064;
        Tue, 17 Mar 2020 08:45:23 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id m82sm1502214vke.53.2020.03.17.08.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:45:22 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id 7so14134049vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:45:22 -0700 (PDT)
X-Received: by 2002:a05:6102:1cf:: with SMTP id s15mr4040657vsq.109.1584459921604;
 Tue, 17 Mar 2020 08:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200103045016.12459-1-wgong@codeaurora.org> <20200105.144704.221506192255563950.davem@davemloft.net>
 <CAD=FV=WiceRwLUS1sdL_W=ELKYZ9zKE13e8vx9SO0+tRvX74QQ@mail.gmail.com> <20200317102604.GD1130294@kroah.com>
In-Reply-To: <20200317102604.GD1130294@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Mar 2020 08:45:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXPACnPt=5=7gH3L6DufZ4tLSPTN-AtTAmvi5KAJuP6A@mail.gmail.com>
Message-ID: <CAD=FV=XXPACnPt=5=7gH3L6DufZ4tLSPTN-AtTAmvi5KAJuP6A@mail.gmail.com>
Subject: Re: [PATCH v2] net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue
To:     Greg KH <greg@kroah.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ath11k@lists.infradead.org,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 17, 2020 at 3:26 AM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Feb 25, 2020 at 02:52:24PM -0800, Doug Anderson wrote:
> > Hi,
> >
> >
> > On Sun, Jan 5, 2020 at 2:47 PM David Miller <davem@davemloft.net> wrote:
> > >
> > > From: Wen Gong <wgong@codeaurora.org>
> > > Date: Fri,  3 Jan 2020 12:50:16 +0800
> > >
> > > > The len used for skb_put_padto is wrong, it need to add len of hdr.
> > >
> > > Thanks, applied.
> >
> > I noticed this patch is in mainline now as:
> >
> > ce57785bf91b net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue
> >
> > Though I'm not an expert on the code, it feels like a stable candidate
> > unless someone objects.
>
> Stable candidate for what tree(s)?

I noticed that it was lacking and applied cleanly on 5.4.  As of
5.4.25 it's still not stable there.  I only noticed it because I was
comparing all the patches in mainline in "net/qrtr" with what we had
in our tree and stumbled upon this one.

Looking at it a little more carefully, I guess you could say:

Fixes: e7044482c8ac ("net: qrtr: Pass source and destination to
enqueue functions")

...though it will be trickier to apply past commit 194ccc88297a ("net:
qrtr: Support decoding incoming v2 packets") just because the math
changed.

-Doug
