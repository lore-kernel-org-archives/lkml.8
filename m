Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C574C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1B32082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRSdIwhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgBDVOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:14:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36620 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBDVOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:14:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so7805675plm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJ6dt4IAx4lLUXsNXyTvXPa3oissv4BK7c1F70A7bh8=;
        b=oRSdIwhJN0CghtS9RntV6TwOsdvFrxSFJjT6YQdAQnM2F+VX+syfEAu3ehPlGD1jWf
         BRSf1W4q4aBPpwq14CYmdOrmUNcI4nkmCgB/IHekGeVgTR/XKpWfVyoo7nO1MoauhY/3
         UoqObmqt9o+bSi8pbgkIT7OQF2qPX2omMb1FvlHsasHZU1S8yRbs+AVgeD3fr/1+lzKt
         t9cEQd9Gud35qSLkVw5cogBK30lPAUZ2dWD1a/3a9ZTE0VIoFYwSu7/wItIUMyaGXOZb
         os2Y2ITzMrVQics/jxxFQHM55f70Y/ISAv+mvHEz9jJ7m1JLJ9BJIyRU+qrwIqkkvajG
         Z3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJ6dt4IAx4lLUXsNXyTvXPa3oissv4BK7c1F70A7bh8=;
        b=p2qWlhf/vlbBcjvkeIvcjVfDEr5aAqlvlr9igmN/M0UOs7eiOte/oMGc0KdcVTKvV3
         eGiQGAiCAukf+cEDYmt6DCDhdcDYZ79rKB3sxPgrb96h4BJGgbpP0SBlStxKttI7BGUT
         zSMT7cDRKg6QjormoUgWJycgLLCAsiWP2c13nmGeAdeI/dRJANXQnrTJawNnPQQ1NNeh
         e4eLmHOxWtdX4NsUJ7oZ0WIgfjdptl/7BChQEojdwZbVt8cD89TL+mMIKXPSD1xsLpZf
         dRDsnEB3i8ozzm+QWCyUgjoSCiljavxoA/1mjuyM7FN0NUrwR5OLj4gsrFVz3SP3fjAs
         ZTHA==
X-Gm-Message-State: APjAAAXlCWN9au+0PPBHMvHaHxwcX6RBEEvQsQ9FmsTBxkSS5L1rZ+Ys
        s5FTa0sbh2aAbwuEgtUNn33nGBfA3X+taYyK4V2Wzn7zyFIR5A==
X-Google-Smtp-Source: APXvYqxlNPmkXWAk4ntFo8+j7vPZz1JM/Js336XATIdIxno0pMF0BYtKzho9m+KZys/drne1OuHaScjgbBxZP4jx/Sg=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr1318164pjt.131.1580850883761;
 Tue, 04 Feb 2020 13:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-3-swboyd@chromium.org>
In-Reply-To: <20200204193152.124980-3-swboyd@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 13:14:31 -0800
Message-ID: <CAFd5g4536r2p7Dg3Hv=BbdmgkiT+FvBvp+NYV6dzocEmaDFi+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: qcom-geni: Grow a dev pointer to simplify code
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 11:32 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some lines are long here. Use a struct dev pointer to shorten lines and
> simplify code. The clk_get() call can fail because of EPROBE_DEFER
> problems too, so just remove the error print message because it isn't
> useful.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

I personally am indifferent to &pdev->dev vs. just dev, but not
printing an error in the case of a defer is a definite improvement.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
