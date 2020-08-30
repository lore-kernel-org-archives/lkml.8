Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D3C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B2420757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTOWtMDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgH3Uc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:32:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgH3UcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598819543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6LNd/M7f8yjnWnGycX0VNlHNADmyStv3fopd0UN66g=;
        b=DTOWtMDgAe/Um7mXNl8Asl9UPZHmdGo+Es7X90pJqjJvcgF0YiLX68hY76cICMv50EfyR0
        rE9w6srWiGvJWTrE7Lr9IiGC/HX+J7pVh3b9NhIvo2Fo9kT6lfcRKVxLMgJNbdEHR7DF43
        Egx653+88ZF1G1p0OBSlz32qbswJghg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-81N0mSanMgu7PIpuStXS1w-1; Sun, 30 Aug 2020 16:32:21 -0400
X-MC-Unique: 81N0mSanMgu7PIpuStXS1w-1
Received: by mail-oo1-f70.google.com with SMTP id e2so2377163ooq.23
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C6LNd/M7f8yjnWnGycX0VNlHNADmyStv3fopd0UN66g=;
        b=j+FVHOyCMPxPa5vHMQUi7/1JKyrZHM8Gn909wsAZyH4fS1qSUPNUhVIGDdyCoHuUwR
         l0SIs9y5Uh4QbKuDAoOS0FnLP/3WRXYLM/04LayI6IqGBh2DvJBza+/+2bwncMDXbE/L
         z23q5ohMXnh/eK7fuWwDEpGoJgrr24lNQ/fV3ZT8v6vYJGQQ7HX1TgfU4M4eXf4o0yYE
         0OWFI8ZgEdPs7189Xcm3bMWBoa+jyqigYgkMmLxFzeYHrh6SZvZQCvqxX4G971KVDC7+
         aQFKQuPkjPwP8WDPnCwLsm0MD7/4gmqsaCgZG1NNdTVcEdjnmQYedsfCsLoz+SQi+Ang
         G4XQ==
X-Gm-Message-State: AOAM5306y8guCm+negvCYhaTFUtKdGWoCbgW1io5pq756J9BfwzHB64W
        d6liyrh19yylqB5DkRbtJDA/A2GOCq+8fzpK+IZmpq6GOBKIQdHQlcDkzYn1uQ7komL9zngG/Xf
        yHdX5ftwy3LYffE55BFtwuRfJ
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr1888094oie.100.1598819540613;
        Sun, 30 Aug 2020 13:32:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrD9u+F/6q4rxTxr/wlg5yP/lpYGhMDfdv39b63+EyY5FCBbybR161LiJntIW2vFMpWCd8RQ==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr1888076oie.100.1598819540299;
        Sun, 30 Aug 2020 13:32:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w21sm1244227oih.37.2020.08.30.13.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 13:32:19 -0700 (PDT)
Subject: Re: [PATCH] net: openvswitch: pass NULL for unused parameters
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     pshelar@ovn.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev <netdev@vger.kernel.org>, dev@openvswitch.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200830151459.4648-1-trix@redhat.com>
 <CAHp75VcdUoNMxzoQ4n2y4LrbYX5nTh3Y8rFh=5J9cv7iU-V=Hg@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5fc7bdfa-fedf-8f5e-9584-eb168b2fe3f3@redhat.com>
Date:   Sun, 30 Aug 2020 13:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcdUoNMxzoQ4n2y4LrbYX5nTh3Y8rFh=5J9cv7iU-V=Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/20 1:02 PM, Andy Shevchenko wrote:
> On Sun, Aug 30, 2020 at 6:17 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags these problems
>>
>> flow_table.c:713:2: warning: The expression is an uninitialized
>>   value. The computed value will also be garbage
>>         (*n_mask_hit)++;
>>         ^~~~~~~~~~~~~~~
>> flow_table.c:748:5: warning: The expression is an uninitialized
>>   value. The computed value will also be garbage
>>                                 (*n_cache_hit)++;
>>                                 ^~~~~~~~~~~~~~~~
>>
>> These are not problems because neither pararmeter is used
> parameter
Too many ar's, it must be talk like a pirate day.
>
>> by the calling function.
>>
>> Looking at all of the calling functions, there are many
>> cases where the results are unused.  Passing unused
>> parameters is a waste.
>>
>> To avoid passing unused parameters, rework the
>> masked_flow_lookup() and flow_lookup() routines to check
>> for NULL parameters and change the unused parameters to NULL.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  net/openvswitch/flow_table.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
>> index e2235849a57e..18e7fa3aa67e 100644
>> --- a/net/openvswitch/flow_table.c
>> +++ b/net/openvswitch/flow_table.c
>> @@ -710,7 +710,8 @@ static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
>>         ovs_flow_mask_key(&masked_key, unmasked, false, mask);
>>         hash = flow_hash(&masked_key, &mask->range);
>>         head = find_bucket(ti, hash);
>> -       (*n_mask_hit)++;
>> +       if (n_mask_hit)
>> +               (*n_mask_hit)++;
>>
>>         hlist_for_each_entry_rcu(flow, head, flow_table.node[ti->node_ver],
>>                                 lockdep_ovsl_is_held()) {
>> @@ -745,7 +746,8 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
>>                                 u64_stats_update_begin(&ma->syncp);
>>                                 usage_counters[*index]++;
>>                                 u64_stats_update_end(&ma->syncp);
>> -                               (*n_cache_hit)++;
>> +                               if (n_cache_hit)
>> +                                       (*n_cache_hit)++;
>>                                 return flow;
>>                         }
>>                 }
>> @@ -798,9 +800,8 @@ struct sw_flow *ovs_flow_tbl_lookup_stats(struct flow_table *tbl,
>>         *n_cache_hit = 0;
>>         if (unlikely(!skb_hash || mc->cache_size == 0)) {
>>                 u32 mask_index = 0;
>> -               u32 cache = 0;
>>
>> -               return flow_lookup(tbl, ti, ma, key, n_mask_hit, &cache,
>> +               return flow_lookup(tbl, ti, ma, key, n_mask_hit, NULL,
>>                                    &mask_index);
> Can it be done for mask_index as well?

Yes, it's a bit more complicated but doable.

Tom

