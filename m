Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D4BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B10320720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNK+SaOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGHU26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:28:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20262 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgGHU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594240136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKlR3ZjSGkU94hKtcspH+LSF41vCI5eSTGDezrwB8ao=;
        b=MNK+SaOC30eAULtpDFpBdLFgVQQHkfFwzwUwaMifWg5GTvFF7BlIr6nXi4HXGnPR1EejzI
        IMP/zAoMa4La/7C5MCbEy7lLEKsRrukMpU4mUKPDD7jZVXm4bCvTDohnflNaAcpTxkSkSa
        9mxI949fNhGZAObRuOyAihkzDlz49D8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-OEupbzAyMeaeVqG6FdlxIw-1; Wed, 08 Jul 2020 16:28:54 -0400
X-MC-Unique: OEupbzAyMeaeVqG6FdlxIw-1
Received: by mail-wm1-f71.google.com with SMTP id l5so123136wml.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 13:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tKlR3ZjSGkU94hKtcspH+LSF41vCI5eSTGDezrwB8ao=;
        b=X8nZkXbNPCInbxADos41TDl52MYlrROTvVcJhLqkdhPyf84EcTaS2T9xUdWJOcxPSa
         WYRSnTqTJptaIV1vmuoWLp4xexjVcbFYYIbAfhzCbhaHepwcJ+xaddMCuvQB5227ES4d
         zwhyughQq+JPdw5sGF7rOxpywhACwwrBOh+MqNrPvzNpJKf3r/dAf4JCjz+d7tTUW3JZ
         QH8swmQMD6rpVQBNCGrTFAIlCiAbHjU5w3kspD1RxlmoIqteildPk2FMjBHoQrWm/BQw
         KIFPbH99hVbiYJlq/UOfJ+6FYSocMChBg5jXlGzbV380VV6g+UnCNzgsUMH8XxzgX8ea
         5slA==
X-Gm-Message-State: AOAM531KFolwr3FU8oeFIp5rr3WRAZU3ebv2/swTacK64+NlUjyRZyvq
        +WcEERU7C0VzCbdfbUlUB4TsuyIcOh6MNZbS2xtM4S3jxivGgLT1gtWOMkBsLZW3Fp0UvdyRiGN
        XshmVszNXzoH5bkPbEJDWMj4i
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr29803843wrx.346.1594240133652;
        Wed, 08 Jul 2020 13:28:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymxGVgiM5r72XA6vzEjzcO7z2KzQpDxACkB5nl5lRy9YvNMCQdsG72gOmEThXjiJuxHh5pBw==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr29803834wrx.346.1594240133412;
        Wed, 08 Jul 2020 13:28:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ef:39d9:1ecb:6054? ([2001:b07:6468:f312:ef:39d9:1ecb:6054])
        by smtp.gmail.com with ESMTPSA id v3sm1664758wrq.57.2020.07.08.13.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:28:52 -0700 (PDT)
Subject: Re: [patch V2 0/7] x86/kvm: RCU/context tracking and instrumentation
 protections
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, kvm@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
References: <20200708195153.746357686@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b17c3ed-e53c-2e20-2880-882fdc84f622@redhat.com>
Date:   Wed, 8 Jul 2020 22:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708195153.746357686@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 21:51, Thomas Gleixner wrote:
> Folks,
> 
> this is a rebased and adopted version of the original series which is
> available here:
> 
>      https://lore.kernel.org/r/20200519203128.773151484@linutronix.de
>  
> It deals with the RCU and context tracking state and the protection against
> instrumentation in sensitive places:
> 
>   - Placing the guest_enter/exit() calls at the correct place
> 
>   - Moving the sensitive VMENTER/EXIT code into the non-instrumentable code
>     section.
> 
>   - Fixup the tracing code to comply with the non-instrumentation rules
> 
>   - Use native functions to access CR2 and the GS base MSR in the critical
>     code pathes to prevent them from being instrumented.
> 
> Thanks,
> 
> 	tglx
> 

Queued, thanks.

Paolo

