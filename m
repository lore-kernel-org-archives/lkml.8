Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE4C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6F22070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGzNq++v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCWX4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:56:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24383 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgCWX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585007800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLT9PP21JpSVg8g9Ca0QcaUFbJS8dx+sxPNM6+3EIvA=;
        b=gGzNq++vTNY3KAGTyR6qFdmtDRlpZJumYkLhxGhhIy4yKrYWxCTIr3aqt7DRQNbvXkPhXR
        UZEfKKGBh3NK1QZJat+ya7waOZDnW54tkT7HRB19+3Cn1n0ZsVPKCmG3e/wdxzbT4vOZT3
        VrdTxSJohOLmBuad8/uXybsKePa7or8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-NFSOpbt_PoS-QNZVSZLocQ-1; Mon, 23 Mar 2020 19:56:36 -0400
X-MC-Unique: NFSOpbt_PoS-QNZVSZLocQ-1
Received: by mail-wm1-f69.google.com with SMTP id w12so643991wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLT9PP21JpSVg8g9Ca0QcaUFbJS8dx+sxPNM6+3EIvA=;
        b=N4o1TtZ1QMzCotjfWARzd6Sfr7NHyYFPqAPGnhQyyewRhgkxfTNtMxRrru32vJAMCl
         zojxfliSlTsto1BoBJT+xmP5NHI74HEh6NO5Sc8dzDudjpGMdvRmUszO/RpCje4pYqTZ
         VMeFnSoK0nx/XJ8LYRZqa7RpSP57uhS45bQ2hTuN2Osev3J8OEsIq/xFGjfh+55WaMos
         IqsTHevK0AI75uOSHttHIXByKvEM5Uif5YFJwiHv5vYpZc3b3hpf9+re0F4NPrcnLqc0
         sRxFK4MYpj19ut+owcBjAeEXgVZJgZcpF8mbzpvQp1XC+xIoAnoZXuSShkiOUmghwejE
         0FzA==
X-Gm-Message-State: ANhLgQ39AlN+8VQz4TaxBEe7OpM36jCY68xe3M6oOaxoLUpLF3TqxWXg
        DjMjm4IQfAWzjve5IqrWwInCPLFG+cczTcG9ONWxL4vBrf7bsfFZM65ldHlSWBwf447l1jrDLw/
        hJoasSffF2VkPi5hlLB2wJS5O
X-Received: by 2002:adf:a54a:: with SMTP id j10mr33957036wrb.188.1585007795333;
        Mon, 23 Mar 2020 16:56:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtA2yqwy0OwlfJUMK17zDbiP8PQ7IbBWxWzAUrDpK93gZxWeKy0DQaWOZHLglMy/9Tmdrqomw==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr33957012wrb.188.1585007795099;
        Mon, 23 Mar 2020 16:56:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id t16sm23019727wra.17.2020.03.23.16.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 16:56:34 -0700 (PDT)
Subject: Re: [PATCH v3 05/37] KVM: x86: Export kvm_propagate_fault() (as
 kvm_inject_emulated_page_fault)
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-6-sean.j.christopherson@intel.com>
 <87sghz844a.fsf@vitty.brq.redhat.com>
 <20200323162433.GM28711@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7012fd88-5590-e50d-cee2-d14fb54ce742@redhat.com>
Date:   Tue, 24 Mar 2020 00:56:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323162433.GM28711@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 17:24, Sean Christopherson wrote:
>> We don't seem to use the return value a lot, actually,
>> inject_emulated_exception() seems to be the only one, the rest just call
>> it without checking the return value. Judging by the new name, I'd guess
>> that the function returns whether it was able to inject the exception or
>> not but this doesn't seem to be the case. My suggestion would then be to
>> make it return 'void' and return 'fault->nested_page_fault' separately
>> in inject_emulated_exception().
> Oooh, I like that idea.  The return from the common helper also confuses me
> every time I look at it.
> 

Separate patch, please.  I'm not sure it makes a great difference though.

Paolo

