Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27EAC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F4424125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5xILhim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAWLgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:36:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgAWLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579779365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bi8LeW06fZZr3fzsbfcVE+s/pxdz6ITVUp+XN3fIHAk=;
        b=P5xILhimAZn0cbmE6HWWtzJcQPgwMxaBEeol+2R+SNZcYrB2axxYlQKDUqADKbMe/c+V5r
        8Scsl4hXVmNXuI0dGCRiPAnek10hUglLpmh3lslLcfSDzRNpHgk/rdLlulTQsDKSudPPry
        c9tEid6vP1eKGJFAt6pOU3iN09aoRKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-sGwsBWRZPMCWq4rk_QGMjw-1; Thu, 23 Jan 2020 06:36:04 -0500
X-MC-Unique: sGwsBWRZPMCWq4rk_QGMjw-1
Received: by mail-wr1-f71.google.com with SMTP id u12so1565856wrt.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bi8LeW06fZZr3fzsbfcVE+s/pxdz6ITVUp+XN3fIHAk=;
        b=ZlPxjGXGE8N8zGHZG6JwiHn3rKkHQgv/QTU9SQyfT+IOI+ufpDIRetjxDcaePPYyj/
         d9sZ4RfDixbd63xa03mel1hug2+SOLg0ZZCsk6SGV1H5e7T0TfBtfFoeh4Kw5M4dCOK9
         lOalUxnYXbGen/ISDctULQUdxkNOTsgBa8nQee/OTX0u1TFIMdMbhUi997tAm3j4qbuW
         ANln7OTj3ERGEG6wq+eg/acajLOfgMamQ0MUk4wMzz8jCdbzVIVZGpTPOjG24QzwEQPH
         2U7JV1D1ztyfLSVi3Z4Pxrry6iB45m68+9sky1miWKIceDZcof5OmfAvgJWXOt33Ae7+
         Vxkg==
X-Gm-Message-State: APjAAAXqVzViuKdHjbTCdKZkw1+KpqY9kzckvp8o1XJrJaOHD3N6qKty
        9aetWQNLNK44CSCD18OUE79SNwuDbT52L9OvHuoecQfpvfoZt6LSru/r5gT4sg3JhT6tuH81SLn
        omoQLBKG73ihwwmidThxsxF6q
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr18058214wrw.25.1579779363168;
        Thu, 23 Jan 2020 03:36:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoGjn/0V+sdl+z38p2Ox7b5U5YbxLK1TAjEmzDEBF7XjGDA9XuZShzCEpQmSPi7PxX/vu43w==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr18058190wrw.25.1579779362926;
        Thu, 23 Jan 2020 03:36:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id a16sm2684691wrt.37.2020.01.23.03.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 03:36:02 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: x86: reorganize pvclock_gtod_data members
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     mtosatti@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1579702953-24184-1-git-send-email-pbonzini@redhat.com>
 <1579702953-24184-2-git-send-email-pbonzini@redhat.com>
 <87tv4mqug3.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09535a66-d72c-6983-3c10-09d12ed9e632@redhat.com>
Date:   Thu, 23 Jan 2020 12:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87tv4mqug3.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 12:32, Vitaly Kuznetsov wrote:
> Likely a personal preference but the suggested naming is a bit
> confusing: we use 'base_cycles' to keep 'xtime_nsec' and 'offset' to
> keep ... 'base'. Not that I think that 'struct timekeeper' is perfect
> but at least it is documented. Should we maybe just stick to it (and
> name 'struct pvclock_clock' fields accordingly?)
> 

The problem is that xtime_nsec is not nanoseconds, and I'd really not
want to have a worse name just for consistency. :(  I chose
"base_cycles" as an incremental improvement over nsec_base, even though
that meant also changing struct timekeeper's "base" to "offset".

Paolo

