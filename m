Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F3C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED2F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2/eaB9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCXL24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:28:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30033 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgCXL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585049335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktuTLWFbdGaqqJxefhDZte1DvZgH9my8ZHHD853RboI=;
        b=h2/eaB9dO98C0D0wrrv1zFAX4DQL8a0VXweX4Ld9Kf4IAg1/F4omhbbhxf3FE+wZeSbEBz
        DCfl0SYW9WF7S3AAtRW78kvyNxXE4Q4387/vASSIvSmnrnapG46k2Ac0Zola+f8fUuUT0W
        OK0QiMycqxLjFwDHSuTYcOWRpL8s2HI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-BYBKLMgPNAO8drj4R4co0w-1; Tue, 24 Mar 2020 07:28:51 -0400
X-MC-Unique: BYBKLMgPNAO8drj4R4co0w-1
Received: by mail-wr1-f69.google.com with SMTP id f15so3702959wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktuTLWFbdGaqqJxefhDZte1DvZgH9my8ZHHD853RboI=;
        b=UrvbjqdUWksq5lr37Ny2oRHyl5VXgf60pwm9H7CbijrSSy3oFKsfn8qqy6+m+Z3VTO
         dlIUD23d+qUqGaZcq05xOBT+Cy95rm7wbjEKD0u3V25QcUZ3zm96Bb5jUYyosLaNQHrK
         MnEynanEeA1j5XGaGoIWLpbotZeaLmoSCT2gsauVXYTXJYr13dcAWQNouc382DvC5nDo
         zMPf2kpsmQqO4HulVZaALEm4WL3R4KhaxgC5kxD15fTWj71kYr3lZCKYKal258cRVSKv
         bugGAuBIARUQgKomAU7R8hTu1w4M1EBlvf8tPNu7YoZXYygIrGXaemYHdxc9kh0hwQqx
         EZ9w==
X-Gm-Message-State: ANhLgQ3Z9kZ26pKvAI1cs5/CIe2yreVmzUgI+gz1iOxbur1wLy+OnbsP
        apggc/P0+mmsVG7sVy3WPSeGTmPr314yYtJcrSPN5kVwQcvVdPGzk8zCOod41BN+kC6qdKrvxG7
        KBoq5wiBKkA26uiPj/y1U3gPq
X-Received: by 2002:a05:600c:295e:: with SMTP id n30mr4362445wmd.78.1585049330623;
        Tue, 24 Mar 2020 04:28:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu8wwBP/1By0+yDJsZyGCHmSqEqyjVhDJVEFj/LdirTJpqlyAsnxBXSoDiLlerfPdX0RN46HA==
X-Received: by 2002:a05:600c:295e:: with SMTP id n30mr4362433wmd.78.1585049330385;
        Tue, 24 Mar 2020 04:28:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id i4sm29188405wrm.32.2020.03.24.04.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:28:49 -0700 (PDT)
Subject: Re: [PATCH 4/7] KVM: selftests: Add helpers to consolidate open coded
 list operations
To:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
 <20200320205546.2396-5-sean.j.christopherson@intel.com>
 <20200320224744.GG127076@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23f62756-aca2-12d0-c2cc-baafafd76280@redhat.com>
Date:   Tue, 24 Mar 2020 12:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320224744.GG127076@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 23:47, Peter Xu wrote:
> I'm not sure whether we should start to use a common list, e.g.,
> tools/include/linux/list.h, if we're going to rework them after all...
> Even if this is preferred, maybe move to a header so kvm selftests can
> use it in the future outside "vcpu" struct too and this file only?

Yes, we should.

Paolo

