Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292F3205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8xcWBew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbgEMPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:35:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52820 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729732AbgEMPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589384116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlSz7XzVoxz8t9/FxrVpi2jDEt51rDwF9jzT8629/kg=;
        b=I8xcWBewLA6hEGTacNvm8EkxQI9NOePLLZ042O3hjwMc9o7ra8xAalMRwT+yCllWQBE1yC
        gglv9zKzqUxRk/gqWJh8/CcPFINTXS8VVEpacXJKxOqb2Tq3cbgohKWKeWK01yx4t+PUFo
        bW7upd0o1WEfL2xab5nhqmfbp0j+1i8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-tShqo-LNNwK4zcZzHmdYUg-1; Wed, 13 May 2020 11:35:14 -0400
X-MC-Unique: tShqo-LNNwK4zcZzHmdYUg-1
Received: by mail-wr1-f71.google.com with SMTP id p2so6936923wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xlSz7XzVoxz8t9/FxrVpi2jDEt51rDwF9jzT8629/kg=;
        b=OlgyJpHRPRh0/fUrJCASdgyl2363OLsL0gl7qIcJBisExXaB2blS4YKKbOnLExWXj3
         OmqPeh/IhXnOAhbkhvtPNqwo0fs1j9pShxlfIqiQZz+uUXngXLcwbjqk/RQu2XH/CnLn
         mbKY2w+p9r1ObKRfIYEBD4BUnTZ3PlG9P4+5YU4n6r0hx1U3nHRVFXCpOIgOMgC3D7WT
         9enDV8z02K/5Vh5FavOEAbjaMY/lq8uX2IMRa75f4+6fH0DdAUN5fx4gr/mxHodV06T2
         UCn7orVKkGMgc3Ld8lvIgsr/DrtGwKoxwsUbHLew/H0Foxl+yYNguj8N6FWe2mh9XkvU
         lP4g==
X-Gm-Message-State: AGi0PuZaycEMAPZ9BNe1QdCSTP2BXgII4/W7sBof4kqWmlBerL0zcbBM
        VFTNlDDc6baOuq64tPvpRs50NgTRh4ERrGOi4O6K+ZEI6PebzmSqJ8ijM51EZrCV+hXZuVnSu3N
        1mqLkOFhLV+YLZ6cK9nHjRFDp
X-Received: by 2002:adf:a285:: with SMTP id s5mr34674012wra.60.1589384113312;
        Wed, 13 May 2020 08:35:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypIA84YuCLMye/q5eJye3p3ezHVL2W4N4sgoCRYfBUJD2arrSnmJhUj2IXdzTelP3klz+QGLcg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr34673990wra.60.1589384113097;
        Wed, 13 May 2020 08:35:13 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.85.171])
        by smtp.gmail.com with ESMTPSA id b23sm33621926wmb.26.2020.05.13.08.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:35:12 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] arch/x86: Enable MPK feature on AMD
To:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com
Cc:     x86@kernel.org, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mchehab+samsung@kernel.org,
        changbin.du@intel.com, namit@vmware.com, bigeasy@linutronix.de,
        yang.shi@linux.alibaba.com, asteinhauser@google.com,
        anshuman.khandual@arm.com, jan.kiszka@siemens.com,
        akpm@linux-foundation.org, steven.price@arm.com,
        rppt@linux.vnet.ibm.com, peterx@redhat.com,
        dan.j.williams@intel.com, arjunroy@google.com, logang@deltatee.com,
        thellstrom@vmware.com, aarcange@redhat.com, justin.he@arm.com,
        robin.murphy@arm.com, ira.weiny@intel.com, keescook@chromium.org,
        jgross@suse.com, andrew.cooper3@citrix.com,
        pawan.kumar.gupta@linux.intel.com, fenghua.yu@intel.com,
        vineela.tummalapalli@intel.com, yamada.masahiro@socionext.com,
        sam@ravnborg.org, acme@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <158932780954.44260.4292038705292213548.stgit@naples-babu.amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cef30e5-5bb5-d3e2-3e0c-d30ec98818da@redhat.com>
Date:   Wed, 13 May 2020 17:35:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158932780954.44260.4292038705292213548.stgit@naples-babu.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/20 01:58, Babu Moger wrote:
> AMD's next generation of EPYC processors support the MPK (Memory
> Protection Keys) feature.
> 
> This series enables the feature on AMD and updates config parameters
> and documentation to reflect the MPK support on x86 platforms.
> 
> AMD documentation for MPK feature is available at "AMD64 Architecture
> Programmer’s Manual Volume 2: System Programming, Pub. 24593 Rev. 3.34,
> Section 5.6.6 Memory Protection Keys (MPK) Bit".
> 
> The documentation can be obtained at the link below:
> https://bugzilla.kernel.org/show_bug.cgi?id=206537

I'm queuing patches 2 and 3, since they are do not need any support in
common code.

Paolo

