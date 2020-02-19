Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B6C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8FA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izH4uc5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBSLK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:10:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726497AbgBSLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582110656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9ngAADFf0H6tNXWrWk3zBJLW6Dh0uOu2zK7HumFKqU=;
        b=izH4uc5PsFZchDxiRprsT1fdCuKf2dc2zis9WQKGvZgOMG23HNkSDTZO4kr/7HXPHBuDIE
        XQ1S8vhGpMyouk+InsqV6iC2WJ2wCx0e1Sc5JBBhrLpTvcDDfRqZpsvIcLuiw0sHc9AKMc
        QaLc/GVxwzzsXHvcAZlEg7zppFFlbrE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-P_8pVvJ5N4SBqdCIsuTpiw-1; Wed, 19 Feb 2020 06:10:52 -0500
X-MC-Unique: P_8pVvJ5N4SBqdCIsuTpiw-1
Received: by mail-wr1-f69.google.com with SMTP id t6so12436419wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9ngAADFf0H6tNXWrWk3zBJLW6Dh0uOu2zK7HumFKqU=;
        b=tmdT/+7fTwIWAmdOOG265g2X3Qw/1rPe8j5DBKUt6/hKgx5+wg+nMfR/uJ/1yTjJdi
         st0txgC0FUlkBu0719IenlkECjhkM5N+vgbVT3KqCB6ORFcj70Cvwa4687ufrzHVpP+N
         qWIm9u7uh/D2W54ONe4CuB8vCrwaNsRdJo+oiKhXRCnsAMB5/Nqpl7by1s7nizwj13Be
         IPK/xQor6dDr6eVNURBwksCcn6tM8vfedAqzXiQSZpjBzJvPLuaIa+0gDWN0bvfRpsGu
         n0YUWPwLZgiYZHsKRSwAUe+2SwlhDdemd0gBjCwWBgQzLaNVdgz851+pdLTMfjNF07SF
         SQRg==
X-Gm-Message-State: APjAAAUzeWPszE9zA5TJDGLeaXLF4Hpjoxk/5YAEuw1xcRDUzupIDusS
        aBnusFOzsn2IgZP81GAiyL5J8yTnPypRtV1Q104JhnsHeVIzTZCGm/M5RciiTiyQTLSoCr5b+V8
        rmC+h1bv1xoQDwiHWuxoD5lQy
X-Received: by 2002:a7b:c183:: with SMTP id y3mr8994473wmi.45.1582110651008;
        Wed, 19 Feb 2020 03:10:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgHklSoTJAASymtkOJdhkIhiMJIFRI+F05r4Zs/xNP/kGoNa/TNx+0pu+EJD1dPQoyvi+MUw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr8994454wmi.45.1582110650820;
        Wed, 19 Feb 2020 03:10:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id e1sm2438009wrt.84.2020.02.19.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 03:10:50 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Avi Kivity <avi@scylladb.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
 <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
 <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
 <20200219103704.GA1076032@stefanha-x1.localdomain>
 <c5ea733d-b766-041b-30b9-a9a9b5167462@scylladb.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ced21f4f-9e8a-7c61-8f50-cee33b74a210@redhat.com>
Date:   Wed, 19 Feb 2020 12:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c5ea733d-b766-041b-30b9-a9a9b5167462@scylladb.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/20 11:43, Avi Kivity wrote:
> 
>> Thanks, that's a nice idea!  I already have experimental io_uring fd
>> monitoring code written for QEMU and will extend it to use
>> IORING_OP_READ.
> 
> Note linux-aio can do IOCB_CMD_POLL, starting with 4.19.

That was on the todo list, but io_uring came first. :)

Paolo

