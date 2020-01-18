Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDDC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9424695
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH8P2D0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgARUDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:03:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbgARUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579377783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ffd+kZMGJK3EtC4IWqohC6rZpO0y8vICQx285ikZQIw=;
        b=IH8P2D0WQyBdRSR3sIUrKQdQzmGeaNoaDNu6HQ+j/yJ7Gynjq89yRcu/VRV7qXM+egzI9K
        hY6QkxBkVcCAbCnZGiuC7BY9S65WWfs9UR4RLwv/X3JOKLRLCWt7qeFIL/Cs4l+irHTENH
        eUn00ZDLXkjlMIEoYYK+Ricg3mOcH+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-J5GkpcqNPn287AA3c4IMpA-1; Sat, 18 Jan 2020 15:03:02 -0500
X-MC-Unique: J5GkpcqNPn287AA3c4IMpA-1
Received: by mail-wm1-f72.google.com with SMTP id 7so1626050wmf.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ffd+kZMGJK3EtC4IWqohC6rZpO0y8vICQx285ikZQIw=;
        b=MSomYS1VdSz84NIVEw9abfU2OlDXE5JGTUf1QXc3Fov2fS61h/EYC0LFoq/aiOCGrF
         hTKMpMeCEhJkcbjf7TsxbSeiB9JjnMaROp9eDwY9n7xCFUieEnyq4BXSeavEKTpwqtdf
         Avw0VI5lOqQH2ljixcBnJ0kaJmr8OXWe/HOkXvWZWu/Wsag528J4mA+OKMr6pg2unQnq
         AC7MUt6MbTWYe1Q2Mhosr5v1f83DrYJvMZvF6QUNCaaFyHNazVFzrCbu0OQ9Wu71mLe7
         MT41nNri8Obd0hrRUW0hYEQFhwY7GRccalacKKQGQkIuncukGtOpuTRHaal6rCcLAhUe
         da2w==
X-Gm-Message-State: APjAAAVBtKKhDTuC4YCCK0LzYZbnaOsdW+94a2qjsmwU42aqFWzs8q6z
        6FJE9ZdvmqAZaO1d1tHtSe45PW61HuHxgjDtNunAikte0qebJauvft8Yy60oYymQCHkdgULdA7g
        W6Itsl3hy+WiMLaifwYHInTNp
X-Received: by 2002:a7b:c764:: with SMTP id x4mr10954450wmk.116.1579377781004;
        Sat, 18 Jan 2020 12:03:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDsQSRZgQ6mbHT6GTIa0SMy65kQ4RAJn7N9yOxqTsF/9/ZO5K6Pt7ZnzQpzBr/FAxjD5bo6w==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr10954440wmk.116.1579377780802;
        Sat, 18 Jan 2020 12:03:00 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f1sm15135006wmc.45.2020.01.18.12.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:03:00 -0800 (PST)
Subject: Re: [PATCH v2] kvm/svm: PKU not currently supported
To:     John Allen <john.allen@amd.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, vkuznets@redhat.com
References: <20191219201759.21860-1-john.allen@amd.com>
 <20191219203214.GC6439@linux.intel.com>
 <8a77e3b9-049e-e622-9332-9bebb829bc3d@redhat.com>
 <20191223152102.7wy5fxmxhkpooa7y@mojo.amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2538c462-7eb7-3357-1ce9-ef26ad267812@redhat.com>
Date:   Sat, 18 Jan 2020 21:03:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191223152102.7wy5fxmxhkpooa7y@mojo.amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/19 16:21, John Allen wrote:
> Hey Paolo,
> 
> If you haven't already applied this, would it be too much trouble to add a
> fixes tag? If it's already applied, don't worry about it.
> 
> ...
> Fixes: 0556cbdc2fbc ("x86/pkeys: Don't check if PKRU is zero before writing it")

Done, thanks.

Paolo

