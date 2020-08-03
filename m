Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D901C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4BB22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9f/uuwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHCSrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:47:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F6CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:47:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so8210904plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6n3yxM2sbQOf19JmVRn/nwlp/haMMMPZ936WJZaCFeA=;
        b=V9f/uuwQlj9fmXTLUJK7VZhqWfboAi380LlqS8NXLmpSV7qDeAc66jzKQQCjcC73+F
         ZzYCQV/ALnekWmaNhvZo5h7GuBVx8joInVPWRYhEoVl4seg9GvTipqQXyEMpvsDJ25II
         6NrnqL8NwGiUn1OuW79sg6DVN6FC6+G7JFFQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6n3yxM2sbQOf19JmVRn/nwlp/haMMMPZ936WJZaCFeA=;
        b=ShdBn+qtDcputxa+JyN21N9j3xNflwOXubkFFwdPMo6sihuJSe/YAhvURsGWV4cSsM
         Yf/7zMGhc8nZWL+KtQpOjuoZ3ixHj7gDI73iEnJ76JgvHAwOTx7M4aLTCeR8vk4ywIfs
         /1pCnS+7PZqSze24RVVXiChQcEpamFQ3YzTyTbi13C2JdsIIhwp40GUw8/Uq/P2K1Qjy
         JveefvTjPFXVQ7BHrzcrLGBY70VICBayao23Um5WB06X2ChjcE0pufWDnIDNUgc44ret
         /GTNHjPqrGFKr/aCiVKDBIg/7Cg5lBSZLcJ+j5BQDtS/dz81kHwBZGN5z2JqEz6tvoz1
         1X+Q==
X-Gm-Message-State: AOAM530ThKFSEwwT2AkCboSUEkvR4aBo/A8ZWNUB2SEMoOBY89k4DgFq
        ALaQ2VgSR7zYMB/pRiUo94/A0NnrspQ=
X-Google-Smtp-Source: ABdhPJxFQLkBSm60MgilI9ZYhyQEl3DoxwFPbsKEfX0BCIFnjwPjADe0OaYNpu2BxgtsaQaVMGP9eA==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12mr6975373plo.53.1596480419905;
        Mon, 03 Aug 2020 11:46:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v77sm17999311pfc.137.2020.08.03.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:46:58 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:46:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matteo Croce <mcroce@linux.microsoft.com>
Subject: [GIT PULL] pstore update for v5.9-rc1
Message-ID: <202008031146.53572B446@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny pstore update for v5.9-rc1, which fixes a very
corner-case build failure.

Thanks!

-Kees

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.9-rc1

for you to fetch changes up to fd49e03280e596e54edb93a91bc96170f8e97e4a:

  pstore: Fix linking when crypto API disabled (2020-07-06 19:42:31 -0700)

----------------------------------------------------------------
pstore update

- Fix linking when crypto API disabled (Matteo Croce)

----------------------------------------------------------------
Matteo Croce (1):
      pstore: Fix linking when crypto API disabled

 fs/pstore/platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
Kees Cook
