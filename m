Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4329EC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B532084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG0Wi7LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAMIHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:07:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728682AbgAMIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578902872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/erZ8RnYKJRFY+c1GhVERMG1XNVgTxXo2w1hrK27Sb8=;
        b=RG0Wi7LXMbHj7Ex9SwF8FPhXKYwM7Dh8Ssy9aSU0pv1nt6CVLHtz6bFtEz9mZO5TblqtX+
        LsODUHyc0gKIUvby7awqIcd4jzVDc6J9hQ+x/SQZMluYgawD/NgIWhD1HcTYvBzFU7yB8z
        8yxYh0vdXa+z7U/elJi1ByQVWPuAAQE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-ftrnvkduPZq4PTnTyEwokg-1; Mon, 13 Jan 2020 03:07:48 -0500
X-MC-Unique: ftrnvkduPZq4PTnTyEwokg-1
Received: by mail-wr1-f72.google.com with SMTP id u18so4629196wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/erZ8RnYKJRFY+c1GhVERMG1XNVgTxXo2w1hrK27Sb8=;
        b=kcYPUEbBvVQ7Sj5IylNot44NIO/s2Wm3RVTHTc0kDIOIhmamlcS96sSc3jvDDzyo87
         iQlPcP/wR2Re0gPNefbCZPDwBl/XU9MA4mqXsgwQHc/QwwqmphqdzgoiatQpXk5STJGk
         P/PtruNKuHDLSusRNJ+6oNBRW7pHG0Hm1LQRRv9N0oHGNEmAJcWjYUK/hBxpKEHxmvTL
         751Ocow5/wO91wcFfFLzmdh9pn0ABdmwz5rUkvw0lJNkAKBWSQ/2YEJq5RnznGm7NPXz
         Gyn2o9D478CAsc8rcWxDRsxThfq2wFb3O73eb8umf6vr9bzCq8If1gln4kQcz/Eu7sSQ
         v44g==
X-Gm-Message-State: APjAAAXao6GtaQGA/lolLhLYvfxsqAxSkXWwcnYmBHqpVMlGDNHItdef
        Zl6Hb1adln88RlO/SHcJF5TWMVYTVgf7a0TY9hVTrW6nc6a7yR41NdWGXACFgzhSayH3I12KGpK
        JBHt7Vw4PcQ8B7EXJj8nDQGrf
X-Received: by 2002:a5d:6748:: with SMTP id l8mr1396184wrw.188.1578902867670;
        Mon, 13 Jan 2020 00:07:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0QAjNUB/O8hGuT0Ik18PvHdQ1W7LOxSNRFjlfRDriRbr61B/AAKzt1NZh7J71GOTzCEVtdA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr1396158wrw.188.1578902867410;
        Mon, 13 Jan 2020 00:07:47 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u7sm13323951wmj.3.2020.01.13.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:07:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Chen Zhou <chenzhou10@huawei.com>
Cc:     "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenzhou10\@huawei.com" <chenzhou10@huawei.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: remove unnecessary conversions to bool
In-Reply-To: <MW2PR2101MB1052B01B542F0C0A576928CBD73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200110072047.85398-1-chenzhou10@huawei.com> <875zhjr074.fsf@vitty.brq.redhat.com> <MW2PR2101MB1052B01B542F0C0A576928CBD73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Mon, 13 Jan 2020 09:07:45 +0100
Message-ID: <87tv4zpyni.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 10, 2020 4:00 AM
>> 
>> 
>> I'd suggest we get rid of bool functions completely instead, something
>> like (untested):
>
> Just curious:  Why prefer returning a u16 instead of a bool?  To avoid
> having to test 'ret' for zero in the return statements, or is there some
> broader reason?

Basically to preserve hypercall failure code and not hide it under 'false'.

>> -				     ipi_arg.cpu_mask);
>> -	return ((ret == 0) ? true : false);
>> +	return (u16)hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
>> +					   ipi_arg.cpu_mask);
>
> The cast to u16 seems a bit dangerous. The hypercall status code is indeed
> returned in the low 16 bits of the hypercall result value, so it works, and
> maybe that is why you suggested u16 as the function return value.  But it
> is a non-obvious assumption.  

This is not obvious, I agree, and we can create a wrapper for it but we
more or less must convert it to 'u16': uppper bits don't indicate a
failure (e.g. 'reps complete').

-- 
Vitaly

