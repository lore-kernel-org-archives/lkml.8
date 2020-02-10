Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746A3C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C12070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFCfjcLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBJVVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:21:44 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42115 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:21:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id p2so1570043uao.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fk9bdz/2mbXx6dTdvB7EEtvMRvBXPbEaBb56NU9MXvk=;
        b=oFCfjcLi6FTB8phhz5e5PNBQQK1bvPyU+YLtRi18QmAAzEqnY924oe7J71K/fOfGTo
         f3gOueqJgdm+vMwJlqJZAnePuZYODm8ZnNni3gHBsL0HBvBbjC8WPRyY4Q5Y++YUloN/
         CR4c3SmRF9iN7SCYbKhjCYcimn+OrtHdACBgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk9bdz/2mbXx6dTdvB7EEtvMRvBXPbEaBb56NU9MXvk=;
        b=jxdF6buVjEfuZWi8ltZhufB2mV91joFvd2UwyCSNz0C1sfoKNGqT12hpztbadeaxyo
         tbmeT+kVH6oVxCpvZ2kB+WODncX88L0Bcpl6nmIP8vAAQQW85r9Z4OMQLsM8SYo7OhgP
         xPFUxjznPEiP33TZWGosOxgwufsb5+vW0Eu/YuT6l+3iHJjxSq/ptWzOZ6+/MWUjMH3L
         +CW/byC56uUGdueGim4W3MYTpqhX6Qw08t1nnHxmkZKWsp/rrlZkc6qMSzkbWjh6t0N4
         r1tHIb4sW4HYZpvGLEzGHxi/VPcsC3cumg2srbX7HJ19koRkufeMCH2jZ4q1Z4MNHqjv
         Vulg==
X-Gm-Message-State: APjAAAUG2x2nKZSy3oVcykF2TLCFivTrNVWpjqukJ6iySy25KfGyIdXc
        lFlX8gYH5mjOI/+ohflDiXSZh6XvUyY=
X-Google-Smtp-Source: APXvYqy39Q4G02ZZerVRhO7SbI5ddWB9WwrXTP5v2Q0rYVeYEt+V2JrYIYISEnRHnaPKgFBL9ZcmFQ==
X-Received: by 2002:ab0:658d:: with SMTP id v13mr1935371uam.71.1581369702475;
        Mon, 10 Feb 2020 13:21:42 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id o68sm521184vkc.53.2020.02.10.13.21.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 13:21:41 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id c129so2282066vkh.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:21:41 -0800 (PST)
X-Received: by 2002:a1f:ee45:: with SMTP id m66mr2278489vkh.75.1581369701330;
 Mon, 10 Feb 2020 13:21:41 -0800 (PST)
MIME-Version: 1.0
References: <1581320465-15854-1-git-send-email-smasetty@codeaurora.org> <1581320465-15854-2-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1581320465-15854-2-git-send-email-smasetty@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Feb 2020 13:21:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VH4954bnD_PzOhFPaYRto5sRVCCuOHgm67=uz5Be_b0Q@mail.gmail.com>
Message-ID: <CAD=FV=VH4954bnD_PzOhFPaYRto5sRVCCuOHgm67=uz5Be_b0Q@mail.gmail.com>
Subject: Re: [PATCH v6] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 9, 2020 at 11:41 PM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch adds the required dt nodes and properties
> to enabled A618 GPU.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>

In v4 I added my tags [1].  Please keep them for future patches unless
something major changes.  AKA:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)

Just to summarize where we are:

* As per my notes in v3 and v4 [1], this can't land until
"mem_iface_clk" is in the bindings.  Please post a patch for this and
reply with a link here so others can follow the disucssion.

* This also can't land until the gpucc bindings change from Taniya
recently [2] lands.

...so we're in limbo waiting for the bindings to be resolved, but
otherwise this patch looks good.


[1] https://lore.kernel.org/r/CAD=FV=UEQ0mOXuDrSZrcJ8g6jb0eLf1Ttn+Mn7T6d2TpCMUcuA@mail.gmail.com
[2] https://lore.kernel.org/r/1581307266-26989-1-git-send-email-tdas@codeaurora.org


-Doug
