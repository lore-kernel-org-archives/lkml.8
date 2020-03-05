Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F015C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0789C20728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ULgqtRG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEVPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:15:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39407 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCEVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:15:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id l7so3368689pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9+1EhWPpss4QhNZrOlX7kurqpoCphQTt/H2TjuPYl1Q=;
        b=ULgqtRG/k56Nm9/C+oQS1iM+7iougmuOf6uGVDm8ZKNfCMzHQlgvfah02EoKzwxfZx
         RqnZqhrww3Wb90uOhyw3TlUOgkDEFh51Qrqn1Zf0bobDidGXMWwvmjiWeC+njkQJOf7N
         w3wcqQ6mFFpQo0ZGB+6TVzKIzUoE9EbdWNAhoby1aFj/wCLyYxl/Gzbp9+W6bZdMJGJX
         mUGz1RqHvD+4eKfCAeGLCWM4iSa1A+xHawoR1E6heG0FipTKWerUfeTCQmLIYQ4xMDtZ
         HYne9SBwz7D+ZXLeWk8VPb5XjTq5t+J0zFza7lvEvBno5kLtj8PwYVrkyXukD3Puj5Aq
         MeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9+1EhWPpss4QhNZrOlX7kurqpoCphQTt/H2TjuPYl1Q=;
        b=uYDiQjtRqAXJ4Qky9w49lm+ilmVlSSK2XNgs6la3P53WcPVKqOZxjJgMht1OrzMrMq
         fEh6sMNYx2ZB33vyoZ7fzyA+/fK3DnKPasd3TbJZ2tXxegDRyTUOKHpf47wtXa7UdYNe
         Vm7S9L1wv7FyH1uYMqhoprWRPuNfGnqANn8LjZ6iVY31OSbL2KS0T4ggeyxPeg0HOa02
         RbF2ECZYGWHdARZRAHmYLtbVCYkCeudSSxw04GGQ7IVyqU2Pk8IZ0O3ujMnVNIU7BHG4
         gN8m6BPI84BTbZV9+MTTKtdidf8D9eY30DowtJ4EpmMMt/vO56ZdaPu+TD6uN+XDbfhB
         x9Fw==
X-Gm-Message-State: ANhLgQ0K7QMF+vQHtqDWVZmseKZjWhbAfAEsZxKoI35pU+B2vrexWGfJ
        ekEeLYwgviWTO+cNH9IxxYJoXQ==
X-Google-Smtp-Source: ADFU+vsbZynI+R8e3jLSyig5XUAieRLdXVzdDbgFtNnMb7/UmNXkF1SMhG1Unke/mdJNVMUjK9dDpw==
X-Received: by 2002:a62:7784:: with SMTP id s126mr298249pfc.23.1583442939943;
        Thu, 05 Mar 2020 13:15:39 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id 188sm29333161pfa.62.2020.03.05.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 13:15:39 -0800 (PST)
Date:   Thu, 05 Mar 2020 13:15:39 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 13:10:06 PST (-0800)
Subject:     Re: [PATCH] riscv: Use p*d_leaf macros to define p*d_huge
In-Reply-To: <20200220061023.958-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-e9025d02-f23d-486a-bbbf-083fe0932619@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 22:10:23 PST (-0800), alex@ghiti.fr wrote:
> The newly introduced p*d_leaf macros allow to check if an entry of the
> page table map to a physical page instead of the next level. To avoid
> duplication of code, use those macros to determine if a page table entry
> points to a hugepage.
>
> Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/hugetlbpage.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 0d4747e9d5b5..a6189ed36c5f 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -4,14 +4,12 @@
>
>  int pud_huge(pud_t pud)
>  {
> -	return pud_present(pud) &&
> -		(pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +	return pud_leaf(pud);
>  }
>
>  int pmd_huge(pmd_t pmd)
>  {
> -	return pmd_present(pmd) &&
> -		(pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +	return pmd_leaf(pmd);
>  }
>
>  static __init int setup_hugepagesz(char *opt)

Thanks, this is on for-next.
