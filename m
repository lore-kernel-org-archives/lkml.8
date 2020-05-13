Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E3C2D0FE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F088C206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZXeZxeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEMEtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgEMEty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 00:49:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA4EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:49:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q10so14684661ile.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7avQntptbSyfVNcjEHEawGHu0ZA5SFwdwGmNt7UNNE4=;
        b=VZXeZxeSkNdl8aWyx4AKhpe+/+yWw4K1AFsNSfSLvZIPTWB9V3k7ygHClGGUvzus2W
         8Kjj1xRmgufSy5p3p5oBvoY8dwp+Ev2OJRUgQQo0Q55Br3c4Y24CxHrlhnISy8mHK51X
         xWjqOBLcJsvmosULWYiVc0Zjoq/UJildgMh+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7avQntptbSyfVNcjEHEawGHu0ZA5SFwdwGmNt7UNNE4=;
        b=U3nJ4mwT80fFVi5FxbmqTIGq5a3Fzgu1iu2Ge32Qt059mhhR9Q1Ol6bCychvMmAt6s
         jWeqECeViWYBE3tb3+yGBF6wfF+baee8c0chsaHhOZXQ/VhFRz7LTbiEJrnsnxNCysvU
         QUBHE9LAW8E3DY6ArQqILuOiYJE+sU6C2ArnifLRGA3ScWrepFrCqwIW3n7lACQQ5Mzd
         WWztH0Z5Qf0llhOZP97dBqEhcUFezuJzQo+Pjv/E4IupyYnmWkWSkHsVB/xb5bWBLVMe
         SbObC1cS+wXvE2AJ4QEuEgEG+kdYai0A1qQMP9hrh8DdjYHWt6Fl0QOOyWZOBwAcbrU3
         +N7A==
X-Gm-Message-State: AGi0PuZwD4P/JWhZxYNp54kLS8jTwu11DDppG009eTWPQ1m0p72QKEv5
        xPNSWAHXH1gybLwOARjsqfbDOJ6SAw/vz2GgMAa9ZQ==
X-Google-Smtp-Source: APiQypLW4XrYA+YX10To7LSSFdH/pr6GwbWp+XKOzx9CNfSJM6J+CCr0iqX9Ux4YXkSF3w5tC6rtWCABka5M+lXvzeY=
X-Received: by 2002:a92:1949:: with SMTP id e9mr25726680ilm.106.1589345393815;
 Tue, 12 May 2020 21:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200401201736.2980433-1-enric.balletbo@collabora.com>
In-Reply-To: <20200401201736.2980433-1-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 13 May 2020 12:49:27 +0800
Message-ID: <CAJMQK-hsneV5FdyTHBvLV4pxfGWC=c8mLsH_c5KSq2LsCLGEww@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] soc: mediatek: Enable mmsys driver by default if
 Mediatek arch is selected
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, CK Hu <ck.hu@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        ulrich.hecht+renesas@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>, matthias.bgg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:17 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The mmsys driver supports only MT8173 device for now, but like other system
> controllers is an important piece for other Mediatek devices. Actually
> it depends on the mt8173 clock specific driver but that dependency is
> not real as it can build without the clock driver. Instead of depends on
> a specific model, make the driver depends on the generic ARCH_MEDIATEK and
> enable by default so other Mediatek devices can start using it without
> flood the Kconfig.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
