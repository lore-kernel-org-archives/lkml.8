Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF74C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9261320775
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgDMOMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:12:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33865 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbgDMOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:12:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id s29so6587995edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwii8YlQE8mee1Z5xIVhf603RnvUDTx/2KtWa57lsHE=;
        b=qBn/4jteVc5z9+MKANjw+7JNv3UAhNTWBU4UGroZ/oAsdftjunU1BD8c1w3oYR3+uw
         j1IuwTlB39BwvShlCQI4TgWL6lsWIXXpiILIBSU8zQpYwkkc0BQlJYl0gcRTvtzVfXE9
         emsj6EqPTMRivRT/ZAfKZQIVOrmkUIcQdXUvSMOpNpCTtYD0u5ZypN1WYDmGzCse9da/
         8lrj2jSh0jKwh11084qiYeKROknGJHOKoDKI2uM+NQgwgsihT8O4W8ZgPyPGtwqp935x
         eB7Uo9+7N3GuvsFt1z9PramOw05TjN/p9OfWnQisqjuNBriJTf9pZyo7yo/QbAhABaB9
         V7ig==
X-Gm-Message-State: AGi0PuY5zT07TPScuT/SqmkUIXyl+dUinFCto61+iMKRmf2jsvsCtUrO
        wdYAILbCAvxmRgkx+VtXnGMJuaVSIp0=
X-Google-Smtp-Source: APiQypJjySahtwX210l6+YzHGGd9KTmUhMXtjUvPcObAZvzlT3R2fTTn3J5V8dE79qIA+G5ayVHxjw==
X-Received: by 2002:a05:6402:1684:: with SMTP id a4mr819255edv.99.1586787170945;
        Mon, 13 Apr 2020 07:12:50 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id u23sm1385690ejm.28.2020.04.13.07.12.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 07:12:50 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id x18so5992004wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:12:50 -0700 (PDT)
X-Received: by 2002:adf:f04a:: with SMTP id t10mr6751961wro.64.1586787169975;
 Mon, 13 Apr 2020 07:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200413095457.1176754-1-jernej.skrabec@siol.net> <CAGb2v65qetxxVX1yoCjyduM4zRTyF3YKX1g9CuaHZkF_Z+AKQg@mail.gmail.com>
In-Reply-To: <CAGb2v65qetxxVX1yoCjyduM4zRTyF3YKX1g9CuaHZkF_Z+AKQg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 13 Apr 2020 22:12:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v66LxhqTBeA_Br=kUrTq83hocEcAzYYC6nXpASvkkjn+1g@mail.gmail.com>
Message-ID: <CAGb2v66LxhqTBeA_Br=kUrTq83hocEcAzYYC6nXpASvkkjn+1g@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 6:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Apr 13, 2020 at 5:55 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> >
> > m divider in DDC clock register is 4 bits wide. Fix that.
> >
> > Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Cc stable?
