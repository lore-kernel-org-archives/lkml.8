Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B458C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441D22076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHc+TqrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgDWNKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726532AbgDWNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587647401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdinXCqJfRCZgVfA06mXMGWP27voGlnnDgqPkPUuXHQ=;
        b=DHc+TqrBUIGUybURESc1mn54oEBt26bhOfuAi46bgd4Kv6xMiwMScyGZTmpRk49Unt5Wa8
        HsEwzllC/yQ8Vj4AGnrqZ9oUmbq+AT36P74tU6fEGDf6ErpR2C8YYO7BeUw/VScFiTeOx2
        Gzkna3bvL7zsRUKyM6BPyc/8Q75Taic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-GgPj_zu9MBmovQ5BTvMKYA-1; Thu, 23 Apr 2020 09:09:54 -0400
X-MC-Unique: GgPj_zu9MBmovQ5BTvMKYA-1
Received: by mail-wm1-f70.google.com with SMTP id l21so1990576wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdinXCqJfRCZgVfA06mXMGWP27voGlnnDgqPkPUuXHQ=;
        b=SQrPBDieMfqb6ciApJoIwwTGU5tqRsue+Img2J7qtpA8YWn6jP4exXetJcJaUI5EBC
         36A4ltsgPTuF8lJQWKVBC2i7cqZRuuIc+o6kxQ9jHOXHIlDLo8FXdrR0emhKo8U9qw26
         Xxyljc5veJdc5eQqVRrtrADn3BOVce8jfo62RSIFZmiCE1gdZkIjs4fspOgBU7Xh+2W/
         VAGQjs5h/NQFlL1X2Z5que+cOIow2Rrns6sMap3AMJ0ZadzE1n5mJYCX0+F5uYNqFchZ
         2ci5+HoU0ibvV8Ve1+mFWburgIbeQ8TgJyyZ59tPQFPxwYG554SirA8nC3fMRxgKUY2F
         EQIw==
X-Gm-Message-State: AGi0PubBPusLjTangNnTbcp4Y1NvQqN411dhRX0okSo+1jjJHJrYBMpf
        CHiUPJl3og0tYQP1jXfOCXSiEzHh4nqBe3UI+j7Gc6tVMuDHEywViirIh/lFF+Z6mWm+2NdprwL
        DOrsVFHtv6dp9WHzII6are81S
X-Received: by 2002:a5d:420d:: with SMTP id n13mr5326769wrq.204.1587647392802;
        Thu, 23 Apr 2020 06:09:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypKUZdILxUxEUY9M3uIZZlX5wYN9iQ9hZggVqr6R47Bv4L1KltPEiyeTOqSHqyMh/e7XQZ2P5Q==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr5326746wrq.204.1587647392575;
        Thu, 23 Apr 2020 06:09:52 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id b22sm11920460wmj.1.2020.04.23.06.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:09:51 -0700 (PDT)
Subject: Re: [PATCH] kvm: add capability for halt polling
To:     Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jon Cargille <jcargill@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200417221446.108733-1-jcargill@google.com>
 <87d083td9f.fsf@vitty.brq.redhat.com>
 <CALMp9eREdS=nfdtvfNhW87G20Tfdwy69Phdbdmo=NzAw_tavzw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cea84a43-e400-54b9-a6bc-3ad834c17880@redhat.com>
Date:   Thu, 23 Apr 2020 15:09:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eREdS=nfdtvfNhW87G20Tfdwy69Phdbdmo=NzAw_tavzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/20 23:36, Jim Mattson wrote:
>>> +     case KVM_CAP_HALT_POLL: {
>>> +             if (cap->flags || cap->args[0] != (unsigned int)cap->args[0])
>>> +                     return -EINVAL;
>>> +
>>> +             kvm->max_halt_poll_ns = cap->args[0];
>> Is it safe to allow any value from userspace here or would it maybe make
>> sense to only allow [0, global halt_poll_ns]?
> Would that restriction help to get this change accepted?
> 

No, in the sense that I'm applying it already.

Paolo

