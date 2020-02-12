Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F1120637
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhO3jD+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgBLIba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:31:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20632 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728192AbgBLIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581496289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZOfuc0f9zTXdDLlba5WZgUvut3L8/MVnfbdrFnGVlk=;
        b=RhO3jD+7xFfhwSK3oe0WoZR9cH5/gA73KTDOP/hncOy6DgP2U7ro2OdygIgK8vhGUEmnlk
        yIUYr/Lk+RF9hM12o4eiunjJOKDnjP5SfgkHNKv2XWMT4CjMT/YMVcYQVLArWBHIsz/0vB
        1VBQoZJaVW030Ir6XN+sXrdReavfOOE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-lKjF_G1lNrSSidDS3FDrOQ-1; Wed, 12 Feb 2020 03:31:27 -0500
X-MC-Unique: lKjF_G1lNrSSidDS3FDrOQ-1
Received: by mail-wr1-f72.google.com with SMTP id a12so504611wrn.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZOfuc0f9zTXdDLlba5WZgUvut3L8/MVnfbdrFnGVlk=;
        b=UruonPWcXHxT43qHWaUCAEGsV4jze4KPEDPibTBPZoheJQvfs6HpxZfKG5quUp9xLC
         YXxFTw964ZSHa6KsUcQOTe87K4uZsETcuWOIOicxLRRMcMPZgVVgnt2wlfEUjsFNpfmU
         padYH8BXcYj38cFFKN4pU/WZUMq2oQFjxa5BF9pAgrP4+CYm+uTuSbIasFhDzqakakfB
         cekAnyX6uyJ+nx1MOkRqbGQv+NJ96DIKw5bdqAMrrxbh0/243wE55/bs+tWh7kd2GDPF
         BsgxI69YgSfT+jvnf3oiiea96GGgIjznqq+ngmKBVIXVxY3zIpDb1zPRGwmpjU3tB7l3
         +6wQ==
X-Gm-Message-State: APjAAAUH0oVfFeLSgQ2XQp0xCgho/09qdsFLAar5lIc15qzW4go1hODm
        U+ruksE5/rrlAmknCte/Hv18ir+DKcqScoAgP1wzbVWv7vck7ZCXTG+2ItXxbrCTbDfaEZeWB0R
        vuYgHo0+ccoHkay8MwRLvVXiI
X-Received: by 2002:a5d:534b:: with SMTP id t11mr13741812wrv.120.1581496286529;
        Wed, 12 Feb 2020 00:31:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqza9H25/6DFSL8gggVhZrtaOfNP+AdiOecReyyBui2YL/vcqKEAGwyfksGHrCPVHXAXdbPgkg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr13741777wrv.120.1581496286194;
        Wed, 12 Feb 2020 00:31:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id g128sm7071124wme.47.2020.02.12.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 00:31:25 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
Date:   Wed, 12 Feb 2020 09:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200129172010.162215-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/20 18:20, Stefan Hajnoczi wrote:
> +	/* Semaphore semantics don't make sense when autoreset is enabled */
> +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
> +		return -EINVAL;
> +

I think they do, you just want to subtract 1 instead of setting the
count to 0.  This way, writing 1 would be the post operation on the
semaphore, while poll() would be the wait operation.

Paolo

