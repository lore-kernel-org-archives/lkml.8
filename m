Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9325C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89544206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxQnN3ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgDCHHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:07:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388472AbgDCHHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585897673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XkVKL4skcBI9I3qnEHa0ueL+rxPTyXtnrcDFqwnTr4=;
        b=MxQnN3ZXAT8QKZWAhJ1cROA63j7WlnkXJbrSQ7TGAJwn8b2pfQAtZ93eV2T2ICRUC97x7r
        D1vj1eyZVGaw9HPdZoYA5zT6KDIYn2+zN7hgHjRfe88bCqECqaNc7HpMRA/nvQVrw5Eby/
        TNW6uskM9QGEy3Zx7J8OUrbVg5OLjQA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-nAxzqPFrOTCfQncJe5Elhw-1; Fri, 03 Apr 2020 03:07:51 -0400
X-MC-Unique: nAxzqPFrOTCfQncJe5Elhw-1
Received: by mail-wr1-f72.google.com with SMTP id v14so2628297wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 00:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6XkVKL4skcBI9I3qnEHa0ueL+rxPTyXtnrcDFqwnTr4=;
        b=iLyK97hM4ZNHjvOWbYaz/PtrzQJpY9T+wqOekxjs2DUVB+9EHSPKb5v6p4CLEmeWEV
         OgBOPYlePW1p3ebnL837we/uJYJFqQPOei8EAfyF1ObnlfypwFvSSO1OILg//BCdw2qx
         dqDSC5yvIGKGXfbdgdVexUnt6eKJ0Ftbc3Qsk0SPw8pEeiQnqIS8/j59QwxDmPyE1qKZ
         DbARSZn11BzV5te+7sJPFr3o7bMS8F5cEh0ciHByMOBJyU8m8bvGM6CjeTWv0VGUtJ7o
         PvseHbit2SqEI7ZXdhJ1j4Vx1lkD8A/p4JFFwmZRwLx6oship1lUkHWsaDAmWNvBfW82
         xWFg==
X-Gm-Message-State: AGi0PuY9zfGCLUSPfHyylytAaBEd7BrMOCUGoBTffIYDKQLnBkRh8wcy
        VD1gbelWqbNsgfsOBnvc+6zneGq+Q8NkW0POKHz8oR//TcsnHE5kkrptMEl2F7tBA9xL8k4RsFm
        sPtzYjsAXi4CvzsXgXDa+LhC9
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr7325853wrp.230.1585897669656;
        Fri, 03 Apr 2020 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKj00MKc2lrco4DtzMzrre8ASngvPTRlJYQu6MPCyFkbxQQEZUm4rZj/EV1GW2sYRctom4M+w==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr7325834wrp.230.1585897669459;
        Fri, 03 Apr 2020 00:07:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm11316556wru.88.2020.04.03.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:07:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>
Subject: RE: [PATCH 5/5] Drivers: hv: check VMBus messages lengths
In-Reply-To: <MW2PR2101MB1052E7B2458F489E0123C1D9D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com> <20200401103816.1406642-1-vkuznets@redhat.com> <20200401103816.1406642-2-vkuznets@redhat.com> <MW2PR2101MB1052E7B2458F489E0123C1D9D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Fri, 03 Apr 2020 09:07:47 +0200
Message-ID: <87369lyrlo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, April 1, 2020 3:38 AM
>> 
>> VMBus message handlers (channel_message_table) receive a pointer to
>> 'struct vmbus_channel_message_header' and cast it to a structure of their
>> choice, which is sometimes longer than the header. We, however, don't check
>> that the message is long enough so in case hypervisor screws up we'll be
>> accessing memory beyond what was allocated for temporary buffer.
>> 
>> Previously, we used to always allocate and copy 256 bytes from message page
>> to temporary buffer but this is hardly better: in case the message is
>> shorter than we expect we'll be trying to consume garbage as some real
>> data and no memory guarding technique will be able to identify an issue.
>> 
>> Introduce 'min_payload_len' to 'struct vmbus_channel_message_table_entry'
>> and check against it in vmbus_on_msg_dpc(). Note, we can't require the
>> exact length as new hypervisor versions may add extra fields to messages,
>> we only check that the message is not shorter than we expect.
>
> This assumes that the current structure definitions don't already
> include extra fields that were added in newer versions of Hyper-V.  If they did,
> the minimum length test could fail on older versions of Hyper-V.  But I
> looked through the structure definitions and don't see any indication that
> such extra fields have been added, so this should be OK.
>

Yes, my understanding as well. When we decide to extend some of these
structures for newer VMbus version we'll have a choice: keep the require
length minimal or implement a more somplex check (e.g. add a 'length
check' function pointer to vmbus_channel_message_table_entry() -- or
pass 'length' to all message handlers and handle it ther). But as we
currently have no such cases this will definitely look over-engineered
so I decided to go the easiest way.

>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/channel_mgmt.c | 54 ++++++++++++++++++++++-----------------
>>  drivers/hv/hyperv_vmbus.h |  1 +
>>  drivers/hv/vmbus_drv.c    |  6 +++++
>>  3 files changed, 37 insertions(+), 24 deletions(-)
>> 
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>

Thanks!

-- 
Vitaly

