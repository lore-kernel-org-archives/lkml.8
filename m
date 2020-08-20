Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB1C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D0220855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2vvJ7LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHTH0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgHTH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597908401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moE59twGHKI7k28SZAbOSnFimdPydL4GY9WfrG5itmA=;
        b=E2vvJ7LKRjYDRA5wQTFpsskmrv6cwSNjACl1Lx8rq40Vn/uo6BYTgDYD6lAjPKDkkFHRX9
        lXu+B4pJU2ycdr6lPcUCdt2I2guwpZsc2kvqoIS83sht2GB5q9KiY7oDZdx6WgE59hljJr
        XyBLqB2hPvsxaTNw78b0MHhWDXojdGM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-h6eGS6kRMoShq6jwQ-4UDA-1; Thu, 20 Aug 2020 03:26:39 -0400
X-MC-Unique: h6eGS6kRMoShq6jwQ-4UDA-1
Received: by mail-wm1-f69.google.com with SMTP id c184so1556572wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moE59twGHKI7k28SZAbOSnFimdPydL4GY9WfrG5itmA=;
        b=c529LPyNnd/gmDkLJrhowM1781KQzjODatt2dn+zCPaZyw+yL5BOOqrbrkVB/D4UUr
         MupmqyVUvWcRKhB8I3yG42Qx/pRMMXr9f01fjunaXDK/Dr1rLC+fEUt0ugG+dIq4+pPm
         zQIOB1ws+1dkE3uXLi08G3ET7QHigIYYMoXloK/jLgLwnBo1XsidH7AWs3wF3eeh51Do
         gjzsP9eReI7d7ZfhWodt0M4fpyw1LoqLW2s83oUXS2lnzOvYtoKZ3MrKsuThG1stgjNf
         zCvi6fEfQvQK0+CI65INzNL6XhDaDigfYeHcyADlZDVOSXJ8fjpoqXi6dHmrLtQeXwuo
         JZKg==
X-Gm-Message-State: AOAM531Q0l/bHgu7ZkQZCKz5accrH18mgpiSuRv6I8ftBMqngW4zhOzp
        x1rL8NlgUUUFgJslwgsJ3vNQEKYzidzis1dcWG6XQk6bHONnKRZUqwWO1MTSMDgGpa2uSHjLoxP
        f86CnDLfRErXi7NO5SW3dTtYI
X-Received: by 2002:adf:c789:: with SMTP id l9mr1888093wrg.41.1597908398518;
        Thu, 20 Aug 2020 00:26:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBwwkk+81R0CeVuNZYFZ/H/Iy/w3GMsVNOB7/445m84umm/A6fxcrBYXhG1+K6mO8XKIcRQA==
X-Received: by 2002:adf:c789:: with SMTP id l9mr1888078wrg.41.1597908398316;
        Thu, 20 Aug 2020 00:26:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id p25sm2494328wma.39.2020.08.20.00.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:26:37 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: arm64: Fix sleeping while atomic BUG() on OOM
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200811102725.7121-1-will@kernel.org>
 <ff1d4de2-f3f8-eafa-6ba5-3e5bb715ae05@redhat.com>
 <20200818101607.GB15543@willie-the-truck>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c579063-7ce8-cba6-839f-01e5a46a7b94@redhat.com>
Date:   Thu, 20 Aug 2020 09:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200818101607.GB15543@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/20 12:16, Will Deacon wrote:
> Please note that I'm planning on rewriting most of the arm64 KVM page-table
> code for 5.10, so if you can get this series in early (e.g. for -rc2), then
> it would _really_ help with managing the kvm/arm64 queue for the next merge
> window.

Yes, I plan to send it tomorrow.

Paolo

