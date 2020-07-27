Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A47AC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041A8206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMvbgGA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgG0NHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgG0NHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:07:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C1C061794;
        Mon, 27 Jul 2020 06:07:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so9461115pgg.10;
        Mon, 27 Jul 2020 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU4uOkyeKSlCP6DAw6Cy7Ktbov/Gh5qKQZ6czddo9eY=;
        b=LMvbgGA04HznqjLaf5szOXCLSh9x11dnwmIwyhStp3Yd6GdkUIoccAW/Isj24QFJWW
         wdI6Czp8coHdtka/GILmJP2zDVqFW31MkuUJjMDot+6afXCbcCATnr/g8bcFqTBSX97Z
         VmXwKBzn7yrfC4307jov37Vl263FjWd1ACqRLatKLfxh+znxF+VyON54aaFRAhFZU0Gu
         WWinM7ylHXnAKlfIOoxvjSmbCCiIY7wFBZ9Ap14yWC5mvPx8tcw+iW+KpDwnhNK1mIIQ
         WXqG3n8q9+BoLDsALdNMXgiqXpNUbIKGlUWQWZw/or+yikJ3plwPIPd7dNyBGhOkhYq2
         BSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU4uOkyeKSlCP6DAw6Cy7Ktbov/Gh5qKQZ6czddo9eY=;
        b=LFnEvp7NDRDm9wOKBymHjqZUKGIARzIuFWKVwIh4EW59BZFFcd5VAPJRntDBVMcArZ
         mng9+8UxT6XRmsU36biW73GcgJIdCftqQqAp79dd2oF6aNyT52uGX76mmwrsm07aoo5f
         GuCmv1z5FtBOFg4YLSwyzFcdaLkhI0Y3dwHc/TRvWDwKnq0L0Dd4fTNhHmvpswLvMnCD
         RWPancTfrTGT1bdu2G9qNg86pC6xxmoU0KOzkVVNJ//CBEvO+aJGKzzQISpL5FmXndFn
         hoLQMMt4H1+e9pGyL1SrpMUq0k76a/dV3GP8x5+wnF5XXAhrU3moZvCadqZ2oBS4yGrS
         vNWA==
X-Gm-Message-State: AOAM531SF6ZnPlRqpDpa+of1vpSP8T2ELXhSUx9QtfAfxgQbiKMJeNj4
        TuGuDuVftGWpsfRH0NgTziooWZ+uL928U5Q7pC8=
X-Google-Smtp-Source: ABdhPJxCW261IYIacWDsDLoTBan3fG0xkKSa9VYjzETNf7JTLwKKTZElidbIm/RSXmnZDKY/gCXa0PcYgLgpAP0UwfE=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr19297932pgn.4.1595855241880;
 Mon, 27 Jul 2020 06:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200727122242.32337-1-vadym.kochan@plvision.eu> <20200727122242.32337-4-vadym.kochan@plvision.eu>
In-Reply-To: <20200727122242.32337-4-vadym.kochan@plvision.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 16:07:07 +0300
Message-ID: <CAHp75Vcaa0-s6FEUw0YqoEDi=uVRcJiDvwA+ye4cNxwkK6eb+g@mail.gmail.com>
Subject: Re: [net-next v4 3/6] net: marvell: prestera: Add basic devlink support
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mickey Rachamim <mickeyr@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 3:23 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
>
> Add very basic support for devlink interface:
>
>     - driver name
>     - fw version
>     - devlink ports

...

> +static int prestera_dl_info_get(struct devlink *dl,
> +                               struct devlink_info_req *req,
> +                               struct netlink_ext_ack *extack)
> +{
> +       struct prestera_switch *sw = devlink_priv(dl);
> +       char buf[16];

> +       int err = 0;

Redundant assignment. When you got a comment the rule of thumb is to
check your entire contribution and address where it's applicable.

> +       err = devlink_info_driver_name_put(req, PRESTERA_DRV_NAME);
> +       if (err)
> +               return err;
> +
> +       snprintf(buf, sizeof(buf), "%d.%d.%d",
> +                sw->dev->fw_rev.maj,
> +                sw->dev->fw_rev.min,
> +                sw->dev->fw_rev.sub);
> +

> +       err = devlink_info_version_running_put(req,
> +                                              DEVLINK_INFO_VERSION_GENERIC_FW,
> +                                              buf);
> +       if (err)
> +               return err;
> +
> +       return 0;

return devlink_...

> +}

...

> +       err = devlink_register(dl, sw->dev->dev);
> +       if (err) {
> +               dev_warn(sw->dev->dev, "devlink_register failed: %d\n", err);
> +               return err;
> +       }
> +
> +       return 0;

  if (err)
    dev_warn(...);

  return err;

-- 
With Best Regards,
Andy Shevchenko
