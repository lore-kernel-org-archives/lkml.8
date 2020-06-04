Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC02206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvXrEv5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFDF7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgFDF7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:59:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8EC03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 22:59:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h95so684810pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUUk7gLCC9sr5iPcgp8jkdDPE9W39BQTP/3fVTPj3aI=;
        b=hvXrEv5fPtwYgH6i9ONHo+JyteLKKi6xTABhIoSPnsADZSv0IfYCEC+3KK3FEhdA6I
         +uVPzmYOMuGF5eVAr+Md2FOKA+tjv2TIpfg63YgAjO5KK26egHr5jktwW1NLhesaWYkL
         Y3jGzqiy5H1UOkhNK3R/Oxt+rdxk7tYSRa6bYZyUMJTaDMnN5OgfYLk8LT5UXZ1fjWLR
         F3qWUoPX8mvZAWwUDFVdXnhImSux43HOy4cwQR+yPAQkV49/EC7HEu9GV7WBsgXq1FDF
         nJcjWn/STN/cDe+Zyen7yPQQoIHVyIz0ng/GVnrwb7UllE799CYOteKSShEIv/JymoBm
         QbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUUk7gLCC9sr5iPcgp8jkdDPE9W39BQTP/3fVTPj3aI=;
        b=F8PlIy3/v66lkycZMJbfludM2m0oDHe8HbRV/mgbbBdbGS4MDeOIqVhP17tCu3tphW
         pqgh6dogjGto5XY61v1VNG64LD4oa4kr4eyvR9h0wC3hUoPDMggmQMy6Z9weW1Z7/uwT
         wehkLpgkXzNTXfq0yFuhE4MBaI9/5gcl9aurWNGJVtxkK/HEapz3odlihtJ9huBEfo5Q
         MZHawgaiHkZSQNu27SVKlD9zdxDksB09FhaAghA5SAGWTZZ4igMLXvuOJIXUOtUhDo6c
         2oXzIvHZ+G92m4IXAWcPwYnqSmmdRCDU5dDwWumQ+wCZOPW2kKAzwPDri5YsYIG45ZFS
         9kqw==
X-Gm-Message-State: AOAM5327y9KyA6Od1uRBBm1U81vM1dAW7wwo/L86q2G3B2nqMi2W4xzj
        5jd8Ad88ESTQMimmZto7jlwpmw==
X-Google-Smtp-Source: ABdhPJzeh7kob7ogWckMzO3sBJuBrbSbZ4YSjxaUNcIH/bi/7Ii6yzULiplFHNYkFJS3fY1lPDS7/Q==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr4038244pjn.103.1591250346020;
        Wed, 03 Jun 2020 22:59:06 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id m2sm4153047pjk.52.2020.06.03.22.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 22:59:05 -0700 (PDT)
Date:   Thu, 4 Jun 2020 11:29:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200604055903.ycvu6qfnlwgkh52a@vireshk-i7>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus>
 <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus>
 <20200603181743.GC23722@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603181743.GC23722@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-20, 19:17, Sudeep Holla wrote:
> I just realised that we have the timing info in the traces and you will
> observe the sensor readings take something in order of 100us to 500-600us
> or even more based on which sensor is being read. While we have 100us
> timeout for cpufreq opp set.

Which timeout from opp core are you talking about ?

-- 
viresh
