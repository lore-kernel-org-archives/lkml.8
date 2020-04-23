Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420FCC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4420704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8n5rQmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgDWSr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:47:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20149 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbgDWSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587667674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UP4LvX8gxcGhISOea8YwNFKWeVA+DfOShDtScHbi7jk=;
        b=f8n5rQmpuH0i5row8TiAFOcv4p/szdxr6pVHo7hmkvQVF9iHTUHf8HbEm26BTPkXZnyZxG
        eHxKBJAXHt3ZTvyeaaEKfmZaN+kmlaU8MyS1oKFFbdhzdZt2r+s5WgU50RF8Dae6Ol7WX7
        nrckwTg57go9f1zVhvUraOzv97icPIg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-a0fcPTxfPcqqPz-vX4XyrA-1; Thu, 23 Apr 2020 14:47:52 -0400
X-MC-Unique: a0fcPTxfPcqqPz-vX4XyrA-1
Received: by mail-wm1-f72.google.com with SMTP id 71so2754357wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UP4LvX8gxcGhISOea8YwNFKWeVA+DfOShDtScHbi7jk=;
        b=fNQyvftq/TZGCoNhx0mk9f3K1NqLa7XkAD1adlh2vhKlnkB1matGhQmz/fcytujUCg
         NHhKvUB91TgrV10rS7RmpNGylVUImD+ONAvRBsxPr/7W8hbWbBifThVz19TXlctD0u86
         +ksSjq7rYPWtI3lIm5J0IXtWdmQqVxrQcKD644snuWoQb90KFgQde5T96v3RgGE8ohcP
         Hkmcak5zOMBy7niJ2ogu++3DU6hT598tLu/6N2oGzVFRFakapX3X81yfJvi0GT2gRcAu
         8FSvkDsIlwUukBAvg43lkTHf8Dxfkl3rBSrlfDufExCeGCt4fG4TqPWTzPM0pHmuUsJm
         l0qQ==
X-Gm-Message-State: AGi0PuadeHrdic7poBiHW3fJRppGnEhamwnJYNnpVwMP6eIKD4Zol19L
        2FAQuBIh9EuFmnMNHf5rIkuOvkIIiFRjJ3D1MV/dPEpekUxdeMxMWEC955W9n5X7lYQbXTUWguj
        qw10s0L8XyzCQ+58/5wi6Ycq5
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr5378708wmb.61.1587667671278;
        Thu, 23 Apr 2020 11:47:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIGX+c0VaPtxeEQ+EdfwLa4HdBfcFzZxxcdOmn4WZe3Y2qrKzLPY6u6SWTyNn1roGFw4gNOxA==
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr5378684wmb.61.1587667671025;
        Thu, 23 Apr 2020 11:47:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id h13sm4648105wrs.22.2020.04.23.11.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 11:47:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: check_nested_events if there is an
 injectable NMI
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, vkuznets@redhat.com, wei.huang2@amd.com
References: <20200414201107.22952-1-cavery@redhat.com>
 <20200414201107.22952-3-cavery@redhat.com>
 <20200423144209.GA17824@linux.intel.com>
 <467c5c66-8890-02ba-2e9a-c28365d9f2c6@redhat.com>
 <28f3db39-4561-7873-09dc-a27ebe5501b6@redhat.com>
 <20200423183315.GM17824@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4805d3a-357c-99bc-c6cc-97149d79916e@redhat.com>
Date:   Thu, 23 Apr 2020 20:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423183315.GM17824@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 20:33, Sean Christopherson wrote:
> On Thu, Apr 23, 2020 at 05:45:07PM +0200, Paolo Bonzini wrote:
>> On 23/04/20 17:36, Cathy Avery wrote:
>>>
>>> You will have to forgive me as I am new to KVM and any help would be
>>> most appreciated.
>>
>> No problem---this is a _really_ hairy part.  At least every time we make
>> some changes it suddenly starts making more sense (both hacks and bugs
>> decrease over time).
> 
> LOL, no kidding, what sadist gave Cathy nested NMI as a ramp task? :-D

The suggestion was to write more tests, she decided to extend that to
fixing them!!

Paolo

