Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB8C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B45A2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwYV0g7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgARUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:20:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727178AbgARUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579378803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1i9PTd4XYhlFur0DN62XeTXztI9o6pVfaoSTN+IRyc=;
        b=bwYV0g7LU0lqwoUofhBI3aFZOPEDcm+pq7Rb6y2y1PZQVgFLfgZN7I/lANbPWJZsgRnMbm
        B8nCZGnatgaVV3H5TzcHCGhWDbJEepF76AQpkpnBw9bhE5S5RYdv4MFMw1excHEwBZ+0Ne
        rXMQAFALzyHm3EIiZbRdoWopH/qDAeg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-Xmjx2K61OWmhIbfyfEn6Kg-1; Sat, 18 Jan 2020 15:20:00 -0500
X-MC-Unique: Xmjx2K61OWmhIbfyfEn6Kg-1
Received: by mail-wm1-f71.google.com with SMTP id c4so2955530wmb.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1i9PTd4XYhlFur0DN62XeTXztI9o6pVfaoSTN+IRyc=;
        b=bdM9WGikcO1W0mjpqJ5VRjExDS7alI7NliwidypGntI0e6yPqrplge2naH2A8Gow5d
         iortfKf/QzhYauJ7+Hqu+UerkIbTCiwsmVBibanF6Ogdjm667C8xbEKI9ocLynGKyVuy
         hWfH0WQ7FEjGIPecvLElu8RvDNPjXM4/nzh+SeVA10LhxtQDtL6VJfhsRfdelaHiJFIK
         FzDXIo1JEVMGXZ0rvP+Q3Ukh7+ZjaG7aEHy47dksi5x6iSNe/3AwPtawKEAQf3LBH5wG
         r8dmJhJYWNIuZgK/h3z+uEjQzXQUA55GSp09Y1rnHaHI2l2BH4Z9fj15W+qbmEq8eYay
         0qtg==
X-Gm-Message-State: APjAAAX/80YtL5PHgoUMn3u4pEOHW92sgf1M+jPC2/tLmY9h/KrV2L9J
        fT3sGr/snXdNWMFOv6Sd5YN+sZFFMNfZ2Spy0l4/AUPtNr3BOcehPr3BVKj2V7uNutz+BELWhia
        NklASx3DLRvCY+PmMIO315su3
X-Received: by 2002:a1c:7205:: with SMTP id n5mr11456216wmc.9.1579378798749;
        Sat, 18 Jan 2020 12:19:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyX1dUK6hqvCuIrZTcr9szFlDS1cmMGBoBRngZVr8X7aZDqHlS29ojww0W8gwplggf86+90HQ==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr11456209wmc.9.1579378798554;
        Sat, 18 Jan 2020 12:19:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id h2sm40870251wrv.66.2020.01.18.12.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:19:58 -0800 (PST)
Subject: Re: [PATCH] KVM: squelch uninitialized variable warning
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Barret Rhoden <brho@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200109195855.17353-1-brho@google.com>
 <20200109220401.GA2682@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff6df7b3-e3ad-53f3-d71a-cafc3d091c6c@redhat.com>
Date:   Sat, 18 Jan 2020 21:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109220401.GA2682@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 23:04, Sean Christopherson wrote:
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

Thanks, I queued it so that at least it gets to stable.

Paolo

