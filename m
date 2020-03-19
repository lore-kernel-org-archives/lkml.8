Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E1C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6008B20409
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1bMMFxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCSPPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:15:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23128 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgCSPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584630904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bo5DLSfTIO55szrTrrWpDLgWWQB+Imxl4yoST1QLG/Y=;
        b=U1bMMFxoEHXLBabc2ZvNf+n2AtcDo2lUF5qxGzv+SRbO4LLp5k7BChRZVXTSREsKtEWhWB
        /PWz7VjRvSewAQeReu8AFms7I0H87woSE1goRESwbkTwWU/fTwxYQ45bdbW8jbJQMMiU1B
        kCEAQb1oUU0NCyMbxqTKyLKAMAy34ik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-A--pOFBoPpGCrPOoZ9wt7g-1; Thu, 19 Mar 2020 11:15:00 -0400
X-MC-Unique: A--pOFBoPpGCrPOoZ9wt7g-1
Received: by mail-wr1-f72.google.com with SMTP id k11so1178383wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 08:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bo5DLSfTIO55szrTrrWpDLgWWQB+Imxl4yoST1QLG/Y=;
        b=CzAjFT7H/0MzAL0bZyuq8n9WuQVdKvyFI0CtBwHw/M5AfReKBqUEi36DZtYkOeNuXd
         bLgaK0BS0JcZiH/xtLmHm0W8Z50bclpwomy1QFItH9LKO1qOv5uaguQg5uWRw/Iy9MGB
         y5Cxnfxsxg6iSIsx2GM3LAE6fLX/C4WIsyqFb9bF76AaZXIdL66tZXWBvyVTX35TsD9p
         VIGXTc/mjZKrJkq4KkbU4aWqAqpBillQCqqfGWdVlc5RPL1hmaoppFmzi9HU85ILdrjg
         6dinx7YGiygRmkP93YzajhdQkKhBKtTNSmye/hdYlcnfh+o+4orN0I3JRFN+ZobkM8pE
         EBZw==
X-Gm-Message-State: ANhLgQ2Xeru9OuK1rYQYH9Pw16FaUqbenGy0PCnqU9OPGvRdpmbuY3v1
        e6h296pwCYq0obIb02itj31Zlr8rWhIl+v/sUdjYgZ6Yvctzoz9LPFxBZ8nRJYDtn7o9sdfKJ0l
        VB0FQRs8Aosn0T8tyAwOpjRI4
X-Received: by 2002:a5d:6091:: with SMTP id w17mr4829438wrt.402.1584630899489;
        Thu, 19 Mar 2020 08:14:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuA4dSKVZDCrUWm80Ekbq5QYYRsE1mC+1AVs2HaGMk0uIM2odsiyH+IG+8lqvhKWYlX8DB8Gw==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr4829409wrt.402.1584630899185;
        Thu, 19 Mar 2020 08:14:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id y10sm3539341wma.9.2020.03.19.08.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:14:58 -0700 (PDT)
Subject: Re: WARNING in vcpu_enter_guest
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        syzbot <syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <000000000000f965b8059877e5e6@google.com>
 <00000000000081861f05a132b9cd@google.com>
 <20200319144952.GB11305@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20be9560-fce7-1495-3a83-e2b56dbc2389@redhat.com>
Date:   Thu, 19 Mar 2020 16:14:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319144952.GB11305@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/20 15:49, Sean Christopherson wrote:
> On Thu, Mar 19, 2020 at 03:35:16AM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    5076190d mm: slub: be more careful about the double cmpxch..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=143ca61de00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
>> dashboard link: https://syzkaller.appspot.com/bug?extid=00be5da1d75f1cc95f6b
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bb4023e00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com
> Reproduced with a little tweaking of the reproducer, debug in progress.
> 

I think the WARN_ON at x86.c:2447 is just bogus.  You can always get it
to trigger if garbage is passed to KVM_SET_CLOCK.

Paolo

