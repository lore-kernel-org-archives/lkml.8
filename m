Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC221C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A711620725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpsM6cqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGJQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:12:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728022AbgGJQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594397526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjEBh/BOTj8O0DP/1T6iu+nKRTbX5bjS6l9mZZGhjTI=;
        b=NpsM6cqdJ+fO5EIu/zjbG1XZxW84liU0m+Lbi+6dZEKaxA4HvqJt8FpdRmJCYwu3dfY71r
        vD7G8/JMW6jZQGOSGsHiDHHcPSasSOKHN3Gg3QHuQnoKxq9f/qrBGgevoDETxaU6EufTJK
        bRFh5U0DiHpK1hiCVTVclSglE/ti2pE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-w8MVyzcMPj-IV1Ekcrxdpg-1; Fri, 10 Jul 2020 12:12:03 -0400
X-MC-Unique: w8MVyzcMPj-IV1Ekcrxdpg-1
Received: by mail-il1-f199.google.com with SMTP id x2so3990863ila.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KjEBh/BOTj8O0DP/1T6iu+nKRTbX5bjS6l9mZZGhjTI=;
        b=sEXsFKOdqt7uCteOiyCxqH3hv7g8uHdZomTm7bPtVn6v4sDO0XIP9Hsr81uOjZ/XlL
         m1U+TBxEK+tfjXr1sZ+fNQ7VFNmWYeMvXmSoN4IuWyjR6e0AQFC8TwTaGuj506rEjGW0
         3NDhH9Pg8EHmhGcUDPqskew9rmFLWGA3lr6nLz0N7/ZNNaVagWhqbgsyHHOh8vxlRi+W
         OPmCAod1b32UML4rj0WZ6EuWSM5TS0wsR93mu24KD13Ur4VuDvFUoWjTojBzhzqh7eTZ
         HDHfdFWr+OZIhfJCgeOjyHEP4fKqcJLN/zUtyW9G6R57t47HGMK9wT+D85emB//nl/tR
         QM5g==
X-Gm-Message-State: AOAM5335VH/O3BHn0uKZ7b4ohbZMiloqSYmvN8UXKq4ykFNbuHWW9a/e
        l7aJfKmPaWzx+Az0MUwoaI08pTPZHqPf0NdWBJ8d6WfDsqtv8w552gMKyU//boBq2+y/QypVx3N
        tjyOTRbIK8vhH6xxV1tWw9kJL
X-Received: by 2002:a02:a88a:: with SMTP id l10mr48785646jam.110.1594397522458;
        Fri, 10 Jul 2020 09:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy94wI731wHeAF8lN4eK3rZcY0aU8wnnlQa/0Aw+qE/7Bpzae229hnG2N1PedlmgS/crLLGSw==
X-Received: by 2002:a02:a88a:: with SMTP id l10mr48785622jam.110.1594397522235;
        Fri, 10 Jul 2020 09:12:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a1sm3518204ilq.50.2020.07.10.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:12:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 08EDE1808CD; Fri, 10 Jul 2020 18:12:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joe Perches <joe@perches.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, mchehab+huawei@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: XDP: restrict N: and K:
In-Reply-To: <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com>
References: <20200709194257.26904-1-grandmaster@al2klimov.de> <d7689340-55fc-5f3f-60ee-b9c952839cab@iogearbox.net> <19a4a48b-3b83-47b9-ac48-e0a95a50fc5e@al2klimov.de> <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net> <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jul 2020 18:12:00 +0200
Message-ID: <875zavjqnj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Fri, 2020-07-10 at 17:14 +0200, Daniel Borkmann wrote:
>> On 7/10/20 8:17 AM, Alexander A. Klimov wrote:
>> > Am 09.07.20 um 22:37 schrieb Daniel Borkmann:
>> > > On 7/9/20 9:42 PM, Alexander A. Klimov wrote:
>> > > > Rationale:
>> > > > Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp465"
>> > > > which has nothing to do with XDP.
> []
>> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> > > > @@ -18708,8 +18708,8 @@ F:    include/trace/events/xdp.h
>> > > >   F:    kernel/bpf/cpumap.c
>> > > >   F:    kernel/bpf/devmap.c
>> > > >   F:    net/core/xdp.c
>> > > > -N:    xdp
>> > > > -K:    xdp
>> > > > +N:    (?:\b|_)xdp(?:\b|_)
>> > > > +K:    (?:\b|_)xdp(?:\b|_)
>> > > 
>> > > Please also include \W to generally match on non-alphanumeric char given you
>> > > explicitly want to avoid [a-z0-9] around the term xdp.
>> > Aren't \W, ^ and $ already covered by \b?
>> 
>> Ah, true; it says '\b really means (?:(?<=\w)(?!\w)|(?<!\w)(?=\w))', so all good.
>> In case this goes via net or net-next tree:
>
> This N: pattern does not match files like:
>
> 	samples/bpf/xdp1_kern.c
>
> and does match files like:
>
> 	drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
>
> Should it?

I think the idea is that it should match both?

-Toke

