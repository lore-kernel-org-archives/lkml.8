Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F7C2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKYPns3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgGFEgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 00:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGFEgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 00:36:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F05C061794;
        Sun,  5 Jul 2020 21:36:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i25so38074342iog.0;
        Sun, 05 Jul 2020 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wlXgxNX6Ukh/qiixaaDUJ5g+jEymKNQEKfVHnNZOhk=;
        b=WKYPns3LbcL1OTp5M394z1f6iMzxxGo8ZwKAScrHQgZ2R91UJP7hrAcchMKYW+rQ8S
         iB7n8AvymbXR/fOaU9uOxpHftwgglC7ngUN7VSy1ejACqm8CNRSumhplDqpnM5CxYigj
         gUYrBBYc4KnywEm3RgTYE+w0mCylkFmbYLuCpK1gZRJ15DbqrL+7y+wDxX6b/VXTC4d6
         XtqLmc+H1zIZ4g1fayHbRPmLegEwqhRSEHbve8eO7CjatLit8XiDAZkUapcKWKWnxTpf
         hIMaayvSMqMzsaTYAzKoY/Duy9ho0BQdYiistGkP8zF3c3TOE38Cr4opN01wYAtU/VIc
         mpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wlXgxNX6Ukh/qiixaaDUJ5g+jEymKNQEKfVHnNZOhk=;
        b=kbIuosFc2SEH/EPJhZJ67tQgNGzEngaGnW2COLZj5OJ5pkD5RdCNaZ9xGD2OlGGWjv
         9aqj/IJnyIgYP+Eyapyixu5TjPqRwlV50cAJGcynRh8BOZT1IOKScjbXPho3qXTPkap9
         sxgRsaR3dH5rvf/rwQ8L78ZLhjMjvEhv89Bo/BVnXl7V5vuAwHp1SbCH+lJ5ST3if2zw
         hxithMbBJaAtj0QtvBU7f607Veoq5Dq48/KNvPPIARC7fiBI06zOr2DEGs/MzZvLhofh
         06qiO0x0TXNlpkh8g2hJGZ9Qls9wHqVbVwrXSwZAWxDbsf2iW9kuj3OG6G2xf4wOLQOh
         m2YQ==
X-Gm-Message-State: AOAM533JUN7JtrTZkG53Tt2M8mAm/QsXCHOlMpkVSb1EBzgaFUTNyamA
        rGc7BDPxwmArBFOymEyJ0pbwg0hKs0DvOj3kIvc=
X-Google-Smtp-Source: ABdhPJzHThS8tRGDZMm4VWWwx7UJh8NaEMFXkXErWwarLP//8jm7j2BkmjFBMwEhnILHvsf+I/9fj8ziPNEHQaNcHdI=
X-Received: by 2002:a02:908f:: with SMTP id x15mr49850033jaf.12.1594010208288;
 Sun, 05 Jul 2020 21:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
In-Reply-To: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 5 Jul 2020 23:36:37 -0500
Message-ID: <CABb+yY0eUG=bxrQHP9-5gHk7SYF=c+EE+0LGKhnpxgfr078n6w@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add initial Keem Bay SoC / Board support
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:56 AM Daniele Alessandrelli
<daniele.alessandrelli@linux.intel.com> wrote:
>
> Hi,
>
> This patch-set adds initial support for a new Intel Movidius SoC code-named
> Keem Bay. The SoC couples an ARM Cortex A53 CPU with an Intel Movidius VPU.
>
> This initial patch-set enables only the minimal set of components required to
> make the Keem Bay EVM board boot into initramfs.
>
> Brief summary of the patch-set:
> * Patches 1-2 add the Keem Bay SCMI Mailbox driver (needed to enable SCMI in
>   Keem Bay)
> * Patch 3 adds the ARCH_KEEMBAY config option
> * Patches 4-7 add minimal device tree for Keem Bay SoC and Keem Bay EVM
>   (together with information about the SoC maintainers)
>
Please break this into two patchsets - first enabling platform support
and second adding mailbox support.

thanks.
