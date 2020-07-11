Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB405C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B6220720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYu3lnVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgGKPIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgGKPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:08:36 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526AC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:08:36 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r8so7358692oij.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRBM4MxQjZwlr3vgeAC3G2zshvu8PlmN+TgUFaaHs8k=;
        b=NYu3lnVpJpBH+lVW/qrZPBJVHxT33neSZqt0btrYZhTT5kOpiH692FTKNImx6pdgRX
         A4GvUS1s3yPZxDihU9wwCqadVk+LgDWh06nc8iueXySI8BSrS9S7hnRJHn1Chnb0Sylr
         r+pn3gMqLGFriIv6C5U5aeDPOs6DMDXCIZ2YimIffFUlb5neHEtu/k4uq+w2T8nwbheA
         booYHaKidlve1R3vCFVbhVIw71Qqatj0dyd9Za45tN+kWOx/+og/UoalAxPLheqS7w9H
         5VqdNzcbLWMzohHmtNRVDLmtrqE6p32lLFS6PnEzAnsbjD4QBekktjIlnecqbGIJFVdC
         9DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRBM4MxQjZwlr3vgeAC3G2zshvu8PlmN+TgUFaaHs8k=;
        b=lCA3Kg44ZVpchw/qTMXpLDMYMCJxuKBh8L+tkpPeDRnjCD0pId+FoP3pkvc/1V6tNS
         E1OJyehJLfyqcyZ2BOknmjtgaLANL5zuS0psFDxy8FmEe4BLvEV2IqDi9rolOfFYgJOj
         dSfz9ik3mTKyF+TsvmyxtxOzbQbIDveWsmvNUAF/Bv+R/1mCXbCIcwQtD+Q5ChB+H+D1
         tvVfzjY37KUN+6TYJdKB1p/AQODKMaSz7Ncbq98bO6USmjE9c+S2kY+F8JH3yt5qeyS0
         Y0seM8YCtbRW2NDrjyog0LDhCFxdcnbUXcOGtbgR4l8yehzPanFFh1EW9Cx5E4MRzu7i
         iU+w==
X-Gm-Message-State: AOAM530GLTzVAdhDywGPw1g3tegYflhyv1otHTkhygXkVsIev3+ZUB47
        CNxzBGBDmE64LxsQEANVGBppy6EZxZrBJxMPbtA=
X-Google-Smtp-Source: ABdhPJzWp7CxpTT+jxuVi1iP4wUjKKLVhEPkkguJn8KZrCdjWmWKEsZQscEmd+ZvsCtxjhuN/Jnyh0PMYVf+ThtyLLU=
X-Received: by 2002:aca:2b18:: with SMTP id i24mr8340377oik.103.1594480115647;
 Sat, 11 Jul 2020 08:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200710024100.GA2055744@ubuntu-n2-xlarge-x86>
 <20200710122459.GE5653@sirena.org.uk> <20200711033036.GA4486@Ryzen-9-3900X.localdomain>
In-Reply-To: <20200711033036.GA4486@Ryzen-9-3900X.localdomain>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 11 Jul 2020 11:08:24 -0400
Message-ID: <CAGngYiXBdT1jOwRS_A03iQiGRbcpPncBxtVOsnFpmauO4ffS5A@mail.gmail.com>
Subject: Re: sound/soc/codecs/zl38060.c:614:34: warning: unused variable 'zl38_dt_ids'
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan and Mark,

On Fri, Jul 10, 2020 at 11:30 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Sure, you could hide it behind an ifdef for either CONFIG_OF or MODULE
> (since you could build this as a module with CONFIG_OF disabled).
>
> I just figured this would be something frowned upon but if that is how
> you would prefer it to be fixed, then I have no objections to it.
>

That's how things used to work in the past: we had to #ifdef CONFIG_OF
all the driver of_XXX code, so it could be built on !CONFIG_OF.

I remember problems with this approach: it generated a lot of
visual noise, it was fragile in both directions: including too much,
and excluding too much. Last but not least, it required us ARM people
to test build each patch on !CONFIG_OF, which many conveniently forgot
to do :)

My "vote" would be to fix the warning using compiler magic. For
example:

#if !CONFIG_OF
// #define of_match_ptr(x) NULL
#define of_match_ptr(x) ((x) == NULL ? NULL : NULL)
#endif

That seems to eliminate the warning on my gcc version 7.5.0, but of
course as compilers get more clever, this could eventually
generate a warning (if it doesn't already on clang).

So perhaps use compiler attributes instead?

Stand-alone testable code snippet below.
======================================================

// gcc -Wall unused.c
// results in: match_table is NULL
// gcc -Wall -DCONFIG_OF unused.c
// results in: match_table[0] = 5

#include <stdio.h>

#ifdef CONFIG_OF
#define of_match_ptr(x) x
#else
#define of_match_ptr(x) ((x) == NULL ? NULL : NULL)
#endif

struct of_device_id {
    int id;
};

static const struct of_device_id some_ids[] = {
    { .id = 5, },
    { /* sentinel */ }
};

struct driver {
    const struct of_device_id *of_match_table;
};

static const struct driver my_driver = {
    .of_match_table = of_match_ptr(some_ids),
};

int main()
{
    if (my_driver.of_match_table)
        printf("match_table[0] = %d\n", my_driver.of_match_table[0].id);
    else
        printf("match_table is NULL\n");
}
