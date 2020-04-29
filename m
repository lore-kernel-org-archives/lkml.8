Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C01C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417A42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt2AeFPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgD2Ig0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:36:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgD2IgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588149384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRgQdTkn6qzRkQ8VVsW9dG8WYy4nYX+Jt55KEFeKtGA=;
        b=bt2AeFPbS8c5/9pK9xDWvXzwSgwFvbuP/cLKEYCcrW9MQBN2c3tBEukW95PCiTgUQTYFNx
        jm8OYNRaDrn43lYVbALuNAekSZHd6un84tF5QmSFr1Ub3oQTq9h9CBZsKiNd968X455Cdt
        Bs0rGrOM928PdziBwBBzwMK+6VjF+QA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-NbAodbhuNOa1oIDvB6y9HA-1; Wed, 29 Apr 2020 04:36:19 -0400
X-MC-Unique: NbAodbhuNOa1oIDvB6y9HA-1
Received: by mail-wr1-f69.google.com with SMTP id p16so1354492wro.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZRgQdTkn6qzRkQ8VVsW9dG8WYy4nYX+Jt55KEFeKtGA=;
        b=gO1+Oj7PZ/t5L36uweqs9wGD0WgpOvJ+GXDLjRhkPy0iVz6aFfpPbt98/N7PCUFM7T
         X6rsipSzB70BjtpV6XKidQ4Qqnd1yUwHKOKsk0LasnKiX9BkQ2eFrOflOrjS98n6YE6b
         UqzLhsfWBitR7mBaWOJLcFXa9j98GkOkPGJzrKzdiSUtyvhPj/KGQPvjrM2PkPEhKMhe
         2mexHITILuN0JNO7e2/loFBlBO3m/fMAWJsOIvIH84AZ52QHvg7gEnQizQnARSKj2fOz
         I/FBaGbAahG7DrAkktc3vNLQZRKjBoJ4T6vrr+jh1w/0Xw3hcS1nWncUUp6zxVyduRfJ
         7PsA==
X-Gm-Message-State: AGi0Pua9EZg1OUeMn1huk+XXBb7Dm4qjieJ2MXkrhV/cbGknw3db8kuk
        +Hc8wy+UeGEUvn7+Hgr3pvpORqwwtyEZNx5ZRuyBsIr7dkfW5FL5IvB4nU+0FdYtLXSvtRJELXZ
        CChTTZTJw/zIeALTZbwAMehtc
X-Received: by 2002:adf:9342:: with SMTP id 60mr36541879wro.129.1588149378460;
        Wed, 29 Apr 2020 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLSaWR1sAvWMX7AGwwO6UHEwfuQ24iWbemgcg/Uw0ef/sYvFheYyqtDLemSd+ABFL6cnQwmhw==
X-Received: by 2002:adf:9342:: with SMTP id 60mr36541854wro.129.1588149378247;
        Wed, 29 Apr 2020 01:36:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id s6sm6686281wmh.17.2020.04.29.01.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 01:36:17 -0700 (PDT)
Subject: Re: [PATCH 12/13] KVM: x86: Replace late check_nested_events() hack
 with more precise fix
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
References: <20200423022550.15113-1-sean.j.christopherson@intel.com>
 <20200423022550.15113-13-sean.j.christopherson@intel.com>
 <CALMp9eTiGdYPpejAOLNz7zzqP1wPXb_zSL02F27VMHeHGzANJg@mail.gmail.com>
 <20200428222010.GN12735@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b35ec9b-9565-ea6c-3de5-0957a9f76257@redhat.com>
Date:   Wed, 29 Apr 2020 10:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428222010.GN12735@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 00:20, Sean Christopherson wrote:
>> So, that's what this mess was all about! Well, this certainly looks better.
> Right?  I can't count the number of times I've looked at this code and
> wondered what the hell it was doing.
> 
> Side topic, I just realized you're reviewing my original series.  Paolo
> commandeered it to extend it to SVM. https://patchwork.kernel.org/cover/11508679/

If you can just send a patch to squash into 9/13 I can take care of it.

Paolo

