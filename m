Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC890C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC66F2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="jI0xGxBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgEAWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgEAWmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:42:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B01C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:42:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so2698577wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1YoBrGcOfoWOs/B+m22a2sFXdCiWrExB6slCiIMgKbc=;
        b=jI0xGxBhVhqnybezou5wj+pRK5XU0aUq5pyIuEgt1VDoiOBjHDWAeMXBE2CzslyrAV
         4kWrhrL7z+puiACbIuYaThmJfB++lY3YmYpSWWquIJSr4y3PF1j5CmDza9rKwoBhnh9i
         rhvHql0fkniS8CdnKOT8Ev+tI/Jcq1QaftZDRBZtq9RE3tXWWRV5COIo0l4Y/+o7ZIHl
         F7Yq+FX8U6T5kLbrxfpxBiad1J/SbUcPvazfNRc19Bg/g0HDPc7gjRtqyVTtX8Ey9O5+
         1oMWqKoQb4wUMfzIgUh8STCnfm80SsxxY3ygXHhaHlEBIjJLTehQamZuZuoKhDvlB4rE
         8xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1YoBrGcOfoWOs/B+m22a2sFXdCiWrExB6slCiIMgKbc=;
        b=kDhBOg872kmGHPaWXx0hx3Jv9ynEspk8xE6bmye7b9fY8I1twueHgpISJmuaIR0lSV
         kugB7gv0cvT3whoRWE/oXGUGo9tXXeDSJ6sBNXE0b2uwqQok1u1jPPy/leKXR4GrNMAR
         ofhtHd3F/XYJVPilrE9N6+UOJoE3oANRS+FPXsTZnW4HW28Z3nEXT8AOWBJb5OXbWbe1
         dJnsrjwp8Prt0nkui9mf+dJ3Ees5maytu8w2FhajTh1dtAiYgZAXAzfGs8iI38TRNJEZ
         PMBGbmfv6zm8q23Ik2mD8pdQ2PzrkTqKq706ZZL7vT1vRFUgW15Y05KBHHp7XLGke/6t
         b9gQ==
X-Gm-Message-State: AGi0PuZ9bYP5I6oH+zq3E65lyw6WLvql9C8gi36hTXpnxnd38KrKfXu7
        oY/R8fqbxmportT7XbQDWzsHFQ==
X-Google-Smtp-Source: APiQypLwiXqwSDx/2b4YPOndd8yiZUZwFdBeA1+HWHdbcYWvVSw4FKrouvTOTMmgtoXo931jzjCF9A==
X-Received: by 2002:adf:ecc5:: with SMTP id s5mr5112370wro.261.1588372937299;
        Fri, 01 May 2020 15:42:17 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48db:9b00:e80e:f5df:f780:7d57? ([2001:16b8:48db:9b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id n7sm1404912wmd.11.2020.05.01.15.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 15:42:15 -0700 (PDT)
Subject: Re: [RFC PATCH V2 0/9] Introduce attach/clear_page_private to cleanup
 code
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
 <20200501221626.GC29705@bombadil.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <889f9f82-64ba-50b3-147b-459303617aeb@cloud.ionos.com>
Date:   Sat, 2 May 2020 00:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501221626.GC29705@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/20 12:16 AM, Matthew Wilcox wrote:
> On Thu, Apr 30, 2020 at 11:44:41PM +0200, Guoqing Jiang wrote:
>>    include/linux/pagemap.h: introduce attach/clear_page_private
>>    md: remove __clear_page_buffers and use attach/clear_page_private
>>    btrfs: use attach/clear_page_private
>>    fs/buffer.c: use attach/clear_page_private
>>    f2fs: use attach/clear_page_private
>>    iomap: use attach/clear_page_private
>>    ntfs: replace attach_page_buffers with attach_page_private
>>    orangefs: use attach/clear_page_private
>>    buffer_head.h: remove attach_page_buffers
> I think mm/migrate.c could also use this:
>
>          ClearPagePrivate(page);
>          set_page_private(newpage, page_private(page));
>          set_page_private(page, 0);
>          put_page(page);
>          get_page(newpage);
>

Thanks for checking!  Assume the below change is appropriate.

diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..f214adfb3fa4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct 
address_space *mapping,
         if (rc != MIGRATEPAGE_SUCCESS)
                 goto unlock_buffers;

-       ClearPagePrivate(page);
-       set_page_private(newpage, page_private(page));
-       set_page_private(page, 0);
-       put_page(page);
+       set_page_private(newpage, detach_page_private(page));
         get_page(newpage);

         bh = head;


Cheers,
Guoqing

