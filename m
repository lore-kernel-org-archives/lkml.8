Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D7C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508A02071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ceJi3zIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgCaNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:31:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38658 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgCaNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:31:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so25126170edq.5;
        Tue, 31 Mar 2020 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwQ6p0kjxHWUaH6A6bVvx98gfYpYtkPqYfqeOSPqSBo=;
        b=ceJi3zIySsmcUUoMmbHyJIINyLKe1RaNcCjos5UDdJyQw4zHK+W9pBsv/ATDJMWnx7
         gqi08d8eB+GQcLMotvF2luheKYoJ+pMkCW6SOAlIrXTHusdPn+5UcgJ2yr5Hnr8L+CUc
         6vglca50z1wEpzPK3t4w2fQi9Uu2s55eRg03uSO+wUkvcUKQPFYMES3TXyAL5Gom6JmO
         5w0XUDYTiTG1UahLy/9VNjHRy5Nx5EeNDy8tZHKcQVCqfAKM0i8XsoCZRYNk6o+5w89A
         UyaN1vXpkdI0wsq0CcavJkv01KK86hVYk93wPvOpT1/+G1kaS/L//0UtSjqePGqLt399
         sOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwQ6p0kjxHWUaH6A6bVvx98gfYpYtkPqYfqeOSPqSBo=;
        b=CQKHpOQ+kpk8peWNS2tT+3WtUnRA9NaeDvBX+ca+LC0qdWY4fuH0I4563C6t11zBjz
         7K2mqTx434MQp6//MhRaGHn6FNfjapdleApAhZmQJ7zgEYNqMRtgxTWz6lebUvC7PHWo
         D6ZkOXHEiPdVwBzQKV+uvtCZtDxrJ5CDo0E6d9iTPNCwYimmLrerp1COCyFvk3QgBCt8
         f9xlax1DV+pmbF7zqhkjdGF6mJHJ0fH2vxeTqMOV7EZcd4KSyKDAOHJ9fsmjrNciNpRS
         XF6Qb1DLGGkzOpX7SeF6DILg50fDS5wyWkM3pa/Z2RvXGPL1H0WJe3+HRGuvr+WlKeKW
         sa2A==
X-Gm-Message-State: ANhLgQ2szH/YIrzFUT4BHezVVptM7QjTrDetQiGtozg3n4Y9FKGTH+Sy
        AU8dJyqgzc+6IgMHn8DSnxCXTDcTFaiLdytuqQW5ySOQ
X-Google-Smtp-Source: ADFU+vsUMbwWMvrTmly08wlYEdvS8JaGTqzQfOyIFOyynV49KSGBzq6rwLnsJZGo0uibBQM6JWfp7zNbBSCAn7fUy5I=
X-Received: by 2002:a05:6402:b14:: with SMTP id bm20mr15236694edb.365.1585661493777;
 Tue, 31 Mar 2020 06:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
 <20200330221104.3163788-4-martin.blumenstingl@googlemail.com> <05c15e30-3e20-6fce-d2ca-87b8762d0fef@baylibre.com>
In-Reply-To: <05c15e30-3e20-6fce-d2ca-87b8762d0fef@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 Mar 2020 15:31:22 +0200
Message-ID: <CAFBinCDdjz8FqwAvPOKRYF-KMm6bMMa9D1j7x1=Pkvsx-zRrUg@mail.gmail.com>
Subject: Re: [RFC v1 3/5] arm64: dts: amlogic: meson-gx: add the Mali-450 OPP
 table and use DVFS
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Mar 31, 2020 at 9:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 31/03/2020 00:11, Martin Blumenstingl wrote:
> > Add the OPP table for the Mali-450 GPU and drop the hardcoded initial
> > clock configuration. This enables GPU DVFS and thus saves power when the
> > GPU is not in use while still being able switch to a higher clock on
> > demand.
> >
> > While here, make most of meson-gxl-mali re-usable to reduce the amount
> > of duplicate code between GXBB and GXL. This is more important now as we
> > don't want to duplicate the GPU OPP table.
>
> Looks good, but please add comment about the CLKID_GP0_PLL assigned clock rate.
I can do that - do you want that comment to be part of the patch
description or in the .dtsi?

> I'll ask LibreELEC people to have a run on these patches (including the clk changes) with Kodi.
real-world testing would be amazing!


Martin
