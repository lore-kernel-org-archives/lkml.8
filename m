Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0257EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9972073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Onj9kiOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:44:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726034AbgCFJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583487898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbxIdYhTTjgVlUuu7acZggNhYjFYj5XT7w4bg+bKCpo=;
        b=Onj9kiOE+6sRUX8Pyw9bTJxHkGmbprAHh7OgMhFJLqpmEujvUAz1J4NJPP+9nXH/DU0XrI
        otuPBdFd2RhVlRsKe1B9xqBIx+6FvjE5CMbhrpn0QFLa2IU4bQvtSK7p3j7cTUFT2k3AXg
        hzdc1CySqRFEqpu3r/o7QQ7VZhl7Z3U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-n8LusmgWPoyaGjNvTbhvvw-1; Fri, 06 Mar 2020 04:44:56 -0500
X-MC-Unique: n8LusmgWPoyaGjNvTbhvvw-1
Received: by mail-wr1-f71.google.com with SMTP id u8so762919wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WbxIdYhTTjgVlUuu7acZggNhYjFYj5XT7w4bg+bKCpo=;
        b=h+HTJLaKMyKp/eqFNoORARS+JzPrP8I55sXF/o0q3wmAhWSGGx2OawCZ9mnpqCoFHD
         ijPzeyQanMxxzS36SS/S2P6/npkb9c3/E69P4aAU/lkodUI4meN0TWH0tjJ1ryw5yuYe
         +phclv0H9auzrG2vrjUe1zfdcBfaZttFGHGPpCB4HqmgPeL5ucxHZbreIg28PcwBgX3o
         w95oO2t7QsvsTBEXYqsJPpVFAJo3PqrcMAkQ78Kj0IZktJ4PLOjWgusZdM45ogHBcezw
         ToyEVEqVGuGDBHEDqWL3SD7rNdb59DjCMphPvv4AlOA2MWpSIDdkWDHsy1lT+QMvj1Li
         OBBg==
X-Gm-Message-State: ANhLgQ3JqRXw+d80cf6iElF0PM3TOF6hOZNjF6BMlKeTJ5s1O5XpQqK8
        4zzfG7pgl4gcNnM9cHtlEWGpWjtCo9wIGHK7uTn9NrHWyNsIV81m5CmlmTZDa3ywpgeijPHr1ri
        99LfAYtDrbrE5xLXcPF79tehx
X-Received: by 2002:a1c:7919:: with SMTP id l25mr3019502wme.135.1583487895752;
        Fri, 06 Mar 2020 01:44:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvxjBVBTvy10EKYcXioKSADNfuDaKvIrnd4UdrjOTMe11WoR4rkgftir/YuAN37Jpblb9nk5g==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr3019483wme.135.1583487895545;
        Fri, 06 Mar 2020 01:44:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p15sm12572147wma.40.2020.03.06.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 01:44:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson\@intel.com" <sean.j.christopherson@intel.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: VMX: Use wrapper macro ~RMODE_GUEST_OWNED_EFLAGS_BITS directly
In-Reply-To: <1e3f7ff0-0159-98e8-ba21-8806c3a14820@redhat.com>
References: <f1b01b4903564f2c8c267a3996e1ac29@huawei.com> <1e3f7ff0-0159-98e8-ba21-8806c3a14820@redhat.com>
Date:   Fri, 06 Mar 2020 10:44:53 +0100
Message-ID: <87sgiles16.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/03/20 03:17, linmiaohe wrote:
>> Define a macro RMODE_HOST_OWNED_EFLAGS_BITS for (X86_EFLAGS_IOPL |
>> X86_EFLAGS_VM) as suggested by Vitaly seems a good way to fix this ?
>> Thanks.
>
> No, what if a host-owned flag was zero?  I'd just leave it as is.
>

I'm not saying my suggestion was a good idea but honestly I'm failing to
wrap my head around this. The suggested 'RMODE_HOST_OWNED_EFLAGS_BITS'
would just be a define for (X86_EFLAGS_IOPL | X86_EFLAGS_VM) so
technically the patch would just be nop, no?

-- 
Vitaly

