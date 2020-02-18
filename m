Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15EDC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C5324655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="XZenJzgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBRXL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:11:56 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:37214 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBRXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:11:55 -0500
Received: by mail-pg1-f182.google.com with SMTP id z12so11720818pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 15:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DXk+4RCbn43nqyIHGgTQFY5EAVuHQEITLuF0Eerk39Q=;
        b=XZenJzgMpinXndb3Ft4G15TfderKPHgDYRxpubwasNQLkZB+Ej7R/UFEF15vdnY9y4
         knD7v9XCGz7RiZzDop4DPV2KOyHwLl2olZtj5k4OEp1FCOpvdxk+9um/fK5aCrlgg4I3
         PG+3JJr57m6oGVFFXkqnu4GTFYrTXok91wMb4hIhi09OIE0d9E/anDmZJbts186Pr0BI
         QIcVz41u97YuL94xKs5o8oQv22Ne16wb56FisvA82LkFUCqlZha+3goWyrX9J/hCRZ/z
         v0vLEiTg3Lnd7R67bGrnQ7TeA7ONNqzDUmWutK39lOikG9jz2SwbcC6tvZeIduhnNlZq
         B8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DXk+4RCbn43nqyIHGgTQFY5EAVuHQEITLuF0Eerk39Q=;
        b=hCf9y0qv/yho/r1P/Mg0dTjy/7BGTEjWndT9s3pNbBjfc3MydBk6nNYaHuRgjqgkJv
         qPN41kILmYL8PpgWnnPs+uBIi5igE7K3AnlRrG567QhXyVGrCvfdWdWD9bt5Wjvsa7Gz
         +vxoILYCQ0x0fEh/9Zb8juf/SZCp7lnoiyDW5ymvw8jaP5xk46m6D4FHlyXFT3ChA1hw
         Q4vGZdzHarBaVBsYo7snR4GprPAOxEZqaEZX8mANGItaebqsRn25O8efl0Pw9c8PG05l
         XISCsertXxrfdeRpPPUsuCXjGLWru4qhWAl8RqglGbJYbMsqOjaGZE4R4Jx4M8h6s7WP
         le3w==
X-Gm-Message-State: APjAAAWIRAKZfg1Wy11hliZbVnWFPrROcZqxT0FN2FmqE75sugXRKpXG
        rs3WQleiGpBRfBXBBXs7/61+0w==
X-Google-Smtp-Source: APXvYqxAvYc6wOp++1fA29CqVZ4pX8ZcQgO5sfXyrjNUJqM3cKhZrGBDX4l7ssoxrYcvkA1KbymPQQ==
X-Received: by 2002:aa7:968c:: with SMTP id f12mr23710431pfk.235.1582067515244;
        Tue, 18 Feb 2020 15:11:55 -0800 (PST)
Received: from [10.234.160.59] (58.sub-97-41-129.myvzw.com. [97.41.129.58])
        by smtp.gmail.com with ESMTPSA id p17sm76321pfn.31.2020.02.18.15.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 15:11:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] #MC mess
Date:   Tue, 18 Feb 2020 15:10:17 -0800
Message-Id: <3CF4895A-5BCF-4E5C-B8D9-F9019DD02A12@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 18, 2020, at 10:20 AM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> Anything else I'm missing? It is likely...
>=20
> +    hw_breakpoint_disable();
> +    static_key_disable(&__tracepoint_read_msr.key);
> +    tracing_off();
> +
>    ist_enter(regs);
>=20
> How about some code to turn all those back on for a recoverable (where we a=
ctually recovered) #MC?
>=20
>=20


At the very least, in the user_mode(regs) case, tracing is fine.=
