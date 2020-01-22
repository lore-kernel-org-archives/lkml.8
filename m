Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A953C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0078C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFfdY4a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAVOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:24:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729037AbgAVOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579703086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqT6CKkFGq3yewDVX4rWRr0dGnPZkXFg3u7EsnPq/64=;
        b=gFfdY4a1CTVtqebu4zMtGxsFs6Lu25oLORhYFeqoUC6C3HjL3PyH7RjBcvmmRIM2PYR6kE
        nCWd+u45ZKEM55FHegJW4hDp0WRuAmr/aGI5lP9X5r7tnGwCPjcP4znyZTVNVyfC+XbO+V
        4sPFVGPgL903ZCa2okuRSraTGHfEisc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-gIjaKBQmP52f6c6Rwcnkyg-1; Wed, 22 Jan 2020 09:24:45 -0500
X-MC-Unique: gIjaKBQmP52f6c6Rwcnkyg-1
Received: by mail-wm1-f70.google.com with SMTP id s13so1001131wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqT6CKkFGq3yewDVX4rWRr0dGnPZkXFg3u7EsnPq/64=;
        b=JwKE6Ps+5s0MHsJe0FyO78smui7FljTrSBXKBFQc1wBVvFQyfo+KKItaI+V1NvX5w9
         vOGwWGrln3/HIXL3CRpvPHkVnFDpDATJ8kD94FNoImw+3YLG3B0GAM2U3qqx/LqcC9tS
         XphRBExsjkQs4iXgv6sI7xSZk+lHlDWwQA7hY+sw8lGNv/0Ul3lIrMoq4LTgo7G5qlqt
         rD3mcdWDOTwn1M10E5eWH9W/fvdwrO10rtjH23IJ/c6gAmAmiE/j9FUUoRkHCMTfcIQL
         JTrIdLGaC+YXVenCqJQCWEGSWrRYLpg87KWfaZXehNCKAEk4TS42SyQ8LRi7YNPu8GZp
         GafA==
X-Gm-Message-State: APjAAAUUEkHLYA/HIb05Ep8Piex7JyqOtkGZIfMCDIrFM/INwjcJFeKh
        VR7UPsCQ9U9v3dPAoZiABktDT8wnXlfsuKpn62Oe/yrhpczW7GU3JRcaAc0UyMULDwOSSdVQf1+
        FNCvCcQ8vkOUQqOFb8hdzaW/4
X-Received: by 2002:adf:f54d:: with SMTP id j13mr11499353wrp.19.1579703083586;
        Wed, 22 Jan 2020 06:24:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/2ceqwR2kycBEWzkQorXDtWBW1IKh4GGt2+mtCymg1sayhTfnKvWGxkroPEuUM2HmBy7NKg==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr11499329wrp.19.1579703083264;
        Wed, 22 Jan 2020 06:24:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id m3sm55904641wrs.53.2020.01.22.06.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 06:24:42 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Add 'else' to unify fastop and execute call
 path
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     rkrcmar@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1579663304-14524-1-git-send-email-linmiaohe@huawei.com>
 <20200122044256.GA18513@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0914980e-30dd-5b39-a951-ca73e1b86ab3@redhat.com>
Date:   Wed, 22 Jan 2020 15:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200122044256.GA18513@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/20 05:42, Sean Christopherson wrote:
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

Queued, thanks to both!

Paolo

