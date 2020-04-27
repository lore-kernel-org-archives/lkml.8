Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046EAC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D2F206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgD0LDV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:03:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46469 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0LDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:03:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so17076797lja.13;
        Mon, 27 Apr 2020 04:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGgK5CRFIPvp5oQwSbTJDNV152r7++oABkTa9vPmsQs=;
        b=uk/72uFwUnxx1r5FAsQwEW8c5zYQ8w71I5T46YwVGcjh9Dr6+CLHqywz3sLrnKRuG0
         8HY+GrjgQFoHbpQp5AhyXQ0IU4+jjnGQ+kh/wDPpwIbwRx1qYYXYnWEKSKeP2cBroGlp
         Z/n70fv6VBNk62T7fBjdMXNV96DRtMfVxxkBZx0seVnvJVu/67m/WfA7Ji6geQ8kr9BW
         3y2I0HaYn0RI/TkQmSvXdc54y9nvzaMvlVRidEGYyWquE/QqSS+AFbBkeFXZ1FjGXvtN
         5YlRQ5mz0uuw6+1MEKDNOkuiP9revBs51hII6M0PYReJ38A+g7fTRn/mYL3kks3k+z5Z
         lgbw==
X-Gm-Message-State: AGi0PubGM1z32JyIGMvV+Szt/BHJ4GCPeevrGKvu1t6ZmdnNkaB6sDpy
        eR2VdYNmCdOx4chx2WdXSeESutuj5wg=
X-Google-Smtp-Source: APiQypLbU/zzNLuBwaDzb9NdFtH/jstxpVC4sjHrWi4INnvSzG7LxPzNxLFBWqvyowzZE7rof39Qow==
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr14406876ljh.26.1587985397103;
        Mon, 27 Apr 2020 04:03:17 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u3sm11448108lff.26.2020.04.27.04.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 04:03:16 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id j3so17049843ljg.8;
        Mon, 27 Apr 2020 04:03:16 -0700 (PDT)
X-Received: by 2002:a2e:910e:: with SMTP id m14mr12649569ljg.141.1587985396375;
 Mon, 27 Apr 2020 04:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-7-peron.clem@gmail.com>
In-Reply-To: <20200426104115.22630-7-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 27 Apr 2020 19:03:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v66TFzpEmzdqxmjqGvVONkPEhaDMHNA4tRUvrX_Mg8w=tA@mail.gmail.com>
Message-ID: <CAGb2v66TFzpEmzdqxmjqGvVONkPEhaDMHNA4tRUvrX_Mg8w=tA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] ASoC: sun4i-i2s: Adjust regmap settings
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 6:41 PM Clément Péron <peron.clem@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing or reading the i2s FIFOs.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
