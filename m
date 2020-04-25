Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8FDC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFFC20706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPryU7wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDYHsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:48:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587800901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lm7UGNtVQ/9rx+IjjaysXcfjKjoPvyljZwJ/cj3g/k=;
        b=TPryU7wXl2P0dJ/R0hncCA6tA2B6q81YRskYjkIRuMHrUnZlcy3ne46v/81uS2CZZeHjrD
        5IprFxxcD0waIiVsHAP0KR9P+jNOKMSSvMkTp/ORBaLu1aJ96liKXSOtCz0UqRGJfiZvcY
        l0qKVbonznmzFVTsBdD1bD0X0pxG3GI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-5Re18leTPV2NoPRsXpieNw-1; Sat, 25 Apr 2020 03:48:20 -0400
X-MC-Unique: 5Re18leTPV2NoPRsXpieNw-1
Received: by mail-wr1-f70.google.com with SMTP id v9so6315407wrt.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 00:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+lm7UGNtVQ/9rx+IjjaysXcfjKjoPvyljZwJ/cj3g/k=;
        b=OQh67jYl6I6V2UsWXVKHI45823SF2ogx4UFNcrmC8C5fj8ckOCgMYUXMI3GyQ6dQ1f
         RQ2uacaR2WIDYbGOC4GV3caTdIrDVv1i6VE3Sc+fw86hUuhsmsJcz06Fk+mcFycid1mK
         3vHjVqdGXwj+LIVoKdf7b/CVDYynmGY6GhZ8CKAdEO6FhjLZ9jvreuFeBNO/LGrgOfnQ
         DQ+CUMb/VL1b4C9v+SCUVeyElYUjFmdHyzbrDuxkakPV0LHqTPu+37BGGnntowMkQ0Nq
         FN+CDZF3TkTdm1ZAkWEVypSIoQ1EVolMPIm+dRnmimZ9I66DZF4+IZc/kJKkLMoTmstp
         E8fQ==
X-Gm-Message-State: AGi0PuZzD7QOfJz10NgA48lAo6EhmZnHEYV9rT3WxdZcwhGRWo0T4xM4
        0mt/oqLiLwMYDTqqv/FYZRz2zRR5ouwaK1E3Xi85SwQVOTnaod5NbHl6VlDK5RGb6fVPjEPbsrO
        rOmRi3kqjNFkmb4X65wXnU6KO
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr14403663wml.84.1587800898699;
        Sat, 25 Apr 2020 00:48:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2racS5mj+0NM5MCd6RBG4jVkFYQMJgRtKqSAC7ooMySFxgT5VZf7gBc7p5o54fJ5wHWSrgg==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr14403646wml.84.1587800898515;
        Sat, 25 Apr 2020 00:48:18 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id a10sm755359wrg.32.2020.04.25.00.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 00:48:17 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] kvm: x86: Rename KVM_DEBUGREG_RELOAD to
 KVM_DEBUGREG_NEED_RELOAD
To:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        Nadav Amit <namit@cs.technion.ac.il>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200416101509.73526-1-xiaoyao.li@intel.com>
 <20200416101509.73526-2-xiaoyao.li@intel.com>
 <20200423190941.GN17824@linux.intel.com> <20200424202103.GA48376@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1c0ba71-1c5b-a5b7-3123-7ab36a5c5c74@redhat.com>
Date:   Sat, 25 Apr 2020 09:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424202103.GA48376@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 22:21, Peter Xu wrote:
> But then shouldn't DIRTY be set as long as KVM_DEBUGREG_BP_ENABLED is set every
> time before vmenter?  Then it'll somehow go back to switch_db_regs, iiuc...
> 
> IIUC RELOAD actually wants to say "reload only for this iteration", that's why
> it's cleared after each reload.  So maybe...  RELOAD_ONCE?
> 
> (Btw, do we have debug regs tests somewhere no matter inside guest or with
>  KVM_SET_GUEST_DEBUG?)

What about KVM_DEBUGREG_EFF_DB_DIRTY?

We have them in kvm-unit-tests for debug regs inside the guest, but no
selftests covering KVM_SET_GUEST_DEBUG.

Paolo

