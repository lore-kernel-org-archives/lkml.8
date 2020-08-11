Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E6B206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYAxKLO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHKVt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:49:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF135C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:49:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so153082plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yRAye5F5l9hzR1g1P5dMPEhRVrsrXgvMRbsuClxK5F0=;
        b=aYAxKLO+2Nd++44vwrkooer5fORLLDqSDvBErgWq068zdHXMHzeisim1L/+G9ic6O5
         dNzUAomGUNjaDzTQy5YM3DWEsiWl1xsCLkIW3tZMbZhttwSRn1mAIPXFPe1gGxQo2tEO
         RDTUNDgaF1QpU9Qqd9uSYzY1wz1F8JzoAOtdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yRAye5F5l9hzR1g1P5dMPEhRVrsrXgvMRbsuClxK5F0=;
        b=jCo8Cl56nw30r9pfuWlv6T2NuW/NTxuLLbi4W85D3KGUAaIQ5RnnpXZoLIR5cKoDsk
         UdhX/nGu0UadcoUyu2tFzotZZoRUsbrEDmqLrWoaGN5nFCJ12AJKGf4EyltPNoEktkpM
         +W8Uea2XKyJIUGwMhecKXa73icwIByvT+Hk9A/lqLAU+dNKmDd3DNzJ3kq3Az9KqZVx2
         Qr4woVGJkEtDKwNc4TMR8Apkyc0u+HO0mJodHvnlzCO2xQdv0boAZ7l4+o/dtGPChEnT
         axVsbHx658MfHyws2hQZjK/Uhi4qBdcNwySVj15oJqWowRZ9f+C0EvKPZeqx/EwQ2UVg
         EC9Q==
X-Gm-Message-State: AOAM530EkJ94ntY274iy+Kgp8w0iIlw/vN8bHjlP3xbH2ibzuNO0NLT5
        uKRWqDmBl29cIvhbkzx6fKO4fg==
X-Google-Smtp-Source: ABdhPJxTaonzDdTXCXuqxdmP93HMUeWwx6e1dOqgdNNGwjyPenieCTBR8G9AO04BsWwnHSnOkJcplg==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr2552967plp.203.1597182567153;
        Tue, 11 Aug 2020 14:49:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l19sm59212pff.8.2020.08.11.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:49:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200730095350.13925-3-stanimir.varbanov@linaro.org>
References: <20200730095350.13925-1-stanimir.varbanov@linaro.org> <20200730095350.13925-3-stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v5 2/3] venus: Add a debugfs file for SSR trigger
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     jim.cromie@gmail.com, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Tue, 11 Aug 2020 14:49:25 -0700
Message-ID: <159718256557.1360974.458611240360821676@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stanimir Varbanov (2020-07-30 02:53:49)
> The SSR (SubSystem Restart) is used to simulate an error on FW
> side of Venus. We support following type of triggers - fatal error,
> div by zero and watchdog IRQ.

Can this use the fault injection framework instead of custom debugfs?
See Documentation/fault-injection/.
