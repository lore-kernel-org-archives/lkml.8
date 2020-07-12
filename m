Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C334C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126762063A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sunYpune"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgGLR4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGLR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:56:01 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17782C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:56:01 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id y9so1941895oot.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cQ21waqM1AuqRfe+8jZIqLE+yEZAS6raLrScXTkrSoM=;
        b=sunYpunee7th1fO9elWq7ois0/PafjOirwsYFLUKsvrLrQQSh1dP6o/vPx8pLltTDk
         ClHO9zj7dTI4ozgHdPZru/xrjmJTx1PrVaMsEtWUvr2NzD9uaPqfb8Legfd8SfZf5bfe
         IAfvlhxolFotQdFbug2ZR6hNWLWNwRhHH3AcjueqanYYfW6hfaMpXqVztSoPAdQcpXG1
         Ke+9XswkxqvP9Xd0EyuSlG7ESCffWZmJDoNTRiFuc/qIJuxch1SA9tqRPM1d2OoU6VZm
         ch7aHBKuaWLEWCEITlrTShY5X4sx0ZsU+CEhb79mdqFelrLXZzzjL7xlcunM1fRSpKV3
         sKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQ21waqM1AuqRfe+8jZIqLE+yEZAS6raLrScXTkrSoM=;
        b=sCE5hg42JgsT8u3hNqGo2HJQjW58Yv7Nb4AT6k8ThaoXDFPFfjizo9b7BwbTXNXpLR
         O4BBSQPnPrQ+XbC+CICRcd4UFbj/Kj1gT4vbiG3tElBDue0wt38rMDPfw0wSA2CgSsTw
         wk+U6QP2l7OchjJkiclLrpNUDl8BLZ8437IzBXi9iEtcuG0y0XRLUMNZVr6c6xadGvwU
         O6fMpRd+EQxd2sKh09ix4EDhJmKrvplfkoTJryl/X6g2U7OFrAFQE7q+GHhyUkrQ7I//
         NwpiYH7qBJDSMP66nh9bORzUtte9r1r/0fsvkX5Y6EDPaijYcRSFg8GD/2JoSoFp+ZSR
         p8Tg==
X-Gm-Message-State: AOAM531j/UoT49jqnipMnpjZLLTzQUHWf9Vv4dZsO3k+SA59IjEalK0b
        sR4XOKe18BBLJcd4kNOG1HY+MmYa
X-Google-Smtp-Source: ABdhPJyAUOziNxehnJvcQ8wGW707FtHHXWNYmUbVUXRQz57vsv8dRnqWdSbQUC2RuTt0ijU8W1QIGw==
X-Received: by 2002:a4a:9552:: with SMTP id n18mr27075101ooi.1.1594576560193;
        Sun, 12 Jul 2020 10:56:00 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s15sm2568706otg.24.2020.07.12.10.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 10:55:59 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove unused members of struct
 xmit_buf
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200712123821.553420-1-insafonov@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <895d5f76-832f-62a0-fc82-79b26ca104d4@lwfinger.net>
Date:   Sun, 12 Jul 2020 12:55:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712123821.553420-1-insafonov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 7:38 AM, Ivan Safonov wrote:
> Remove unused members of struct xmit_buf: alloc_sz, ff_hwaddr,
> dma_transfer_addr, bpending and last.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---

Have you tested this change? Previously with this driver, an unused quantity was 
removed from one of the structs and the driver failed. Apparently, the alignment 
of some other quantity was affected. I do not think that this change would have 
that affect; however, you should be testing whenever the changes are more than 
cosmetic.

Larry

