Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBDEC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6E02078E
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezkdcm/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgIEN53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIEN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:57:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F0C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:57:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so12179571ejf.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7vHnbsQaTVoLJzyyFyi0SrSiuFZTKN5WtNqQ73f1pI=;
        b=Ezkdcm/1AiLLyGLqw7QrBbjI+ob4TYlIspAe7l+941Y2g3E0mPSWsG3hMwoRGUPB3W
         xNlF/hGQtEgiTXCLt4dxKF9zIOSHpd1K4uF35xysMtsgvkXfR9xWXC0dbLJYdVOlKKKa
         IY7RuWuQ85bNjJOVp/esmgzhuhFv8LNzToFB4Wfuxi909jyjQDmf2Y0wKrcqmw+ogdtX
         J8ZnnH0Ig/1YGLAUy5iQHUYrKq5Fe1ilJ1SHAAQCcbnotfa0X7duvruzGGzcZHYLJvpc
         bnjuAMzYov5r+RR3IaUpk6V6pCUA3LEeuqLHHSYLqMlvU4zCkpJ1ktl0aOoZj12MQUdH
         2Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7vHnbsQaTVoLJzyyFyi0SrSiuFZTKN5WtNqQ73f1pI=;
        b=cHNB4elAtxXl7/8+jlbBz/IQ2jHozqu6bWQgnG2dxiD1dAHtk2VfioddZlzMN7+qDf
         YA0qjwWzGVRpAhDIpo2sBiFjM5vUbjVl4lMjPsdIMSdVeZ/2YI6oDtidvIPocNjoBkPw
         JsCfqzs8JK9JPRwizIuj+lsCsl3Sgx9f2zmuJ1P5Au/78783Ja/XfRtqcxEPoBm29GTC
         dS2e0xao8wbwZD9FcbyEBZECGo91X4ltM6zgd2G6D7kaEunU4z/z4WdTqDvBRkeJ238z
         k0Rr9NbEvtxzIITzmNSrYjYdnH32v9ELE+Y1oCohhjkVKtRjYwcyj8zRQxFENUQo+bi9
         /MVA==
X-Gm-Message-State: AOAM530w7Au0J8DTw85sMvfewQ0VmwJfV0ikdivfJFX1N/F0rfIa11HC
        ZkJ+zzOM+Ulat3wq9XCiAmSkke36Wgw=
X-Google-Smtp-Source: ABdhPJyZXke4ITsp+HoHza4LYDRy+JGbTyBl/Psg2ZtgrlX6lJGnxACB8hPu2U8b2bXCly7ymlR5LA==
X-Received: by 2002:a17:906:1d08:: with SMTP id n8mr12978014ejh.236.1599314236978;
        Sat, 05 Sep 2020 06:57:16 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id f13sm9142992ejb.81.2020.09.05.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:57:16 -0700 (PDT)
Date:   Sat, 5 Sep 2020 15:57:14 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 3/3] openrisc: Fix issue with get_user for 64-bit
 values
Message-ID: <20200905135714.74bsr5h423k7guw4@ltop.local>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905131935.972386-4-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:

Hi,

The change for 64-bit get_user() looks good to me.
But I wonder, given that openrisc is big-endian, what will happen
you have the opposite situation:
	u32 *ptr;
	u64 val;
	...
	get_user(val, ptr);

Won't you end with the value in the most significant part of
the register pair?

-- Luc
