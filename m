Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E049CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70462070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+z/4M4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgERFre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:47:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:47:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so10180307wrp.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IgUxf8/whiEMr3BbVOGT5V0QZ7sOsie1bVJvZSf8S14=;
        b=O+z/4M4S6qmhnbqAb+zfbpEol9IeVhqsvhikRdXudQm4xCbogglWu/OD2xrrPDwY/N
         8DB0qC444Pv1XDnT6It2lKVeP3xGQAsKNiSKkEzuYLvLaLrA0pM1akbqWt4FchYrB9mg
         TA3/wR40rVRaFom4pNGPKiCa1dBH1auX8uv2e4VVyfVWOZ0tOeaazdBtL6Yjhisb8nRG
         nC4YJTqrtKifzXFlDhWlpQTcSM/Edi1Lrb2VRYFN8pgUphXsnfczE7y6dNd9VLu1Ev63
         5zcU/7L6G1pFIBtQkWs9pg/hIEXZZzhio4PsrgmYeHy2Be29vU+IG+QGAbervEMouGxX
         7NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IgUxf8/whiEMr3BbVOGT5V0QZ7sOsie1bVJvZSf8S14=;
        b=ukyYhsGdJNeVGl/T1sJv91qP0ci4fRWg0EbshgOwJMWSSi+DdwXUndHUz80sOYW4QZ
         lJSXBZeIo2gqF7YtAMfJf4aL3vxpx+LpC01erZShtIbAaE6Rkd1FBAFsGioBPKjHB0Ip
         iinr5Re6oao+TQhKgnqz78jRtf5pJnBo4LVQjDCMbX6Yt3syR/ArS9/DACrXgYo/M4Dq
         fsyibfZl4jswIhyLDgDGWeT36DSMSI9UNzqKEr/YLUogLq0OF26jDD6AEtHlVtD3KMYk
         iOjSfHk0TvocFmla0g1QRzvWEdTaYCcetv14J65+MB5KyY0RrKwMQNXy7TYD5ICLKlaS
         Q/NQ==
X-Gm-Message-State: AOAM532reGNkFXOhhzyRZ6+QrEzcVFjFPDqiMN3+N+m7yuMI81J3ecWf
        4TbbezRh5/bOVTJs2bAyrrrt/nXVjB01tA==
X-Google-Smtp-Source: ABdhPJznH4GEoq8J2yvBT47OK6fWcYlu8U6hIGVu3x3TdjVPDYhkgjPwNSUbUVmPVWB6bHCSrtpVTw==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr17689909wrc.24.1589780851623;
        Sun, 17 May 2020 22:47:31 -0700 (PDT)
Received: from dinux ([41.68.129.21])
        by smtp.gmail.com with ESMTPSA id d1sm15511374wrc.26.2020.05.17.22.47.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 17 May 2020 22:47:31 -0700 (PDT)
Date:   Mon, 18 May 2020 07:47:29 +0200
From:   Mohamed Dawod <mhm.dawod@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wfx: Typo fix
Message-ID: <20200518054729.GA12362@dinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing some typo errors in traces.h file

Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
---
 drivers/staging/wfx/traces.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wfx/traces.h b/drivers/staging/wfx/traces.h
index bb9f7e9..80e131c 100644
--- a/drivers/staging/wfx/traces.h
+++ b/drivers/staging/wfx/traces.h
@@ -32,16 +32,16 @@
  *             xxx_name(XXX)       \
  *             ...
  *
- *   3. Instanciate that list_names:
+ *   3. Instantiate that list_names:
  *
  *          list_names
  *
- *   4. Redefine xxx_name() as a entry of array for __print_symbolic()
+ *   4. Redefine xxx_name() as an entry of array for __print_symbolic()
  *
  *          #undef xxx_name
  *          #define xxx_name(msg) { msg, #msg },
  *
- *   5. list_name can now nearlu be used with __print_symbolic() but,
+ *   5. list_name can now nearly be used with __print_symbolic() but,
  *      __print_symbolic() dislike last comma of list. So we define a new list
  *      with a dummy element:
  *
-- 
2.7.4

