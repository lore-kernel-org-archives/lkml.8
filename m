Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7853C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9772084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZqdpCA9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:16:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44531 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:16:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id f198so2357940qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQUY3QDPMDTK1rQ8X2lwbSG72/yMK9wgJPmqxVwBErk=;
        b=ZqdpCA9LxxE1FdBB5L90z4u8xd5+i9PbegTQwlFefCRUHZnd70UD/v5WxHspbbXlNb
         m1zhkwzSreZCmdGCIqcmJDXsVoyW2Rymztklpg+dEPvjFg56U53n6mhvN85PpyJUYTBV
         piciPbwADqL171F3KDaMnR1S6TRBZhjqtdmn2Ub0rOvyr4h9+K8hvoCVLcxh727Vx89f
         W5Y61DJbIW6wdhEz8aaKa6ddLlDTFcnW8x/hri+R8XWcl2Mu/qOEn7fFKI2sFAylzFO1
         F9K26YBs+qyLp2K1QPPAre+SsMR7dBhkclTIHPCAMma1lZNd4Pf3ryJYEeVSH5j2n9l/
         Pf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQUY3QDPMDTK1rQ8X2lwbSG72/yMK9wgJPmqxVwBErk=;
        b=rJwqi+niyWNxrPUHr5+Tr6A/4ukWH9crs2GPYrZiGngHlVXGz0dUfnq4pAQPDPytOh
         Qlxxd9LtFu6irRqcHSAC7k11oeG/Dl2x9tgthlz5foCNrWUfcCHDYcpHHS3mnfuoSh4X
         5p8tugVZjK80akEcX1+5wZUiZr1WcJ1NJ2yEsjEZVKMupAsIC44+pVxX9a35dlBSNJ56
         p8wrG5pO1rslDAIrbs0YkdE/2BkQ6gvMR5Sm8GnxngHTLSutFsp/er+ErvavYAY81lKg
         3/tyADbEpn5k2oWaXs9j7B9Bh3dVVngUmpq7l16CeLaGvxlFL36POdRBu5D0vjf99EEW
         0Ajg==
X-Gm-Message-State: ANhLgQ2UXfV2+yvMcpEeO+u4ztHfzU0RenNavlzOo+onvWXdpA6V4see
        H8b6Yp57kMf7gLW4Bjsit03ktQ==
X-Google-Smtp-Source: ADFU+vvkMsxohXrfARQj0UcaqMypxNcqS4qcoA2Uy1vzO/CcdN1RB9ht/HOZED17BkE+AVVtDmcZXA==
X-Received: by 2002:a37:546:: with SMTP id 67mr2997085qkf.272.1583504182122;
        Fri, 06 Mar 2020 06:16:22 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o129sm2142898qke.109.2020.03.06.06.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:16:21 -0800 (PST)
Message-ID: <1583504179.7365.158.camel@lca.pw>
Subject: Re: [PATCH -next] x86/mm/pat: mark an intentional data race
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        elver@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Mar 2020 09:16:19 -0500
In-Reply-To: <1581343816-6490-1-git-send-email-cai@lca.pw>
References: <1581343816-6490-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 09:10 -0500, Qian Cai wrote:
> cpa_4k_install could be accessed concurrently as noticed by KCSAN,
> 
> read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
> __kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
> kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> 
> write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
> __kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
> kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> 
> Both accesses are due to the same "cpa_4k_install++" in
> cpa_inc_4k_install. A data race here could be potentially undesirable:
> depending on compiler optimizations or how x86 executes a non-LOCK'd
> increment, it may lose increments, corrupt the counter, etc. Since this
> counter only seems to be used for printing some stats, this data race
> itself is unlikely to cause harm to the system though. Thus, mark this
> intentional data race using the data_race() marco.

Borislav or any other maintainers, can you take a look at this patch when you
had a chance?

> 
> Suggested-by: Macro Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index c4aedd00c1ba..ea0b6df950ee 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
>  
>  static inline void cpa_inc_4k_install(void)
>  {
> -	cpa_4k_install++;
> +	data_race(cpa_4k_install++);
>  }
>  
>  static inline void cpa_inc_lp_sameprot(int level)
