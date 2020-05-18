Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B522070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDvmkEp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgERRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:37:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51149 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbgERRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589823433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pW1EBLelNH4xkOAfewry7ROyh0LG2QQK4g8hD3z33Eg=;
        b=KDvmkEp/qCnxBfFjYFSKEORJ+zXqEyOcqU3TXyEZcd9DCCk95Zuw1iLHbAVqzaJubZM6vP
        qep8yhdgJ5asqbRibveqLmiVPL+NAyVvpTpuloSUfeWHNILwp7D34thtTNYdil4J0yX59F
        RaWDrcXbgAjxFqtX8wzqNwAs6liJTSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-LflvGdE4O6u8m88md7xazA-1; Mon, 18 May 2020 13:37:11 -0400
X-MC-Unique: LflvGdE4O6u8m88md7xazA-1
Received: by mail-wr1-f69.google.com with SMTP id d16so5939764wrv.18
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pW1EBLelNH4xkOAfewry7ROyh0LG2QQK4g8hD3z33Eg=;
        b=MiBddNnAScbE8D/qx7idao8p/e6oaOH5UINmWVG9VJ7Ggwmn2aL62qNwF8PEY6dJJ+
         lUVyUVLzNBCxzktW44MsVncPMWF2T4NTB4KQhn0POGWz5A9AMay4FFKv9cTb1tUgIOAr
         nJH1t6nu8OBHVVF/QTCKb9zKbuNxy1zrFEbLLXg4bI2b0+0s0rnlFXn3UgnrupsvwgwQ
         rqJYkVQXf6NoGyHd/MrcY+264uPEKSIWhLOvB+wwUjrcInZwxO0JbDTNEE0XmMHvwYwB
         Bhs2spqfXbYCRuVCHEsRrTNURDacJgjM/2+RNHq1KBWnhwUEHrmwqx4PlrZfX04zv2zG
         wvJA==
X-Gm-Message-State: AOAM531j2TZo6y3we/QBTvdKsI9cmSG014xr8QFqileYf9fmNwaDPHZC
        XEpLRx6v1Z9gE4qCO7XvsPNFy3kBBb/6Ndfndh0petRwUAPy/rYy1INByEXp6qLBKwuV4eyP0r8
        rpVxdr8Pb14QnEFxairmS6P21
X-Received: by 2002:a1c:f207:: with SMTP id s7mr440847wmc.123.1589823430113;
        Mon, 18 May 2020 10:37:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHziqAUOZpnpSyz0zm5tqYhlwsJ/sYOxewftDlo7x0v61iHrJcJcl48zpv1zYNxvv9vqXjDw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr440825wmc.123.1589823429893;
        Mon, 18 May 2020 10:37:09 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id k13sm265994wmj.40.2020.05.18.10.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:37:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: emulate reserved nops from 0f/18 to 0f/1f
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200515161919.29249-1-pbonzini@redhat.com>
 <20200518160720.GB3632@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57d9da9b-00ec-3fe0-c69a-f7f00c68a90d@redhat.com>
Date:   Mon, 18 May 2020 19:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200518160720.GB3632@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/20 18:07, Sean Christopherson wrote:
> On Fri, May 15, 2020 at 12:19:19PM -0400, Paolo Bonzini wrote:
>> Instructions starting with 0f18 up to 0f1f are reserved nops, except those
>> that were assigned to MPX.
> Well, they're probably reserved NOPs again :-D.

So are you suggesting adding them back to the list as well?

>> These include the endbr markers used by CET.
> And RDSPP.  Wouldn't it make sense to treat RDSPP as a #UD even though it's
> a NOP if CET is disabled?  The logic being that a sane guest will execute
> RDSSP iff CET is enabled, and in that case it'd be better to inject a #UD
> than to silently break the guest.

We cannot assume that guests will bother checking CPUID before invoking
RDSPP.  This is especially true userspace, which needs to check if CET
is enable for itself and can only use RDSPP to do so.

Paolo

