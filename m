Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0EEC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C1206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UMIrgNyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgBVTmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:42:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36997 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgBVTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:42:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so6826618edr.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 11:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxXwmG/BoLt3/DuSIM90nibgbKIiQUu8A/JCVZrI5aE=;
        b=UMIrgNyD6Xysh3omTsoSt+PHA41YQHPYK5cghpRVeHlz77TJ7VeDmYfWrDvhOmc1qI
         jHj7IHIBLOuwbuN1YbltxeLjSG+oGJTz9lKiXLh0GMtSkLa3f1CwAu3mApEn9rY6zIWW
         qnsZoJPouP5O0tOJ2Fg/kJvcf+p4ecUGrx6pfZfPCXo+4iInjRvgm14RUbXu0l9Elg0w
         EN2Xi+CKWIITk0Rucsz09925+BtHNYF+NBKK8MSOemJ6EYCxNgqaNmXop5RgFYxkjfd9
         I4IW9qJwpAxIZ8H6bp14M8B4losIzyNOG2OR4lniKVyn+PmOQhWAYji3fViIQWDlM1iY
         MG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxXwmG/BoLt3/DuSIM90nibgbKIiQUu8A/JCVZrI5aE=;
        b=SCFLqDZ7kye4L6fypgpNyVyIT/Qvo85LFpj4TEswJgDMC8WyjAOu89dYDvx6dXtpZZ
         n4yNi2/C4zVHixRQVvOdFNrTpelX+ecrS6ORJRX3ro/3xHOnnHs+quQVcNH9nskZStJA
         dUJhOeJRW9WE/QPWtNU1NxrIALrV2zdSdTk5g71iePeXnDpLG9VbEpetB3JcreYvUAIC
         pkkW7g5TXwC+PsPwMg42Vxh9S+Qd6bD6fQf7kPF1Ah0xqHsoSsubxqTWx02rlqx6M9qJ
         2R/+YwMzOS8NwPmJzQ6xeaYHTKeCYSOvJaCQzMe94Dgz38y2hS9eT1eKovFdj56axv8t
         WMZg==
X-Gm-Message-State: APjAAAWqEFBSV+VAS9A5ArSiiGvp6W4U039mFDZ8eNOMs8MUc1JH78/z
        0j1eqGfF3FMHtbbW+0Hc8i/9tG8nNhywsEVQgDo=
X-Google-Smtp-Source: APXvYqwfAkL5gcMkA/17+706cDRZPOl9loVVEPtWeFZTvqzB7twy3wihTpHS8mLjeiRkAbjzkyTYXKADIgMaiqwtzIM=
X-Received: by 2002:a05:6402:b2e:: with SMTP id bo14mr41025601edb.13.1582400551407;
 Sat, 22 Feb 2020 11:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Feb 2020 20:42:20 +0100
Message-ID: <CAFBinCBLJyPxOBv0JNe7o0ME3rvPi+2Qv7Lwgw6T92f15ZXcxA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 0/3] devfreq fixes for panfrost
To:     steven.price@arm.com
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, sudeep.holla@arm.com,
        tomeu.vizoso@collabora.com, alyssa@rosenzweig.io,
        dri-devel@lists.freedesktop.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sun, Jan 12, 2020 at 1:16 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> These are a bunch of devfreq fixes for panfrost that came up in a
> discussion with Robin Murphy during the code-review of the lima
> devfreq patches: [0]
>
> I am only able to test patch #1 properly because the only boards with
> panfrost GPU that I have are using an Amlogic SoC. We don't have
> support for the OPP tables or dynamic clock changes there yet.
> So patches #2 and #3 are compile-tested only.
>
>
> Changes since v1 at [1]
> - added Steven's Reviewed-by to patch #2 (thank you!)
> - only use dev_pm_opp_put_regulators() to clean up in
>   panfrost_devfreq_init() if regulators_opp_table is not NULL to fix
>   a potential crash inside dev_pm_opp_put_regulators() as spotted by
>   Steven Price (thank you!). While here, I also switched to "goto err"
>   pattern to avoid lines with more than 80 characters.
>
> Known discussion topics (I have no way to test either of these, so I am
> looking for help here):
> - Steven Price reported the following message on his firefly (RK3288)
>   board:
>   "debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' already
>   present!"
> - Robin Murphy suggested that patch #1 may not work once the OPP table
>   for the GPU comes from SCMI
>
>
> [0] https://patchwork.freedesktop.org/patch/346898/
> [1] https://patchwork.freedesktop.org/series/71744/
>
>
> Martin Blumenstingl (3):
>   drm/panfrost: enable devfreq based the "operating-points-v2" property
>   drm/panfrost: call dev_pm_opp_of_remove_table() in all error-paths
>   drm/panfrost: Use the mali-supply regulator for control again
I don't have time to work on these patches in the near future
can you (or if someone else is interested then please speak up) please
take these over? you are familiar with the panfrost devfreq code and
you have at least one board where the GPU regulator actually has to
change the voltage (which means you can test this properly; on Amlogic
SoCs the GPU voltage is fixed across all frequencies).


Martin
