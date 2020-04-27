Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9220C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86987206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDCKgM5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD0Mtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726769AbgD0Mta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:49:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A6C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 05:49:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so20352627wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/9BeKGDV5jCVKkpLL/J/G90uyL40eKzSl52eSn32nKI=;
        b=FDCKgM5d+I3LXOYYHNZvJYOFYfaxiQn750YyOS/Mm5OmI+UtgkQVmrJLcJVO0GC0Zt
         ceXiZxzYCxuFo2pj874FSKlgYESw3zCrGcrtWoh67uMbNS/y2EWqn12K4HTEzdQ7L9TV
         8Ydt0EQ9XPan1CP0DnYWP2akHU0EB/DthO3nLMNuV8+uRBcrGkHHzmYx3Sv205fTRm4E
         5b4C0qe5JPTt53JhevF3pCQjMwj3oG45MbshoLTtRCQYpv6qE8JUMZhaJADgkSUMSajp
         0iY14KjeEy4G+bGCIym8GenUWx0dqk816Qz/srCvboPJihp9eY1jWRPhnfObljaFxrcT
         lMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/9BeKGDV5jCVKkpLL/J/G90uyL40eKzSl52eSn32nKI=;
        b=bOEApAud2tJWFW+xQk+DYqpdGt2GerM5SkMQ2gg0/Kp0+31UvNHVrCtQWjCE/13OpD
         Lz+UssI2U1DKoYR0jnv3gTJBcuJSfIgBMTbXrUCiQWZpZCT+Sp7JjcfPpDYH69+ifgGt
         Tyq5MWJQRjVHYCjm28BLbF6Jq78IWQGwF5NyxcgruwQnouEnxclGiyuaCfka567MSQmL
         zTfVlxSJME9rJggyBoFSnsKPf8t0VlsiZuXyOplSWPqmtkMkT4bM2MzUZitcr4wLpArT
         Lyde+CSUuVAAw4u6vAi3BVQALuAT+q8bjHvbJZ98kC9R3Q70F38iJ2UdOhJp9Ain1VfK
         Ntmg==
X-Gm-Message-State: AGi0PubMYImZUcAQh9OfiCEUTkbJHj5eZ/4j9j/Y0YGdwqtfTcyA9B+z
        BsyNTsqsFdfj5j91B5eu+AQ=
X-Google-Smtp-Source: APiQypKNTyVT4ZVU1rmEWgLaRydqb1YmP+qBmZ8pwJNkhtvwPDp9mdOc3aC0FBQ2FtzLzfCwkPZKcA==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr27648742wmf.175.1587991769172;
        Mon, 27 Apr 2020 05:49:29 -0700 (PDT)
Received: from localhost (ip1f115f16.dynamic.kabel-deutschland.de. [31.17.95.22])
        by smtp.gmail.com with ESMTPSA id x6sm23218969wrg.58.2020.04.27.05.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 05:49:28 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:23:48 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     jason.hui.liu@nxp.com
Cc:     anson.huang@nxp.com, aisheng.dong@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, linux-imx@nxp.com,
        oliver.graute@kococonnector.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: arm64: imx8qm: tlb SW workaround for IMX8QM
Message-ID: <20200427082348.GA98329@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is this nxp software workaround already proposed to linux community? can
someone point me to the discussion if available.

https://source.codeaurora.org/external/imx/linux-imx/commit/?h=3Dimx_5.4.3_=
2.0.0&id=3D593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c

Best Regards,

Oliver
