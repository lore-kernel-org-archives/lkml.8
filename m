Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E52073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTkoZztp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMJIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:08:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35622 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbgCMJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584090486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wl+yNGtuWXWkfGSGtM8HBlvrUGjPCbpwXBezEmRx7rc=;
        b=WTkoZztpTO5WBTsxiK3XBDQLkF82TXRtCl4XJgnUaQs+An7B2liwtpYf3cW83RqoOsN2A5
        xIVKDizdFv7Z+IoGK2+tgkPUBPqxEZ5NAmZD5yXt7/4DODlomx59XlfIVPk8praFeDQBme
        LjHE0o7ubK/KVL6pBaOQ6GnwSOW8pd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-ZkiuPHt0OmCFdJTxDkx95A-1; Fri, 13 Mar 2020 05:08:04 -0400
X-MC-Unique: ZkiuPHt0OmCFdJTxDkx95A-1
Received: by mail-wm1-f72.google.com with SMTP id f207so3171702wme.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wl+yNGtuWXWkfGSGtM8HBlvrUGjPCbpwXBezEmRx7rc=;
        b=MybUfd2vjtwX0L0O/gDlAswHn7K7/VdoB7C7LZudy5xEok6kblFp675MBm2ayk2Jug
         vb6tlnriF5Ac7YzeA3ftJiDGoRfWFIDbBmLgVwZT5FXoSOVWyrUV5a6v0PFEir5p2BUT
         aFxoEOCKcoUW8RdBJtFelxZEBJw1jtx3I12n1OTt3nPiaKHap7G/MD3DnpCaLfIYTTTV
         U6CxScWd/+ZcoAVTML89d6KwFSopye6xF5pzcLYu7oiCXm99cvjxciNZe7WZ8+8uDnzs
         J4bdDKtKP2BDlYBTiIRsyzIvfEyiXZscrtadvbKaicvWpM9UqZvnOyW87AHxO4FeES57
         u75Q==
X-Gm-Message-State: ANhLgQ3XbKOu+AKEXSp+iH5eYjy9JYHi1ChN9XplZZwwn3OUDoT5LWBn
        JCEGGau3PGli5F1MrK2T0gXnX2AB6qBNpby65plrwxVZSgy8uv+F1JyMd+9JPFtWX82MPqseCLv
        mXU3fg9llDQodrIQ68QUK07It
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr4716938wmk.79.1584090483178;
        Fri, 13 Mar 2020 02:08:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuGYVrX3d9NDPj6bLJOiHXmXO+iiPtI2qoFJ6vPVqe8f2YiQ7CXhiXwjGV1CBmokIarAb43A==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr4716906wmk.79.1584090482942;
        Fri, 13 Mar 2020 02:08:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a1sm39008132wru.75.2020.03.13.02.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:08:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>, Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: VMX: Micro-optimize vmexit time when not exposing PMU
In-Reply-To: <CALMp9eTSBpaPYKE6toPCbSfCQGhM9M4=1Z1FFBGQ9Bm_pKSpuQ@mail.gmail.com>
References: <1584007547-4802-1-git-send-email-wanpengli@tencent.com> <87r1xxrhb0.fsf@vitty.brq.redhat.com> <CALMp9eTSBpaPYKE6toPCbSfCQGhM9M4=1Z1FFBGQ9Bm_pKSpuQ@mail.gmail.com>
Date:   Fri, 13 Mar 2020 10:08:01 +0100
Message-ID: <877dzor5am.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Thu, Mar 12, 2020 at 3:36 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
>> Also, speaking about cloud providers and the 'micro' nature of this
>> optimization, would it rather make sense to introduce a static branch
>> (the policy to disable vPMU is likely to be host wide, right)?
>
> Speaking for a cloud provider, no, the policy is not likely to be host-wide.

Ah, then it's just my flawed picture of the world where hosts only run
instances of the same type/family because it's mych easier to partition
them this way.

Scratch the static branch idea then.

-- 
Vitaly

