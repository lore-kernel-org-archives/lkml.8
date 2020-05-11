Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D782C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D942320736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589228881;
	bh=Nz6bTgIxUAn7rUabLhD1q1zn78Zqka5bB1ueKi/F2BQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B5m5j/w38G82+7QC+3c6Qp1Q2pXEuL7CvqtPruUUvAKcf7vDPS4ZYj17ESg2Ylsw7
	 Ui+wlE94HGOp71eHQWoundpLXyKHSviQ6FtL5Vw/iM5i9jvvxt4JcEmdJf0nfX8VZT
	 tESe6JyrT9QLymXaemQKSoT5p87PEElRUr6WIdz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgEKU2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKU2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:28:00 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0AC20752;
        Mon, 11 May 2020 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589228880;
        bh=Nz6bTgIxUAn7rUabLhD1q1zn78Zqka5bB1ueKi/F2BQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BHozvJi5BG8Yx/0T1MOrqp/qMMQOQIlc2yfH0wPjmH/W9fNac63HYVSf2O8XDHI56
         3nbcJXGDJMUfQtOuLBmNgCjEWHwTdwnZL8xE0ahfvEX2w7PaV36yNitkgO9OuD0ZZe
         GyJmzLOxCr5+zPeCvxtUMeNbWYv6ICCl1TxnndHs=
Received: by mail-oo1-f46.google.com with SMTP id b3so544907oob.0;
        Mon, 11 May 2020 13:28:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuawI/I9uFwl4pQ+ACBzoIGhoHPaYr/0cPag8xnzNcDfJGWFXJV0
        hHuDwFNv/o+PFpCMNGB+/GArWh/xac77DilcBg==
X-Google-Smtp-Source: APiQypLSBJzRE+cCsGihwUlGGjWJH9/vO5uxkoJWXIl2XNbr12Oy6bpN1iK3mElpqX8cGoxAID5e8vKZk15IV0bTy4E=
X-Received: by 2002:a4a:9285:: with SMTP id i5mr14814535ooh.50.1589228879703;
 Mon, 11 May 2020 13:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200418170703.1583-1-digetx@gmail.com> <20200418170703.1583-2-digetx@gmail.com>
 <20200506163237.GA19296@ravnborg.org>
In-Reply-To: <20200506163237.GA19296@ravnborg.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 May 2020 15:27:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+xU4p+CQ=xzvgcktCo9i=SfHajMgbZ1DKOVzo+hCYdCw@mail.gmail.com>
Message-ID: <CAL_Jsq+xU4p+CQ=xzvgcktCo9i=SfHajMgbZ1DKOVzo+hCYdCw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] of_graph: add of_graph_get_local_port()
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 11:32 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Dmitry
>
> On Sat, Apr 18, 2020 at 08:06:58PM +0300, Dmitry Osipenko wrote:
> > In some case, like a DRM display code for example, it's useful to silently
> > check whether port node exists at all in a device-tree before proceeding
> > with parsing the graph.
> >
> > This patch adds of_graph_get_local_port() which returns pointer to a local
> > port node, or NULL if graph isn't specified in a device-tree for a given
> > device node.
> >
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Nice little helper function.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> Rob - OK to commit to drm-misc-next?

Yes, that's why I gave my R-by.

Rob
