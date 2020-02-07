Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B77C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1214520726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyTxi4X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGJQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:16:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbgBGJQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581066998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3e6VGnl7p5aII5PG66IQC6em60bIEwWa13Qn8r4drow=;
        b=GyTxi4X0G4QdW/EatxE3KRRq9HHqEHLy3ZWslhR1TAgd/ALntY4p2ACdZ4AzajPXJ3SgjH
        oJMzBF3eXkSQs5+9a5JXV61MWaOV5CHj0s1puYVGYdttdiSf7MXkCJYvApWF0o45p0eUQy
        xrhKdXD16TauBV3eN27xqTQKEqJxQZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-cmQH6KJ8PkGP1LOD1Ic0JQ-1; Fri, 07 Feb 2020 04:16:37 -0500
X-MC-Unique: cmQH6KJ8PkGP1LOD1Ic0JQ-1
Received: by mail-wm1-f72.google.com with SMTP id s25so451181wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3e6VGnl7p5aII5PG66IQC6em60bIEwWa13Qn8r4drow=;
        b=ko2Yozq72IR8ClJDsyrb9HcgDfLFILHco8XvtTix6Fus+p+BhVwo55NaBriZZr+AKp
         5bR6TZF08JVpMaNG/Ou8pKFtuNvZp7oXiaURYpuPe8JI6KCqi/8wzNKuE5OzCo7veISn
         gi+RGvlEfCNLcaQsas5fYHp9G9lnq4QYXHK44B335IzZQ17Qtbiq/7hqKYsf1UdLpWXe
         w6D/Tr9l4+P/mvbrPsMGeQeNlUqGwXWML3IXCRcUvd7P4GE6mQxvFECKrLdWWmBFp+xU
         5eRfl5VXqFtGukT85hxBYZ1gqiewMoCeWp9g67Sxd/kyDBGlyeP+3uQs5Hw40Mx09Rr1
         0O5Q==
X-Gm-Message-State: APjAAAXjrKkH6jbJr9HVRzSGohuw3e9DRAfBiZEg19o67uYdMDX7FS/h
        2zmLi3jOiv/qTI/8rsVhSZTStYdAKIJsTt/ME+cgjNCNcwuFiAO+WqGw4rCGK057DTwXiQDlwkz
        oewEH/E21qePpSFoEcFNTDqBu
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr3413207wmd.156.1581066996037;
        Fri, 07 Feb 2020 01:16:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWo7rQpQBdxXn6bJTKzbF2UU/0mee8M38zNSRICzbl5n6q/+4CeKDtcLL8L2jb7RfK5OLSRg==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr3413176wmd.156.1581066995824;
        Fri, 07 Feb 2020 01:16:35 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x132sm16326045wmg.0.2020.02.07.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:16:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com,
        Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH v4 2/3] selftests: KVM: AMD Nested test infrastructure
In-Reply-To: <92106709-10ff-44d3-1fe8-2c77c010913f@oracle.com>
References: <20200206104710.16077-1-eric.auger@redhat.com> <20200206104710.16077-3-eric.auger@redhat.com> <92106709-10ff-44d3-1fe8-2c77c010913f@oracle.com>
Date:   Fri, 07 Feb 2020 10:16:34 +0100
Message-ID: <87blqag3kd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krish Sadhukhan <krish.sadhukhan@oracle.com> writes:

...
> +	asm volatile (
>> +		"vmload\n\t"
> Don't we need to set %rax before calling vmload ?
>

No, because it is already there

...
>> +		: : [vmcb] "r" (vmcb), [vmcb_gpa] "a" (vmcb_gpa)

"a" constraint in input operands does the job.

-- 
Vitaly

