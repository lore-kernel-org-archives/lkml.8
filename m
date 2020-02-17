Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF3C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05961207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBQH7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:59:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41730 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQH7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:59:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so19584044eds.8;
        Sun, 16 Feb 2020 23:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Diza8Cc5Cpy+OVsRi4P0IsWcjJ4gPjcUytSTU6gocRQ=;
        b=KGMb3bNcO9hOcceVAIUGqw3i5hbeuG/1h/5jxiXZ3O398psl0ubUJBpG+Og1O/8lOe
         dsCfD8LGuc+kyItDVy4/5TErrfZZqjW6pZozhxzCMmaYXRF4uXqO5D2+Fs2U7auUxcGP
         zagrDYljhC+yvXXuE+D1ZMSASnAdq+8itgDbHvvwMrQBQQ98C00me0jZwQxfpiF0RNUU
         8lkARqkGi7eRZiXwpvAMglZH00JmrJzNHC2DCaqa+0C1VxuvcQpmw41ILcP8EaDy3+TY
         2JCLbKD8kvjt2KWxYZo5ZxERu+y4/D5v/0N/X88zRwIMeX4JAARHlQK1smfxu9rPqvYS
         L1PQ==
X-Gm-Message-State: APjAAAUnLqm4Sk35EWNa63C9IZYp6p/36BBPYbTpjSFuUtXVsvSt1wmP
        gFzPE1t3lSUvgkfUKbzr2Aqea4IPP1s=
X-Google-Smtp-Source: APXvYqy0dTf5QvJVnKsSHwIf/s4bt+LCzibbUo2tiw91NAparwrHkETsTw+HDY+DhXHVnw60N/BdnA==
X-Received: by 2002:a05:6402:b2e:: with SMTP id bo14mr13577541edb.13.1581926388311;
        Sun, 16 Feb 2020 23:59:48 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id cf2sm484135edb.2.2020.02.16.23.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:59:47 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id w12so18407721wrt.2;
        Sun, 16 Feb 2020 23:59:47 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr20431084wrs.365.1581926387451;
 Sun, 16 Feb 2020 23:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-18-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-18-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:59:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v65jWNCss88961zXT5is4LQQFh=Hcxx9ydn_bGqR7Sig8A@mail.gmail.com>
Message-ID: <CAGb2v65jWNCss88961zXT5is4LQQFh=Hcxx9ydn_bGqR7Sig8A@mail.gmail.com>
Subject: Re: [RFC PATCH 17/34] ASoC: sun8i-codec: Sort masks in a consistent order
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> All other definitions are sorted from largest to smallest bit number.
> This makes the AIF1CLK_CTRL mask constants consistent with them.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
