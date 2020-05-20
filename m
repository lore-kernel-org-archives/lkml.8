Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47612C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A7920829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1T1VzFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgETVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:13:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50598 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727018AbgETVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590009220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9q+MVTxOqNCDfm1aFUF9Xo/SKnt2cacs55IlEoGNHvA=;
        b=B1T1VzFxSUC/pqOEcG1rBsEQdkZcu5zm4X2ILt0AICYvxTVXM+n/oQFLblptWol9GBdA7r
        3ApZg4tvq6TxRWc9Cqhlq6J0pt6bpJRq0jt0G5stgHyGNx6Pxbm37DJ1C+cYIThPHlRLdz
        i22JZwAMuUHB6i0lJxr1b/oRQi5/PPA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-9W5n5iydNK6pOlWyQoUr6w-1; Wed, 20 May 2020 17:13:38 -0400
X-MC-Unique: 9W5n5iydNK6pOlWyQoUr6w-1
Received: by mail-ej1-f72.google.com with SMTP id o23so1859201ejx.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9q+MVTxOqNCDfm1aFUF9Xo/SKnt2cacs55IlEoGNHvA=;
        b=BzRoIjI8p4IEYGf8BaQG5per1CKur7nrLQTELg0c3+gwzjabBGt8zJzwu/v1pcA0I5
         OVjUzqE+31YjPuBGTw2oIDbVEi4Mst3oWWCLAn3MCvPAJqIELuM3Ony75Me5qSdaAnDz
         GJ/CI0vRjHuAaWlohGpN4/MhYkAmzRG8EEgwR9TXm+rvNkjRcrgauEQCvveAjqYp+2k9
         MPS2WO7nZWfDe3MACbuBD6gBVD9roYT1t8Ly/JagppBydUYu5SHBErDWNxyF8h5cDUGg
         9sJ49aiZG32XfZBtWS7SdtIKn6D0QjwsDHrYGOaK4Ruy3OZQK4VD0yIJS7ZJ0Wo9DhMu
         0lIw==
X-Gm-Message-State: AOAM530LO0rIbar6gKedgvXpS2t1nY3wnZUfIo/pHiGdb1rT9IkNp2pU
        DFgA3XPCYlRvUP79z5Utlx433pDhH0MbQaRW0idAHUqxIwNakJlJZ6n16jVupdUcSRxqK0jAPUK
        VgKbhhKWO3FhfNyQ0ioMX3nPn
X-Received: by 2002:a17:906:4886:: with SMTP id v6mr932537ejq.11.1590009217557;
        Wed, 20 May 2020 14:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQQ/ymyohkomsuFQ61gv/edSNt58FILtFnlIurwiVtnbBAEtNk/6YFqAQpcZtu96ld+iDlDQ==
X-Received: by 2002:a17:906:4886:: with SMTP id v6mr932525ejq.11.1590009217375;
        Wed, 20 May 2020 14:13:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c48:1dd8:fe63:e3da? ([2001:b07:6468:f312:1c48:1dd8:fe63:e3da])
        by smtp.gmail.com with ESMTPSA id g20sm2820206edp.31.2020.05.20.14.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 14:13:36 -0700 (PDT)
Subject: Re: [PATCH 22/24] uaccess: add memzero_user
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <20200520172145.23284-23-pbonzini@redhat.com>
 <20200520204036.GA1335@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2e23a99-f682-1556-dad0-408e78233eb6@redhat.com>
Date:   Wed, 20 May 2020 23:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520204036.GA1335@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 22:40, Christoph Hellwig wrote:
> On Wed, May 20, 2020 at 01:21:43PM -0400, Paolo Bonzini wrote:
>> +			unsafe_put_user(val, (unsigned long __user *) from, err_fault);
> This adds a way too long line.  In many ways it would be much nicer if
> you used an unsigned long __user * variable internally, a that would
> remove all these crazy casts and actually make the code readable.
> 

Good idea, thanks.

Paolo

