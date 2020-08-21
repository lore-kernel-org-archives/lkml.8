Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47470C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2312020656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ahSuHdM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHURFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgHUQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:18:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:18:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so2266315ioe.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luUAi1TbOa9Dnc1tIwWCWIIp6OXw4Q4Gp7/3zvZWN+4=;
        b=ahSuHdM/nkUJ6JtkBGtFBeRVfzbonjEc/j96YRLEJ4vtmgg/KKihM/7sXJPF+cxzsp
         QAV3Vt2rftE+yFPlN3N9m9EO0Q3Hto7nzTNZzODiCr5quN7ecOhjw9W9+c9BmYLGabVu
         E257jRzn/TFc6+q8S1SliMsuyT+g5ggI0Wq4nsEiLaXf0oxG8Za4ala0j1N8BM9LU4kh
         5R1yY5XWkQh5JRWT1nTTfhm7+z8qkA/rAv9wlXqFEiUn2wJKGX1I4s0Tw9kozND2q7vL
         N5Rn5ptnxGRFDutvd0+GGNwT+yWVBwQ6bT8s+/djlP7sY3x7ga+3SVfN2hoA+YqCoBF6
         PzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luUAi1TbOa9Dnc1tIwWCWIIp6OXw4Q4Gp7/3zvZWN+4=;
        b=U/QigE2m3kkXDb3btzNnC3ZjbVEYGdIKOGUoz3zJiAzaBYYUasdTi+avMAd2JLm4Or
         WfaBKuLn5vSedDjrbWfYJoZ6Ihn+9VSedhYVi5maKkanb+K8jW/fQXHsoC61zDqiGDA1
         BNYe2hEcRQDleYaly6MKr8+Zv+asa2d6kT05Pvf+aMvEd3t3HsIeXc62DxcpprdA0b1V
         17jom0PvZOJ9Zo3lhAupPE0PV6nUD0uMKzC8SA61kcoLADosoEuS108NqA1enT6pfljo
         jBXlkI6r6cv1eonoy+H0+OUQSQ6w70K4fQnQ8b0KdZLKHyMvWjXZtD/lFQnB29s3fnO0
         bQmA==
X-Gm-Message-State: AOAM532kQn48ho+UaCWFi/yiIcS6ut2NF8QvH1Adv8JKd9kTwuyBMAko
        9ImOzG0h2/vYT7T7hDbJIWBeGQfKAIZvqMC5vDX/oxz5PvsNtQ==
X-Google-Smtp-Source: ABdhPJz5jpr2DxnMaG9eqJjbyNPm6jyyHc64mTSoHOxOHhYYkgi7vT1uWhdnCIVnP0s7oboMggBGb9m0MGs/KT7TKYo=
X-Received: by 2002:a6b:b495:: with SMTP id d143mr2998016iof.61.1598026721446;
 Fri, 21 Aug 2020 09:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200821151942.6b01dbd8@canb.auug.org.au>
In-Reply-To: <20200821151942.6b01dbd8@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 21 Aug 2020 09:18:29 -0700
Message-ID: <CAOesGMhHhBBdXdEAM+P5orFz56bdQTk8MP20k4UZ2rh53Ge6XQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the
 arm-soc-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 20, 2020 at 10:19 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   8d53ecfbf231 ("arm64: dts: xilinx: Align IOMMU nodename with dtschema")
>   b4b6fb8de8dc ("arm64: dts: zynqmp: Add GTR transceivers")
>
> are missing a Signed-off-by from their committer.

Ah, I see what happened here. I've been relying on some of my
semi-automation scripts for catching this, but I had to use regular
manual git merge for this branch due to GPG signatures not capturing
it in patchwork.

Since the committer was Michal, and the pull request came from him, we
still have the chain of contribution documented, but I'll keep this in
mind on future manual merges.


-Olof
