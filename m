Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03174C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25512075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXTf/vAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgH2ISv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2ISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:18:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A08C061236;
        Sat, 29 Aug 2020 01:18:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ba12so1152581edb.2;
        Sat, 29 Aug 2020 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=wRFsH65qEKlAb6hncYTia/pYv8Gyz6fqeLSzzlTd088=;
        b=RXTf/vAH7+1eg3sPtJR3mUZhFp/HjFxZOBqzv1oAEN/XHPPyXVcyDQogjXth44xzrx
         bo9s+DXL0CtR7jecoHyFbdrmhxgk4YpngS+55eUTcjTjSAGEEYdgc0Luy/dkl7ZYhvFE
         gjzS8ewUc/UY+dHO8gJxgq5B+ZI3lshpNmC3Q529NlA3mV/gwkL49/kPvWoccGgNHtdD
         rLg4C0RnBZwWvmMDp+zJmdKwxUDgCdzWtl/GGWPw/Q/1P+K8Sv4TMuIsQASA5MPCwPNg
         mzEUn9rBEASqsDcpeOYZD3zL5vQIFSIDTEyFwhP3l/UCjJOhGoHcynqiOX/JrXx+2fsy
         0xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=wRFsH65qEKlAb6hncYTia/pYv8Gyz6fqeLSzzlTd088=;
        b=cQBaLL05WLlqFIuy+v5lT3tWrv8LBHmXvPBvX8ArFOdbtl3FXsFJyyhjjAQbS9wvjm
         NqD179EyYp2Uycbz+SWGYxgtAW9IMl55t7+tRolY48WMKCAdBg5hF1jcn3TIiDxN+azN
         2h8ZPMI5z6xtWM3i4aBu3bap6YrqSDIFusGCys7rGZBP50E4idKRMgA36P29q6sAB067
         dqqYR6y3Zu6CkjNQE8/qodoX5LxCtB+NjNCQPi305cQArDZd6eyEIO61ZNG3cOP5UYfj
         0hTNrniUo1K8vgf2NB4uJZXOU3rZpPPgOiEmoUvKeeWkDRrpFZHYFk3PBSvGfE/NZxlH
         iODw==
X-Gm-Message-State: AOAM531IzqlOmuyiXRKwwdnoKTtD/IQ4dV1IfnU1nplqryZDI/H4b/UZ
        kn3f5J5pjo1o7U0TCyUZiI2CO8o+J2Y=
X-Google-Smtp-Source: ABdhPJyt1i8CCPsON1BaSsP8z4tlI7mtDz7h02HFK6FEHAXm5g8qXOiKvjzUgXC9BYBUXUulAsVOPQ==
X-Received: by 2002:a05:6402:2:: with SMTP id d2mr2519849edu.221.1598689126406;
        Sat, 29 Aug 2020 01:18:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id q15sm1500297edc.74.2020.08.29.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:18:45 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 0/2] howto.rst: Sync with original
Date:   Sat, 29 Aug 2020 10:18:39 +0200
Message-Id: <20200829081839.2546-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829080428.1219-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I forgot adding 'From:' line in the body.  This will make author and
signed-off-by mismatch.  Sorry, I will send v2 soon.


Thanks,
SeongJae Park

On Sat, 29 Aug 2020 10:04:26 +0200 SeongJae Park <sj38.park@gmail.com> wrote:

> This patchset syncs howto.rst for recent changes to the original doc and
> fix some trivial nits in the translation itself.
> 
> The patches are based on v5.9-rc2.
> 
> SeongJae Park (2):
>   Documentation/kokr: bring process docs up to date
>   Documentation/kokr/howto: Wordsmith
> 
>  Documentation/translations/ko_KR/howto.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 
