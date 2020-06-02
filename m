Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C02206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mowwJ93O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFBTND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:13:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F7C08C5C0;
        Tue,  2 Jun 2020 12:13:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so5570220pgm.0;
        Tue, 02 Jun 2020 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ummwQBzJmeaMwFpF/XOW+e04S4X/mnuUzT0O2pim+gY=;
        b=mowwJ93O5qpRX5IFlAiTr29MSJEJk0Bt6JOqz9mRcpKC1egaqDKtF/ehGv4VYG6KRH
         dT8nqmsEcKxAiKDJdCwGedymzhNU94KuBah+eAyQ9owQQBpO8+o2zwW+j3pITw6vrT6O
         NVImb44rzTEpHVQGFfB77l1vJPZC/Dp+gU7E3X+aj4K0JBwXCcZ1gR8HzBxphsJMFjyW
         e45mHpBtuGKKhgoz9YvjauWD9o9njzD3qlwUdXkzrtVUxcX1b/8lOmagC/4LX4d86MyK
         T+QDW2+4N1FF/WJ3eYpHQmohvTHx5LVsx9GXZiEdLerHGFqcqa2DftFax0ZuyZFSZ7RS
         JjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ummwQBzJmeaMwFpF/XOW+e04S4X/mnuUzT0O2pim+gY=;
        b=Q+meR4cWKqLVLYAXwpvwO8qEVZC0tEwWRBEq3iu4t0TNiN4XYXlEobc/JzaUa6B9he
         uJH7Z+KJ1mQDZ7ZUGpeJuk5+9QPNNKgZGhakF1U/jUZM5VYNaDdU1jXH39zHi6beKPBJ
         JhpKUy3ZkcEhOOHvgRX6H5sFtWkvt3CpVbBm4OGJG3NO+CNnDR/lOthdnplRM9uf4ZQU
         kkIfs+ZEVLPlXiWo/RE+OTsYBO96Z0dZqmtJO58Fu6DB96zKnF8INvJdxk5xyZJGrJiH
         g9mMU75ckzyA5BIWoF31/EZPJcHvStsRFEN3KYd5ucaFS7xIhu6N12SuEADJao7pJ888
         jUzQ==
X-Gm-Message-State: AOAM533oNDHNMX2M7LIiqK+5S4vceHDRjPKadzEkFQUWeCaYfibaUfzv
        nUPxXwhoQubdV7Y/v7iyXvZZpM2E
X-Google-Smtp-Source: ABdhPJyhziYsvPwC8/dwKEJABhRSA6vjkhfux4LVvVp/C0Qul3g3j3pf/8BakqK3KCPFBfjeDFvk5w==
X-Received: by 2002:a63:531a:: with SMTP id h26mr14410583pgb.188.1591125180418;
        Tue, 02 Jun 2020 12:13:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x77sm3065832pfc.4.2020.06.02.12.12.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 12:12:59 -0700 (PDT)
Date:   Tue, 2 Jun 2020 12:12:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/92] 4.19.126-rc2 review
Message-ID: <20200602191258.GC203031@roeck-us.net>
References: <20200602101901.374486405@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602101901.374486405@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:23:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 421 pass: 421 fail: 0

Guenter
