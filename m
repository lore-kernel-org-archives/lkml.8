Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D76C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2324F206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMN/vl83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHFTEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgHFTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:04:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:04:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so37171799qtg.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jTKApcMj2Zows342O51R8Jw8sfgF/6kSSnPBjbL/bpw=;
        b=UMN/vl83fk+Ti/oqYc8HMdpiHFMu3gQsahoyqsFNxAzIyz/8rysrkzY0sr6pIifKc5
         TFXHfCLKOPbm7ja9lwqr3gqUY4y7v9W8Z37gJC1CJfm0KpKaer7ihk66scrMcIsNbCK3
         u4Rt9lEtDDoZ2xCaJbNBu6412KHLS2/ppPJ8VmQiG2aah8uHHGA2c5DNgzki3nc8xIwf
         IKuruH/JPPnbf5n/V36byYtsYggXOjP9W5rarASjMqIxC2Pch3ERmL/0MnOcJsca8e/A
         G9uPkq3TmCxhZ7Y1MWr5ZfSBEmcztKEY5m0BI+VR7AjypIDDehSKI0TRTObxsFUnuj1/
         KfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jTKApcMj2Zows342O51R8Jw8sfgF/6kSSnPBjbL/bpw=;
        b=CElHDCBDVLfeY/VSvuHTccdr3ShRU29WnsYXcTDGaqeN1nfDCI+SHkpOoHvCg/zooZ
         SEWoJ/ByshFC15wzHSAtpc0SvILuTXci010Td44uKJRCAoflXyIRU9m2LnyGgo8PEk2j
         2ii0vMDmMOuD6lRjqkJP5VsojDYT8ZYPty+dlKGI5f4GJrDS0WX+Vmwkul3+DXH86utN
         bB3+xiuMhUez6EkYHjGe3l5D/d7ul1PukdUylpL5zsxql4mjzN7YLc8hhdYhfvMYgU4G
         +K+HvChL4V7/NNUQOye4C+3UarxQFnvx++ISE3pcMZpjYRx/fX1lXBZr8iZIoGvpaUIC
         3fzw==
X-Gm-Message-State: AOAM532wHDy9dTkrTZvwzoOc7LFiXspr4s1BeQqWc2NZXd5mVM+nsSbC
        owPj+IZvAznM5a4vYbWYEIXafLrBO7kcyw==
X-Google-Smtp-Source: ABdhPJwAiccBZaUrgWKqw2H0hzpQpTVOGVe+G3w9K+ICJ+jfVla28NJqCS6/PrAohYXcSSnprDU8ug==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr10720023qtn.116.1596740679255;
        Thu, 06 Aug 2020 12:04:39 -0700 (PDT)
Received: from gmail.com ([138.68.65.160])
        by smtp.gmail.com with ESMTPSA id w27sm5296388qtv.68.2020.08.06.12.04.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 12:04:38 -0700 (PDT)
Date:   Thu, 6 Aug 2020 21:04:21 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.9-rc1
Message-ID: <20200806190421.GA4273@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small cleanup which I had in -next since 5.7-rc7
-- I missed the window last time.

Cheers,
Miguel

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc1

for you to fetch changes up to 3f03b64981723b61048ea46642bcaa9b518f3ad3:

  auxdisplay: charlcd: Reuse hex_to_bin() instead of custom code (2020-05-29 23:33:50 +0200)

----------------------------------------------------------------
Minor cleanup for auxdisplay:

  - Reuse hex_to_bin() instead of custom code (Andy Shevchenko)

----------------------------------------------------------------
Andy Shevchenko (1):
      auxdisplay: charlcd: Reuse hex_to_bin() instead of custom code

 drivers/auxdisplay/charlcd.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)
