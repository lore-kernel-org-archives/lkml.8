Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A506C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D2B2053B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sSI1R1nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgEWRHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgEWRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:07:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FCDC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:07:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l73so2897837pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=egMx+No4Q7JjvOH6HOQxtmCuDUz9eFhby8mi1jgHo88=;
        b=sSI1R1nGqQkE67A0UByykv2becr/N/nEMsk1aYYRxUFWzu6viyG4Sps2d6npfiJvKw
         gbeTDje4JgbfrNVC/VRmwuHmHrgcIyhpSPSiLqQJwzletjfTO3p1JBOTODia1MqvoQ6X
         XHPqgRc4IpO3EClibxSClAEmy8HFa/JIgNLDyuVUKxamQN/tKzi74Q/uBo6D+Ez5W3qd
         k2RQ0Qjbkh99iyIEfTadj4Wd0yo02fu1D6V4H0DBvGDqGCfgn4KTwZxPsGKv2aS9c9dO
         UaYutES/BtQ0/mpgUDp9uHQWGC//alIU2tz6QaJf/LSFVETtjt50CwK8FiLA+vd3XFUT
         9T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egMx+No4Q7JjvOH6HOQxtmCuDUz9eFhby8mi1jgHo88=;
        b=TMsx/f9K/DWMTRpNcUQ33V1+HfXQyZeewYG1Dq+XZXTthIFCSb2GF/nM1aqDC+Fx71
         IXjiHaKsF82iQJCYWMWL09S9rHqiCdvTK9J16qCvhYEejgNL5FVuSwPXoNVExmhNCRNL
         a9in1ep1ccr7ASfViwY99cs4If7p6eSP1yDuWorxJSTCTQpUQx42c/vb0xFrYVtTIrQj
         cwspw6uNqzFJ1mXfMrwyeEI/gt/FdptnJrqG/2OXWILAKcnyRx0YRnVV++Xbv1+ZBMRi
         Z1e273czRyMc6x/XJFJUmVdWCa/05BiDK9woI+D7Hv4z+89L2dwldamdjAUmivz2fC9h
         BsgA==
X-Gm-Message-State: AOAM532l7SMF+8MeeF+QwF3IQbCd3m+QmOdxYa3OLscTQYewfl3dohn2
        IRKC+HW+gLasGxoqdl6zKejnDw==
X-Google-Smtp-Source: ABdhPJxnyYvG0ZjbSXbIIdKDqPnqOs0WiiBaaWE2i2K0BL1GNY+NkEai1e0hxFdwoTJxRJ3wismciA==
X-Received: by 2002:a17:90a:23e7:: with SMTP id g94mr11931683pje.210.1590253655802;
        Sat, 23 May 2020 10:07:35 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:7c7a:121c:c8c2:4d28? ([2605:e000:100e:8c61:7c7a:121c:c8c2:4d28])
        by smtp.gmail.com with ESMTPSA id m12sm4823488pjf.44.2020.05.23.10.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 10:07:35 -0700 (PDT)
Subject: Re: [PATCH] linux/blkdev.h: Use ilog2() directly in blksize_bits()
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     damien.lemoal@wdc.com, bvanassche@acm.org, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20200523155048.29369-1-pilgrimtao@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <98a69358-9976-e0e6-9cc6-f9c4676d8f3f@kernel.dk>
Date:   Sat, 23 May 2020 11:07:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200523155048.29369-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/20 9:50 AM, Kaitao Cheng wrote:
> blksize_bits() can be achieved through ilog2(), and ilog2() is
> more efficient.

I like the simplification, but do you have any results to back up
that claim? Is the generated code shorter? Runs faster?

-- 
Jens Axboe

