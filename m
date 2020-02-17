Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90BBC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB7220725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBQHTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:19:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46003 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQHTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:19:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so19452063edw.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKr+1RTfgQ42+vPKzJm3cC+KqIteJwDJeivtrGtPfY0=;
        b=KxTkE2hnQJhHjio3MoiDZSr8662Xe/+vaHFQjqR8uVkUrViCrPGijSljPuaszaMzDt
         AT3z0fBx6/0FLIvzDvkNNqmbDa+rBRlx5bmg6aT/JJylL/n045af72DSAUe/mQWxUWZr
         ww4TS274Y+axjfT5Xz0hz24HFmY2QnznGdOHCuu4lrT1DYsx95sE3gfT3vxOjEO7YCkl
         TttuvZ97YW7yxZ1gHArFcJEC1bKgC6TipGBSqvZWX3bBykK5K1IIKNr+VN6O3IpMGira
         +qqF8gFGr1ndn3/dqBpRiETJi95STgPSMGR3HTA5lkz56rxn8kBJTR5lXx+xnaukYugl
         Sgqg==
X-Gm-Message-State: APjAAAV6k1F+IPhR4aGufJEkBBX6LUJ7iRIwlTrN0sMBdcB1mFQfFLOB
        7cDkOhvkjwBK9FU1YjtuDE7uPJ6cNOM=
X-Google-Smtp-Source: APXvYqyZcg7nzInmihq514+YsT1f0FVNMf+WkHRw1ymLeLdM0y3d1I8Ckp/CWJk2JB+YInhi39ZYpg==
X-Received: by 2002:a17:906:6942:: with SMTP id c2mr13672826ejs.12.1581923962003;
        Sun, 16 Feb 2020 23:19:22 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s12sm777589eja.79.2020.02.16.23.19.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:19:21 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id g1so15977294wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:19:21 -0800 (PST)
X-Received: by 2002:a05:600c:10d2:: with SMTP id l18mr20205144wmd.122.1581923961163;
 Sun, 16 Feb 2020 23:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-7-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-7-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:19:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Te_DD5zVU4_qAja0hSzcW0=bQZzwiWaVNoRQ3ms_wrg@mail.gmail.com>
Message-ID: <CAGb2v66Te_DD5zVU4_qAja0hSzcW0=bQZzwiWaVNoRQ3ms_wrg@mail.gmail.com>
Subject: Re: [PATCH 6/8] ASoC: sun50i-codec-analog: Make line out routes stereo
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> This matches the hardware more accurately, and is necessary for
> including the (stereo) line out mute switch in the DAPM graph.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
