Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC3FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A035206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCNDSe9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394074AbgFSPng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:43:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27149 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394066AbgFSPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592581411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJ4olDP4sE92e0G3XhQT7E9mJ/AvOujEs+OICxyS890=;
        b=jCNDSe9jRMlCelk3ZCSiOiJziid9M+2dpP8Zkf+kIxg4lSBasa0ZaHzfLkVeXhmm6qKhr6
        O6uHSeEgc6yjExR11IorxCGKkiTxE+UAynR1i8QM2iA/NzVAZXwU9m5lV4RWnozpxUZU5T
        su9fqm4FCnM9sG/WCk6n+9FmwukhQ9M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-JBVPsHXrP0aiexvNg3WbYw-1; Fri, 19 Jun 2020 11:43:29 -0400
X-MC-Unique: JBVPsHXrP0aiexvNg3WbYw-1
Received: by mail-wr1-f71.google.com with SMTP id j5so2037422wro.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJ4olDP4sE92e0G3XhQT7E9mJ/AvOujEs+OICxyS890=;
        b=nsOzxFiGlyU9SDZW8THosEyzMmOgrdB3y1r+6K54AzbrAK6s9CxeBqKY9timjee6Xg
         Fz0X9lbguK7Y/7BVW2ISbeoYdOEQhNvkdt3E/7sZJ1fuMH1fx7RLGHKSYR7Uu+dL5B4x
         vDezxFLc1b0EHmnK6k6fhh28tatujbIhnQ7qts3EEED5Dtw/yRlJj0kIqcrtv6QfFl0J
         3Uin6ozPT9nTt7Pg96cYtgogr4MmDRnq3MBbSWxOrinIFgFNZTXA537qr0W+tQQqqA8d
         e60G6llOjPVE33R0k69BZQXGK9SenpORFCc7rmvTropAKg38+GouKj82XiConhu5nMk6
         HNmQ==
X-Gm-Message-State: AOAM533uycX6p/nnkJUUVri5tVWiPRUJK4Fa6lwX9uw4nZqbQZOiFqh/
        RLq9aJ0+AAuPOTqNITAH8CNvTKK2CBQ8ntEyKOGInzBy7v4fW9g9OIUtlkEQ0tegYW0nUEEDobP
        ugceiG0TFXkfaUjwWZSKqE9Oz
X-Received: by 2002:a1c:ab04:: with SMTP id u4mr4641085wme.52.1592581407893;
        Fri, 19 Jun 2020 08:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM2p8s4uLxagQNK//PxpJ+oT8+9b3lN2UK1YhhNUn9fFNMbEk3eFggdKAd4PlTflL32CmW3Q==
X-Received: by 2002:a1c:ab04:: with SMTP id u4mr4641071wme.52.1592581407700;
        Fri, 19 Jun 2020 08:43:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id d63sm7719649wmc.22.2020.06.19.08.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 08:43:27 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, thomas.lendacky@amd.com,
        babu.moger@amd.com
References: <20200619153925.79106-1-mgamal@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87312ebb-e842-3b21-e216-916d54557319@redhat.com>
Date:   Fri, 19 Jun 2020 17:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619153925.79106-1-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/20 17:39, Mohammed Gamal wrote:
> The last 3 patches (i.e. SVM bits and patch 11) are not intended for
> immediate inclusion and probably need more discussion.
> We've been noticing some unexpected behavior in handling NPF vmexits
> on AMD CPUs (see individual patches for details), and thus we are
> proposing a workaround (see last patch) that adds a capability that
> userspace can use to decide who to deal with hosts that might have
> issues supprting guest MAXPHYADDR < host MAXPHYADDR.

I think patch 11 can be committed (more or less).  You would actually
move it to the beginning of the series and have
"allow_smaller_maxphyaddr = !enable_ept;" for VMX.  It is then changed
to "allow_smaller_maxphyaddr = true;" in "KVM: VMX: Add guest physical
address check in EPT violation and misconfig".

In fact, it would be a no-brainer to commit patch 11 in that form, so
feel free to submit it separately.

Thanks,

Paolo

