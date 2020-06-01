Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3028206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ue1eDUAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFAGIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgFAGIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:08:32 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE44C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:08:32 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id u15so1780342vkk.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkmSio6UgYEwUD2SM8rAy/RIFijHP9divvcJZFzKfTA=;
        b=Ue1eDUAQymiljRlFA3oApYNxcyFCrmEwh752ztED+rE0vtnA1EgfxpjRH9ijf5dp2w
         7SoAAFunru/w/k0nwRajS8uwDXR45eFdtoh2owusugMDswollTsnUx3Afm7SSVuMN8Kf
         Nb9Sk0q+tD8GdHSIDFp+BqztLFmoS617kynUBIPeamU43WPkw/lAfQMvc1nquOueLwFV
         xiDFHXh/V7XSaIG+qDzKow2eLflBju8ZRSiSIntrf/9tn+cS3L07bmJC/1HyktoUyZTR
         NM/St+D0DSJ+DaCgbZKfLjapqIuA1hpkvUjdNkiTFXR2IwWoLAiHGghYihO3RbLbeACt
         rOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkmSio6UgYEwUD2SM8rAy/RIFijHP9divvcJZFzKfTA=;
        b=WR9skQlBfzQsqOY4VVPfIsY8S0uHH6TLixoedrz1YTbpBT7I4vg91iNwlgUdj1CFJm
         FzI6RjJT1TJSPmXOn/F3PEMQPiLPNcP99TUKnmNEq/5V0DvTo+ua+A6dglidi6sV9XCi
         fj7wQJypqma1oUH8XeoKiJpBAwjohdhurzwCiBsXd6/M2FE42x4UZZr5Ro3VLyYhslfw
         Ld3K4IxCAYTjXOLF1bG7lHlL+rzTNipRzh/c8P3Mb7DwjK3QfJa0ETHyknWGBv4r1oRF
         v6QByMhk2VuEoKFgWxtRwX5EFwNQzSqkcD8hE5YzQhrI6difJQOqgSNHGiejvc1ieeEb
         RHYg==
X-Gm-Message-State: AOAM531/M3kdWzhXD877T8fNC8ydZR+HJ7//oiLP17ZmdsgpaPCYkmqy
        vv3MznlAJzt2GHxcvg6KzIhm2n0uO0F4ukdRcZcD3zTSQTM=
X-Google-Smtp-Source: ABdhPJyuPjNqhHOp0uHEqICQDEH190vhJmliPr9HWavME5pHMwm7rpvSf/xMwZSCN53vg1xB/069+QfzSagWH2U4l2M=
X-Received: by 2002:ac5:cc44:: with SMTP id l4mr4878591vkm.43.1590991710866;
 Sun, 31 May 2020 23:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200529221631.6057872e@canb.auug.org.au>
In-Reply-To: <20200529221631.6057872e@canb.auug.org.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Jun 2020 08:07:54 +0200
Message-ID: <CAPDyKFo7036hqm9nTzT5ov2HGir5ThMfuorMUeS2hM7utGVqvw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the mmc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 14:16, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   7b16993c2bb2 ("mmc: sdhci-msm: Clear tuning done flag while hs400 tuning")
>
> Fixes tag
>
>   Fixes: ff06ce4 ("mmc: sdhci-msm: Add HS400 platform support")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Stephen, thanks for the notification, patch amended!

Kind regards
Uffe
