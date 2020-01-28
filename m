Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0881EC35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE79824681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dX5ri6JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgA1GhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:37:00 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40183 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgA1Gg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:36:59 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so5752623qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 22:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0abVuQRiEoEWLaCFKSSRqYpNWOPktE+d1wvOzU3Y5QQ=;
        b=dX5ri6JWeqf2OD9HUY9VaB/KwNs/qrzPVG/Mkk6o9PIOqw2H/gbYXWgmg5n/T9sQZi
         Iu9x9L3POLnl1YchVinwocuu9ounpYF8/kx5Kl6xkZvkINd+J3VgmAAsMM4XdNmOQpGF
         n/A6miYs2pl1z68bmOVHF16tPK0qb+EWBTpkY/wDARN4JMfLDfXWnSNw6qljowznZeLw
         nC2mDCu/xZdzLMzffrfLowRJu9L4pvo4bnAdA6EAug7bCreb8yqSCB9NBnvi8MDOIkJC
         NhZM5PfIKH0yrTiGcHzwETXhAcZRM4FxAKgtCYb9TW9qoZDA0+sfnlblbnN56jONvpa4
         1ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0abVuQRiEoEWLaCFKSSRqYpNWOPktE+d1wvOzU3Y5QQ=;
        b=fg1SG2PS7lIzKMBh4DaC6b2ZwegZp3ta+bJnBhH4a7nxeyHvPrH7CEyMdBKafQyS6Q
         ssPAB4kRrAJI8m+xFAtqJAMsr8whN8OYnVJWgdLdYp1Sq35sn9c4rGI0iJnc47egy5iN
         8N0ZjsEbU12vmH8Cig4WdPDh+Vbub7Um0lk+2PT/p2exkSIcHzXXmU347JsK6Qrzqvsz
         pkFup2/pWi+KY+Kgfe+7XIxlUVe0PiNVrlpiBtrZtqLHmd0u+xzojwVF4uoTHnRC2sop
         0KH06yidSiegTKvS+Z7bMrdbD//CJtu0qB6AO8LKl3PLpd7NVZDvbnwIQc17z904/TXG
         RKBA==
X-Gm-Message-State: APjAAAVpZPLFdi3w1EeHTweOTVxZOPoP/ySMhaw2Yb4FL4oSAUZq4npT
        YbH2FoGjLTNWAeEC7jzaGZUtkA==
X-Google-Smtp-Source: APXvYqyOYFD97tfKGnmPwPmfp2w3pbVQzr1Mc0RjmsOaGaxOYR1oH4beASJJ2LsvEzXBpFE4wXV4hg==
X-Received: by 2002:a05:6214:1189:: with SMTP id t9mr20389607qvv.153.1580193418367;
        Mon, 27 Jan 2020 22:36:58 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z126sm11703882qka.34.2020.01.27.22.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 22:36:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Date:   Tue, 28 Jan 2020 01:36:56 -0500
Message-Id: <F90DA0AA-4D27-4346-8D8D-D9A7871E2C07@lca.pw>
References: <115c187b-73ce-30b2-0694-999db1f2183b@c-s.fr>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <115c187b-73ce-30b2-0694-999db1f2183b@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 1:17 AM, Christophe Leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> It is 'default y' so there is no much risk that it is forgotten, at least a=
ll test suites run with 'allyes_defconfig' will trigger the test, so I think=
 it is really a good feature.

This thing depends on DEBUG_VM which I don=E2=80=99t see it is selected by a=
ny defconfig. Am I missing anything?=
