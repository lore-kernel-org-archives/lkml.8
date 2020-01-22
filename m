Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62680C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEC924655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aONuVGeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAVAeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:34:08 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37002 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAVAeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:34:08 -0500
Received: by mail-qk1-f182.google.com with SMTP id 21so4776951qky.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=MZXkoAafU5iZQTDaAYrDQk16B2pUQbMjULNwikPL/ow=;
        b=aONuVGeMINjLXyWat8lmCId+oFVaq1+hWp99kPXJWJd/ocEc5Bsb6/SCDvGnigsZc2
         wD7Tmw5dRHc4kTaV6qdsbfvMK7MPpluX50pH9FL3tnNQntHl+7AR6Ou+tm4S7ZL4t6sP
         S+ArZbSbdbE0VPlpvx35oOPc5Fo4v1xAbjVU4nI6SOmcO+5Qlq3PN6II7kuX4jhY6vvp
         9YmMHN3kJR42RCjdcXDKEgNIlRvdF1S/+R6ye6Lwl1+Yq0AXaRh6VqHRSeShJGXtQtyS
         xxFB2MNAkk6XX9NIq7MGrIyKq5lzOn2r/O8pI69PsGojTL+ol80PiiieNLDn8fD0XkzK
         wbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=MZXkoAafU5iZQTDaAYrDQk16B2pUQbMjULNwikPL/ow=;
        b=TYUf6mAafbxfz9pcSgCYsmR7SioSIOigoznVTzY97MSaTzYDwwSpOVg2UsKJYKkX/d
         KbqkGnQR0+nLmfi3LnbVL4LeIlKNeIh0HodQhx1uWXFLtUy6FStoEJE2fMqijNU8gSd7
         MKCCivFTsNdsh+N6qbLizD/ul54IMSGZMtnwDqnEGj0lgBHjfyfZ4sPhQjsj7kKgtQ2W
         0t6YPo9xeLXQXT4d8QYUkAiwvBNMDkEIPbRiCMSt4M4BqcAoNtow6vFIu3H83GPGvRG0
         HZ+hLsTlhB+gzaqjPIpWUYWIpQfO/c40afPdhYLYqmc7f/v75IDq1CdWlxjx6N3obpWx
         UyKQ==
X-Gm-Message-State: APjAAAXvS7N+yLPs730Jqhpv8yhqPjJv9HlYhd6cLJupOpiMNblLqF15
        oj0SieJhCAWdtAHDcj7Kr2znXio2eA0sJw==
X-Google-Smtp-Source: APXvYqynKjBRrSDRWHVuKPbV7GPn8A6vIego0zpwqyo352s+otfGg92EbvIt7IfZWoFH75xHK128Ug==
X-Received: by 2002:a05:620a:101b:: with SMTP id z27mr7032552qkj.241.1579653245534;
        Tue, 21 Jan 2020 16:34:05 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l184sm18248573qkc.107.2020.01.21.16.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 16:34:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Date:   Tue, 21 Jan 2020 19:34:03 -0500
Message-Id: <D88FC26A-562F-42BD-8615-FFA8B0A3D4F7@lca.pw>
References: <20200121221814.GQ7808@zn.tnic>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200121221814.GQ7808@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 5:18 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> Btw, looking at the other "inc" CPA statistics functions there, does it
> mean that for KCSAN they all need to be annotated now too?

I don=E2=80=99t know. KCSAN never trigger any warnings for other CPA places y=
et.=
