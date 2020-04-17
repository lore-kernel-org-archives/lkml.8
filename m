Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884BC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894FB22202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilmyft01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDQFvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDQFvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:51:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74FC061A0C;
        Thu, 16 Apr 2020 22:51:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so1632079wmk.5;
        Thu, 16 Apr 2020 22:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItkPUdPnoyryu4zdqxDZiwYUzxDWdz/KasVOM22uFHQ=;
        b=ilmyft01lChPcVsatC//Ko5h9TriqTOzzlQxJyVt5zOGUArrRYCLByq8cTSLNTiITZ
         t/jVkRE0XYNkDkPGel7o5UkZOYyBMSk9v/O5QtAjokMu5Oo8k9oAYcXWX0EYaWT4BW0r
         dlD+3a9JqA8qZnlCTGb+XWHOCIqxK4fAO3vJx907w4bRCnPs/exHsI1XqlYytZlFZ/2x
         KJk3+vxqh03x170JgDV1fthRDJ5OioSs5F6aCK0NwP9AK67RM5b6LVLNITj7qYgeiRgp
         v2D5YOArR8V1bm/QanqXMh9L6TTj524mAcRCHmWtOxIF7jWD0/WZH4s7DbUNlDLXHSTF
         Drww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItkPUdPnoyryu4zdqxDZiwYUzxDWdz/KasVOM22uFHQ=;
        b=jcI87Ca1alnCa91VP3anCKKntWyQlGA5appLiGUWgHpqSp/eIEZ8kXwWfWOyChmDTL
         e2mL4IsJJ/wcumnkdYcrIfbPgpC5FwX116XiH8kqyiIT3spoSKFIB2mzivy6nBMEutr6
         Y9P2d8Sl+d1bqPdCwpp4xrA1feCCqiV7xYwVczJXcKBF8pdGQnIvNqjNj6pD+U8UB6Za
         7gDByNqkgx2j83XDimRfjEmJV1DHOGquaicGwsMjGWq7Nkz0RyWzsCNUChqA3m0gHmq7
         L94mfYbQV/nHKMaoi/agmj7gggXxgDDKtWoYBH6xoEMYPeG7drixgU6cQeRkauhU36i1
         geig==
X-Gm-Message-State: AGi0PubscYkCmzA9xY3YSAulFTDbXMlttiuk25a0jZGY4lYYa1Fb3Ti+
        3oyVsefAQzQyFAgsLXq+0fAWcMenPpXOFek+y6g=
X-Google-Smtp-Source: APiQypI5crvDrCA80b09MeSmzY52QKrlu+4sAXRlmI7FgOOY7eKa9hh7H5tx43XjQ0A8INN8wmoIieRjbLePWFEroRk=
X-Received: by 2002:a1c:3884:: with SMTP id f126mr1647351wma.91.1587102696698;
 Thu, 16 Apr 2020 22:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200403175005.17130-1-elder@linaro.org>
In-Reply-To: <20200403175005.17130-1-elder@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Apr 2020 22:51:24 -0700
Message-ID: <CANcMJZDH=3vU0pj+Az2YMJbTP7ku0dqhbR65DETmXM6Az0U=1A@mail.gmail.com>
Subject: Re: [PATCH 0/3] remoteproc: bug fixes
To:     Alex Elder <elder@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 11:19 AM Alex Elder <elder@linaro.org> wrote:
>
> This series fixes some bugs in remoteproc error paths.  The last
> patch is derived from something I posted before, but has been
> updated to based on Linus' current master branch.
>

Oof. Apparently I didn't hit reply all but only sent my tested-by to
just Alex (now 10 days ago)

Tested-by: John Stultz <john.stultz@linaro.org>

This set resolves regressions we've seen with 5.7-rc1 on db845c, and
it would be really nice to see them land in 5.7-rc2.

thanks
-john
