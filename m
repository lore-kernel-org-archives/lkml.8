Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE85206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRen5xnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFKWlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:41:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35352 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbgFKWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591915277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDTR+5GttWdXmCNIwTA7d5bDN5WnJR6E3mSy9s64c4U=;
        b=IRen5xnQmr+sREgOu+GfXiItZljowpaV4BwkvHcsuGq1jDXGWgDFykaFlPMhcs/HOrAv9r
        cZwko+zmLGKOQ4lydqdOuN169Wt2pn5jE20MAMxCunqZYEwGW+V6ZREkPdX1ihaUCOSYZT
        r6VXgqiX0NDlk0dZJ4s/cRpfEIK6ss8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-1zbjJLW1N8SQ_D2l4IurnA-1; Thu, 11 Jun 2020 18:41:15 -0400
X-MC-Unique: 1zbjJLW1N8SQ_D2l4IurnA-1
Received: by mail-qv1-f71.google.com with SMTP id o1so5535774qvq.14
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SDTR+5GttWdXmCNIwTA7d5bDN5WnJR6E3mSy9s64c4U=;
        b=BgStDX2Ki/TPNq2dLLSlqfbTYQR9mtbypuWF1Vm6fXLLShPJddcueLhJEVa/NCKbHP
         FNHpeh2YShhKwXnZqaMgIBQXj548LKPfOnScA5xUbnvLrWsnJHaw4QWylGh4OQvF0F2W
         e4MGauTsG69vE7fBd58K4nLrNPWoIULG3cV4GpZBVtI0Be6orxiewfjx9LcBI9BRuoFQ
         Wv8DRncLvy7RcotftOB1msHfKKs8eea6z4bRdmed6a4h8xOdQeBU7hlVjnbfqiJxGJKT
         3NAEv5f1q8B+4p8W6Vip45p5KYsY2v8ES/wLFsPrJD+dNNOErsY0SnjdzU0xTiWLnPQO
         00FA==
X-Gm-Message-State: AOAM530H9HHKlmayYUm7sW07WcfBwtjqGA59/qEjo1HHhMvO6dj6g1BC
        pk9Z3K6B3CewXpr6/H/NM6uPvuZcVt5YVw7+Hh/7xeD8YrlOwtpYliIUHT9oikl2ZunrB+t2AwK
        wW8KmBRdip1O/oL2K9FNts13n
X-Received: by 2002:a37:9c55:: with SMTP id f82mr229741qke.225.1591915274508;
        Thu, 11 Jun 2020 15:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq21behcBdmbji8O8gpSPjyId8zQ3ta2upyygQ2WeCgb/0gGbiZrMzBYYMkxboTw8JW1TaNw==
X-Received: by 2002:a37:9c55:: with SMTP id f82mr229726qke.225.1591915274249;
        Thu, 11 Jun 2020 15:41:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k6sm3256477qte.52.2020.06.11.15.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 15:41:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200611204746.6370-1-trix@redhat.com>
 <20200611204746.6370-2-trix@redhat.com>
 <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com>
Date:   Thu, 11 Jun 2020 15:41:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/20 3:30 PM, Paul Moore wrote:
> On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this double free error
>>
>> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
>>         kfree(node->expr.nodes);
>>         ^~~~~~~~~~~~~~~~~~~~~~~
>>
>> When cond_read_node fails, it calls cond_node_destroy which frees the
>> node but does not poison the entry in the node list.  So when it
>> returns to its caller cond_read_list, cond_read_list deletes the
>> partial list.  The latest entry in the list will be deleted twice.
>>
>> So instead of freeing the node in cond_read_node, let list freeing in
>> code_read_list handle the freeing the problem node along with all of the
>> earlier nodes.
>>
>> Because cond_read_node no longer does any error handling, the goto's
>> the error case are redundant.  Instead just return the error code.
>>
>> Fixes a problem was introduced by commit
>>
>>   selinux: convert cond_list to array
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  security/selinux/ss/conditional.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
> Hi Tom,
>
> Thanks for the patch!  A few more notes, in no particular order:
>
> * There is no need to send a cover letter for just a single patch.
> Typically cover letters are reserved for large patchsets that require
> some additional explanation and/or instructions beyond the individual
> commit descriptions.

I was doing this to carry the repo name and tag info.

So how do folks know which repo and commit the change applies to ?

> * Thank you for including a changelog with your patch updates, but it
> would be helpful if you included them in the patch by using a "---"
> delimiter in the commit description after your signoff but before the
> diffstat.  Here is a recent example:
> -> https://lore.kernel.org/selinux/20200611135303.19538-3-cgzones@googlemail.com
Ok got it.
>
> * When referencing a patch which you are "fixing", the proper syntax
> is 'Fixes: <12char_commitID> ("<subject_line")'.  Look at commit
> 46619b44e431 in Linus' tree to see an example.

Ok

> If you have any questions, let us know.

