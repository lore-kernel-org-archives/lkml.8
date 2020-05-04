Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31997C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD8206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKgyDO+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEDTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:20:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbgEDTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588620013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUz/aAZitMLVExxnDPAtTS+sV7w5r/mnfHx+jPKwGw4=;
        b=ZKgyDO+r7LFghDjoXFdqkEJX5/62PO87q6tvUtKVgk4OL5RC1iTJA7z16aB2aGqXtX+fHs
        7s+t/j4Tu8cjGTp0hnR8Dcll755h+r4brZBJlToJr9BA3ROZQPNAkNn11x0Yg1RCkqZAjG
        7BqWyNr+WS2eh0kDvBJyIL2d6An3LGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-X6-PZDk8NeesqUqufiIggg-1; Mon, 04 May 2020 15:20:09 -0400
X-MC-Unique: X6-PZDk8NeesqUqufiIggg-1
Received: by mail-wm1-f69.google.com with SMTP id n17so534081wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUz/aAZitMLVExxnDPAtTS+sV7w5r/mnfHx+jPKwGw4=;
        b=l/i5GT+ptYsiYyhal+0FAXDYCFJWF2Biqy6wnBiWdiXItHOTriI4uWoWL98qFztAxJ
         Wjk2PhGcfj45faIXtHVyWrHWOM6htajW56k+M2y/+0+SnrZGKZcHj643hMPcfNynVQKk
         hP7Pj8aCXzK14CuNAFudYBrZndvInmbCFUDTRWusyvyW5nZ/MkT/BlCvhweuH60+Fh8n
         oEw/lkRqBivjYQY0M29sU2mMUahhxgnQJn6QXPp32attvMBsKuh1qIaG0SN5PPtBmXn4
         XAwcTiR2tZbxX264krifhevhGQZSU+G9XQXaU5ithCEHmwcxoA8ZQvJkkeRS+MH3hOVT
         saKg==
X-Gm-Message-State: AGi0PuaekzOPM/ejh6gaFO8QSV/CeTxq6pK4EPOkh5HD/rQufVP92rSH
        hQNpBmZzvnpfKlQMcU0Mju2PhP4InIRtO+lWnJEsexMF7k8AiI+6Q78fKv6mPZ5qA61s5cLYQeZ
        vOj/wy/24nn0Ahi7R4Vr+e2gT
X-Received: by 2002:a1c:f418:: with SMTP id z24mr16040957wma.122.1588620007719;
        Mon, 04 May 2020 12:20:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyPq+EBft+DIchDIzmT78A6K6Mxa6RNvlcQjX/sIkHDq7lmFqLYsZCjQWjuXepLhFnr/H1ww==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr16040934wma.122.1588620007436;
        Mon, 04 May 2020 12:20:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cd89:3799:7fbf:7b5d? ([2001:b07:6468:f312:cd89:3799:7fbf:7b5d])
        by smtp.gmail.com with ESMTPSA id n2sm19921300wrt.33.2020.05.04.12.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 12:20:06 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86: cleanup and fixes for debug register
 accesses
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200504155558.401468-1-pbonzini@redhat.com>
 <20200504185530.GE6299@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06dcafe8-8278-a818-ad76-36f3bbbcc0a2@redhat.com>
Date:   Mon, 4 May 2020 21:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200504185530.GE6299@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/20 20:55, Peter Xu wrote:
> On Mon, May 04, 2020 at 11:55:55AM -0400, Paolo Bonzini wrote:
>> The purpose of this series is to get rid of the get_dr6 accessor
>> and, on Intel, of set_dr6 as well.  This is done mostly in patch 2,
>> since patch 3 is only the resulting cleanup.  Patch 1 is a related
>> bug fix that I found while inspecting the code.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> (Btw, the db_interception() change in patch 2 seems to be a real fix to me)

It should be okay because vcpu->arch.dr6 is not used on AMD.

However I think a kvm_update_dr6 call is missing in
kvm_deliver_exception_payload, and kvm_vcpu_check_breakpoint should use
kvm_queue_exception_p.  I'll fix all of those.

> I have that in my list, but I don't know it's "sorely" needed. :) It was low
> after I knew the fact that we've got one test in kvm-unit-test, but I can for
> sure do that earlier.
> 
> I am wondering whether we still want a test in selftests if there's a similar
> test in kvm-unit-test already.  For this one I guess at least the guest debug
> test is still missing.

The guest debugging test would basically cover the gdbstub case, which
is different from kvm-unit-tests.  It would run similar tests to
kvm-unit-tests, but #DB and #BP exceptions would be replaced by
KVM_EXIT_DEBUG, and MOVs to DR would be replaced by KVM_SET_GUEST_DEBUG.

It could also cover exception payload support in KVM_GET_VCPU_EVENTS,
but that is more complicated because it would require support for
exceptions in the selftests.

Paolo

