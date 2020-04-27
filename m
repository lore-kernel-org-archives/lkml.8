Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806D52063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="J+CAqwB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0IKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0IKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:10:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF36C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so5208406wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1dLU8YduWUBDKIvk9hl+sTzDJ6YHT5GLBFDPP+SjQU8=;
        b=J+CAqwB2QPN0E5CdjjxES0Yqz9lutFE6OrUW+aWlSRQAVoFskQIOQSp/tXnrrFcY+S
         pfPm9kzykgdcv5B1jTlNiflWU8tkErfeWOEBGdoh0wqB23/ypAx9G4SDqJnsQYrZoIKH
         X3y71AJ9OtH6jCWpLQIt8drRVFp9fLyL8gJJQ3g6cX91BvylB2ea48hyfzvV8CgsfIZ3
         exmB6/AGgR7uZ7coa3aXGWLVxtz6+AwQQKh/9m8YXJOWEpf3UDedfuJp3nrHNhoLmMiB
         PQ9PhY4SXnN8NPL7rTpmpiUGZcojr7xbYpiuvmesL+WLUZ5or7t1Sr7zh01rgfO/kexf
         3gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1dLU8YduWUBDKIvk9hl+sTzDJ6YHT5GLBFDPP+SjQU8=;
        b=LsstbU4+od/DJRHwtRDz6oQUZ9dKGE8wupTEjSMolegjHvZ6JDxm7QLDneMQQrXIzB
         ft5F2BdEHm0QFRzp2gi/a3iHlOU34BiTRo0P2eUleC3ed2wlULu9zPQhebWDwDX6szwo
         zI/ZPtZw5c8CYQ66pT31+UcpH30yriwtDTJQzCnLH+4wepaEP5H8XcRaYz8ZjnMeR4RA
         96+A2eDVckjUuXVF8u4sBWwSjteWZby/pz4IkcgDRbYESOXSrhsfLah67ztzSfLrN9eC
         /5ZIta64VGPxKe9XRbvdYlJ53a3zVEpuhj4Xzqw0iDAYVLwVry8MfEWb/r/HASSDM+e+
         xc/A==
X-Gm-Message-State: AGi0PuYy5HhYvy+SPTF2Z+Hg0NwjnkW/gjA9NAOVdCXzF8msUFjUiD8r
        /UyOGQogMk0zINMT7gyKJwlqYFcS1zzVp4Kv
X-Google-Smtp-Source: APiQypLn3J3RCB8ryYsKWizfosaGEJo/2w9hat+vzkU31n7Rr0/0iPIQaWP6YM/tdzVZON9yzrUYlA==
X-Received: by 2002:a1c:a794:: with SMTP id q142mr24729255wme.4.1587975007193;
        Mon, 27 Apr 2020 01:10:07 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:8400:6d4b:554:cd7c:6b19? ([2001:16b8:4886:8400:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id d7sm19574961wrn.78.2020.04.27.01.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:10:06 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] include/linux/pagemap.h: introduce
 set/clear_fs_page_private
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, willy@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-2-guoqing.jiang@cloud.ionos.com>
 <20200427055255.GA16709@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <125d6be2-eabb-16d1-19de-82c2e7de3851@cloud.ionos.com>
Date:   Mon, 27 Apr 2020 10:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427055255.GA16709@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 4/27/20 7:52 AM, Christoph Hellwig wrote:
> Why not attach_page_private and clear_page_private as that conveys
> the use case a little better?

Yes, thanks for the good suggestion. Will rename them if no one else
has new idea ...

>> +static inline void *set_fs_page_private(struct page *page, void *data)
>> +{
>> +	get_page(page);
>> +	set_page_private(page, (unsigned long)data);
>> +	SetPagePrivate(page);
>> +
>> +	return data;
>> +}
>> +
>> +static inline void *clear_fs_page_private(struct page *page)
>> +{
>> +	void *data = (void *)page_private(page);
>> +
>> +	if (!PagePrivate(page))
>> +		return NULL;
>> +	ClearPagePrivate(page);
>> +	set_page_private(page, 0);
>> +	put_page(page);
>> +
>> +	return data;
>> +}
> Can you add kerneldoc comments describing them, including why we
> take the refernces?

Ok, will do.

> Also what is the point of the return value of set_fs_page_private?

In this way, iomap_page_create can just return the function, but you
don't like this way as you replied, will change the return value to "void".

Thanks,
Guoqing

