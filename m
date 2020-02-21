Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025CC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B46222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAmyAQyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBURMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:12:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727020AbgBURMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582305156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3L1ZoX/TxjkXS/fwqsg0irgxYEbxhFv9zJWuTR+8M4=;
        b=IAmyAQynDj01UY6WenRa4vmz0SBGmrwl9eUhEeDes1GV+f+tXDI0JBOq2MrMTTLpQRilA/
        ExcE1/lFHtwgHsBo3N5Xy3jhhVSgFb/XGoHzGCJhh7s51MjQ6aZdyxHKNjos90iUti2mSN
        cqT6gZzf13ss9ghXhvzxleL+I4ANlNI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-u5dJnroOOhyC3WZcpdUM2Q-1; Fri, 21 Feb 2020 12:12:35 -0500
X-MC-Unique: u5dJnroOOhyC3WZcpdUM2Q-1
Received: by mail-wr1-f72.google.com with SMTP id c6so1280111wrm.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g3L1ZoX/TxjkXS/fwqsg0irgxYEbxhFv9zJWuTR+8M4=;
        b=d25kc9RGG6HVhDbZV4RyyVHmzlkiP7gb0vcCeP/uWFfCECPwULuXeahWoVcEwBNA6E
         9+Uqtr7oxp7X3ARmdeTIglzd32717C1H6GLif6UVpiT+eX8h5Kp6d1CChdT+X3JILXWZ
         MwnUkC89kyF6jYL5XVBYX8NANyB5uDx6KCt/y8FkujjC63taufYKdFPMIeZBSyxJ3D8z
         3EztDfemiEIZ3Z4O1H25+8sP5oJ8o5ZBQw0EKcGi1ogbluB8MEg37/6lh4fFiXFc77b4
         X7AMXh7gYSvDeQIYNS4OM3d94a0eFsK+77RcaVL7QA+4aPYsxvkdloWJZNT7rlDub5/C
         wh1w==
X-Gm-Message-State: APjAAAXkxWE5J8FqqLdqMCkh6mNEPjLJf2vuSBVM3e4HqdP5nvLnQzrS
        QtOlAisw2xLKC1MWxgPt2UdSbEkhSsKKsadu63H23T8yB36GQFy7n57n+GUpVXsNRvcvpL5nQd+
        E/Y9Ky/tOqF9R3uYEx5zcohBM
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr48865560wrp.167.1582305153493;
        Fri, 21 Feb 2020 09:12:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzWyB6s7IwAppJnceUdyTwctOskCid+p4JUdfGldG0cym2Ms87VdXP5N1NlYKfWlZBVYTZFA==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr48865545wrp.167.1582305153286;
        Fri, 21 Feb 2020 09:12:33 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id g15sm4814994wro.65.2020.02.21.09.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:12:32 -0800 (PST)
Subject: Re: [PATCH v2 1/3] KVM: x86: Add EMULTYPE_PF when emulation is
 triggered by a page fault
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218230310.29410-1-sean.j.christopherson@intel.com>
 <20200218230310.29410-2-sean.j.christopherson@intel.com>
 <7d564331-9a77-d59a-73d3-a7452fd7b15f@intel.com>
 <20200220201145.GI3972@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b47c043-5fa5-3ae5-6c97-e2532dcff80e@redhat.com>
Date:   Fri, 21 Feb 2020 18:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220201145.GI3972@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/20 21:11, Sean Christopherson wrote:
>> How about naming it as EMULTYPE_PF_ALLOW_RETRY and exchanging the bit
>> position with EMULTYPE_PF ?
> Hmm, EMULTYPE_PF_ALLOW_RETRY does sound better.  I'm on the fence regarding
> shuffling the bits.  If I were to shuffle the bits, I'd do a more thorough
> reorder so that the #UD and #PF types are consecutive, e.g.

Let's just change the name, I can do it.

Paolo

