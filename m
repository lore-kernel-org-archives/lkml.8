Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F7DC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E364C207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="B5xvv8pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAVEZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:25:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38565 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVEZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:25:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so2793482pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p46K/p7jyUoEmoJcNjNXBHco0qcUxklws/5FMtIPmj4=;
        b=B5xvv8puH6bKb5FnJqYIuZj2YH76W1Qv5xBhn+QqL0Mpye8LTbYUpvMp7erkb9Fqrh
         C06ZdxbYE2N2TIUm7vug4Tq7Mjzu8unyuDtDZzHCgjh5/MMCMcqK5B413/PDc8DoEeSK
         RuW68Mt8V7aVC9CAGFxRRzYrxiLmdM02HTK8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p46K/p7jyUoEmoJcNjNXBHco0qcUxklws/5FMtIPmj4=;
        b=O9HFwJCR3JBL1zVf31GUCngSUdJo/vY62NCIGtq34KhvW2hxIe50wwnDDlvup/i4b2
         J/Nao6gb5JQKBgxuTVmmHqTvYCY+Yn8JgdnIFUXFFOcAGO21Pf+FHWw5olI/IjkIWzg1
         XXCtIngUVVlGCEs9Rt/xr68Xhy80+1OByH8AXl7ib5nFSTAJgIDianEZ+G+MdXuEjheI
         XT1YEJLpOZlgUt+AtJ4AMYzrrUVOYq1WU8c4dnKNn8CG5o/ZTo+7zh2l5S0N565tHkgM
         iQ39GIniLbEDPRhWEbfHmxrjMuSyt5z62ftiZpcox5TWTDBKKUVynoXuCUm3cARflmZK
         18aA==
X-Gm-Message-State: APjAAAUDRKQBfJ4rZwr7AOcKc+brAFwYQVJs8K6d6SJ07wuGzbZ5804I
        Uu7IBvnY0qH6VgrjDB8cs3tDNg==
X-Google-Smtp-Source: APXvYqwSAhz6EmTD4AjqpgZAR1Z7cqCItOlpDxGIvjZDC0pBDNWWXj5pVrAKXL1pHjqPtwPDRvnYrQ==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr9022713plo.43.1579667141754;
        Tue, 21 Jan 2020 20:25:41 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-cc3a-f29a-38f6-dc23.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:cc3a:f29a:38f6:dc23])
        by smtp.gmail.com with ESMTPSA id d24sm45845707pfq.75.2020.01.21.20.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 20:25:40 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: Re: [PATCH v5 0/4] KASAN for powerpc64 radix
In-Reply-To: <8a1b7f4b-de14-90fe-2efa-789882d28702@c-s.fr>
References: <20200109070811.31169-1-dja@axtens.net> <8a1b7f4b-de14-90fe-2efa-789882d28702@c-s.fr>
Date:   Wed, 22 Jan 2020 15:25:37 +1100
Message-ID: <87muagjewu.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 09/01/2020 =C3=A0 08:08, Daniel Axtens a =C3=A9crit=C2=A0:
>> Building on the work of Christophe, Aneesh and Balbir, I've ported
>> KASAN to 64-bit Book3S kernels running on the Radix MMU.
>>=20
>> This provides full inline instrumentation on radix, but does require
>> that you be able to specify the amount of physically contiguous memory
>> on the system at compile time. More details in patch 4.
>
> This might be a stupid idea as I don't know ppc64 much. IIUC, PPC64=20
> kernel can be relocated, there is no requirement to have it at address=20
> 0. Therefore, would it be possible to put the KASAN shadow mem at the=20
> begining of the physical memory, instead of putting it at the end ?
> That way, you wouldn't need to know the amount of memory at compile time=
=20
> because KASAN shadow mem would always be at address 0.

Good question! I've had a look. Bearing in mind that I'm not an expert
in ppc64 early load, I think it would be possible, but a large chunk of
work.

One challenge is that - as I understand it - the early relocation code
in head_64.S currently allows the kernel to either:
 - run at the address it's loaded at by kexec/the bootloader, or
 - relocate the kernel to 0

As far as I can tell book3s 64bit doesn't have code to arbitrarily
relocate the kernel.

It's possible I'm wrong about this, in which case I'm happy to reasses!

If I'm right, I think we'd want to implement KASLR for book3s first,
along the lines of how book3e does it. That would allow the kernel to be
put at an arbitrary location at runtime. We could then leverage that.

Another challenge is that some of the interrupt vectors are not easy to
relocate, so we'd have to work around that. That's probably not too big
an issue and we'd pick that up in KASLR implementation.

So I think this is something we could come back to once we have KASLR.

Regards,
Daniel

>
> Christophe
