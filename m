Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85724C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D8206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAi/1g6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgFPH7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPH7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:59:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0244C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:59:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c12so11157758lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xyMWKsVRxjewqYUyP+f8kb8GE8J2QsgvF8iuNEc/g7c=;
        b=YAi/1g6QffkjNNBnbEAQQvwo3H8j+CObJ7r5RmYhN0Y/4XSolINcvJFKnXPT9brwjW
         uL7KRxoJZ3KUNT8Oj++87WX2Ex81eGviLNxEnOT/mapxCK5ApFjAVi6Xwpx4xEBReXM4
         OGBXBTxuTBOM1gBXADabNN+cQg9KLpXONjPZzkxQ7+zrrsue5JXelhCyyVOZDzz7JQ6x
         LlJLrcRw9QQj+zFH+X/67NARYHk+/jMUrTtITPf3z8hAUWpzvVKRJ+UA+euvpEaDjMWd
         5sPl9mdW+vriviXlK9qNUpvcm81oXfmKlhRQHu/KRj4UaPd3ubc8JI0m0L4PD6yf6XNv
         uaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xyMWKsVRxjewqYUyP+f8kb8GE8J2QsgvF8iuNEc/g7c=;
        b=HBdKR+nbgUqGg1zGLf9h+aukg3hD31W7p79hWy1FI7E5I7smS4UqIPkrTVoKr2UeUw
         yTy6TeaBkz1Gb0zsp9ynrjd4cMsUei3f18XS/nQqkCypNYlxHMor1Fz2oMEvW1lhJaT6
         UI3VXxaVGKAHy7fk72jZIdO5xAPUXULqa+3VlQ9lfdJa+y/btKDXqy5HzOaR3xQm7sP6
         fEHuSTBNesZYwXveUPYWECxbHBmmV9ayBgc08xpg7iaQMfgy8dCjDBfKe+OiVjFLUME3
         NdCWliRJ2l/hpfJsnneJ1atPeNykzFIURHJ+kIHmg6tgP09OH046uAn/HfXZNFRGo8ft
         K27A==
X-Gm-Message-State: AOAM530G8M+a77wdmchL93m4MqAMMGwQ5zUNBy61fdbu6jVhY0BX9ipf
        1sZ6kSO8JLZOVU+kl/cCHn0sng==
X-Google-Smtp-Source: ABdhPJztl3u9nMjRtr53UAn+quyoEaVucHAqvKSCuaQamiiOTZltyL6YRLAJRhPBqzTByB5gHhsYDg==
X-Received: by 2002:ac2:4567:: with SMTP id k7mr1039284lfm.122.1592294391187;
        Tue, 16 Jun 2020 00:59:51 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id q14sm45471lfn.75.2020.06.16.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:59:50 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:59:48 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] update tee mailing list for v5.8
Message-ID: <20200616075948.GA2288211@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch updatating the TEE mailing list to
op-tee@lists.trustedfirmware.org.

Thanks,
Jens

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-ml-for-v5.8

for you to fetch changes up to cf5057e169f460e825bdf580eb285bb601156f82:

  MAINTAINERS: change tee mailing list (2020-06-16 09:37:45 +0200)

----------------------------------------------------------------
Change the TEE mailing list in MAINTAINERS

----------------------------------------------------------------
Jens Wiklander (1):
      MAINTAINERS: change tee mailing list

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
