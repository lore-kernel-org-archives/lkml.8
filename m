Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB5C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CEF2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHHYw9Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAOR3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:29:00 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46024 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAOR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:29:00 -0500
Received: by mail-yw1-f66.google.com with SMTP id d7so11345817ywl.12;
        Wed, 15 Jan 2020 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qwbs16xdiBNjEElqJn+QHHEW9fioQ11y+dP+/GhZWp4=;
        b=eHHYw9CySXZVjpaZqsfXuv6AON37USbZfA6hLdb10Mzt0lEBQPaUVSAeg+MI/sApTW
         sD2KZJhvQh05qsUgriPsqqZWcRI5YZIc8qjIxaeormuMNU93IkBU5cfXsX2kY9cSjVoB
         sB5dAzKM1usG+NNK4xXb+gDoqRtu3WqTzj42jmpBh9+5MV7v4B7z2xiF/Ro7Eu6ag9c3
         mvsx5EEfTuS3WZeH5qVGailqccZhGj6EMSv6q876u5nBBCxQzDnfQzs4hKVNonfS0ebe
         WnkChNkY6QY++5ScPa0UUFPbjgg9+eesMuNUiTywALtL1r3dVgWgAJOgQMr8zL++rL2p
         dVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qwbs16xdiBNjEElqJn+QHHEW9fioQ11y+dP+/GhZWp4=;
        b=mhGAgddPQ2Qu3axwJ4iAbqGvJwCegfdIE0OVRQYzuErDz9H7SlJtofikV7iSkOG/rv
         plgWGul2vWFAixt8XYAvf+QlYdX8vkiBeCgD/0fktTcWmyuUTcpwkBJehWdpm9xNTQEw
         IpUqwWTNWTCq4ZvEN5Q3/gAlZmqTlrqBP9wcpyry9TaZVJFiXFHjEnMWpPEba3xs98xk
         nxMAqzNRYuMIl8X8S76vOIT/RMgET9j8CkU9eZ6KNa90OOPvDiiTGwWbh5xPU4+Qja7H
         /GYmL8B/yD3USsOn5THYIeRtpTea+hwbqk01+Z6BM3TvDp2t4lwyC2m1CckCIllR1F/d
         6PnA==
X-Gm-Message-State: APjAAAUvGIgJ5BseOxP8DiMbuL/iwJ6uZcWPiGbYwA4yVUHRFjiMZzDX
        be9FxDBxpYAXJra9Z1IMfifIQHJ4
X-Google-Smtp-Source: APXvYqwhznZ95Fw+pvmzRn9MtLfJHhmzVACzcHW/mCWdzqiimVar1dGU4FYoDAr2AWJ6NhrAHgwonQ==
X-Received: by 2002:a81:2847:: with SMTP id o68mr23476365ywo.245.1579109338893;
        Wed, 15 Jan 2020 09:28:58 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id r64sm8530689ywg.84.2020.01.15.09.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:28:58 -0800 (PST)
Subject: Re: [RFC PATCH 0/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
References: <1579070828-18221-1-git-send-email-frowand.list@gmail.com>
Message-ID: <578a2d41-e146-1f26-6bf4-30509ebe6941@gmail.com>
Date:   Wed, 15 Jan 2020 11:28:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579070828-18221-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 12:47 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Geert reports that gpio hog nodes are not properly processed when
> the gpio hog node is added via an overlay reply and provides an
> RFC patch to fix the problem [1].
> 
> Add a unittest that shows the problem.  Unittest will report "1 failed"
> test before applying Geert's RFC patch and "0 failed" after applying
> Geert's RFC patch.
> 
> I did not have a development system for which it would be easy to
> experiment with applying an overlay containing a gpio hog, so I
> instead created this unittest that uses a fake gpio node.
> 
> This series is a work in progress and I have not properly reviewed
> it yet myself.  The work behind the series has resulted in my
> following several paths and distractions, resulting in more delay
> than I would desire in continuing to review Geert's RFC patches.
> I am thus releasing these patches as an RFC so that my work
> behind the review is visible and available for Geert and other
> reviewers of his patch.
> 
> The annotations added in patch 2/2 add a small amount of verbosity
> to the console output.  I have created a proof of concept tool to
> explore (1) how test harnesses could use the annotations and
> (2) how to make the resulting console output easier to read and
> understand as a human being.  The tool 'of_unittest_expect' is
> available at https://github.com/frowand/dt_tools
> 

I will reply to this email with examples of console boot message
changes as a result of this patch series.

(1) boot before patches
(2) boot after this patch series
(3) messages from (2) processed by of_unittest_expect
(4) meesages from boot after Geert's patches on top of this patch
    series processed by of_unittest_expect

-Frank

> 
> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
> 
> 
> Frank Rowand (2):
>   of: unittest: add overlay gpio test to catch gpio hog problem
>   of: unittest: annotate warnings triggered by unittest
> 
>  drivers/of/unittest-data/Makefile             |   8 +-
>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +
>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 +
>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 +
>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +
>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 +
>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 +
>  drivers/of/unittest.c                         | 632 ++++++++++++++++++++++++--
>  8 files changed, 719 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
> 

