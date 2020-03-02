Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D265FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1E921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TltPo9rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCBSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:40:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbgCBSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583174431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1X0PQLF6NwaqQ0Dzv48A0q1FZz95BzWsFQZPymTOR4A=;
        b=TltPo9rWMvjApVCQZ68UK7aBQGjZ2Gqql74arRbuxOs5ArNIo2DF2JFOmw9rBBP8Mp3Haa
        JMFTloWvovkooL9DUATvMO9BnCoewY2Zdad1RIVosXweW4nPWXfJ5HZ+wGYVKOVTmZpMeT
        SXXHJ+KyYIb/mgfyzugyINqWdWet6x0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-6rTeoQNVPxi7B70rqjKtjw-1; Mon, 02 Mar 2020 13:40:30 -0500
X-MC-Unique: 6rTeoQNVPxi7B70rqjKtjw-1
Received: by mail-wr1-f70.google.com with SMTP id w6so79347wrm.16
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1X0PQLF6NwaqQ0Dzv48A0q1FZz95BzWsFQZPymTOR4A=;
        b=jJsYzK3qhNdpp3XXjL55GbxEbnV6B2Zh0KwkBAWnVCUDKnXufe2aOjXUqSWGlBMjua
         tr3FTUSVBb3nmtPk66JiFyhwoJW4wxXELsxjrYDwvRwBPKWarIeWkLVH3a0SRp2slqCr
         gkfjZiC/6BuSxYK2iTuQJQ8Z1S/7OXd/k3waQ9ZYSAq78/kweLluPZqzTHx0J+bsPLKC
         KvhimH0CQAvSDgv2HUo/W0h6i7N/hYva9LqK+6eJsUeUKvLBGvytWOjp88eZY3IkbuRP
         XWku6aJY0as5kQ0m2OnBFeVqEVIXpzR1Abs2GeGPv4u1FaKd0vN3H0IwiY6R1mNWtHn2
         FCMQ==
X-Gm-Message-State: ANhLgQ2EBwgUlXlEhoroo26l7beeeZmj4hVDq2rQmRAbYAwX6b1UxZyi
        XMvjk+/l11zR1DGK261STO7SMXe7gTWz/I5vKy/PfbTJoGiY65F6suzOLrx0eC5/ZonRENZiKaR
        5ObJ7pClR29Tfsy6OVJkaS9sk
X-Received: by 2002:a1c:7907:: with SMTP id l7mr343898wme.37.1583174429142;
        Mon, 02 Mar 2020 10:40:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvwC0ey9J226DWJuc8knmd1FpRwvKZZlAuQKol2FcrrUa/BQT+AdmMNebVCCPpOKiNw/O24wA==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr343883wme.37.1583174428928;
        Mon, 02 Mar 2020 10:40:28 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id b12sm1049163wro.66.2020.03.02.10.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 10:40:28 -0800 (PST)
Subject: Re: [PATCH v2 10/13] KVM: x86: Shrink the usercopy region of the
 emulation context
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
 <20200218232953.5724-11-sean.j.christopherson@intel.com>
 <87r1yhi6ex.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <727b8d16-2bab-6621-1f20-dc024ee65f10@redhat.com>
Date:   Mon, 2 Mar 2020 19:40:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1yhi6ex.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/20 18:51, Vitaly Kuznetsov wrote:
>> +
>> +	/* Here begins the usercopy section. */
>> +	struct operand src;
>> +	struct operand src2;
>> +	struct operand dst;
> Out of pure curiosity, how certain are we that this is going to be
> enough for userspaces?
> 

And also, where exactly are the user copies done?

Paolo

