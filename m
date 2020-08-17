Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19CCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9A920758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYVreFLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHQIDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHQIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:02:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4EAC061388;
        Mon, 17 Aug 2020 01:02:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq28so11540857edb.10;
        Mon, 17 Aug 2020 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtIGKJyafh0KqYvWaN0N70g2C6u2mDYlrTBjQ0qqhk8=;
        b=PYVreFLa0BUrCJDR5kYGmojmlz9nq/Or2c/2yNio3HCIUUpyTr6XZWEHZhREJnKZ8b
         0eKR+SCWXgEiU1esKAyllTQp6df9jVpXS9Kdf42hpXGCf2T6F2IjljQ3weorOXaZSJys
         QntouI11/51OtMQJxHQQAqDlHxy+iu+k4G6BKSk78iWPuE41H1GUjqPCcA9x+bhvhp1L
         NYEDx34mUF+FHc7wXzaPnS9xjABy6By+n/wC4ypU3J/hq55m4SzltnbIAkMT3jkEbH2N
         Un+GEkgTPrNwnLZar6Xm77JM9OdU02jUI9FBHQrH0LB0Kg+E6UVQCbIvjiZZOoJOvlsW
         c/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtIGKJyafh0KqYvWaN0N70g2C6u2mDYlrTBjQ0qqhk8=;
        b=l94si/YrSYUG7AOsfG57I75vPBs+a7obYkWOtiZr2h9yHomroEHuf/Nt+4n3TtJwVP
         I3EMHRz59sz/rMB5AYOxNOIWMoBxXnoEqMvMmQOFaYUwG7y4jFkaEx8CTROVctif/4j3
         1hecbFxzxPBfj/eSgTz+QcnzpIogLUDMPep8j8msqWeSVKStR3cVidkfjwo8LbEj8VN+
         vRbJTtBho5j6C9xtmefxMrutjDk13aIx9QSwdHM7nXOPri3DJ3j9F6XQTzFr5E+4pFL7
         +IjjbeuzufLhzwXTJBSzYiy4QqduTIVhwSnsbl2VLfI6NQfzhqdklNHMfPV+Sg7ItnkO
         1OfA==
X-Gm-Message-State: AOAM531DpMq8kJYMfZvQ/ZoSitMcECOwtnb32v3yXzpzI8eV2I4U3yQW
        dslhV4ujmj8eSUz19L81GS6OpNAX4AGCqpagjwo=
X-Google-Smtp-Source: ABdhPJz/ETQXjPQ3lM4w9XVSHIN886q8jOOzC2UsVk4A9gloEQmp+JIJvo8O+X0uendOw7yD2F1dGvih02MLLBgudhM=
X-Received: by 2002:aa7:d983:: with SMTP id u3mr14266898eds.366.1597651375434;
 Mon, 17 Aug 2020 01:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-8-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-8-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:47:49 +0800
Message-ID: <CAA+hA=TKkdYvC8X5pwGjGGY8jGXpvv2C1nP+tsRckhUGObSLqg@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] dt-bindings: reset: imx8mp: Add hdmi blk_ctrl
 reset IDs
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:13 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> These will be used imx8mp for blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
