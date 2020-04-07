Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9D92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4cjimTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgDGP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:28:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728306AbgDGP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586273290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDEKpry8Wl4olxgiLDrUYCTGcUfE5/0dkfqVTqUlkAw=;
        b=J4cjimTnFlUrYAtbXxYnBh2zZD1rlAKEQCRX2/QQPMcT7KCdh2jvrtHviJT31LvJ94BFz3
        8Q5j+3UdkOoklUzBVBIqrqGZ+NkxsfFJC4kuaMI01NH08Gu8zErxIWp9Mv2zRXexiKS5H9
        tdOhzgWI3bxkt2KKHBbRzZaPJ0IK/ng=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-kBakWZR7MtK_xwbaQz67mA-1; Tue, 07 Apr 2020 11:28:08 -0400
X-MC-Unique: kBakWZR7MtK_xwbaQz67mA-1
Received: by mail-wr1-f70.google.com with SMTP id t25so2125463wrb.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDEKpry8Wl4olxgiLDrUYCTGcUfE5/0dkfqVTqUlkAw=;
        b=snHWRybIQvH0PX9VnnFjl5VdG0qeQ0KwoWW9vUfTkkh/r/+1q21lfhGpBvJKWEm3jg
         eeWgp9Yk4vasWy9QQ8+IuTYNm0ithnl+4cNMrWxE5uh9bBvB3PtpcapxJhnRdZxngq3S
         4xWbqjkM5PGgCN+HjrxA3Bmb7LmYW8bYF9wzeLaP74HdNSXH6T6RUVm57JeorbuA0Gxm
         CXo4fmcobAi50fZ5qYMDbzKzU/wW2Do5nd440LanBT4QEQtmlg8HmoG/4zVOq5TO2ab+
         QA6NIGAmi1DMppskA/kdDQrJ/39as3K8lMjqZgsLSeSLEfxtONESVgqpD1hACZuk5IYe
         PbRA==
X-Gm-Message-State: AGi0PuaJJoXZLR2d9nH9AHsGgRNU6C3ivsfRC2cZmaawosAjnMpWBAq9
        RHC+2TMxt+mlDrDXpLYJdz2Uzj14cnLDIfuuVhBZPSf61jfojqFi1lYmDChpi65qQdmGEwAa270
        NCUAOfGfjen9RtZDHUQxwwDtV
X-Received: by 2002:adf:fa04:: with SMTP id m4mr1881633wrr.30.1586273286800;
        Tue, 07 Apr 2020 08:28:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypIh9D+su8gezcQUaGFFTXfGyJIYfOS0FiQ9d6+kwjeD6R+ccU6LNlmSe6dOV1WJjsqAiz36vg==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr1881607wrr.30.1586273286535;
        Tue, 07 Apr 2020 08:28:06 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id x8sm5037367wrn.27.2020.04.07.08.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 08:28:05 -0700 (PDT)
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org> <20200407143543.GB876345@kroah.com>
 <20200407152412.GE20730@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92c36ea2-98c3-9320-0618-aa225d2fbc9e@redhat.com>
Date:   Tue, 7 Apr 2020 17:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407152412.GE20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/20 17:24, Peter Zijlstra wrote:
> The thing I worry about is them lying about "intree", is there anything
> that avoids that?

In QEMU we generate a random-ish number on every build (actually an SHA
of the version and a bunch of other things) and include that in the
modules as the "in tree" marker.

Paolo

