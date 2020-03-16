Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056F5C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24442051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQs1LV8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgCPPvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:51:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23791 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731863AbgCPPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:51:05 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 11:51:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584373864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUuCYueA3lMuDwdeZICwCc8xpvqxEIl0C/2eLY4HFss=;
        b=VQs1LV8UQt4mqJs2Ff+lpyxud4KmVWxiJtLx0tWgWBs0e8TwkrztCWo5qp355ly65f3Y0b
        XFwX4eSuf8cK9/681YPalr2e8S4QH3/I+auL4VqyKWqqt7IfvL4smi52SJzl4Dy504mBqr
        TAwCdYxDb1l2m8YiwnawMgX8jFLyHKg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-NN9phlT3PpOlT1xU1OBBXw-1; Mon, 16 Mar 2020 11:44:50 -0400
X-MC-Unique: NN9phlT3PpOlT1xU1OBBXw-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1414513wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fUuCYueA3lMuDwdeZICwCc8xpvqxEIl0C/2eLY4HFss=;
        b=IG8owVawSoIyD//bYXoJzQOjh8xaBVBavwlmaJ810NhdQYcEAV+o5RjK3YpqfNNlAc
         vS9FgJHQeQJzdrUgi3odEDQScQwJxt5YACNBT6trh6GNy85KlPZSPDmnAqaYFfqYWRNt
         82bRd1IAb8mg0lgvT7soiLIjFu0se7AxKvDeShufxlWpeDuYCQMJ4AYZ/ebvn9HOvYEB
         CLmh+qONsKGdVry6DNDS6pZGm04BrhitdHczBtTsgfIxcTSC/VB1XUhtzH3q6x5KTMDN
         RTYzSoPJTX7Pihxj7H6gAlG08ETvZjCryWWcDWM7kqzgbhB8TY3HPH47NU+HYOXHQdMT
         bzag==
X-Gm-Message-State: ANhLgQ2IqQslc34ym1LtyMWu47fXG2KpZ/h9xp6nkbud8eftNkpVpSPm
        rqoLFoaPA+BTPeF2thtHoxGVm0Z4Rr2rGWJDbS3g3MOGHmPbM7tmkIXuVtws6xzXsYfxlxm7j1d
        jzh0XP6l3rV3yPkPsfRq3pbkG
X-Received: by 2002:a1c:e442:: with SMTP id b63mr29201207wmh.174.1584373489102;
        Mon, 16 Mar 2020 08:44:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsm0twtuBMCOFO0oksSJxj4VZxA6HrZ3ItbOIShmzBDz85OEDCbgoiXWzoQkLGleoeOgMTbZA==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr29201190wmh.174.1584373488897;
        Mon, 16 Mar 2020 08:44:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 98sm412922wrk.52.2020.03.16.08.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:44:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: correct meaningless kvm_apicv_activated() check
In-Reply-To: <20200316152650.GD24267@linux.intel.com>
References: <1584185480-3556-1-git-send-email-pbonzini@redhat.com> <878sk0n1g1.fsf@vitty.brq.redhat.com> <20200316152650.GD24267@linux.intel.com>
Date:   Mon, 16 Mar 2020 16:44:47 +0100
Message-ID: <87zhcgl2xc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Mar 16, 2020 at 09:33:50AM +0100, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> > +	if ((old == 0) == (new == 0))
>> > +		return;
>> 
>> This is a very laconic expression I personally find hard to read :-)
>> 
>> 	/* Check if WE actually changed APICv state */
>>         if ((!old && !new) || (old && new))
>> 		return;
>> 
>> would be my preference (not strong though, I read yours several times
>> and now I feel like I understand it just fine :-)
>
> Or maybe this to avoid so many equals signs?
>
> 	if (!old == !new)
> 		return;
>

	if (!!old == !!new)
		return;

to make it clear we're converting them to 1/0 :-)

-- 
Vitaly

