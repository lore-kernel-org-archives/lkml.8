Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6050C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960002467B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9ZqyXrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAWMco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:32:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33536 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAWMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:32:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id z16so1491765pfk.0;
        Thu, 23 Jan 2020 04:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UrfVxCXukIQNwayQaXCUBflPDHxJxAsXlJUl97UvbA=;
        b=J9ZqyXrIkldPAMknOgVFzm6lBt2yr32pTPEtW/XqKZqKW+crhXFCmDAmIedLKXJ9CW
         7x/ZuKxkbLc6gjAk1HZbefAJoBuF4s3AaBs4ES5VrV96E5FAMeSvrnEeqnbm14Ev4fEZ
         RZaufLQzHLwtNEJpS+EW6rq6If2+JeQB8F99bqTtfmefQV+IB/TSyn7YC04sWvrLmMuB
         iDz6vJTMcrrwdO3uoQ7Ft+XC1bm146PukPy0WQ35Y5eSKX27mc+5TV51sjFj4YTt+sx2
         aLavNHcmXhXVTcMzDF3rCqGL/CcluOKCcUAdAxBpzattkVaCpilCOE+SxKJmxu6j6kNp
         p8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UrfVxCXukIQNwayQaXCUBflPDHxJxAsXlJUl97UvbA=;
        b=mv1NHjT35oLU4vJvHQaoKyoZO1NcIHIQ8wF5azv3QgZD3aPbmwQ4MAyWakeU3yziFB
         Xozzb77T8PFPLKKr4F3z37uDbVL4g73iJwK1iKBpFida1BJEUzQcPw/2gwkqwIuzsH3g
         61JnxzU/SUUzzEhxh0pzLQIZd5b2bizim2HF8wr9UI6sfdq1STAXZvqxxsNu97zgZ7i9
         QpDVrb53FoC7a+/r1hM7qT4VhqAcBZWEc6qH209ODZeXD4ZL6gjl3aVIk0yJSj+m+eSw
         zgWmqx8NbdxNVGzj74HAWW3oEw576WMRiMkulRkN5zRV6LGxod/7uNrrz/6Az8+6hCm/
         noRg==
X-Gm-Message-State: APjAAAUsPKRqPEvvEnf5RpHTI6T38BQvlOWMiuBa0EIV6zALqQ7zVwtP
        IU13oO02231E/30IZQxfNjE7OauO5wQ+p9su91A=
X-Google-Smtp-Source: APXvYqwQHXX8uKu5xifP3s+WmVCLVrN61RB8PkBIwkN3i1SfQk2qpxlsIgUdxXQt4N4z5Zgod6lw5RIpGsNOzwlTc4E=
X-Received: by 2002:a63:941:: with SMTP id 62mr3883320pgj.203.1579782763361;
 Thu, 23 Jan 2020 04:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jan 2020 14:32:34 +0200
Message-ID: <CAHp75VcJXC6jtgXcxV2ikEEw_q=UPHyHYCST9QvyhWK+oRGvnQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Intel Speed Select Core Power Support
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 9:22 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> This series add core-power or SST-CP support. Also fixes some display
> issue with SST-TF.
>

Pushed to my review and testing queue, thanks!

> Srinivas Pandruvada (5):
>   platform/x86: ISST: Allow additional core-power mailbox commands
>   tools/power/x86/intel-speed-select: Add support for core-power
>     discovery
>   tools/power/x86/intel-speed-select: Fix result display for turbo-freq
>     auto mode
>   tools/power/x86/intel-speed-select: Change the order for clos disable
>   tools/power/x86/intel-speed-select: Update version
>
>  .../intel_speed_select_if/isst_if_common.c    |  3 +
>  .../x86/intel-speed-select/isst-config.c      | 34 ++++++------
>  .../power/x86/intel-speed-select/isst-core.c  | 55 +++++++++++++++++++
>  .../x86/intel-speed-select/isst-display.c     | 27 ++++++---
>  tools/power/x86/intel-speed-select/isst.h     |  6 ++
>  5 files changed, 100 insertions(+), 25 deletions(-)
>
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
