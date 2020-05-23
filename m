Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B4BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 07:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54ED4206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 07:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMEksU4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgEWHHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 03:07:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43098 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387662AbgEWHHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 03:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590217669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70hlERzGDZeQinZgjimkVAxNg2FOuupLb6i0Dut22jk=;
        b=PMEksU4jzd/Ew+/sCWRNTMVZLrtNtEIPZM5cxhCf22Sz9V7Dp7TOBqbmCwXIDu0Nimr9Q9
        P6CbG1C5mie32RY1Jl3irJh6ZsDuiklHVKrCfvLvTwnjma7evtCTg1EJEkAsNpiAa/oTRi
        UpXasEI/VVHRG/7dsMn7IfyLjx3lLlo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-9iSm3CDCOVetjxEzKflW4A-1; Sat, 23 May 2020 03:07:46 -0400
X-MC-Unique: 9iSm3CDCOVetjxEzKflW4A-1
Received: by mail-ed1-f69.google.com with SMTP id e1so4568547edn.14
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 00:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=70hlERzGDZeQinZgjimkVAxNg2FOuupLb6i0Dut22jk=;
        b=Lrk3dx7rMUvy9RsbjMJZCUfoqYBcHV4GIWAjE873dnU/mX/mOdR+5o2x4iDpYenjEk
         Sr9Iz+gSmHbIeWPt6tSd7bKUOHHUg6MB1Kboj5bPwjna4Nat95myR7F8l1+PEVTByqjD
         o06zFjalw3JyByspvj/qvnMwX3aHV9/KZsV4oVCQcrthC3I7pMWc4JSI6ok3YqItLVGI
         hAY+SG6RrUm7pumvSs9zbqeESQZV1cbyKS8S9lC+StgSfsKIzn/WBRss4v4fVDnEeubp
         SIV6jZtZ3cel7LhXOes3lPMwJh+FezqnbhYy6kF4eRrQG4Pz00LMuMFSLjQxccm4POsH
         nQIQ==
X-Gm-Message-State: AOAM533RZygt1bSLCv3xYdguIUatpCf8dHdWy5AKEwHcNQp1RXz5TWPN
        uy1FzhDcgPfsxb2tdjFFr6FznVC3O+NLNF8PdCVz+EdhhEiSTDkJq73mXT3b9/KrVDMujtvyZeh
        iPQITYeUWDyxfHTPRVU0QsYp5
X-Received: by 2002:a17:906:81c6:: with SMTP id e6mr10809921ejx.241.1590217665094;
        Sat, 23 May 2020 00:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK4WzufDbtJf0j428CvNaKQEncvtUDgK8bDXpnzoSoQlHZuzzWxyPxlBZ5a9UE6y9mz/wF1Q==
X-Received: by 2002:a17:906:81c6:: with SMTP id e6mr10809903ejx.241.1590217664779;
        Sat, 23 May 2020 00:07:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:803:ce64:3f04:d540? ([2001:b07:6468:f312:803:ce64:3f04:d540])
        by smtp.gmail.com with ESMTPSA id s17sm9575061edr.84.2020.05.23.00.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 00:07:44 -0700 (PDT)
Subject: Re: [PATCH 21/24] KVM: x86: always update CR3 in VMCB
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <20200520172145.23284-22-pbonzini@redhat.com>
 <20200520182202.GB18102@linux.intel.com>
 <d85c2e1d-93b3-186d-7df4-80ae6aa03618@redhat.com>
 <20200522224711.GF25128@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31e88353-e073-83b3-2e56-6a8e85746d7c@redhat.com>
Date:   Sat, 23 May 2020 09:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200522224711.GF25128@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/20 00:47, Sean Christopherson wrote:
> On Wed, May 20, 2020 at 10:14:47PM +0200, Paolo Bonzini wrote:
>> This patch should probably be split too, so that the Fixes tags are
>> separate for Intel and AMD.
> 
> That would be nice.

Will do.  Anyway this series will be quite different in v2, and there
will be a couple more changes to common code to avoid repeated calls to
kvm_cpu_has_injectable_intr (because on AMD I'd like to avoid
unnecessary calls to enable_irq_window, it is already complicated enough
without those).

Paolo

