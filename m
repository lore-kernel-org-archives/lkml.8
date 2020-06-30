Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B6EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5A020702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vIyCu074"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgF3TA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgF3TAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:00:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6229C03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:00:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gc15so2217950pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRcKUYv8vLMl07E2wdlABymQJFgrXbgTcbsQgAon5/Y=;
        b=vIyCu074YMPyf2Ko3ofarVXk/Wxbl62AqwQ2UDR5UU8SRPqmxHf+1uFctP73i4xGPC
         UM553wn8Jn7Gk7IP4wsYjza2xy5UHJ9ppYcm6xqsmpPYSzMvX5MI3I9jcHzI8qh1ENRr
         RQh3zxcGI9lITyz/c6TlyJ62hLloJACxieH2CO9YJPxUfEnERzIVnVpoyyuLnqABUzc2
         09OWpgauhVKk5aAcaly00m/Rujet839tXO72Wfoe8CtvLgFmE0jZ9v+vLMptv6Gm2sa1
         BKCOPatyl/v4JwP7ZO5xvW2g1d755NzL78E+wbW3nNQFmF0bvWSogT/g28bJP0wQ5err
         DAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRcKUYv8vLMl07E2wdlABymQJFgrXbgTcbsQgAon5/Y=;
        b=fQFPIbU3EqiiMqhJNLlzjhgkBEOK8Wvqo9cT2hSK1Ci4ujvM241O4qHKxJz5jdOdU1
         6ka0ntfbO8CtuY5Fo/fp9TqiINyCbZ26aX8O8SHfpzhRcLHTmO0t+qFPQpRRBm4I4uNt
         aDxp5u87aro3oNkxxFGdNWP6x05nqQECUbzaQP4PEDRe8bcBO93TmZ37y+ZnAKK0Akgj
         fkh3fhQNjW+LQF5d7EniP55s1KXkuTJtdr/9+bbl1gupVQ27GSQQBC0EDQA3huFXL2wL
         ZdB+AjHgZ9MFvu2E2W7fxKm2qDFx+Qdq8eBlcLkzyIE7cSm/baL1BhJxvSPiEe0fFiu+
         kXWg==
X-Gm-Message-State: AOAM532PBs97jjia4/bmyYZtgx4bQc2nr6L4Oc7ej/Y2fL0PQbRjt6Gv
        4Z1TkoC9N3TZNxnaXakdLoXHcYLMwgWXrQ==
X-Google-Smtp-Source: ABdhPJzsjTFT0KHYgvipUVj/IOy0DkeFygIVTw7V0JqjKb+vc9JixphbA5csC5gy8bdDgwbaF2EcvA==
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr23711760pjb.110.1593543623094;
        Tue, 30 Jun 2020 12:00:23 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id u188sm929814pfu.26.2020.06.30.12.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 12:00:22 -0700 (PDT)
Subject: Re: [PATCH][next] blk-cgroup: clean up indentation
To:     Colin King <colin.king@canonical.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200630155441.518850-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a75d74f9-88a6-7bfd-d0e2-b4f05c8aa7b7@kernel.dk>
Date:   Tue, 30 Jun 2020 13:00:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630155441.518850-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 9:54 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statement that is indented one level too deeply, fix it
> by removing a tab.

Applied, thanks.

-- 
Jens Axboe

