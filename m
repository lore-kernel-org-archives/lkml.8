Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C95C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15320863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1qoOgrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgCCQhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:37:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgCCQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583253459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/ZeDpXicreEUdZsIrFx+xNBNktO+QHj/8L3lsHUiAY=;
        b=E1qoOgrq93kprnl8jkvNE+2Cc5tN2YUWwjPJDiBDVqjuLyswTaRzBPtbp/mZvAOvRLmg3P
        wYLUDcdymiYBmLDXaas0iESoMbfvyWl4SLku+on5Jy45Q76+YVSNNCDr+1m1XvJqHxkQvp
        xAVnrpY+SfykZciTCVP1WG3w/Vin5xg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-DM4jGh6jPNSvs4Ch19gFDA-1; Tue, 03 Mar 2020 11:37:36 -0500
X-MC-Unique: DM4jGh6jPNSvs4Ch19gFDA-1
Received: by mail-wr1-f72.google.com with SMTP id c6so1450417wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/ZeDpXicreEUdZsIrFx+xNBNktO+QHj/8L3lsHUiAY=;
        b=JNunU6kwSrG2vhg64L0sCq2p//YmqKAhlDjpXmyvjp7Foer1byYPD2+o0Zb+wEhIJ3
         UwKj8nyOJkPmRYLbnekYALfQNCWi8n30oPJwr9wSnIr28EOTMLLe5wntoE6nmTiwOHjQ
         jLWxIKL/vXLJGAAMNITXp5bp7/b8PyeFNTzVXePrjEglnGWobpKRqqw/ex8iObya/Sh9
         Lt+h5JFZUpZcAbX/KCoJjpDvddC+Gi6znyT5SW1MkQUdi95tnlKmewS0byceN2931x67
         BqiX4ZRSsfdh7madGGurGSSx69ac3e0AX0DYh8elFhzghE7wszbeqKwym38Yo9BhIILJ
         qPGQ==
X-Gm-Message-State: ANhLgQ1ocUpaQYX0dEb7Agpn+OBl2HPx/USKX/XIW5poGRp4wm41dnaV
        I//tttL35trLimi0ZGkghCDSlXak55DtZoVl0ZAP63v7etS2ffj091sGYMq6v2Mr3B4W5pJHD30
        Kw8lc5dgpXoM5ZJZ3xtOiYe2u
X-Received: by 2002:a05:600c:280b:: with SMTP id m11mr2555447wmb.93.1583253455065;
        Tue, 03 Mar 2020 08:37:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsPDqMEjkm6g4/BYmqiljcMv4+VVa/WPH9gF0EnpbOgCkqiHN1ZDAbIRGgQjqKgCsa1fXCfHA==
X-Received: by 2002:a05:600c:280b:: with SMTP id m11mr2555430wmb.93.1583253454831;
        Tue, 03 Mar 2020 08:37:34 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id h10sm4892868wml.18.2020.03.03.08.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:37:34 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: x86: clear stale x86_emulate_ctxt->intercept
 value
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Bandan Das <bsd@redhat.com>, Oliver Upton <oupton@google.com>,
        linux-kernel@vger.kernel.org
References: <20200303143316.834912-1-vkuznets@redhat.com>
 <20200303143316.834912-2-vkuznets@redhat.com>
 <4f933f77-6924-249a-77c5-3c904e7c052b@redhat.com>
 <87zhcxe6qe.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99fc27f9-bf89-7db1-d333-1433ebfa4e89@redhat.com>
Date:   Tue, 3 Mar 2020 17:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87zhcxe6qe.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 17:35, Vitaly Kuznetsov wrote:
>>
>> "f3 a5" is a "rep movsw" instruction, which should not be intercepted
>> at all.  Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
>> init_decode_cache") reduced the number of fields cleared by
>> init_decode_cache() claiming that they are being cleared elsewhere,
>> 'intercept', however, is left uncleared if the instruction does not have
>> any of the "slow path" flags (NotImpl, Stack, Op3264, Sse, Mmx, CheckPerm,
>> NearBranch, No16 and of course Intercept itself).
> Much better, thanks) Please let me know if you want me to resubmit.

No need, thanks.

Paolo

