Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8DF206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUtCnCT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgGHPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:54:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22135 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgGHPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594223686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2JylkmGqvhoOcb/shtzMuVZZ0krZeWRN5Y+vX9FU0o=;
        b=HUtCnCT7+WnP2DmE+ihkloBrVV+LNmpL4y9a5uL0HTsZ4qLAGo17vyoPP+REffP1OCyrfs
        E/zDbhguEmyJgXmvvmN24o/Ec6qdqpUdpY68JnzMXd5hxK3POVAVGfaVPS4l1RXboF7qtt
        1MGI3BUXk3/zLjkn13Epeg1m3hsdbHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-reOxbTyyMyi6zy7FfF1JHQ-1; Wed, 08 Jul 2020 11:54:44 -0400
X-MC-Unique: reOxbTyyMyi6zy7FfF1JHQ-1
Received: by mail-wm1-f71.google.com with SMTP id o138so3412686wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2JylkmGqvhoOcb/shtzMuVZZ0krZeWRN5Y+vX9FU0o=;
        b=CYJnXbIhiOl2kAdKz2wTa6/Fp9TvTEhG7C14AxPiVP+dpZGKxtYmWL83AtrBRPAdCI
         RH4+GDmVt0dbkO3HOVtGxqtbUlVEL5j3yoh04G+ecffAZy6Lgi6r5F74r+f9KaJWzGxl
         FyMaQVuhA8TFh4SYF+soIwXwydCdV4PQZOc/XNEB2/GbLiON7yT0knGee2/YGpGaJJB4
         8gmPg5/gFvuk2Dfm4Iz3S00UurC7Q9fDpfp3l+qsMFbVc4cz255S/YyfZKrfpJnfBFmS
         GqUmZiPzemf5FCYZSs+Y1gQBxsCdf3OCTQArI3uRr2cJ0bYzmfhLJ4L+3f/y4Uy1IE9T
         jrvQ==
X-Gm-Message-State: AOAM533sMdH7JHX54qcl+n4yhFdd6u7tpyu1GqZ3SbRbyVFwFfMr+iLg
        nDm4keSHq3UQf452rtX1zTBAckjoOzsv1zr40uZPZ0IGps/s6iAEeGqAh0B6qMWkzaZPZGMvhKp
        DiBWHN6ribLKhaeng1DV7QOBT
X-Received: by 2002:a5d:6987:: with SMTP id g7mr58593721wru.79.1594223683450;
        Wed, 08 Jul 2020 08:54:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvVvPOE+KvsNAqExWUNOScSfevZpgbIsZWtSGnOuPcU9AGUIfgYqRiH7oZg2skleOLHt0eXA==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr58593709wru.79.1594223683271;
        Wed, 08 Jul 2020 08:54:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id n5sm253364wmi.34.2020.07.08.08.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:54:42 -0700 (PDT)
Subject: Re: [PATCH] KVM/x86: pmu: Fix #GP condition check for RDPMC emulation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
References: <20200708074409.39028-1-like.xu@linux.intel.com>
 <20200708151824.GA22737@linux.intel.com>
 <e285ccb3-29bd-dcb8-73d1-eeee11d72198@redhat.com>
 <20200708154520.GB22737@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <face99cd-f19d-afb3-8f5f-ac5206ba39b4@redhat.com>
Date:   Wed, 8 Jul 2020 17:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708154520.GB22737@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 17:45, Sean Christopherson wrote:
> On Wed, Jul 08, 2020 at 05:31:14PM +0200, Paolo Bonzini wrote:
>> The order follows the SDM.  I'm tempted to remove the CR0 check
>> altogether, since non-protected-mode always runs at CPL0 AFAIK, but let's
>> keep it close to what the manual says.
> 
> Heh, it wouldn't surprise me in the least if there's a way to get the SS
> arbyte to hold a non-zero DPL in real mode :-).

I'm not sure if SMM lets you set non-zero SS.DPL in real mode.  It's one
of the few things that are checked with unrestricted guest mode so
there's hope; on the other hand I know for sure that in the past RSM
could get you to VM86 mode with CPL=0, while in VMX it causes vmentry to
fail.

It would be an interesting testcase to write for KVM, to see if you get
a vmentry failure after you set the hidden AR bytes that way and RSM...

Paolo

