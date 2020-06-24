Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F375C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3936320781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq0rCm88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403986AbgFXN4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389544AbgFXN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:56:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79732C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:56:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 9so2654251ljv.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jMjn+YLTAoGvoS/PZ7suZPzIVqWbA5OFcx5acEPKkgM=;
        b=rq0rCm88NpiP8bRWLoqludCMA3DJG5Js27QIjVIA7hjLsQ/Q5Olux0Hpd1UvjRYl8v
         0GfIb2KlCfXWIC6EJg6n8rnVrayde08jkUBhEcddpBZ+UuOASXVVuU71Qv5h3DtCUPU5
         oz5eQhV9PF2xzwx8zyqHfi/PHqHsxo+6ei1G0QrfOK1At2OKd1UpDfTaW93YIX6s2+El
         fW1uo1iIHLAa9tvKh5fE6GjnmjkBByV9tp7tOu7XjBTwaPJkT6tCiy94+nYiARhxHjSC
         QWUhcWAZwaOdSlkKGN2Nkdf4565LUVn7WS0HWmFrYr9I39EUOZWqYSSBLYow6LB2qwjb
         k6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jMjn+YLTAoGvoS/PZ7suZPzIVqWbA5OFcx5acEPKkgM=;
        b=fEGHGYAIPD1e32RNPyKF0T7pOumbhq/q0HtMl4SgnWs/7BNsFtCtGYw0oL/RSwq7EB
         LzuLTRQnxmHJOtGIRVzSJX3d9qZwaht8OZR7WRlOlNRmBMRcKsBwxVEK8Y/tjP2Lr/bN
         Risf3rqKNGnblaJ/X1rDwZzn5XuDnRqZWq7tDlxZ1ODK1umAG1SdaCV88Vk4iWSA4uY9
         nzT6lFygEMoxr3FnGyk1k5AUncZpOaWJQPDbLgi+Uom4JMSJUSo2yrT/Hp6ouJ1T0xNg
         cKUUAmBOTUiP6O9vV/L1kZipgH5MXK0awcESrm5QlyfPpquMI8cKSCmFFH4hUDtjk6kf
         O6Uw==
X-Gm-Message-State: AOAM531i8MAgGO5Ln9T8FnzCote/zLcJ/e1Pj+1v2LNq72P8JT6k/hN9
        +GdPpPYfMVUakNc3pIbQ3tiTSwn+5qs/NY98L6PqczN2cxhMIA==
X-Google-Smtp-Source: ABdhPJwrl6NDAkY2AQRXGW9TaaYlh4LJPqtI1G2BH0+NT3o46H/BkmCHc+3BInFAMElTeNa11l850/U+cBd26cXS2qo=
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr13408091ljc.227.1593006992517;
 Wed, 24 Jun 2020 06:56:32 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Curtin <ericcurtin17@gmail.com>
Date:   Wed, 24 Jun 2020 14:56:20 +0100
Message-ID: <CANpvso42Y23uTjSj+O+FETBwsFeG6uNjBBWr4KDVk_9_fpyzYg@mail.gmail.com>
Subject: inotify question on modify events and openat
To:     Kernel development list <linux-kernel@vger.kernel.org>
Cc:     ttb@tentacle.dhs.org, rlove@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

In the manpages "man inotify" it is suggested that function calls like
write and truncate are modify events. But from this opened issue it
appears like openat might be a modify event to inotify also?

https://github.com/inotify-tools/inotify-tools/issues/116

Just curious, is this expected, should I update the documentation?

Regards,
Eric
