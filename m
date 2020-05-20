Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E120823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ru7fDmkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgETVds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:33:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37960 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbgETVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590010422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB3w4R5SiN/csltSLBX+nnCVG1y+pWdmJzpsplak43k=;
        b=Ru7fDmkVhOO6Y8U9WusHzvJBfJOjRFGx25YvxPUTwZ/nhWDCE1wc6475jzUXK14SGZz5Bv
        Eg2AUOFrfPHOmteqfBf4l5lvrmzxowV2/8rUyvShDkQQZV0D5xzbmK0L9MhU45u7smHqWP
        g2DQHOaVcVZcs1kRCl5ZRT+wx/tdQNo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-7Hph6OunPPqnFIAgEOFWDQ-1; Wed, 20 May 2020 17:33:40 -0400
X-MC-Unique: 7Hph6OunPPqnFIAgEOFWDQ-1
Received: by mail-ed1-f72.google.com with SMTP id bs5so1810546edb.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gB3w4R5SiN/csltSLBX+nnCVG1y+pWdmJzpsplak43k=;
        b=YdEerK9twzyQvzAqQ2Wh2qG6QLHxxXQ0QKt4XIx48cNvh++K3+LUMoDwjwUXM1L6Wz
         BJGeU0fYg8g7FAKPY/IiGTI2ZKpKqoCZNXX8klQLFMMz9nFHK5MhrarfhRrnIuDEkbi0
         yu/Brp8OFldwzW7/l66ewX7miRVL56IiZ9MP1b99c1BDYRjG7GfkNCWTlfJ5wdo8qzp2
         sqnUNQGYqlo/jSeoXuzMP1AMdm5OSkX4plaJoAkpSeIQgLN7ANydTDQwJCI+euN3fYEh
         orAg4ksh/NZBEqW92ScubaIJheq65BxIhvnLlaoGL4jaWj2TN6UPwP4dbzSdB/udFsOd
         ZVzg==
X-Gm-Message-State: AOAM532c6E9iQ0iSMUsEnMfZL7R36hlQzHFBUvA3uFilSWz1YwBjoKR+
        dwIVpWdKZZkROpRSq6GWpMsZncccq+1p5l43J9+UT/NQfpDvUnsBsu8KMHvVdY9ywmZS2BUmx3y
        iqPpp8stoXrRC7/BjJGVz1LJE
X-Received: by 2002:a17:906:d215:: with SMTP id w21mr914755ejz.383.1590010419590;
        Wed, 20 May 2020 14:33:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzia0DvGV2lHMa6PwY6gsFkX7nDgcB6gFcJVQBCo+Mr3Y6LVk6Ks8id/A5l5WmsOsFCBc+UrQ==
X-Received: by 2002:a17:906:d215:: with SMTP id w21mr914743ejz.383.1590010419391;
        Wed, 20 May 2020 14:33:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c48:1dd8:fe63:e3da? ([2001:b07:6468:f312:1c48:1dd8:fe63:e3da])
        by smtp.gmail.com with ESMTPSA id dk11sm2694388edb.67.2020.05.20.14.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 14:33:38 -0700 (PDT)
Subject: Re: [PATCH 22/24] uaccess: add memzero_user
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <20200520172145.23284-23-pbonzini@redhat.com>
 <20200520204036.GA1335@infradead.org>
 <e2e23a99-f682-1556-dad0-408e78233eb6@redhat.com>
 <20200520212807.GD23230@ZenIV.linux.org.uk>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f08c1176-ed24-f578-5b81-360b1b28942c@redhat.com>
Date:   Wed, 20 May 2020 23:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520212807.GD23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 23:28, Al Viro wrote:
> Unless I'm seriously misreading that patch, it could've been done as
> 
> static inline __must_check int memzero_user(void __user *addr, size_t size)
> {
> 	return clear_user(addr, n) ? -EFAULT : 0;
> }
> 
> What am I missing?

Ok, I have a serious tunnel vision problem.  Thanks very much Al.

Since I have your attention, would you take a look at
https://lore.kernel.org/lkml/20200421135119.30007-1-eesposit@redhat.com/
please?

Thanks,

Paolo

