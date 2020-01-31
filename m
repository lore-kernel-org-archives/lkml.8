Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2CA206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6zNtwzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgAaACi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:02:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46108 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgAaACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:02:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so1961662pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLeSQFRBfskIHE0f3iCBNaLCjMc4rukKI9DHIWPlBJs=;
        b=H6zNtwzj85uOCKrGdgD2mPyq/tYyFhf94ZQl5uKNGLc8FNjZyKZBNfUnYghGwPO/h5
         xouAKd77Lv1JIHXy6AoHPIY/ozkUT7pTCltOgY7oNOwq1hdggzBWiFi2rrcXtw9Wmd6+
         oSiS/h5j+NRtREDd/TbPaqnhWWhPSWjQ0idgEXzkcTN4PlBdijmB1PkCZ/V4SQvEa9eF
         LEQsOfQoOe+nrClSlggr+tZ0Z0YPjZerF+HWG7uqgPiOBV15fQRnp00hRN80uz/WYhr0
         QDY8ZmX5PiJIagOrLRHKK68zSqQZ9pqUlgd4+ScYuDOopLZSqi/FiwCCvTbjpFZbtPF7
         beww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLeSQFRBfskIHE0f3iCBNaLCjMc4rukKI9DHIWPlBJs=;
        b=TWRPTwmk1MclZ9UXBNxCvKYBqSoRJC831HepXAeIbhnfzkLqUvGxBnrf4mHnmk0I6U
         9cNJpkBfi5tQhinbd6irCO8PBIvLeju4TM9ElV0MVcV5Me92aHmp5X+JB4zAwffINX5G
         bakzMRl4Nh0hr2BO7vkgZqmqwP9Hzk+jbGJnUR8xJypOROoCFGbV+nXDnNGXy2+cykkT
         2dNHTDmCzdenxNZEj+Zd2D6iU4mAk1T2HwkP8dsHppKardB1kzZXLsoIGYoT+Eqbt+nL
         TQoTFRE5yyKtynr2z69u1Rz7ZukPNG5XtcCqb/6FbxFmrh8Zu0JZ/O2xVLoy4XrqJqM6
         YoHQ==
X-Gm-Message-State: APjAAAVg0YkO3P/RUV/W6S1UberMQBa1n87iPaLS0xZQlQfv3iPWtZTP
        CX6De5R+JYY3oneJHk/EMaELSXcKo/fQFQ63DZ4BHQ==
X-Google-Smtp-Source: APXvYqx/0EW+d8mJMIBv4huc+moxnQN17IC0fBZZ3vrRM8OvugVYrfhPi4Jx+H5+oA96apJnx+eENL3S6BZh9zlzeBQ=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr8974611pjt.131.1580428957622;
 Thu, 30 Jan 2020 16:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20200128085742.14566-1-sjpark@amazon.com> <20200128090029.15691-1-sjpark@amazon.com>
In-Reply-To: <20200128090029.15691-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 16:02:26 -0800
Message-ID: <CAFd5g45yXr-dNtgwUytVxwOGS5vfktZORNQ-p050cpN6W37bJQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] mm/damon: Add minimal user-space tools
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        SeongJae Park <sj38.park@gmail.com>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        kirill@shutemov.name, colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 1:00 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds a shallow wrapper python script, ``/tools/damon/damo``
> that provides more convenient interface.  Note that it is only aimed to
> be used for minimal reference of the DAMON's raw interfaces and for
> debugging of the DAMON itself.  Based on the debugfs interface, you can
> create another cool and more convenient user space tools.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  MAINTAINERS               |   1 +
>  tools/damon/.gitignore    |   1 +
>  tools/damon/_dist.py      |  35 ++++
>  tools/damon/bin2txt.py    |  64 +++++++
>  tools/damon/damo          |  37 ++++
>  tools/damon/heats.py      | 358 ++++++++++++++++++++++++++++++++++++++
>  tools/damon/nr_regions.py |  88 ++++++++++
>  tools/damon/record.py     | 194 +++++++++++++++++++++
>  tools/damon/report.py     |  45 +++++
>  tools/damon/wss.py        |  94 ++++++++++
>  10 files changed, 917 insertions(+)
>  create mode 100644 tools/damon/.gitignore
>  create mode 100644 tools/damon/_dist.py
>  create mode 100644 tools/damon/bin2txt.py
>  create mode 100755 tools/damon/damo
>  create mode 100644 tools/damon/heats.py
>  create mode 100644 tools/damon/nr_regions.py
>  create mode 100644 tools/damon/record.py
>  create mode 100644 tools/damon/report.py
>  create mode 100644 tools/damon/wss.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a4db07cad33..95729c138d34 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4616,6 +4616,7 @@ M:        SeongJae Park <sjpark@amazon.de>
>  L:     linux-mm@kvack.org
>  S:     Maintained
>  F:     mm/damon.c
> +F:     tools/damon/*
>
>  DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
>  L:     netdev@vger.kernel.org

Another reason to put the MAINTAINERS update at the end; that way you
don't have multiple edits sprinkled around your patchset.
