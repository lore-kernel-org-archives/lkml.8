Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C95EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51072075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgH1P4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:56:12 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:35732 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgH1P4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:56:10 -0400
Received: by mail-pj1-f45.google.com with SMTP id g6so707859pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qzfWzuMBNGhEvnQgxEL1n9TGRf+NI0mV2QRU1s6shzQ=;
        b=VuihroXWgXjaUsatL/sBAGuRuFOAO8JWhOjrq5gcv05TdT7rtX4gtytDeTUElYEyZX
         jmV8r9xvWUvWWIhuuDQKTdFBlZLNId7tQbDaotL6p/cEp+sj3ZU30qWHZ3yWuSV5cRIM
         f1lMRPKKmOIqrhmxH0LHZMjqoe1ZN4cRh+B1lurPuZdYP5U9yNkZr7Ru4oWwaG4iZmA8
         tpq7fN3ezJBqokccT9f1me9TmiQL0N4M66shBu+zSlBSHfnp621ZPApSMwh4S/TRvgQd
         xJqeMfTZ+Pv5okNszEi5lwO/B5sedXGiOaTl32SdzeWY1Eajrq7X/3RlS2J6P6ROIp+V
         86nw==
X-Gm-Message-State: AOAM532ApPRtSmSXn3+pskmOP2z3d9SGQZHz74ExMGurra4ZQQ0pWS1O
        4eYZ0J3juGVs6gHXt4Dzfeu2gfAhDZkF7Q==
X-Google-Smtp-Source: ABdhPJxNPX349VxWsdZHaGw8iWI7QPEGL9AK5pIOcajA0Di3u7k5Qw1ueCvpm3ra9Mljk1GyontA4Q==
X-Received: by 2002:a17:902:c402:: with SMTP id k2mr1949302plk.308.1598630169186;
        Fri, 28 Aug 2020 08:56:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c4b8:3871:4bc4:154f? ([2601:647:4802:9070:c4b8:3871:4bc4:154f])
        by smtp.gmail.com with ESMTPSA id t20sm2270212pgj.27.2020.08.28.08.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:56:08 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-pci: cancel nvme device request before disabling
To:     Tong Zhang <ztong0001@gmail.com>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
 <20200828141707.4124-1-ztong0001@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <62d8d9fa-9615-4ad6-9eb7-9f26165d1455@grimberg.me>
Date:   Fri, 28 Aug 2020 08:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828141707.4124-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added to nvme-5.9-rc
