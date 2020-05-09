Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448EC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC3321473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0TmtAu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEILLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgEILLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:11:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74903C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 04:11:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m12so7888783wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rgJrLSjHlAQWw14xkbMllSGSwhG0VM0yS2HV2OmYzlg=;
        b=S0TmtAu0TiFgHaZPxbd8arbZ49KP9evFXFQyDTUuQGsFitk6YyUwcwlpAD8i+w7ZiM
         oEuJj9xTU+HEKCHQzRGNZvOpIeGzJsiTr87qFJ2nb9JeYHnVfv9Ktwqwh6b7mOCf/mJi
         Ah5PfJG+QkDwdnCWYNMyrQo0KnCiwfKAawIQN7ZclNoRCzLhSpfV2ehdDUQZt7FCmtVp
         3ienEgXONmdKdyk/C1T55eoipeLbZCWTYqX1KrAsusxwVn2/QbM5i4pwHYT2WybuL5th
         lUg9r+oCitKuspc+PTXygii/q8e2dfWGwj7rXNj0wfmW0fIadoptlpbq941KzovPLagk
         Eozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rgJrLSjHlAQWw14xkbMllSGSwhG0VM0yS2HV2OmYzlg=;
        b=jK+OfAtcgFTi2u1698LwIyVl5W7fVDZeuWIExM0RBoTE0cTLH4y+RrR3SRxr5w8u7c
         +OS8XqlvlWKTFG6ea4+wWD+0dwlqizunMd4Fobie6YJpZkp62oazcNskPDDIhjpWE7Ii
         DAmJLbpBJQxWQD1uyvjQLXBFsW3V7Mtl3Vl//7K9nMzz/CbNHjOyllq5IykvxD5aQtpa
         q2NXKHvafzZQft/0hk1jVmY0e9szOEO22biTfllfGZVsKZVIVP4c2YO+G+mBpVYpg1hT
         vjwjHie2WK3BjD/iidzXvW90BswUQaWJdN17WoHgwoTY5BxtV41oT/HDw9r2EJJ3zaHY
         5mtQ==
X-Gm-Message-State: AGi0Pua6dCgDq4QUEJLREPZyEah2necs5EHQfpH9FkUMEeNotg9Mr+6E
        h9Mh9PUygUZGvyRUKOPreD58MVNRxldEK/LY4ZwM8QBT
X-Google-Smtp-Source: APiQypJ3bEsI1jrAVqs2gXeRjY6U2Nd+jvo9MoTEw51MBCXA+5Zzqu/49y23C1W+1kx3iuARuW8L9HU49Tngkw5SvIk=
X-Received: by 2002:a1c:c287:: with SMTP id s129mr13657428wmf.39.1589022701053;
 Sat, 09 May 2020 04:11:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chunyan Wang <yanrrr@gmail.com>
Date:   Sat, 9 May 2020 12:11:30 +0100
Message-ID: <CAM0T-t16KMFHZ15wtDLTgtv8yiiP5_8Zu-a643AeBiX5NctCfw@mail.gmail.com>
Subject: tsc_khz vs cpu_khz clarification
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to understand exactly what the two variables tsc_khz and
cpu_khz represent. Information online seems to suggest:

tsc_khz - Is the frequency of the tsc

cpu_khz - Outputs in /proc/cpuinfo in the processor description, best
I can tell this is the P0 frequency. Some code examples also seem to
translate tsc values to real time with this, implying it is also the
frequency of the tsc.

For AMD the only information I've found states the tsc frequency will
be the P0 frequency. The system under test is an SMP one with 2x "AMD
EPYC 7542 32-Core Processor", which sees the following between 3
successive boots for these values:

boot 1:
tsc_khz 2894561
cpu_khz 2894496

boot 2:
tsc_khz 2894562
cpu_khz 2894578

boot 3:
tsc_khz 2894561
cpu_khz 2894458

I'd like to understand what these values represent given the reported
values above.

Please could you keep me cc'd in responses.

Regards,
Simon
