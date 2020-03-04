Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7245C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05EE21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qUya1I+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgCDL30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:29:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43796 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:29:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id q18so1161584qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Jx+iSwpjH1MMUgtvqiqrwQ2sYugCQ9UmLyXay35eB1Q=;
        b=qUya1I+ID7bIC0Bkj4Q0zp0EdHdSdO6ykJWvMXw4HKDFjWyXV8ds3Bs9MArm+vdQdc
         RpunjqglWR6mGJe2Lv7g9advYS1SvRo9LA3gCW5QqI/AMIgsHiHRUFAsdYeij2rtzyTk
         sNSh4wHESGW+6lSzw7OKW4psbfNeqxjoimBZufpM/BoHmrYBRoQNs3Xc2GtPgWnsfXPf
         igl3aC/5VPWbzpP3KfCNQ0wpC8Mh4VlwHq19u+9gw6f3Ulw8FCMZG8YCqNbscon2aj4Z
         WYfZ5PGzedI3tG7vyVtTX+unDExTi5VMHoWYOeG+xlDzhECpmkCqkM7aufo6LUVMsIwj
         NApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Jx+iSwpjH1MMUgtvqiqrwQ2sYugCQ9UmLyXay35eB1Q=;
        b=qRt2WmcNZxfcRzZAjOLC4RoBCghWq6AN1BRNLACAQVWXMuhg2EcPp5XK7NOcXGNyT0
         jNzaKff9PAiVuRyJFO4EJ3O3EHe+0LMV/YPEK1oBb+k03i+3b9me3+Yaum1hlMPUVTzY
         TTa+VPkBIcOs2m9/F3o9/ucm4hR3D3omNszRS+LqoDY85djl8PuzqoNp7QiDWhuK4JVm
         hnLaj5ChF4+fTz0bZ9gUVvKQE7R9WfVBWoidJI+hWHvPA2LoAE7VPN7aG3Chvp/ICUCg
         gDT+IXDSYzkOgnmS5G9HcTyN/JxUx4oyMhzoCA/IjnS7EWtui/sCl0k2JH6yIkI68bx1
         9N6Q==
X-Gm-Message-State: ANhLgQ2qdVLw4RPfV3P8hd6urvxp381yz8kXssXHflfJitFLWRfGUbp9
        uFrOHKLiNg9O9qnIn6xLQSiQQA==
X-Google-Smtp-Source: ADFU+vsraAELUldtqJkt+JLHLEkp9XWZWryntOEccYsrwg70reKk2W+439zfYVSLClVswo3lxz5LLw==
X-Received: by 2002:a37:6115:: with SMTP id v21mr2464683qkb.105.1583321365177;
        Wed, 04 Mar 2020 03:29:25 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u48sm85943qtc.79.2020.03.04.03.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:29:24 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page table helpers
Date:   Wed, 4 Mar 2020 06:29:23 -0500
Message-Id: <11F41980-97CF-411F-8120-41287DC1A382@lca.pw>
References: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2020, at 1:49 AM, Christophe Leroy <christophe.leroy@c-s.fr> wro=
te:
>=20
> AFAIU, you are not taking an interrupt here. You are stuck in the pte_upda=
te(), most likely due to nested locks. Try with LOCKDEP ?

Not exactly sure what did you mean here, but the kernel has all lockdep enab=
led and did not flag anything here.=
