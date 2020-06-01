Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D22BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E8D20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka9tP6NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFAHbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:31:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgFAHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590996667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6G1DaJ08L5P/lyjnG8cNJ/5oUXkDX01HRarXVwG8K34=;
        b=Ka9tP6NKbNlEanIS5BlEPIwxhcfK4fPjlvdjyu8VjKqPNcuq6/Jk4xPLvVxNVTk+H/xifS
        dAE9OtSsQZvieh7OrctpjErFaIw0xw9wr7N/BreJzztnhNFlhZj8eTvOueTG0gPlG1r2Xt
        Tv82OqQJTes7EW1YpeNeUPDOSDjapSI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-_qkO3InCOruLvNHvfwUAKQ-1; Mon, 01 Jun 2020 03:31:05 -0400
X-MC-Unique: _qkO3InCOruLvNHvfwUAKQ-1
Received: by mail-wm1-f71.google.com with SMTP id v23so2349200wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6G1DaJ08L5P/lyjnG8cNJ/5oUXkDX01HRarXVwG8K34=;
        b=ZjBXk3odDoWf4QibyJldhGrvpmvzmm4HHnTBxb8FLbgRcNTcIcI+rFc6sOyBb/datW
         DKUpTLqvQwv0WHP7jVRNipnPeTiLBEzwZ+fpW6Bgy4OT1IVx1VZcOyJza6pszZxAVv6L
         BCNy6xb0djRjhdbkil2bQaKW2vHgzS6f6kqBF8k/oyMqcIbeKvbKV9mh5vbaoZEH7Uv8
         Mit3NzAs8U+gKrSKvkGAFklQZlpWEDOhv5/TolhEL8RqkM78G19TXtKWsdutyi4lqM9M
         SoKj1fX6/YUTfwRMc035R27H29wsBsl7bgAf3Ivl8P66eWqV+/TmXbW0l2rKKyfpc7At
         vLsQ==
X-Gm-Message-State: AOAM530ILjqVvva/8SuUlJz+QyrQDJLw/SA7vi3SgfVnKCWDZHgMhQKD
        6vMeKP7NWy8aNFBdEVqS8gFxpL5+puTwVxKpOS7YgUiUeq4cgP8xs9W/Tt+44kQjVH0yENDQm6j
        gi8Z8fOvTwY8tGiaY6Dqqb6t2
X-Received: by 2002:adf:e588:: with SMTP id l8mr22077538wrm.255.1590996664494;
        Mon, 01 Jun 2020 00:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9CiuurbEGUM+sKXjGsTYbH5kwYWrk7YkA8nOXpNCb3aK4jjTRYLRwZENXDds++uDCWmIvUA==
X-Received: by 2002:adf:e588:: with SMTP id l8mr22075970wrm.255.1590996642714;
        Mon, 01 Jun 2020 00:30:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e044:3d2:1991:920c? ([2001:b07:6468:f312:e044:3d2:1991:920c])
        by smtp.gmail.com with ESMTPSA id m129sm10521268wmf.2.2020.06.01.00.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 00:30:42 -0700 (PDT)
Subject: Re: [PATCH 20/30] KVM: SVM: preserve VGIF across VMCB switch
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529153934.11694-21-pbonzini@redhat.com>
 <db95e255-3f1d-4c19-028c-f23c7737e178@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18f371ca-462b-79c7-edbe-7f8576892ded@redhat.com>
Date:   Mon, 1 Jun 2020 09:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <db95e255-3f1d-4c19-028c-f23c7737e178@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/20 01:11, Krish Sadhukhan wrote:
>>
>> +    svm->vmcb->control.int_ctl             =
>> +        (svm->nested.ctl.int_ctl & ~mask) |
>> +        (svm->nested.hsave->control.int_ctl & mask);
> 
> 
> If this is the very first VMRUN, do we have any int_ctl saved in hsave ?

Yes, copy_vmcb_control_area(hsave, vmcb) is called before
enter_svm_guest_mode (which calls nested_prepare_vmcb_control).

Paolo

