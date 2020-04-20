Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D5C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCF72078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULkgTSO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDTHfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:35:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46427 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgDTHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587368150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddEryRA8fru8sR3cTZfHtReHkDM3BB1oRAtqx9hNvis=;
        b=ULkgTSO7Zit4YIa/TepJ8PX8CtxFbCCWSCexscJs8ppY40n50f9CH+PFBgkxZcozymRr30
        CB6Pg4m5nZgEuAHtSG7xD3j65+nwq40llotAIXrFsXBgnTs4hIyRY1IOJbArPW8kPF3XSK
        rp/a0lL2e2cet3Jg6YCSpvqJkMo7We0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-0FRc6vd3N_eWC6A3SdG2Nw-1; Mon, 20 Apr 2020 03:35:47 -0400
X-MC-Unique: 0FRc6vd3N_eWC6A3SdG2Nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27C56149C5;
        Mon, 20 Apr 2020 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F8D760C63;
        Mon, 20 Apr 2020 07:35:39 +0000 (UTC)
Subject: Re: [dm-devel] [PATCH 0/3] dm raid/raid1: enable discard support when
 any devices support discard
To:     dm-devel@redhat.com
Cc:     Paul Wise <pabs3@bonedaddy.net>, Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
 <20200419131908.GA22398@redhat.com>
 <9cb6a39a43178be29af2f47a92c2e84754b62b69.camel@bonedaddy.net>
From:   Ondrej Kozina <okozina@redhat.com>
Message-ID: <6bbf9d94-2fbb-f96f-ea85-a480ba109c55@redhat.com>
Date:   Mon, 20 Apr 2020 09:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9cb6a39a43178be29af2f47a92c2e84754b62b69.camel@bonedaddy.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/20 4:48 PM, Paul Wise wrote:
> On Sun, 2020-04-19 at 09:19 -0400, Mike Snitzer wrote:
> 
>> You went overboard with implementation before checking to see if your
>> work would be well received.  Your 2/3 patch header shows you're
>> capable of analyzing past commits to explain the evolution of code,
>> etc.  But yet you make no mention of this commit header which explicitly
>> speaks to why what you're proposing is _not_ acceptable:
>>
>> commit 8a74d29d541cd86569139c6f3f44b2d210458071
>> Author: Mike Snitzer <snitzer@redhat.com>
>> Date:   Tue Nov 14 15:40:52 2017 -0500
>>
>>      dm: discard support requires all targets in a table support discards
> 
> I do remember seeing this commit while working on this, I guess I
> ignored it in my attempts to get fstrim working on my rootfs, woops.
> 
>> I haven't looked closely at MD raid in this area but if you trully think
>> underlying MD raid can cope with issuing discards to devices that don't
>> support them (or that it avoids issuing them?) then please update
>> dm-raid.c to conditionally set ti->discard_supported (if not all devices
>> support discard).  That is how to inform DM core that the target knows
>> better and it will manage discards issued to it.  It keeps the change
>> local to dm-raid.c without the flag-day you're proposing.
> 
> On my system I have a HDD and an SSD, with /boot on MD RAID and / on
> ext4 on DM RAID on 2 DM crypt volumes. In this setup fstrim works on
> /boot but does not work on / and with my patches it works on / again.
> In addition I don't see any messages in dmesg or other issues when
> doing fstrim / with my patches.

Did you have discard allowed on both dm-crypt devices? dm-crypt (kernel) 
does not allow discards by default.

Regards O.

