Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B998C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D448206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9FBHzUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDFINH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:13:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726562AbgDFINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586160785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ii26BGJpPDfR08ITd9Ut/Tbr0X9A7oSKJHxrZlNNO0k=;
        b=V9FBHzUDD46leEA+OZVip4GgbOEXtZ2Ybu7dpcyr3gEUiBXD7K/JHoYdN7LFwxqMPb+sUC
        NwTcEZQxD2gSHT5XIBYO9K5L0gXwVJQopRK9zo3LL+3hsm29x+O4F1JVWf+oyyHjpWP9Z2
        Zxffkady8mxdGRmsMhaA2JoTFur7+4s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-dvFtQq8KO6-x9ljTCe0ffQ-1; Mon, 06 Apr 2020 04:13:04 -0400
X-MC-Unique: dvFtQq8KO6-x9ljTCe0ffQ-1
Received: by mail-wr1-f72.google.com with SMTP id o10so109883wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 01:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ii26BGJpPDfR08ITd9Ut/Tbr0X9A7oSKJHxrZlNNO0k=;
        b=iX8XsFjGljDFnGTp7X6+Yh84WvPVqZBX9tghVMXJ4PLR04flqUIadUhEOMo7yILlyR
         TDCJlSq3he3zraNSKN/919rgIdb8d/tMuelaeH5QHPOxzuzoVOTgy7AH/kf+IUhwxe2Y
         48ptWZuz03MGR7iY1bVFbToIK10xZXq3RQ9yWAbPuQx/l42eOjHImXtS3ydMkMgGpsCG
         40hUMJbaJ50pRdZ1nFJiwZTY+VuxW9nL84KLux9YerCieLES1l+NYm1Jl4Ws6Jik+JJY
         nSn/OBWWvl9AhQ2eZiKKjgHX0Nj5qX/Y+F6koYeeLqgNyN/OCiFbcfJhwqK0XY82+tF/
         3lDA==
X-Gm-Message-State: AGi0PuZ6p5A/8INg9WUNivA3w3keOZRvyXWpN/hQsRzHPs1WEvTuuGUf
        y2bmPC+6pwSH6m2+r6y2GKDfOnnvXr7IupwvNRY+AZ0b5FLXipxmONQ6HN1X64FRZhpaKMHceoK
        Hfqv7QhN6IskEmwnXkLRtPcJg
X-Received: by 2002:a7b:c450:: with SMTP id l16mr5741886wmi.123.1586160782942;
        Mon, 06 Apr 2020 01:13:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPBBB4LWKtb+olcVrK+i/vs3mSagwriQBtGODlhja7He2RQMneGMb/WFbmwZkety2M04lL2A==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr5741865wmi.123.1586160782633;
        Mon, 06 Apr 2020 01:13:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80e8:806f:a5f9:88dc? ([2001:b07:6468:f312:80e8:806f:a5f9:88dc])
        by smtp.gmail.com with ESMTPSA id c17sm19979917wrp.28.2020.04.06.01.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 01:13:02 -0700 (PDT)
Subject: Re: ata driver loading hang on qemu/kvm intel
To:     Suresh Gumpula <suresh.gumpula@nutanix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7C92AFF4-D479-4F80-8BED-6E9B226DFB72@nutanix.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56486177-b629-081e-2785-b6e2ca626e88@redhat.com>
Date:   Mon, 6 Apr 2020 10:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7C92AFF4-D479-4F80-8BED-6E9B226DFB72@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/20 01:36, Suresh Gumpula wrote:
> Hi,
> 
> I am seeing this old problem with qemu 2.12/kernel 4.19.84(intel kvm
> with nesting enabled) and guest kernel 4.10
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1345964
> 
> Could you please advise me on this?  I am seeing the exact same problem
> where the ata driver load was stuck.
> 
> Really appreciate if you could give some pointers?
> 
> Is it a known issue with nesting? Or is this bug fixed in latest kvm module?

Hi, that bug was specific to running under Ravello, not on bare metal.
I have not received any other reports.

To clarify you have:

- QEMU 2.12 and kernel 4.19.x on the host

- kernel 4.10.x on the guest

What QEMU version is running in the guest and what kernel version in the
nested guest?

Paolo

