Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB9C55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736E620776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzyPkRSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgDWPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:45:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36162 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729411AbgDWPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587656714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/eyK+EbSaVmWgGDTgI5XBVI7nXdlbx2Mfw1lzGhFR0=;
        b=gzyPkRSKWM963WOFXVwXI6h2IArpOjLV8nCSZ0lNw+PkW6LDINUVrmufd4nT9JlBteZj1a
        iaJQOOpVgxVGXh8xCok1V8f1KhC6OeHmhN6l+UjgiXayBT86IIHOMyTvx4OHU6g3CckBTL
        sJlzDEqNt3VN5zn/Fyt9TE3wuLim640=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-0bcyUlqXO228VXmCzroyUg-1; Thu, 23 Apr 2020 11:45:12 -0400
X-MC-Unique: 0bcyUlqXO228VXmCzroyUg-1
Received: by mail-wr1-f69.google.com with SMTP id p2so3058851wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/eyK+EbSaVmWgGDTgI5XBVI7nXdlbx2Mfw1lzGhFR0=;
        b=C4/JqROjm8Vrhi+2n76bXpVMbGx7BNtNEDqRcYRWvI3HIq2gya6DRol50zwIfL9gkb
         betuM+2NmsorN1LF8UGVJMXolO+jENbu8avGYmBKtSmW/bA7ZpxQF+HFH1kVVS5/vDFT
         SxRueAUQrAZYH36VjRs+4g3EJvscbfIGpjxD3u4zw48Q2s+PKJaW6u6ikf7v8GHQsxdz
         Le0E7N3tlzOhEaqeJ/uiNqAgpthqGS8M6soDDQHZtp5ZR80wNRx7VuAzgJnyTpYcdPwI
         7JwH3a0PMQsXc3fGrbvVS131SVGVmwyBW5jDMWwD4UwRV+NHycoEedQz4cxDVi7hajD3
         XV6g==
X-Gm-Message-State: AGi0PuYJIntopQOohtjezjkz44GBxGW7WQtWI/dGAr+8JDmiYQF1SRlm
        gsFWVGGBUdZ6KiEN2PQM9XagapAIpgHPplUc/VdKVftGNPO4fX90iL9wIBpMaq880DT1N8/dIWi
        2NxzI0IMQhfznRdP44zkEGatY
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr5521551wrv.310.1587656709292;
        Thu, 23 Apr 2020 08:45:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypJQIWjb+dZw7q23LstnoGqkWnnG7jTTPRc3d17WOFTrkOrZ7Cz8Lu6tsmp8q4JwNsmEAyDl6w==
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr5521534wrv.310.1587656709102;
        Thu, 23 Apr 2020 08:45:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id q184sm4116644wma.25.2020.04.23.08.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:45:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: check_nested_events if there is an
 injectable NMI
To:     Cathy Avery <cavery@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, wei.huang2@amd.com
References: <20200414201107.22952-1-cavery@redhat.com>
 <20200414201107.22952-3-cavery@redhat.com>
 <20200423144209.GA17824@linux.intel.com>
 <467c5c66-8890-02ba-2e9a-c28365d9f2c6@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28f3db39-4561-7873-09dc-a27ebe5501b6@redhat.com>
Date:   Thu, 23 Apr 2020 17:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <467c5c66-8890-02ba-2e9a-c28365d9f2c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 17:36, Cathy Avery wrote:
> 
> You will have to forgive me as I am new to KVM and any help would be
> most appreciated.

No problem---this is a _really_ hairy part.  At least every time we make
some changes it suddenly starts making more sense (both hacks and bugs
decrease over time).

Paolo

