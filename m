Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ABA2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFHk3IxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCIJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:31:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgCIJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583746305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bAxovC+YmLxqKmhTg+wnldWy/2Z+UUqMLgm0E3zQGuQ=;
        b=DFHk3IxUINZwdC2JpdGtGAVJp42jIMbIAhgu+s8O/DwLVGNDdgpFa8JKszs30lFWl5udY/
        yPpJxbhD6j1q8Aqrqj4PAeyi8eDd7uyOOyXKlwvs3XcJ9/SNUW/uIM0x0yJKMODk3WcXR/
        qXNowZ+wWedVGuFdSzjrM8Z5SLjZ/iM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-D4T39OEoOTaNbMS9sGpNSA-1; Mon, 09 Mar 2020 05:31:44 -0400
X-MC-Unique: D4T39OEoOTaNbMS9sGpNSA-1
Received: by mail-wm1-f69.google.com with SMTP id p17so2221173wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bAxovC+YmLxqKmhTg+wnldWy/2Z+UUqMLgm0E3zQGuQ=;
        b=hz0QUpi7VvgTzVmlv/huBypdgsl4StWXDVS6m7uUDvN1yxQGK4RrXAEtaYINLCBn98
         4UMq/TxbK+57zbDkjkv8e8Xf3iKCjgRhZewpHCwgb/9XVRBqJWAth7DzlFtxQX3VbUmk
         ru16AGonxrrB0D9PFI6nDqMoce3hCDhdcnn1mwylM2ObirTc7p7NcbfYPDkjVd/IzvcQ
         QQQsIxHh6u0gXcuhDfGXJS4KQ4CoM3XwNiN33Jso2V//QiqaZkUqjxNTYKvzA1y0tEC3
         ZFOH1u3AEaeDyFtfizkm1nDVRDsjofnE5V7jE3NXZUeuBmGk9vI8iZ7U+Iy3iuEkp4FC
         9avQ==
X-Gm-Message-State: ANhLgQ0ga0fSY6mbFICaoYgA8p4H7Y/uiPYSlG9KkPmW3pD8r5/hHpnC
        BH0w9nmy9sQh0LVDi/C8PfMz7agxV1MoS/Z0hmOAxD9LGLOZaeAvK3WUWsnRpiY06Rjzm75Bmjj
        AFJm+BFEmUn1g73GujAkCvmfV
X-Received: by 2002:a05:600c:215:: with SMTP id 21mr19153915wmi.119.1583746302712;
        Mon, 09 Mar 2020 02:31:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vukk69NSM339Baa9gmzJoWipsNi+hBKkDBAew96ERxS+NgbmmfnSmY3RZMXrY0CvF3CeTM9/w==
X-Received: by 2002:a05:600c:215:: with SMTP id 21mr19153896wmi.119.1583746302471;
        Mon, 09 Mar 2020 02:31:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d15sm59386303wrp.37.2020.03.09.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 02:31:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: VMX: untangle VMXON revision_id setting when using eVMCS
In-Reply-To: <20200307002852.GA28225@linux.intel.com>
References: <20200306130215.150686-1-vkuznets@redhat.com> <20200306130215.150686-3-vkuznets@redhat.com> <908345f1-9bfd-004f-3ba6-0d6dce67d11e@oracle.com> <20200306230747.GA27868@linux.intel.com> <ceb19682-4374-313a-cf05-8af6cd8d6c3b@oracle.com> <20200307002852.GA28225@linux.intel.com>
Date:   Mon, 09 Mar 2020 10:31:41 +0100
Message-ID: <87mu8pdgci.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

>   enum vmcs_type {
> 	VMXON_VMCS,
> 	VMCS,
> 	SHADOW_VMCS,
>   };
>

No objections from my side. v4 or would it be possible to tweak it upon
commit?

-- 
Vitaly

