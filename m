Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C653DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBCD2063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVz3WfpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbgDCHDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:03:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388959AbgDCHDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585897413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1qqB1lJcxaOIJdybFP2nmQlGVmtCZINAz0JQfogkUI=;
        b=EVz3WfpEF0gnPvhk9FdxWq1ABPA8mDm/fUqIMitLu0RerevJQJxvPR/CoTR2i8slrqY5Z/
        CqjUhjpoOpE/bxz+plgK9eljZWVZysw/Iu3bQE6iiW7gzVAlVCCznu2ltAdjlx9ruFD96F
        Zb8oARh1vLteUTNpzg7dNoPnx/jcy7I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-9Kvd2WPUNTKly_hN48sGMQ-1; Fri, 03 Apr 2020 03:03:30 -0400
X-MC-Unique: 9Kvd2WPUNTKly_hN48sGMQ-1
Received: by mail-wm1-f72.google.com with SMTP id v8so2383933wml.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 00:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f1qqB1lJcxaOIJdybFP2nmQlGVmtCZINAz0JQfogkUI=;
        b=oe96Pw9VbcvNLocjkhGGugdnqWGKwtPdgtBkRBeDc70/SKnkGvlyyfnqSrNAULIzCZ
         xIK/UiaU0rT47vzcgpPy4xRTqzskoQyz7Zb6gzuR6SyD4OXFWBtgfQX9wtvhgBEghyzr
         IF3QWwCKLFIq72fjyLqHSLP6v002JTb98NbAALTdWIdf1G1MeKkraRP9eUSO4vVoeIsq
         Uji5Ugmqd8UvTkCdU9j03+dg+79tcGf3F49FV5ppD4AgiIaRRVi7CfYSj1XX3c4Oy0dI
         DlsCpj4asFOPyVoLEFwHbAUlg2m8sUGS3pCsut7ck0hMIgRJRqo1X6SEq6Q78/gywUuV
         rSHA==
X-Gm-Message-State: AGi0Puaon1lEHOcL+U3UVO9D8qULY1SqCs946VtDB07YwYviqYX0vf4U
        I8g81jTvvrbB5OPVgo9lSu/ULR5d7brd1xbhrlRvQumy/0bg4BjrYr0NomemGmxDfM4cTGiMQj3
        WYkwSmP+X1sLgtnHttJMBOM++
X-Received: by 2002:adf:9168:: with SMTP id j95mr7050281wrj.145.1585897409143;
        Fri, 03 Apr 2020 00:03:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypI9ApfdigOp/bpV3TSNlmrxc6hlVZfZJsgIPls3WO5f8QCC1uQMAwtm+TFeAzJrg1He2meKww==
X-Received: by 2002:adf:9168:: with SMTP id j95mr7050260wrj.145.1585897408903;
        Fri, 03 Apr 2020 00:03:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 9sm10024793wmm.6.2020.04.03.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:03:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>,
        163 <freedomsky1986@163.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/5] Drivers: hv: copy from message page only what's needed
In-Reply-To: <MW2PR2101MB1052836B9357770FBE0C3825D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com> <20200401103638.1406431-2-vkuznets@redhat.com> <3ed15a02-0b86-0ec1-6daf-df94f8fc6ba5@163.com> <87a73tzwdv.fsf@vitty.brq.redhat.com> <MW2PR2101MB1052836B9357770FBE0C3825D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Fri, 03 Apr 2020 09:03:26 +0200
Message-ID: <875zehyrsx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Thursday, April 2, 2020 9:27 AM
>> 
>> 163 <freedomsky1986@163.com> writes:
>> 
>> > On 4/1/2020 6:36 PM, Vitaly Kuznetsov wrote:
>> >> Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
>> >> messages. Each message comes with a header (16 bytes) which specifies the
>> >> payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
>> >> look at the real message length and copies the whole slot to a temporary
>> >> buffer before passing it to message handlers. This is potentially dangerous
>> >> as hypervisor doesn't have to clean the whole slot when putting a new
>> >> message there and a message handler can get access to some data which
>> >> belongs to a previous message.
>> >>
>> >> Note, this is not currently a problem because all message handlers are
>> >> in-kernel but eventually we may e.g. get this exported to userspace.
>> >>
>> >> Note also, that this is not a performance critical path: messages (unlike
>> >> events) represent rare events so it doesn't really matter (from performance
>> >> point of view) if we copy too much.
>> >>
>> >> Fix the issue by taking into account the real message length. The temporary
>> >> buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.
>> >>
>> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >> ---
>> >>   drivers/hv/vmbus_drv.c | 3 ++-
>> >>   1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> >> index 029378c27421..2b5572146358 100644
>> >> --- a/drivers/hv/vmbus_drv.c
>> >> +++ b/drivers/hv/vmbus_drv.c
>> >> @@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>> >>   			return;
>> >>
>> >>   		INIT_WORK(&ctx->work, vmbus_onmessage_work);
>> >> -		memcpy(&ctx->msg, msg, sizeof(*msg));
>> >> +		memcpy(&ctx->msg, msg, sizeof(msg->header) +
>> >> +		       msg->header.payload_size);
>> >>
>> >
>> > Hi Vitaly:
>> >       I think we still need to check whether the payload_size passed from
>> > Hyper-V is valid or not here to avoid cross-border issue before doing
>> > copying.
>> 
>> Sure,
>> 
>> the header.payload_size must be 0 <= header.payload_size <= 240
>> 
>> I'll add the check.
>> 
>
> With this change,
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>
> FWIW, all of this VMbus code, as well as the drivers for the VMbus
> synthetic devices, make the fundamental assumption that Hyper-V
> is trustworthy and doesn't send any malformed messages.  However,
> starting this summer we will be submitting changes to "harden" all
> of the interactions with Hyper-V to no longer make that assumption.
> All relevant fields will be checked before being used so that incorrect
> memory references aren't made.  This patch is one small step in that
> direction. :-)

What about 'alternetive' Hyper-V implementations? :-)

On a more serious note, my understanding is: if your hypervisor
misbehaves it's 'game over' for you (as a guest), the only question is
how hard is it going to be to figure out what happened. In this
particular case if hypervisor send us garbase we probably want to fail
immediately and not try to handle it as a valid message.

Thank you for your review!

-- 
Vitaly

