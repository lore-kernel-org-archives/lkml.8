Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D68C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB86218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTDlFixc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgBLUwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:52:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53163 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBLUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:52:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so1385399pjb.2;
        Wed, 12 Feb 2020 12:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktEu+4lqCDbKO9qnX2sTlUigBje7mt6XvSgw9jTL1Mk=;
        b=uTDlFixc9E3zW4wTk0TrpEQ2A3Yli1behriN27YAL8w35rHbk2z+09sIys8fE4GSiO
         L5jyVxcLE5sYowM0Mkb+TgFO66yvc5H+CjNsF6nlPAmfrH3NwrA4aDcqMslox3XL7AMm
         FdSXPyFcop/k3XTrwwTNEkf5kayQUlnEUq/7/suKwCn92RI0hVjsPXI0+rXxHqVC3NLb
         3xDXT9x7DXMJBdrxZH1KxnezomenMaoz7H4Xe3kv13FwzwM3nYKwN+BA8VB+3dPOKErS
         iuLTXzw8ztaXWV7aW62YauSfz9ya4Txr9pikwo20YqYEBHddQNVuPeNnBjY+2TLeKe1P
         meww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktEu+4lqCDbKO9qnX2sTlUigBje7mt6XvSgw9jTL1Mk=;
        b=ho300KLIBdptAD7IISUY04CXIHK/ebnjX9EXm1m95kCNS1yEkn0poZIhksOu4Hm/WC
         mRFwd/6DU/E0RWcUNWp+/KzJNAaN59aHGktkqloJvet8T15/Y/qepP39nAydMzBFfGsT
         O0LTg38dq8+fF0+ZT0zOQxU0gHAYHIahDia94NraL/S8To+PFhV00mbtf2xdEuNxzYog
         gh/I/2+H6fruUcKuHWb5bhAv6EODRwpSn7VrghuL8v+b9D0bTzJzDO6RXuV1bxOVEYK5
         jr00FLWF6zDwrww+0Jvi2z5g/CFOzhcCS1g0JaGxAqNbtHMuIN/Ob7GnsnVJndt119/n
         zyjQ==
X-Gm-Message-State: APjAAAVAMgJdivf8ZWHiwShGqdx0H6Ekidg38LdDHS4l8Ikqr8700rve
        QcfLbGGSfhfkTV+qPbAlpB4d96lQW0oLo/5+AjUmY4E5
X-Google-Smtp-Source: APXvYqwxpkbf0L8zsRg5l2ML4V17u7r9J3ky+ezHWyvI6+qF3r5FN6i0X2ddHsr1cxJGlD0sr2lEoIiUu0uJATfEkKs=
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr974150pjb.125.1581540756516;
 Wed, 12 Feb 2020 12:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20200212101947.9534-1-geert+renesas@glider.be>
In-Reply-To: <20200212101947.9534-1-geert+renesas@glider.be>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 12 Feb 2020 12:52:24 -0800
Message-ID: <CAMo8BfK9LFfopJcNUDruFK-G_KqYP=7u9zdpNgZ5OZ_Ty7rO8w@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 2:19 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Xtensa time code is not a clock provider, and just needs to call
> of_clk_init().
>
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/xtensa/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
