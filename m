Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC43C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3ED20723
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvQtaK7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCMDfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:35:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42834 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCMDfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:35:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id w17so5651091oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9U8lazxGRetsQy6HWnT4z3HZb84M9DeDJBZYGquUHA=;
        b=VvQtaK7OKtdcv0KRvKeMjyrYt8hlIs0Vv5qQmDthPKjy15/K2kxiDlKjmOcjnDOcIQ
         Arp38t5pkvnfhLHd011nBlk0NFRhTjgx9WlVSPdl6p2wwPQCaNY5clM9UxERmPa/GnHM
         dLjMUs2IQ8Txs3QAkJNvS42FEqhuuAubNu73Hv0+N4oldHeUTEaOF7RHPtZLKKvtjyEy
         2OTE9jMgKzSSbDsUtXn9X/WqP/121CzAZihC6t7x0V981y3uiWgVL8yxpxZL6aj4++sz
         t3hsJ6d4CstVJHV69rfRmfc7rqvF9ewNfCIscN5kVhErYC6y8s2efDkpAHNZTxZswWXK
         EG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9U8lazxGRetsQy6HWnT4z3HZb84M9DeDJBZYGquUHA=;
        b=E/ZsHXGGSJr/ctd1ohi/fpgrcBk8zgAs4DnodciY821nwUzt0Mivh/VeybCiy0fWFB
         3UhxscqkxiVEkBXkzkf4HT4PTcBGWu/mDEZE1Dfs/FfD+oR8JxYZ2ghbW/hs7LK0w1Jb
         uzW+PLq9ctRKbuUxM2NbYlEesB2wyy73wjzQlkZZddCipK0+OBP/uJXI1Ls2ZnQfh4ZM
         nPRebehj7y1pzgkJqMXqRbEijB0LcPIrefB7+ZKrfAyMPEh7mRXCx0VHViA4jSjbQKlp
         fQqWHCwZ0n+IemqHPEy5mEfpKM+gdoKHo1jQ26wiqkLSXTcfw1N3N95PxWSow01oWTRD
         KaxA==
X-Gm-Message-State: ANhLgQ32Eu5pHEmUtLcIEOpbzLTECf9tI338vqh+wUdMKaxF/ZjlOdqn
        Hfe4nW+ufzhEJc8C+C0OGbQ=
X-Google-Smtp-Source: ADFU+vu7PRLfbONkr6AgNM7esPfXmysezUGwWouWPhb9//WvPJSpF00Lzuv38/ieLK4bSxa2EB769w==
X-Received: by 2002:aca:c45:: with SMTP id i5mr5037058oiy.111.1584070519356;
        Thu, 12 Mar 2020 20:35:19 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s203sm5817558oib.8.2020.03.12.20.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 20:35:18 -0700 (PDT)
Date:   Thu, 12 Mar 2020 20:35:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ndesaulniers@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Fix missing NULL pmd check in virt_to_kpte()
Message-ID: <20200313033517.GA37606@ubuntu-m2-xlarge-x86>
References: <b1177cdfc6af74a3e277bba5d9e708c4b3315ebe.1583575707.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1177cdfc6af74a3e277bba5d9e708c4b3315ebe.1583575707.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 10:09:15AM +0000, Christophe Leroy wrote:
> Commit 2efc7c085f05 ("powerpc/32: drop get_pteptr()"),
> replaced get_pteptr() by virt_to_kpte(). But virt_to_kpte() lacks a
> NULL pmd check and returns an invalid non NULL pointer when there
> is no page table.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: 2efc7c085f05 ("powerpc/32: drop get_pteptr()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/pgtable.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index b80bfd41828d..b1f1d5339735 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -54,7 +54,9 @@ static inline pmd_t *pmd_ptr_k(unsigned long va)
>  
>  static inline pte_t *virt_to_kpte(unsigned long vaddr)
>  {
> -	return pte_offset_kernel(pmd_ptr_k(vaddr), vaddr);
> +	pmd_t *pmd = pmd_ptr_k(vaddr);
> +
> +	return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
>  }
>  #endif
>  
> -- 
> 2.25.0
> 

With QEMU 4.2.0, I can confirm this fixes the panic:

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
