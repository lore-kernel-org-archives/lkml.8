Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15258C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9218206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SoCIgu/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgFEW4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgFEW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:56:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6747C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:56:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o6so5864321pgh.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w94Y30Zj7mgg0jm3gA8QPbDqP4Kye5MwiIglsO9uWtI=;
        b=SoCIgu/Xz1pn45ICdQTezePAt9VI+dO5XYvTbmNXVHOiE53+A6rPMVa213jkfsJ39a
         LyAXUdrHq6iqzCkT0bk0V2J/7eqrlk4LIyLaFMAMPDCqFtbFlBA4wAbmnsWF03+49az8
         O9yFCNlzsb14ItloIGFVUj6RvfIJ7elammovrwF54k25auCB8yOEaC9KbD/o00k0+/Fr
         tmG00Y/BDUgsGMOIfM+V6qI2tBNv4b23G693sbHw+5o7VjwFm6MM1Vq2e2haMuTlYvV/
         3bXNwBgK/K5qMfdhIK13E6QarityB6y61tyDmarToflyM+MxcMXqfqbtMiD01DL6MG7z
         88pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w94Y30Zj7mgg0jm3gA8QPbDqP4Kye5MwiIglsO9uWtI=;
        b=FRNHWk6hIoTkrBTY4TTTtuQlpvXIS4dXv6iPoUzCwd95objY3frHuBt7jBpur98OPH
         idJ3zdc49/hAUfcqEd1mpICRMxr9310axwEp2ozXSGBVCt7/U+qzjt4VFHHEt7qaXs3+
         LDhGmBeF7faYpnpVSpVkf2fKIy9hD4FdCMvJwoB0C4QWPpbJtNLO/NJonCO7n5TxqcO8
         wzG+DlcYBZ4IeGc+KMmeFHnnH6Jn8zYheafvBx7Fgtcir/bPRTBx3K5QX3E6VNxuU+sD
         05+uzZhNDSti1AycJ8LbXs0+S1QXjJ6nScLVz16UecCws3NoC7CabfigAb7Gc2SQy/+j
         MPrA==
X-Gm-Message-State: AOAM531ub8eqd3upcpifae8eMaPF7UOHSt2AylcWK5aYvanwlOQKZiqV
        gGEducawjiAg8310AX6g+F6H7w==
X-Google-Smtp-Source: ABdhPJyXn5aY8Y2tU9anpymJoYRaxBGnHkDmaAx5qvJihVgks3VcY0U1PnX9FQlhvvu5VSdM/4sagQ==
X-Received: by 2002:a62:4e8a:: with SMTP id c132mr11145162pfb.22.1591397806892;
        Fri, 05 Jun 2020 15:56:46 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q65sm581373pfc.155.2020.06.05.15.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:56:46 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
To:     Andres Freund <andres@anarazel.de>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <e3072371-1d6b-8ae5-d946-d83e60427cb0@kernel.dk>
 <6eeff14f-befc-a5cc-08da-cb77f811fbdf@kernel.dk>
 <20200605202028.d57nklzpeolukni7@alap3.anarazel.de>
 <20200605203613.ogfilu2edcsfpme4@alap3.anarazel.de>
 <75bfe993-008d-71ce-7637-369f130bd984@kernel.dk>
 <3539a454-5321-0bdc-b59c-06f60cc64b56@kernel.dk>
 <34aadc75-5b8a-331e-e149-45e1547b543e@kernel.dk>
 <20200605223044.tnh7qsox7zg5uk53@alap3.anarazel.de>
 <20200605223635.6xesl7u4lxszvico@alap3.anarazel.de>
 <0e5b7a2d-eb0e-16e6-cc9f-c2ca5fe8cb92@kernel.dk>
 <20200605225429.s424lrrqhaseoa2h@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0179d0bf-0b01-3f05-9221-654a00f0452d@kernel.dk>
Date:   Fri, 5 Jun 2020 16:56:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605225429.s424lrrqhaseoa2h@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 4:54 PM, Andres Freund wrote:
> Hi,
> 
> On 2020-06-05 16:49:24 -0600, Jens Axboe wrote:
>> Yes that's expected, if we have to fallback to ->readpage(), then it'll
>> go to a worker. read-ahead is what drives the async nature of it, as we
>> issue the range (plus more, depending on RA window) as read-ahead for
>> the normal read, then wait for it.
> 
> But I assume async would still work for files with POSIX_FADV_RANDOM
> set, or not? Assuming the system wide setting isn't zero, of course.

Yes it'll work if FADV_RANDOM is set. But just not if read-ahead is
totally disabled. I guess we could make that work too, though not sure
that it's super important.

-- 
Jens Axboe

