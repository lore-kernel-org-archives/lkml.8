Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F1AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597DD2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5PJDuhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDGOpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:45:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728943AbgDGOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586270702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT0qdTW1KghtohwORbuJ6mTZmGdeHBnuCRf4FinRRxI=;
        b=E5PJDuhss7NF5Y9mrTjkzHN8cRo7b66Ep05FDLAztU5ycATvEbiWSwSW+cS8+APYsetP9j
        HmQ6U6pqL2po3tafTCalprwjSFX/hJ+gkz4iDkB5Pr4opMycUAtePZF4zmZvZM0sK58T57
        rDZlnDIEYUE2gPbRdRKqMLf7AZsY7T8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-qqPqT1giNlW1bk2YaVZPrg-1; Tue, 07 Apr 2020 10:45:00 -0400
X-MC-Unique: qqPqT1giNlW1bk2YaVZPrg-1
Received: by mail-wm1-f72.google.com with SMTP id p18so815250wmk.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AT0qdTW1KghtohwORbuJ6mTZmGdeHBnuCRf4FinRRxI=;
        b=GF+HBThjzz6hBgxwS/jeNarAQHBTUK2W5e8fz9cE4BvhTPVUd8a2k1CWAVZV9kpres
         6J00+DGorJhPNA+F6M1nOlIsRIeePpSRbRbw0nexlcyJ2q6AkGNekb9FSRXgfao2vVSv
         3ztI4UOTPTyjzj9t9XaK7iEZz4hDq4LH5Mm9QmDynpWuHInr5W8xdUQiFH3M9DwMUZBW
         EHwVLNHIK0aOOG30kWEKVukmSgXkNBfloss4LnE6/5ZJH/4/59jSucWY4WI5oO7hJI49
         SRP+oBRVFS+4wEjFsqhMZDef7xuOI8Ubj3u47Q61xkHzCBsr6iOT8JhZwBZVHMeQMEjO
         NgJw==
X-Gm-Message-State: AGi0PubaT/Xd18St3sf05L6+4/Fo8/YuH/R2yxZhbbLOxOCD2Pd5kW01
        0iS/Kmb84qUCrjkVw9Pjpu/sgVrWd6mhRXmUrhN9aC50GiqOouwki+T4+y/3WNxuIkYXmO+WVud
        osPiL2XPSgL5il1yUpc2lNSKi
X-Received: by 2002:adf:e94a:: with SMTP id m10mr3202494wrn.324.1586270699290;
        Tue, 07 Apr 2020 07:44:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKCQ/p5quX3w6mUyi1yue3FS9DaUy/yuqSJYcCjxVRzW3VgA8Ksd01Zu9omkJ69R14szoc6Dg==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr3202447wrn.324.1586270699024;
        Tue, 07 Apr 2020 07:44:59 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id j135sm2754009wmj.46.2020.04.07.07.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 07:44:58 -0700 (PDT)
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
To:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org> <20200407143543.GB876345@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <527b5c72-96cb-a6cc-5301-449d86015ec9@redhat.com>
Date:   Tue, 7 Apr 2020 16:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407143543.GB876345@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/20 16:35, Greg KH wrote:
> On Tue, Apr 07, 2020 at 01:02:39PM +0200, Peter Zijlstra wrote:
>> It turns out that with Split-Lock-Detect enabled (default) any VMX
>> hypervisor needs at least a little modification in order to not blindly
>> inject the #AC into the guest without the guest being ready for it.
>>
>> Since there is no telling which module implements a hypervisor, scan
>> all out-of-tree modules' text and look for VMX instructions and refuse
>> to load it when SLD is enabled (default) and the module isn't marked
>> 'sld_safe'.
>>
>> Hypervisors, which have been modified and are known to work correctly,
>> can add:
>>
>>   MODULE_INFO(sld_safe, "Y");
>>
>> to explicitly tell the module loader they're good.
> 
> What's to keep any out-of-tree module from adding this same module info
> "flag" and just lie about it?  Isn't that what you are trying to catch
> here, or is it a case of, "if you lie, your code will break" as well?

It's the latter.  Basically it's doing _the users_ of out-of-tree
modules a favor by avoiding crashes of their virtual machines;
developers need to fix them anyway.

Paolo

