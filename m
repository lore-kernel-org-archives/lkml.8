Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A19C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080FB246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PMtqoD+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgB0Pxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:53:38 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:44669 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgB0Pxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:53:37 -0500
Received: by mail-qk1-f179.google.com with SMTP id f140so3540713qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EH0SNO5Rcc4XYOUSFVK7bK7rNzgEXpv0OLPCvUs1MKM=;
        b=PMtqoD+Qorl+adIp7K03I0mEvU1rioCUSaRdmWReGiwltATTH6RJtRscNq5iIqT9cY
         JSA9CN5t7cEAsNpiP/S+TdjCZcTKeZJ7h8ZLu9IL9vsnjmxAe95o1Ckuho0hdEY+xmNL
         CEMDj98AiR3AVKxOVA67huauMos3yZqp1HaKRkhsgTyCF1cBspSyrV/tJ29QVVd5jreq
         w1KuhoOK/p1h2CGmmtI3EtJOoNYVhOHIwcABWJUfIsCW9XUbZe25fZvxtRdPN6d4SWIp
         wAezUlU0JJj25Yv2HvrdtSeIUrtAoCBHpz/VsuoRmrD7sJUQdQ9hHwbfqYD5c3XQp6ND
         1fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EH0SNO5Rcc4XYOUSFVK7bK7rNzgEXpv0OLPCvUs1MKM=;
        b=J+Lrc7oN1w6obtgOnRKOmTVyFySOGspCfVZF7TAZ011MXo2YwKuWdYWc/3LGndVB5U
         b2gJnshKi4aEaB4MC7disdXfyfrk0WIXx4s0GvOVFuiWff5C3jvZ8wdUYBVmB9D/iJDb
         A09NepmkH5uCgYBFuNixsnmcf5ZcyZusxTQTVsNBSHPSGC/7uubWw5jDuRGbLtMqy1w7
         AjBfq5l/UjncPg7zm0URGIrKC0rfjFPLRowgnfLr0P0EI3JHQXHOZ+7YWfmjJ8p642HS
         2DkFYocHNuO4cIXDAVkUS2VyOp6aOXMYeKvEcNMOWQHmCKavKf0b8J7lfS5hJQU3xkTF
         N0Ew==
X-Gm-Message-State: APjAAAWjtTvgcAfka548pyZVKYfOACInrhYH/yDiSPDsUKMFQr93MlKU
        81sE/rRHhWzEdFNqHFMXijIYVQ==
X-Google-Smtp-Source: APXvYqwdqVD1HKLQD9Dk+yGMQZm/xAmaIFr/8snWfVHM3u7MryqrGdgt6o3CYFD+XYsHevMncfcZeg==
X-Received: by 2002:ae9:ed06:: with SMTP id c6mr6871655qkg.7.1582818816659;
        Thu, 27 Feb 2020 07:53:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h12sm3241397qtn.56.2020.02.27.07.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 07:53:36 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7LTj-0005VV-D2; Thu, 27 Feb 2020 11:53:35 -0400
Date:   Thu, 27 Feb 2020 11:53:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     syzbot <syzbot+55de90ab5f44172b0c90@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: possible deadlock in cma_netdev_callback
Message-ID: <20200227155335.GI31668@ziepe.ca>
References: <20200226204238.GC31668@ziepe.ca>
 <000000000000153fac059f740693@google.com>
 <OF0B62EDE7.E13D40E8-ON0025851B.0037F560-0025851B.0037F56C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0B62EDE7.E13D40E8-ON0025851B.0037F560-0025851B.0037F56C@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:11:13AM +0000, Bernard Metzler wrote:

> Thanks for letting me know! Hmm, we cannot use RCU locks since
> we potentially sleep. One solution would be to create a list
> of matching interfaces while under lock, unlock and use that
> list for calling siw_listen_address() (which may sleep),
> right...?

Why do you need to iterate over addresses anyhow? Shouldn't the listen
just be done with the address the user gave and a BIND DEVICE to the
device siw is connected to?

Also that loop in siw_create looks wrong to me

Jason
