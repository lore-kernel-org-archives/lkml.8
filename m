Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A97C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B680920727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPsUp3WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbgEWXOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 19:14:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39721 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388047AbgEWXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 19:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590275686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MzHc18owJsea3S0pNt/rgvBciUHqh90tS1+xejWc1g=;
        b=MPsUp3WT8ZuU0BOnBT5QS6uQBWxiMXtWTV4lohdIQql2QJYzijh4+RvHY6CMSZMGoNDvUc
        c5W1hTQKfvLn7Rzdt1MZVw1UK4eflqxH/olxSXrAJC4npm1XbV1Tb/EfqcEBZOZbOYwcQK
        Fy+QAANzqcuD6g3PMVcAMjdpavZrbqc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-ouinngDQOaWI9LUZxkAimg-1; Sat, 23 May 2020 19:14:44 -0400
X-MC-Unique: ouinngDQOaWI9LUZxkAimg-1
Received: by mail-qk1-f197.google.com with SMTP id p126so14780314qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 16:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/MzHc18owJsea3S0pNt/rgvBciUHqh90tS1+xejWc1g=;
        b=fozRFKm/FX+rImIyoPD1wQ5X0CGVwbyGkPJFpCVXBpO0cATAYzQ2ZKwG2aktpEZkZf
         cdiJomCPur+GqzR37ybEXJPRnArpBLaCSBcLuTsGl4f06NwU64++se2gk2/izLQby816
         Jpb2kTT+jpwXAZvVinAdCwsFli4/JSDmWvOgb6z5DxYFAchBEeb7TT5CXSFELaTItYq9
         wc+Ecg+mLNNHH2P6LUdl/o7nFKuCgvm/BFs2bJ9GZCKqDsGAYGuGXCRB74pVlRZn4CRt
         bSdGACnMf6/nNTQ0pTUKWoTNeu71NPMrNR3l+RSPJfymaDM0TZP7E7//HLJtBLkfZiHF
         a+0g==
X-Gm-Message-State: AOAM532mEA0Pxx6lmFesCs3u/7c1A1ApiWzaY1/PB0zj2uEqv2J41bA4
        eEowl6e7Qwd9Z35f/EQt+xeFYXeZZ2hZZaEscv8fSps8amvogQLsOfB8I0rkFoS+30S+g5QorCR
        +BPX2a2OXPvBS1jkgLa3GbirJ
X-Received: by 2002:a0c:8e84:: with SMTP id x4mr10010268qvb.175.1590275684053;
        Sat, 23 May 2020 16:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg2V3f8vAVlVmyPgxPifwONVk1iV05bsQWUMpAUKMaaP31/PMeICcUqi8DAc/chgJvp8iwaA==
X-Received: by 2002:a0c:8e84:: with SMTP id x4mr10010251qvb.175.1590275683837;
        Sat, 23 May 2020 16:14:43 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id n31sm12353018qtc.36.2020.05.23.16.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 16:14:42 -0700 (PDT)
Date:   Sat, 23 May 2020 19:14:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v9 00/14] KVM: Dirty ring interface
Message-ID: <20200523231441.GB939059@xz-x1>
References: <20200523225659.1027044-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 06:56:45PM -0400, Peter Xu wrote:
> KVM branch:
>   https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> 
> QEMU branch for testing:
>   https://github.com/xzpeter/qemu/tree/kvm-dirty-ring
> 
> v9:
> - patch 3: __x86_set_memory_region: squash another trivial change to return
>   (0xdeadull << 48) always for slot removal [Sean]
> - pick r-bs for Drew

Sorry to always have forgotten to add Drew in the CC list, so it would be a
partial series again...  It'll be there for the next post.  Thanks,

-- 
Peter Xu

