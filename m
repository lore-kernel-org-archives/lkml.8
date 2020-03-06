Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B4DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982192084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHQ6qk5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFNpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:45:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33862 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:45:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id j19so2283415lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HlHInjFMccqDiZAW2h7dIR71BCrB+D8mPZu9+j1MN8=;
        b=FHQ6qk5hqbD2qhFvRgZ3LVpYdSyWjhuFzo8kQy9oW1+AW/vDKIqTBYC8mb4BrjqzYu
         PUKHoxlds59gjOrwJZgYpIHlwyEpf7y2889eDr7CF8k4uM4yxFCVaq71Wml0/0xz+dWG
         U8wChxbMKfNDhuI07VZcoqEEFyNrO3A80u58UScYrMHiIxQoP8so8W1+tKRMouzGeY6X
         V0/OBotJRq7p0VlH836pIjR5s+msoqEWcnjd8EQ5sywecQBNKfrnW1Jpfp2XUsXtXd0e
         GW5JF5yMarrByddEEJO9zne6E6EVIbnJUvPpZVQUgFHoHw9RLlA8oOy/jTh5SyiBt5Sw
         i+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HlHInjFMccqDiZAW2h7dIR71BCrB+D8mPZu9+j1MN8=;
        b=m/xNCtqgDaaliywkoClgEnNvHSpSJwo+ium31yndbpDMcvZOC88byp0MemlWGwo9TD
         3JbiENyjFifyNWlgq9Xe2o3sQlamNYynxJKhSncWK++4w1t4AXh+OBY1IJ9xC3P6jJkU
         dbZ7BQt0Mj50U6qToPe3SJFiZesjth0ywcF5CV4Ti6wrIkp6QbFK1e54W0GNv8xNwW8j
         j+5Oas3OI/FMjHeYbSXFfWflu5Ra2pee/Y+woT42w/7qShxHbud+KcwGboHoqDKIKAA9
         XZadZXFeLcmMVqPbYpfHDqCOGX3X96fZ+MMfE6/IkverMnGU5Z6yIK8fqoLx1Rk2CFJP
         8UJQ==
X-Gm-Message-State: ANhLgQ1q6IULSaxn3RvjGzOUemvR2zc2X21G4wc2NaJ91FWGEMgsnr0U
        Hj5XWrUg5gP4Ry8bBYQIkEQM6k0s2bxtbMuYZnrB+g==
X-Google-Smtp-Source: ADFU+vtS4etaU8JF15tZD3Ix13FzFgX9XaRY1ceFufTOGBQl3SOmzB3BGAdD+9bvpxp6KQsusW0FzkuQaZihBrzNwzY=
X-Received: by 2002:a2e:b169:: with SMTP id a9mr2039334ljm.258.1583502317443;
 Fri, 06 Mar 2020 05:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20200306005809.38530-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20200306005809.38530-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Mar 2020 14:45:06 +0100
Message-ID: <CACRpkda3DnsoYQSwrny2iS-vx2VmqzdwhBjuNXb6KNUwp9zc5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: pl031: remove useless invalid alarm handling
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 1:58 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The core will never pass an invalid alarm to .set_alarm, it is not
> necessary to check for its validity.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
