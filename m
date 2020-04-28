Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD797206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mRUxRr09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD1H7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1H7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:59:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2FC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:59:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g74so20852065qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6AzO3J+pJc2HgGzurMjhzn7pGcLIvylFGEP//1RdqLA=;
        b=mRUxRr09nt8M+HiNy/fOSeVowb0w50LzwiLSb+mlfba70s6C8RH7ltYb+XmDeBPIZZ
         8hFkm7CnRlBA6pDXCC5hp7PaaZZXCaL4SXqyP5qYonh6UG7KOA5z3u3Eo3jXNsqQXMah
         e68QtPLfJnv1QoK5ipUHR6eIuZ5w0VzJQKtOoYiiDw3khS06oesid3BlvC9qrxZtayKi
         k+BWK1gi3fryKoTpuNm6heWJNlVgYmZXA2wZ2Qi13ukbTU+ZecLz0xb4ny4LQKFCz/V1
         9cHkkk2OypEH9WiBUAg4+bNH/3huleNNczDrb62eJoNtE5iK5m+yJDAifYRH2h75WCeQ
         Doww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6AzO3J+pJc2HgGzurMjhzn7pGcLIvylFGEP//1RdqLA=;
        b=ZA3x+9mawEsnB1+9z5xmcULUkud4KzMwKYtGT3TRvgeiDI8Q3YWlbOslmrlQ58xR7q
         Tu8CgHs+Ooz+J591TjUbA4JOOj8CebrOSHSnSvbgfw4l7ojK3ln/lBHH75Itxscq1K1Q
         535lyfqidYQLbDm9205WSo4ZYfbLKsixsK7FkAyQzy2VVkIhrJMBD8vAfi4L9Nb/aJmC
         uj7kxlJ6XERbslBocxI67sbg6Qf0B1Te3Lwvfdpxtw5QOn1+5++L6Jcz1r/Cxdw0199g
         E8nQsBfCHajiMNzzylNGYvLm/QujWOAvXTPNORorj0LkRp/mZv/5w1D3xKdT8gsP6FzS
         FtOw==
X-Gm-Message-State: AGi0PuYENDxe1tB/w9DJs1y2wFbK/WSCieOSKw36n9myc4AaOxQWKfLg
        nYDrkdVEk/dMvIW+urzzFWIiGQ==
X-Google-Smtp-Source: APiQypKSbtUAki4jMyaYUh2KGgxnYfeNfc4BrYAM5UBuFk4pjiTNa1JgFDMgpsA+oqsTubpc39F4TQ==
X-Received: by 2002:a37:e306:: with SMTP id y6mr14729735qki.173.1588060781365;
        Tue, 28 Apr 2020 00:59:41 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d4sm12620254qtw.25.2020.04.28.00.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 00:59:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
Date:   Tue, 28 Apr 2020 03:59:39 -0400
Message-Id: <86DB56DA-F2D4-4D79-A609-B427DC3366A8@lca.pw>
References: <018a6f32-5cf6-b38c-7b8c-78b6e5c2d98d@c-s.fr>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
In-Reply-To: <018a6f32-5cf6-b38c-7b8c-78b6e5c2d98d@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 28, 2020, at 2:12 AM, Christophe Leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> Yes but Qian was saying: "Also, it is not very nice to introduce regressio=
ns for robots when testing PAE because they always select CONFIG__EXPERT and=
 CONFIG_DEBUG_VM"
>=20
> Here we see that the said regression is not introduced because they select=
 CONFIG__EXPERT and CONFIG_DEBUG_VM. This is because the robots explicitely s=
elect DEBUG_VM_PGTABLE.

Right, the robot just tried to be helpful, but never figured out this was a m=
inefield.=
