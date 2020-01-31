Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D779C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005A020661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5CPdGIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgAaAYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:24:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51439 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727614AbgAaAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580430277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yce3RzcRj3/knjHHok9NbXtjPYcgNWKvZz8mmZTolms=;
        b=N5CPdGIcBKiE+5WdhpdAmPmbbuyAr2qWG40lvTXGlFtIRhLDLweQiWJXSHpxfFBzCL6heF
        fKcspcCULyd98NmEZgLuwsa/2YsXv2t0XSZQ9mx/vzuzmXMM4UjzTrsibb9EF+9XL4Vzox
        DXWakWGSds7V01OnfF9fB5HAzFEffHA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-Ec-zhgFPOfuC_qOo7iHs0A-1; Thu, 30 Jan 2020 19:24:33 -0500
X-MC-Unique: Ec-zhgFPOfuC_qOo7iHs0A-1
Received: by mail-ed1-f70.google.com with SMTP id cq10so3551906edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yce3RzcRj3/knjHHok9NbXtjPYcgNWKvZz8mmZTolms=;
        b=KZoZvE8rZYwbFBA+UyMpSs5X90cS7aC9wOhzJurQ20GNxZOxDy7Q6tJaEkp04AJEME
         7Ro69vg/OGTBUWmFVncVBMRMvxx970QFPA3Z7F0LYoIXsVGRdoGYFfszFBTaj2mXyzAc
         HKKboDeY/tcbJ9K3Te/DMNn5460yU6wnsh3zjYnO5kw7F94QsDJt5zKKzNZ8K3tBNF6G
         bz3NDYLt6ddOmCHAoG21sjvTOwU2Qthj4qipOQyPmwUNwl5nsh2faONbBoQLEoYpxGq3
         bTLnuHtRjjlHMJWm5+6WGpkTUcfg6kL+WjMOPe1mRCA+C7JXzGASbu3Rav0yZ/dBIu21
         yGwA==
X-Gm-Message-State: APjAAAVXM4EtmRtg8SeBDm44UATZ1mxJHb+9HmUw3N92enK9APGZHvT4
        LTseHBdSfTJBAXCkRYLfHBYvGREDak9FVFr5L9J7A3bdCrbijrlJp2jFVnPnitC342bBBT1HLC6
        FFGx/r2NEzWUhjcr1rAAyrMzUMKh35qNSWb0D6TKS
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr6377962edk.366.1580430272325;
        Thu, 30 Jan 2020 16:24:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfns7Ipz2OMXE7rsuvi11JkWCkrY9gHsHVLdpY40duyr/etkHlFPDUanfpd7IpDQXFGEdFBuoEY3X8zi7kwNg=
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr6377950edk.366.1580430272088;
 Thu, 30 Jan 2020 16:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20200130191019.19440-1-mcroce@redhat.com> <20200130141448.27fa32aa@cakuba>
In-Reply-To: <20200130141448.27fa32aa@cakuba>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 31 Jan 2020 01:23:56 +0100
Message-ID: <CAGnkfhzHqHFiqje3_ruSFvz09QKv3M8dqvOqzN_kau6ZpKzWOw@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nf_flowtable: fix documentation
To:     Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev <netdev@vger.kernel.org>, linux-doc@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:14 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 30 Jan 2020 20:10:19 +0100, Matteo Croce wrote:
> > In the flowtable documentation there is a missing semicolon, the command
> > as is would give this error:
> >
> >     nftables.conf:5:27-33: Error: syntax error, unexpected devices, expecting newline or semicolon
> >                     hook ingress priority 0 devices = { br0, pppoe-data };
> >                                             ^^^^^^^
> >     nftables.conf:4:12-13: Error: invalid hook (null)
> >             flowtable ft {
> >                       ^^
> >
> > Fixes: 19b351f16fd9 ("netfilter: add flowtable documentation")
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> This is netfilter so even though it's tagged as net, I'm expecting
> Pablo (or Jon) to take it. Please LMK if I'm wrong.
>

You're right.
As get_maintainers.pl didn't list netfilter-devel@vger.kernel.org I missed it.

-- 
Matteo Croce
per aspera ad upstream

