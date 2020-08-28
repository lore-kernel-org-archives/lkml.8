Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CFCC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB232078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FZP0qMxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgH1H7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:59:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:35320 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgH1H7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:59:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4BdBp22MWgz9vCBS
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hLzDXKXMY-_J for <linux-kernel@vger.kernel.org>;
        Fri, 28 Aug 2020 02:59:38 -0500 (CDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4BdBp16jC6z9vCBC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:59:37 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4BdBp16jC6z9vCBC
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4BdBp16jC6z9vCBC
Received: by mail-ej1-f71.google.com with SMTP id f13so208999ejt.16
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Gt/r/qKlREITPrsScJxjBMwzXFb7YB/EXLOQjzIAH4U=;
        b=FZP0qMxStZQUljlMwuHfMd4tkwCoMEiryYJ9plMZpIf7jIz4KaTrLcoXTVzTOnQIJ9
         hq93Cy5FQJZAXJer4P+WzzBiEA3JFjSCk4SaU47ltB4yyYqN7EUVVZ7lKCZYU6GfJZE8
         Hk0d4QR3TShMHPu82G6A/d6WaeUUQY7SpjQnvdJaO6fv9XHYyM9DHln2EuSLRvTdLQLM
         xC+u7HdMDUf21OSl7rmVzvel5CLDLYtE5i+zYkb0hmPsWCn48qV7fmnJvn7JhWgtOkrr
         tZonh4Qw2vPnsBcxYTE667ob8ZJ7PQkqk1/7tjROJ1S7wC9zIniy0jLjbC5wZxtf+57t
         uoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Gt/r/qKlREITPrsScJxjBMwzXFb7YB/EXLOQjzIAH4U=;
        b=Xv2xf5KDQUNfXmgoALZTSlwwCUtFSoAVMv3ikW3wis2pfwbjAJKe3vAUMlDHsP1BnY
         D4mm9STAq6nK+TlmxqZE5wUm71PqB8e1ThwwqjyJU2uapwvi6i+FHeUmk1YhNSmkiycj
         MhRIDSrIuOj5lhpf+XS9ioxqixU6xO6iRTZzbrlNPlDDaOGV02bEKT8w6XM1KlwXLruh
         UL7ZDpmirNu9qCvJOD4B2abYsm5TeB49o5DIY9J8e8+jKWKgXPDws+Te5NeJWhum/zhA
         Em/eopSv48jk/HSb+lIrcowoNSgPGB9aFOzJi4FNcvqeBYZ5KZw1zXbD8sd8dGyxPp6M
         jjpQ==
X-Gm-Message-State: AOAM531ZV1r65eBT7qC/FITAFnFLnmrjIKKEcLQdPoYRS/M0+X4I3iC6
        DO1Z8SkePYAsLvH8FW+BAOd8pGCd22udAb6mJdDbpR9inSWqS4pBcFoH9N/aAwZXkGoraoGgBVJ
        FHz31wp74rlRWlWIMicoSy4ReRwWQsDkd0NZ5oJuaKkFN
X-Received: by 2002:a17:906:2686:: with SMTP id t6mr537256ejc.406.1598601576710;
        Fri, 28 Aug 2020 00:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy0sota46wpdzKEATTkuB705/2tu9OHnrD+468ZAdKOWmWUArUI7tLMT2A2mDPTe7/L4Yi0e1pCShXdXtVJFs=
X-Received: by 2002:a17:906:2686:: with SMTP id t6mr537241ejc.406.1598601576397;
 Fri, 28 Aug 2020 00:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMV6ehGKBfXN89XeDzMHKQ_6qLg41R2Tb7=sE+NC7KrbPsigDw@mail.gmail.com>
 <20200827182730.GA712693@kroah.com> <CAMV6ehEwaStF7Xvy-u4p+eU9C1UObCN8eVmuJmVZRFykROdnnw@mail.gmail.com>
 <20200828062042.GF56396@kroah.com>
In-Reply-To: <20200828062042.GF56396@kroah.com>
From:   Qiushi Wu <wu000273@umn.edu>
Date:   Fri, 28 Aug 2020 02:59:25 -0500
Message-ID: <CAMV6ehGwjKit-uOSv1=mRON6Sw6258Xyr8RB3bkLm0-wFymOng@mail.gmail.com>
Subject: Re: Some questions about the patching process
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Kangjie Lu <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Thanks for your response!

> You responded in html format which got rejected by the public list,
> please resend in text-only and I will be glad to reply.
>
Sorry about this!


> > 1. Linux allows anyone to submit a patch because it is an open community.
> >
> And how is 1. a "risk"?

We are assuming the possibility of potential malicious commit contributors
and want to reduce the risk of accepting vulnerable patches from them.

> > We would like to know if maintainers have some methods and tools (such as
> > Smatch, Syzbot?) to mitigate these potential issues. We are happy to
> > discuss these issues and hope our observations could raise some awareness
> > of them.
>
> How do you "raise awareness" among a developer community that is 4000
> people each year (1000 are new each year), consisting of 450+ different
> companies?

Yes, this is a problem. Maybe people can summarize and pubic some security
coding guidelines for different modules of the kernel, or recommend maintainers
to use some bug detection tools to test the patches.

> And yes, we have lots of tools, and run them all the time on all of our
> public trees constantly.  And they fix things before they get merged and
> sent out to the rest of the world.
>
> So what specific things are you wanting to discuss here?

Specifically, we are curious about what kind of tools maintainers are often
used to test potential bugs or vulnerabilities?  Also, can these tools have a
high coverage rate to test corner cases like error-paths, indirect calls,
concurrency issues, etc?

Thanks again for your patience and reply : ),
Best regards,
Qiushi
