Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C244C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1009A2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O8T8RwxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgERVWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 17:22:39 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14641 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgERVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:22:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec2fc500000>; Mon, 18 May 2020 14:21:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 14:22:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 14:22:38 -0700
Received: from [10.2.55.90] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 21:22:38 +0000
Subject: Re: [RFC] mm/gup.c: Use gup_flags as parameter instead of passing
 write flag
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com>
 <20200518201737.GV16070@bombadil.infradead.org>
 <CAFqt6zbcn5kEbtY1fod4yy_PETKX8zVM2NjsY0HHyOixiu2q4w@mail.gmail.com>
 <975cc333-e9f4-29e4-db0e-00ea8b8a7c25@nvidia.com>
 <CAFqt6zZoFBkvkZKOc9mbGVO6_Gst+0k=wpjmXYSKvFru=HgczA@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4effb531-844e-0755-249f-ba5dea7bf490@nvidia.com>
Date:   Mon, 18 May 2020 14:22:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZoFBkvkZKOc9mbGVO6_Gst+0k=wpjmXYSKvFru=HgczA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589836880; bh=E85nFVa8mu0vGn7khXC49N7FJQ3xbA85drUoVklhxno=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=O8T8RwxSkH+IdRc0E8xXcXXZ3GbbJAx3B/6OP3dwhbwhfvn/jTthg5lb1R35np2cG
         LGGqn2NlgENnn/OyzffzE8mGx729KDQdrdrppRNWh1Of4M/E0yADc24fZ+DWdQcxFj
         ls6LEGLSfOHJQEn+16OxxVZHvDM/AReVcobs80e3ORmIQprOzi74LuU1AX1EFJ5Ob3
         V43mi9iUqr+7FaM/ywAiL+5Gpg/Pu/YqQlHyA7uftO/plG0cXTI8bYXds7LDeflxXV
         WU4vUC223YEbtuPm6DaXJEb1i/dyQiE3yEQtjkSRDrFqdnqGvOw5dTYHLGyaHqQVWU
         yH99yp/2kRGTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-18 14:06, Souptick Joarder wrote:
...
>> So in other words, if you do go out and change all the call sites (there only
>> seem to be about 7, outside of gup.c, actually), that's going to conflict
>> a little bit with what I'm doing here.
>>
>> So, how would you like proceed? If you want to do the full conversion
>> (which really should include the call sites), it would be easier for me
>> if you based it on my upcoming small patchset, which I expect to post
>> shortly (later today).
> 
> Sure, I will wait for your patchset :)
> 
> As there are only 7 callers of the __get_user_pages_fast(), I prefer to do
> full conversion in a single commit. But if it is not preferred way, I would go
> as per feedback.
> 

Thanks, I appreciate it! And yes, you'll want to do the "write" to "gup_flags"
conversion in a single patch, definitely.


thanks,
-- 
John Hubbard
NVIDIA
