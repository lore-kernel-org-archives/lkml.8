Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC80C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97A7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Om8wbEWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgHTRPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgHTRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:15:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A872C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:15:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ds1so1254171pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lnb73Iq69gKSLZJF0MMWf+npRy4EArM7SDSo7R1fk90=;
        b=Om8wbEWrVQQmlk+tjod+u90QU+sV70v4tA8PHYYHY/8zcf3tjvGLnqbNDJUi1CjmDA
         GhjG+BuIsIFctbe9Op5+FZA4MOZEQKjH5VRXkP1GJ9xLV15Ou5Yw7wML8iA4Adr9ApdK
         LKpbH8gknpCqTIi2T0Shz6X8PIEdlGnePzZqRW9EgsSurx0ZU7lh6sFtRPode0sHk6Os
         /SRyiRrKLubfJb9J+kERsIzetPXPmDS+tm5rVnqVNuAP98y7K1Ad6S5Iz14lxE5kIJWS
         gzKL0hqqOWWssD/Hmpno7+y3hU6Xv5OG6f2AgyWIsMcSz9MYmz4B8Axcb1b0o7l3/eDM
         7V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lnb73Iq69gKSLZJF0MMWf+npRy4EArM7SDSo7R1fk90=;
        b=umRvZRyScrH5BuRCdeQcetdXVca1xurWY5T8epw1J63GAgJ5X2e4RUxGIXdUnfnK9O
         dTUO+L7JeGtV1je3bwW14Ceocu+YFK8YfYUMArff7cStcKzIX5rrAiLEqDL4eq3beVyY
         brAQoedT+SqevHZpVTqzAb9s6FBkBAageJ85iqto2SPwiJnvCjnReTT5B4yR5XQRAYIi
         7yAdDUD90pQuTGEyDmidIDc8Ze8fJ60w0vdchhmepJqDhFpZcwnjtNBrRdjrgaWG9qgr
         0vSzBOOhvm1e/3Kp7jQwiBYQBZssRP4LofQxsyTA1F61E6VgQ7JWQL3dHhb+UcJJe+Tm
         dnqQ==
X-Gm-Message-State: AOAM5338eNha7lbaIfnS4Kj2QecAlxEsEcCyAemI0w+j+XxgA9FZ/I7P
        QZf3zNjCl86c6J/tT5p0x3+u/6RlM5jTAy/hDL0=
X-Google-Smtp-Source: ABdhPJxNjEk8N2CwA9AQjce290avW7h5BEXFqhxYqZoNWxNsofrU0gOjcdnL3uyPt9A76exUtYmarg==
X-Received: by 2002:a17:90a:e64c:: with SMTP id ep12mr3425355pjb.206.1597943697872;
        Thu, 20 Aug 2020 10:14:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::16b5? ([2620:10d:c090:400::5:609b])
        by smtp.gmail.com with ESMTPSA id q11sm1075155pgj.92.2020.08.20.10.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 10:14:57 -0700 (PDT)
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
 <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
 <20200820171214.GA15207@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e4804b-f036-a1f8-63b6-b51592d9a0c5@kernel.dk>
Date:   Thu, 20 Aug 2020 11:14:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820171214.GA15207@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 11:12 AM, Christoph Hellwig wrote:
> On Thu, Aug 20, 2020 at 11:10:58AM -0600, Jens Axboe wrote:
>> To be fair, I've only heard this one complaint about it, so hopefully it's
>> not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
>> just fine :-)
> 
> The cause for this is the weird NVMe of by ones, where 0 in a field
> means 1.  So for the overflow to happen you need a controller that
> supports USHORT_MAX queue entries.  Which don't seem to be all that
> common.

Yeah, don't think I've ever seen those. I come across 1023 and 128 all
the time, but I don't have one in my arsenal of NVMe drives that is
any different than those two.

-- 
Jens Axboe

