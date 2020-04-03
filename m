Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D544C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056D12082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="mTlwkVFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391033AbgDCPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:53:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42350 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390770AbgDCPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:53:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id e1so2827911plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=aCbpKCHta5Gf9lbTrJuxsCQNSKBDWurQHiWXvTOaiOs=;
        b=mTlwkVFz8FS56fdhyghqaDOvmP5TQC31zSmweEkCTWqSkbmr72yJAnmvCQZ3DstzP9
         PFT5l2+WbeQfWLEXe3YxlIDqVPnfOMvXR5AkZCfolAMA1NJ69Smbd4UCv9vIdP9zE9cu
         2ndAVtVns2gnAf4tKklhKW0mzlTx8YCdW1PqqXZNrvNdOOBFwrnRxjOeBfDGuNPOkTJY
         3IhMh5dHNi+ylpRnA2kTDhTRN4r8J1XK84HK6fKnSdUUYksalQtOWao85+BN3jZdFVbA
         /BE+bUmtr3reObtM+qHX0hX0r/ljnK9jtwMttz9wCqQ+eblTHMIIJwdThz7XMg6/f1jw
         x++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=aCbpKCHta5Gf9lbTrJuxsCQNSKBDWurQHiWXvTOaiOs=;
        b=B0NnORGNanmCGmdpMHy6B3yzigvGhM2B71s9inUVa4/OroQJOUMSvuVM11UVqDiuEG
         tbQSvB75cyhxfGCHdnXBzuDARrcPQ5djZTNn+TIiOPsOMuKDsi48URitNtatuRPsCn97
         aYFNB426i5/xmaA0+XHW4aR0tjwAXZmlJ1cw3dGdur5wwypEQNTGUW3nyuhfUqyTE7LF
         wDoZHLCEsEgoQGVXy2YPkAck2qdkwsbCu5/mIBp2C80wBBQOv0ZiNLavahZ8iIVMjOKA
         4hrLEoVRvDrPP3pF2Lc0IxS+2DCK+zguMLNVeVaW5HvfzRDUTi3h2wzEXMd4PJWDeSlb
         rrfQ==
X-Gm-Message-State: AGi0PuYce/pg9RqKpdttkr4EJEVGlmy1GviNAO/kOrKMHqtMTf4xbBhI
        Mu7v4g0zO4x8q79DPlxIS7Yv4P05aAk=
X-Google-Smtp-Source: APiQypL5LwHE9/7vOtYmByb2Psnr6DVT3WG+8Er6QRzHhKJtMNlTakNy5skV9vno0vwYkxv2ZlzXVA==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr10559247pjb.10.1585929197597;
        Fri, 03 Apr 2020 08:53:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l23sm6015331pjy.22.2020.04.03.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:53:15 -0700 (PDT)
Date:   Fri, 03 Apr 2020 08:53:15 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 08:45:02 PDT (-0700)
Subject:     Re: [RFC PATCH 5/7] riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
In-Reply-To: <20200322110028.18279-6-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-a151714b-ba54-41dc-bbc6-e215c9594e59@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:26 PDT (-0700), alex@ghiti.fr wrote:
> Now that the mmu type is determined at runtime using SATP
> characteristic, use the global variable pgtable_l4_enabled to output
> mmu type of the processor through /proc/cpuinfo instead of relying on
> device tree infos.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi |  4 ----
>  arch/riscv/kernel/cpu.c                    | 24 ++++++++++++----------
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> index 7db861053483..6138590a2229 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -50,7 +50,6 @@
>  			i-cache-size = <32768>;
>  			i-tlb-sets = <1>;
>  			i-tlb-size = <32>;
> -			mmu-type = "riscv,sv39";
>  			reg = <1>;
>  			riscv,isa = "rv64imafdc";
>  			tlb-split;
> @@ -74,7 +73,6 @@
>  			i-cache-size = <32768>;
>  			i-tlb-sets = <1>;
>  			i-tlb-size = <32>;
> -			mmu-type = "riscv,sv39";
>  			reg = <2>;
>  			riscv,isa = "rv64imafdc";
>  			tlb-split;
> @@ -98,7 +96,6 @@
>  			i-cache-size = <32768>;
>  			i-tlb-sets = <1>;
>  			i-tlb-size = <32>;
> -			mmu-type = "riscv,sv39";
>  			reg = <3>;
>  			riscv,isa = "rv64imafdc";
>  			tlb-split;
> @@ -122,7 +119,6 @@
>  			i-cache-size = <32768>;
>  			i-tlb-sets = <1>;
>  			i-tlb-size = <32>;
> -			mmu-type = "riscv,sv39";
>  			reg = <4>;
>  			riscv,isa = "rv64imafdc";
>  			tlb-split;
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 40a3c442ac5f..38a699b997a8 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -8,6 +8,8 @@
>  #include <linux/of.h>
>  #include <asm/smp.h>
>
> +extern bool pgtable_l4_enabled;
> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
>   * isn't an enabled and valid RISC-V hart node.
> @@ -54,18 +56,19 @@ static void print_isa(struct seq_file *f, const char *isa)
>  	seq_puts(f, "\n");
>  }
>
> -static void print_mmu(struct seq_file *f, const char *mmu_type)
> +static void print_mmu(struct seq_file *f)
>  {
> +	char sv_type[16];
> +
>  #if defined(CONFIG_32BIT)
> -	if (strcmp(mmu_type, "riscv,sv32") != 0)
> -		return;
> +	strncpy(sv_type, "sv32", 5);
>  #elif defined(CONFIG_64BIT)
> -	if (strcmp(mmu_type, "riscv,sv39") != 0 &&
> -	    strcmp(mmu_type, "riscv,sv48") != 0)
> -		return;
> +	if (pgtable_l4_enabled)
> +		strncpy(sv_type, "sv48", 5);
> +	else
> +		strncpy(sv_type, "sv39", 5);
>  #endif
> -
> -	seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
> +	seq_printf(f, "mmu\t\t: %s\n", sv_type);
>  }
>
>  static void *c_start(struct seq_file *m, loff_t *pos)
> @@ -90,14 +93,13 @@ static int c_show(struct seq_file *m, void *v)
>  {
>  	unsigned long cpu_id = (unsigned long)v - 1;
>  	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> -	const char *compat, *isa, *mmu;
> +	const char *compat, *isa;
>
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>  	if (!of_property_read_string(node, "riscv,isa", &isa))
>  		print_isa(m, isa);
> -	if (!of_property_read_string(node, "mmu-type", &mmu))
> -		print_mmu(m, mmu);
> +	print_mmu(m);
>  	if (!of_property_read_string(node, "compatible", &compat)
>  	    && strcmp(compat, "riscv"))
>  		seq_printf(m, "uarch\t\t: %s\n", compat);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
