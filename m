Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13610C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEAC2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZMw8BfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgBQRHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:07:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729271AbgBQRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8ekHRxyGjG79FMqVIJ5GpDBPE0vuy0FBs+DN7hAGZE=;
        b=OZMw8BfBkjgBvNV/UEdDiNqjZyEElGyXwdbNon68RxuPYONpcP3g4DIYIYVWxBvEA2yfAP
        iuILeGfZQ/7KhxGaIlABlvjKteYYk32li9EabTz9QJnTrKq2fzVLN1gxZ4JlQd0Blcb8E+
        pwptxfS9ZP2uQWYMGMg6zjqayVvc/WY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-XibzD6rENrKokR6spH3eug-1; Mon, 17 Feb 2020 12:07:42 -0500
X-MC-Unique: XibzD6rENrKokR6spH3eug-1
Received: by mail-wm1-f71.google.com with SMTP id f207so13421wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8ekHRxyGjG79FMqVIJ5GpDBPE0vuy0FBs+DN7hAGZE=;
        b=OFiimskegOZDQ/7DtR/cANQNLIKTus6TymtNntlooxtInOghY6HDHBV0wLpgH6zOBm
         C3ZIcN6UBXlrryrsUq1Y1O/TGaYT/eDYRAjfSjgxHuu4jDOgxTsqi/plKkec+iVhW816
         e1tkHYspVmWfrgvnWg9RHSXD+v/AABk23cXa/135HIJb5YZ/+b0YIGlPsNBTUpB9uTag
         2QBvbvc4Xx8oglDsLHnAllgP2OAxzSUJ6TLLDbwvT1CC8YIhTd2b+/gp+yijOaZ/7wOS
         YU7w4jBnQ+8z8vZOxOPspwebAuxUQW4fEmDI5OGrWxZynWYUm8+Pc15p7/YyOmv8TpiB
         UPeQ==
X-Gm-Message-State: APjAAAU6Uf8JZMERMy9clqUM+gjHMGUJ7pkR80K9ff4MWnOzdrsfs4M3
        kmV5MhxBZIp1zfrDKbO25dNg8qQiEH/HXDxIpILwVmsSrzNjXhUAr8lC+aCYgNjymCkVycYC6Pi
        XsNtlsSFrWUn9AQdHc5DArYMW
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr23169028wro.80.1581959261298;
        Mon, 17 Feb 2020 09:07:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBi1h1ePrfcvbLrgaw7FsnBlFRQyIF6cIDnTGDykcOro85MvUUUz1i0rgLeTQdc3sx7DjSBg==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr23169004wro.80.1581959261031;
        Mon, 17 Feb 2020 09:07:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id d4sm1694350wra.14.2020.02.17.09.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:07:39 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Fix print format and coding style
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
References: <1581734662-970-1-git-send-email-linmiaohe@huawei.com>
 <87o8txbngb.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbae67b2-a9b6-d2fc-a49e-ef07d1358860@redhat.com>
Date:   Mon, 17 Feb 2020 18:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87o8txbngb.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/20 09:57, Vitaly Kuznetsov wrote:
> I would've suggested we split such unrelated changes by source files in
> the future to simplify (possible) stable backporting. Changes themselves
> look good,

In this case I think it's trivial enough that we shouldn't have any
problem backporting to stable, but in general I agree.

Queued, thanks.

Paolo

