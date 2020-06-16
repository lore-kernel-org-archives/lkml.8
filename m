Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B99420776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N36N90sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgFPKuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:50:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgFPKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592304644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Vs0qBJGF5Skn7e+ab03WoozZDmoJ3wPcLfeh/kmlAk=;
        b=N36N90szDLVU3v0W0oDci0GxFYLKJTx7kfAvVSu1oBl2nBhZjWYmyFn8jwQAi8rC0ec95Y
        NycY4FiyI88PNJVJq6vqJxLs4DEIrpzrkNAFBNDv86VGBaOPjsg7FC4h/1LQ11lVZ9xBMk
        sWG5TzZFcWiRpgmE8ncd3eZiq4hwTIA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-BX2c0wa9PM60QvBzNOiUhA-1; Tue, 16 Jun 2020 06:50:36 -0400
X-MC-Unique: BX2c0wa9PM60QvBzNOiUhA-1
Received: by mail-ed1-f72.google.com with SMTP id bs22so5997525edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9Vs0qBJGF5Skn7e+ab03WoozZDmoJ3wPcLfeh/kmlAk=;
        b=ZmKeG1L1bZ1mK7o41AcqaANExC4xyV8MzbIx/YbYbMX1tHabpfpdTPa3bHeMOK9prc
         cqbarfcAsz09Dfoq+rH761BdSbdKInGWc6JOOg8D14fMq3mYe8a0bUNosfuVsD/vNjrX
         ijQssRrE7GQF+3DvVB80fv63kw8fT5WenTppFMLZafg6qxO90iHdy6ZOThBar7NCcQKX
         /AlOrLH8bI7Byx/5Wo9qmJzHu60PuhMH3BGb8YCynYXX8h4cszb9AXANaRLK5qEyhuNc
         FcYF3z8uxgFLgUBr8+9ImE+7ex6F6yIClviQRwq3Olm/yDk3yPXQ2w2Ce8Xz4C8/GlWD
         aoXA==
X-Gm-Message-State: AOAM5328/V0+CE3P5ZF7d/jW1T/cM6oqOBUIbfmmNWdTJOeqvNEbuK0G
        LdX+0yYGFDQMDBYhBUWugHE/Xla/eDHG4swK3i27VYOTfETeoSzvshBrKcezpR/Mset3zLsgkq3
        8Uj8MwMntl/BhZq6eFL10QwUZ
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2101716ejx.479.1592304635675;
        Tue, 16 Jun 2020 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw87a28bFg8pZEku0ADK2i6m0pm5nzZqm2/cOZe9pSBkcaMlR+rMQluhXBQnviYJv6Z+sbDlQ==
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2101700ejx.479.1592304635422;
        Tue, 16 Jun 2020 03:50:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id lx26sm10821467ejb.112.2020.06.16.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:50:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: hv_hypercall_pg page permissios
In-Reply-To: <20200616100810.GA28973@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87blljicjm.fsf@vitty.brq.redhat.com> <20200616093341.GA26400@lst.de> <20200616095549.GA27917@lst.de> <20200616100810.GA28973@lst.de>
Date:   Tue, 16 Jun 2020 12:50:33 +0200
Message-ID: <878sgni8sm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Jun 16, 2020 at 11:55:49AM +0200, Christoph Hellwig wrote:
>> Actually, what do you think of this one:
>

I see Peter has some concerns but if vmalloc_exec() used to work then
open-coding it with the right flags should do. I've also tested your
patch with Hyper-V, it works, so:

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com> 


> Plus this whole series to kill of vmalloc_exec entirely:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/vmalloc_exec-fixes
>

FWIW, the vmalloc_exec() doing W+X allocation is misleading indeed, thus
killing it makes perfect sense.

-- 
Vitaly

