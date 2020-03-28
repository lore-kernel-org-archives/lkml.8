Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243DBC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFEC206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4RIFLxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC1SKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:10:40 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39392 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1SKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:10:40 -0400
Received: by mail-ot1-f49.google.com with SMTP id x11so13458420otp.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+YZxsPbDfbTvVgTH0HDYH7I/GL19/iF9GQHFSWLmIBw=;
        b=o4RIFLxFkz3KrsoLX3a2xu1JmUKvrZLBOuCPqqxM7CF3PMSyzBm7PYu4PNkRNsyaAN
         pvpei2GoiO5e616tuJas/nRtCseC+2fZQt6fgYYc478b6jGQztimvhEcWzEtbZa9XyWO
         wX32NrRyS6U03F5A+JW9f9sM6HD0wIX/pPY0JnWWuCsodW2bTX/4RbV42HMtEBXqX6dE
         mrMLGTydE/PZH2fAJ5RVfq+prBhl30DuPMwYryD341dKzdh1c1ikro0mdkyEqPA9pgEG
         oQGjSpre+BRMbKYopgFdQYNE3VuGGrDnw9Rrv+v143T7qaAmAYvdfKceOVLsI/Qy4SSR
         5soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+YZxsPbDfbTvVgTH0HDYH7I/GL19/iF9GQHFSWLmIBw=;
        b=KkQGTmTn6RJ0r1rv34mEPpxugsqLo6/6145pL7iLxXtxXy8gRRjIHdNzADJl1EIyDH
         9yE2/OrCuD9+3UD5vCm1GunIo2vcVBqDapbLVo1ZmMjpHka59EDd4OANinkPe6/Fc+Hg
         frlf/z1XnqmvhyZ8xc7EMBsHFDaZJvpH+oeSTYq3f+Op5HwByVuMVvIt+6aq9g7JjslD
         QDwX4YBkbLFoXlmmMp7StzdZdwQzdniYR1izkqP95uGejsqHU/IvfmGD17j82A5klViF
         qWiK5HjdD7GCG0VrzgWl1nVbFudc6KKJagywxahEprw5ipMjPcVysH2s5xWFgrRh8ylO
         FowQ==
X-Gm-Message-State: ANhLgQ01QZ5IlmemOsawq5GgDc9DHMf7CL0CERUWNwOPGARKmklnNyPG
        sDcq+cpC3z5SHSruNhijgo5rwte1i2fazfPa5DCEthZlIU4=
X-Google-Smtp-Source: ADFU+vsh3VADX6sDL+UXZNiO+lMo+UjTXOfiR+aFfL3IjDEaLkhfY1EzG2l5AdkmxOFjrNuFYQ0f1Y1d6iTdSMDqTI0=
X-Received: by 2002:a4a:d746:: with SMTP id h6mr4090800oot.21.1585419039477;
 Sat, 28 Mar 2020 11:10:39 -0700 (PDT)
MIME-Version: 1.0
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Sat, 28 Mar 2020 11:10:28 -0700
Message-ID: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
Subject: Weird issue with epoll and kernel >= 5.0
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've observed an issue with epoll and kernels 5.0 and above when a
system is generating a lot of epoll events.

I see this issue with nginx and jvm / netty based apps (using the
jvm's native epoll support as well as netty's own optimized epoll
support) but *not* with haproxy (?).

I'm not really sure what the actual problem is (nginx complains about
epoll_wait with a generic error), but it doesn't happen on 4.19.x and
lower.

I thought it was a netty problem at first and opened this ticket:

https://github.com/netty/netty/issues/8999

But then saw the same issue in nginx.

I haven't debugged a kernel issue in something like 20 years so I'm
not really sure where to start myself.

I'd be more than happy to provide my test case that has a very quick
repro to anyone who needs it.

Also happy to provide a VM/machine with enough CPUs to trigger it
easily (it seems to happen quicker with more CPUs present) to test
with.

Thanks!

Regards,
Omar
