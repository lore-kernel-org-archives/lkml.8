Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BADC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC71424684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGzMcBOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWKNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:13:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45824 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:13:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so1830755lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4wQ9deVteYqlHZm83bOhSrDXjF79dKTeR9wrXt2k3ek=;
        b=sGzMcBOzhTqNZ9cLyh+uNoAhFnEU0E/MgamCqEyHhkoT3AMNv3EnunHUwqOeBubxiV
         /eCySRaeCUHfiQ2p5Ejff1gUmv4glnNaPxqsxorzVcCKxUkuMEvZ8bFVBLoKXfJQ8gQ0
         p3PmBG/VRN98rxJuxDmS+QAHJSXVousgyu+mtLjoYinBgsHu9a4DqR+3N2nP2cziGfEI
         QLg5QTgbldf7Qbcvf3OOkSvOvs9XnuTu3+y8uemLnYixDAAaHXVnYfX5do41YS9k7rCx
         zMXEiYPxpAS05OlEFO7UY20z7BOp2/gvy3mlqZP5vHdZiig19ZYBrzAEvvppTg6Wh+X/
         UH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4wQ9deVteYqlHZm83bOhSrDXjF79dKTeR9wrXt2k3ek=;
        b=l7Wx1yDOcdYxAp//O6YxoDYbCkQ66F4Mhi0GbAyny2rtspk3k/2XiRHiSfoK7PRIBB
         1X8ozW1xFIWyltYzaXT5EdhnbZdJU45dwUD3j0cKv4ummiBGkzrl9fHTuAmUIBOk6qwC
         tG6yIZnmbddrKGBPgWMIZAAfrHiOgoebxZSAMBL1Lw/jMdnnVuprvyrLWKHkSTYDCl4/
         rKPSo/bXYXlEobTW8QtXDsHZL8gM3rpIMDtMhigeTcsLyC2gePnp2TYS0Lk9ZJ1Wkzng
         Ak4LiFP/m8HTBZ1wszOS0POTUTiNAOFfyIHFtEP1nGdBKOvU4vP5CoWrJZOaC75cNWia
         WWFQ==
X-Gm-Message-State: APjAAAUPfAPNl/vT3osNcyGtM38E3XhEQXWUpc+xpQaH2yuFFifmM3ED
        0ACJ+MwxPaXOtDY6VlBJW0Z+Tg==
X-Google-Smtp-Source: APXvYqz+AonGwRFNf1MyGq1jaClp+4wgw/P8hISb6+lfs3B3LpXl+eHn4A5+oxtVpKsqEwPOZxGEXw==
X-Received: by 2002:a19:4a:: with SMTP id 71mr4356482lfa.50.1579774393698;
        Thu, 23 Jan 2020 02:13:13 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id t13sm898056ljk.78.2020.01.23.02.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 02:13:12 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:13:11 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [GIT PULL] optee driver another fix for v5.5
Message-ID: <20200123101310.GA10320@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix with an added dependency to MMU in order
to avoid compile errors on nommu configurations.

Thanks,
Jens

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  https://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-optee-fix2-for-5.5

for you to fetch changes up to 9e0caab8e0f96f0af7d1dd388e62f44184a75372:

  tee: optee: Fix compilation issue with nommu (2020-01-23 10:55:20 +0100)

----------------------------------------------------------------
Fix OP-TEE compile error with nommu

----------------------------------------------------------------
Vincenzo Frascino (1):
      tee: optee: Fix compilation issue with nommu

 drivers/tee/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)
