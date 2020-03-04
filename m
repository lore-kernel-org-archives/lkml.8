Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C66D20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PP0s/RBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgCDInZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:43:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728531AbgCDInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583311403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hce8JDdzVVDYBPGMxiJcDplsUovwlLc6eEvZfAZBcYY=;
        b=PP0s/RBI6fM9sMfqOfBrT4CgzgMpIwQrx7StD2uWxrPC9lfW8sE3Brr052P5NeS6kQrJsO
        QtdU71Sy1LvxLvkIYqjhYF4ax1NGktA9xQyOKW98fDoLGGdHAJn3BGLXY+/pF7gRVxsSWq
        o8phN1g9HPy0AXDWW6JDlVRymBWNNsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-aDWIm675OAWwRWCe7-JB7g-1; Wed, 04 Mar 2020 03:43:22 -0500
X-MC-Unique: aDWIm675OAWwRWCe7-JB7g-1
Received: by mail-wm1-f70.google.com with SMTP id 7so555219wmo.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hce8JDdzVVDYBPGMxiJcDplsUovwlLc6eEvZfAZBcYY=;
        b=EG0Uib91/Uldczn7Uj9uktFXghG/lSQxTBdGHHySzu+KAfDRHhCCEmPNFTWoc7kyso
         Y2JBXJmgEGohRJJmD8yvH+9qS+WNNF7lCqMIdQCkxX6Bc7p6ijbyF5tQxYzyXrOH8zi7
         bHk0IPkHe6HvMTc3yWdplsPi9i6q9H9NtRNUka/k+mbR8DS+2ZR/FIbZ/hwQuTvEst0l
         4GIJEqsrkZcDJXozdRs4esS1n32cG69gkvCNXGZbOYrZn22K+IOk9Yd8Wj7qwFI5+Qrd
         BYTcwaqWUCTNMraQRwkG23dudbX5ugUReFO2RKV+mU30L3+mUBSLkpLdMTRuUag+FJMP
         zVIA==
X-Gm-Message-State: ANhLgQ1CwYr9Dv8f2UEJncMJvO5TWgZAiP7nROBipqWh1eJ/b+Wq86e0
        vadqoiF8lOozu2h6Oerlcg1JoLChyYR06nq8GhBjCIQgd/v+iQq7+4AvKPp9QEROkClTWoNIvGr
        O0cmxr4wVi9rMKeay7+4ILoKr
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr2908841wrx.362.1583311400827;
        Wed, 04 Mar 2020 00:43:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsIWAgYkF08JKNQU4lP4nFriej3ZoonWY+vx3f4wg2xML2eU/w1demead39U0sY7ItwcyunMQ==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr2908812wrx.362.1583311400545;
        Wed, 04 Mar 2020 00:43:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id k63sm3042895wme.43.2020.03.04.00.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 00:43:20 -0800 (PST)
Subject: Re: [PATCH 5.5 111/176] KVM: nVMX: Emulate MTF when performing
 instruction emulation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Upton <oupton@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20200303174304.593872177@linuxfoundation.org>
 <20200303174317.670749078@linuxfoundation.org>
 <8780cf08-374b-da06-0047-0fe8eeec0113@redhat.com>
 <CAOQ_QsjG32KrG6hVMaMenUYk1+Z+jhcCsGOk=t9i+-9oZRGWeA@mail.gmail.com>
 <20200304081001.GB1401372@kroah.com>
 <04e51276-1759-2793-3b45-168284cbaf67@redhat.com>
 <20200304082613.GA1407851@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf7c6b2d-64eb-8d13-3e9a-09c40d2ecf95@redhat.com>
Date:   Wed, 4 Mar 2020 09:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304082613.GA1407851@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/20 09:26, Greg Kroah-Hartman wrote:
> On Wed, Mar 04, 2020 at 09:19:09AM +0100, Paolo Bonzini wrote:
>> On 04/03/20 09:10, Greg Kroah-Hartman wrote:
>>> I'll be glad to just put KVM into the "never apply any patches to
>>> stable unless you explicitly mark it as such", but the sad fact is that
>>> many recent KVM fixes for reported CVEs never had any "Cc: stable@vger"
>>> markings.
>>
>> Hmm, I did miss it in 433f4ba1904100da65a311033f17a9bf586b287e and
>> acff78477b9b4f26ecdf65733a4ed77fe837e9dc, but that's going back to
>> August 2018, so I can do better but it's not too shabby a record. :)
> 
> 35a571346a94 ("KVM: nVMX: Check IO instruction VM-exit conditions")
> e71237d3ff1a ("KVM: nVMX: Refactor IO bitmap checks into helper function")
> 
> Were both from a few weeks ago and needed to resolve CVE-2020-2732 :(

No, they weren't, only the patch that was CCed stable was needed to
resolve the CVE.

Remember that at this point a lot of bugfixes or vulnerabilities in KVM
exploit corner cases of the architecture and don't show up with the
usual guests (Linux, Windows, BSDs).  Since we didn't have full
information on the impact on guests that people do run, we started with
the bare minimum (the two patches above) but only for 5.6.  The idea was
to collect follow-up patches for 2-4 weeks, decide which subset was
stable-worthy, and only then post them as stable backport subsets.

Paolo

