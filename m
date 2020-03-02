Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2EB2467B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6wne3gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCBRJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:09:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbgCBRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583168983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT1LxWtW4Alz7bMFxQVRaqlYT59rz8oUaocc8kmU1Ic=;
        b=U6wne3gy171tjvEeoNus2sGOEQhq1FHb/BlqEmyS7SCPNJpRmf8lwn1vHaOCi6OfoH7aXJ
        eyyWGbHASuGWt8Pgdwo5MilSGZQ7AF2wNGPs+dkBxywVuaxrbuU5Uqkeu3Sty5mlQB+r2C
        IDXl9ufIkOOtICr1xtau9IGrt083vMM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-A26cY9evMnO_LdMb30COfQ-1; Mon, 02 Mar 2020 12:09:42 -0500
X-MC-Unique: A26cY9evMnO_LdMb30COfQ-1
Received: by mail-wm1-f72.google.com with SMTP id f207so458wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WT1LxWtW4Alz7bMFxQVRaqlYT59rz8oUaocc8kmU1Ic=;
        b=uZglfUzgBxAtdvlsntyKMfg7JqZCyWGJNxXMlTE9PjAWK8MgC2tl0ven/EzQ3oVl7I
         2WJl9ewiissqvlpOHfKkzSCs0aRVdehtOWYi7atqXvvF7/9ftBS+j5cNdUDc1Cr6S3jb
         qbSL2i5W9R1OTZNPOdZRXWhKUVczvSbn1XSkkc1FSmpauPTF7otB6WMIhvZOgC3jfmJu
         Sguo2Bqm7eE7/aMMWzKQIjV4sDTFdFJsNtr97NbQDsa26zcMIirP6WH47nQ8Anf522Zd
         PNHZUNaDNpMNMYuhfqB+itzdLhvYXvBDcJOHViSq7oZNC0UhCSl9i85xzoJ2tPW3TdQt
         2tfw==
X-Gm-Message-State: ANhLgQ3iUu7JSsI4L7lPkwIBFGJTaDNQO1YEsTbJBVsjT9H7CoVUYlSg
        bb2PAre72DF3nhMZiqBMPKzG4EBWpz+oIc0JYU0KqqDIuPM+0LbapiTAG8gWV+P1ORB86/guBfu
        nP8GrobV5DbPClB+CPM7CKySC
X-Received: by 2002:adf:ebca:: with SMTP id v10mr529131wrn.307.1583168980823;
        Mon, 02 Mar 2020 09:09:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtVkAdxBvARGR1a/1q4KckNRdJ1jfVeNZnf0QSzFxhNZ1uq7iVs/65BkCMwF7KIJkGDcxPAQw==
X-Received: by 2002:adf:ebca:: with SMTP id v10mr529103wrn.307.1583168980629;
        Mon, 02 Mar 2020 09:09:40 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id s15sm29549483wrp.4.2020.03.02.09.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 09:09:40 -0800 (PST)
Subject: Re: [PATCH v2] KVM: X86: deprecate obsolete KVM_GET_CPUID2 ioctl
To:     Jim Mattson <jmattson@google.com>, linmiaohe <linmiaohe@huawei.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
 <CALMp9eSaZ557-GaQUVXW6-ZrMkz8jxOC1S6QPk-EVNJ-f2pT5w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1ff3db1-1f5a-7bab-6c4b-f76e6d76d468@redhat.com>
Date:   Mon, 2 Mar 2020 18:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eSaZ557-GaQUVXW6-ZrMkz8jxOC1S6QPk-EVNJ-f2pT5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 18:01, Jim Mattson wrote:
>> And in fact, it's not used anywhere. So it should be
>> deprecated.
> I don't know how you can make the assertion that this ioctl is not
> used anywhere. For instance, I see a use of it in Google's code base.

Right, it does not seem to be used anywhere according to e.g. Debian
code search but of course it can have users.

What are you using it for?  It's true that cpuid->nent is never written
back to userspace, so the ioctl is basically unusable unless you already
know how many entries are written.  Or unless you fill the CPUID entries
with garbage before calling it, I guess; is that what you are doing?

Paolo

