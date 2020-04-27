Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0494EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C311720656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpgRqh8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgD0KDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbgD0KDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:03:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8384C0610D5;
        Mon, 27 Apr 2020 03:03:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so8788171pfg.2;
        Mon, 27 Apr 2020 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7BxKFweYFM5l6F2sMkhzleb96tz5ULQ16O7j1OFWYM=;
        b=KpgRqh8GRU+uQ2SlSDqPMsdLe/NvAVIOvg7PdgRfCJPIrJXpZRJfGi2H3bcxEZmiu/
         c024VF55BLz+8LttdI50b/mNkKbJu95vectVoonNfbejM9imZbNik06ogDudErPokFY3
         aGBnp/HyjWfE95xyJPbQIxGmWM0JB48wlSnvumsjZIqgsFe3d1RCd6GtMXki7PZkHiha
         WLBaDoxoBtO/hBdBXxdyfVGfYphtmzMMGxtn86LLKBctP055gWfDofy7M96qdhZALML8
         rWNxtFpnideXlpUwRQRxzS3Uyhsr7PoCC5AiByy6By8BvBEav7x/8XMw6xQwvxheV2ga
         SCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7BxKFweYFM5l6F2sMkhzleb96tz5ULQ16O7j1OFWYM=;
        b=Pte94v5YVk5od0HvCXc9F5a3jxWvqvxgGmpA0gNFM2QQpX8VjOhYovLdvYNSPDK2Du
         AMRYYuv/5h2c1HhE2aex+2omWHT6shk3roGiTzis3fD/flKGivMs5Wc5f1Ye25jMEVId
         GdzgNgmVPiTNXhxd5WAYHPz/jDhKNwaG4c+UVFu23yrYePucKR9SKnZOM3flaLX+KQOI
         EA1zOO8KICwqhDjUNhUse7Yoe7MvknetBGsyqo2vhRqO9MBBfrq74oGxzZbLiTdQGRgo
         hfDTbLrrvypfmTgUCt5V4c2T/RRQquR35qZZtHVWbV1oyHBLoQhL2MVxo3de65RC3jwS
         4xLA==
X-Gm-Message-State: AGi0Pubg1UCkx3tnqn+sRkETMZTnikwDPU5d6cVEKixUO5CkokLTZVnc
        nS4W7TdIqVHbOqtERPDnb8TI5Xkg7+N9tGkUnHF7Y9fx
X-Google-Smtp-Source: APiQypLles5u47p9bkAKuILNITkiEJk5MPNGUeMvAmApcjBKVcYAZjYchQA/cy883cJouMybjR+0Z8MV9vnwC2CRPrk=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr22647891pfb.130.1587981825268;
 Mon, 27 Apr 2020 03:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200423224222.29730-1-jithu.joseph@intel.com> <CAHp75VcqV3e8ecAUX+dr9h-bE+1XJ_71hJRA1b9XdouJJLD2ZA@mail.gmail.com>
In-Reply-To: <CAHp75VcqV3e8ecAUX+dr9h-bE+1XJ_71hJRA1b9XdouJJLD2ZA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Apr 2020 13:03:38 +0300
Message-ID: <CAHp75Vezc9-vTSVsTE=ce_2XRPfFVT2gHwZhwqZiRX8M=sdmmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] platform/x86: Add Slim Bootloader firmware update support
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        Sean V Kelley <sean.v.kelley@intel.com>,
        kuo-lang.tseng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 2:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 1:49 AM Jithu Joseph <jithu.joseph@intel.com> wrote:
> >
> > v1 Upstream submission is available here:
> > https://lore.kernel.org/lkml/20200420194405.8281-1-jithu.joseph@intel.com
> >
>
> Pushed to my review and testing queue, thanks!

One question, though.

We use a bit different template for module names

vendor-...-wmi

(yes, with exception to TBT)

I would like to rename sbl_fwu_wmi to something like this:

intel-wmi-sbl-fw-update

What do you think?

-- 
With Best Regards,
Andy Shevchenko
