Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0031CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D1B20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="yS1UlVCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGPXTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgGPXTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:19:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6895C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:19:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so4563368pld.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=n4KTe3/xuQSWnZuouMggMmRt0/TA0hq7CmPqtl7gf30=;
        b=yS1UlVCB7/DevfhrSDlYG4yNIeaAteh3TMZPyrtc3jolPKCiHV225h1xQe5YOZhTlI
         BR/eM9E7fTCROcgjOezPXe0aal4ZJ7M6an23k9aHgb0dx97C5FuSCSOJdh8TbQjVpltg
         5g0POU6F1xR33zbXr4DVSSbz9khLkqi3MWw/vv1viWmmMJNJXq6468d0wU18kD6xtK1R
         0/Z3yP84fRQAKdNEEyZAQAxsTf6ex3B2PgElbg0682gaR0tZZmI0Zq2DPmhhr4d3FNuQ
         f3WcXzoDaEkz4ACVCg4qB1YI7nxsjxZx77Bf05P/dVN16z7F8sAO1vHDjeRTsipfLHFL
         OQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=n4KTe3/xuQSWnZuouMggMmRt0/TA0hq7CmPqtl7gf30=;
        b=tNn0dGjcINGHqENf6dhadOU5JOabTXdB56dkjtdFvi4tM3CdSdMRVbDkhmRmOuyS8+
         5z0Ow+dOst5XRtqXpCCHu58oBPCcb/I4+B6DLIa5AM333zKDwSI03Mkd+nRxN7YY5Nht
         kY7iFw+YgwrCAVbDO/iN716jSnufODC/mt+52w6cMrWNVG1bV5Sq6g5Nr3KRsuYIKFe3
         kgipMoN9c5bqrQJCwbcuq2/1Cneg7wxdAynfcAE9myezwZxpLLn4fkYJSECme+oGuXS6
         76d5ZrgigQ1hjZ9zbNkTY3jQkFeKGa+flkvGeJmMZXEhZLR5mT/tP0Um+L3v6pYAy9EJ
         aQBw==
X-Gm-Message-State: AOAM532qOZ3Xpf/sTUlDxDlIrFE1rds9zFsXc1BV2GyveDv0jP/bJQIE
        fCxtQqFX1Fz+LUfAiFWhTnNSDw==
X-Google-Smtp-Source: ABdhPJycqY6eAxKaeNeuobCKcFDl/A/Pm6poKCispycxj4QQknv/oWVgsDB75ASvN2wpr21lu4X37g==
X-Received: by 2002:a17:90a:f996:: with SMTP id cq22mr7779446pjb.208.1594941558995;
        Thu, 16 Jul 2020 16:19:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r25sm1627287pgv.88.2020.07.16.16.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:19:18 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:19:18 -0700 (PDT)
X-Google-Original-Date: Thu, 16 Jul 2020 16:03:52 PDT (-0700)
Subject:     Re: [PATCH] Replace HTTP links with HTTPS ones: RISC-V
In-Reply-To: <20200705220236.29402-1-grandmaster@al2klimov.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        christian@brauner.io, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, grandmaster@al2klimov.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     grandmaster@al2klimov.de
Message-ID: <mhng-79889b3a-dda3-49ab-ba9b-0c20292c2c31@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jul 2020 15:02:36 PDT (-0700), grandmaster@al2klimov.de wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
>
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
>
>  arch/riscv/include/uapi/asm/unistd.h       | 2 +-
>  tools/arch/riscv/include/uapi/asm/unistd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> index 13ce76cc5aff..4b989ae15d59 100644
> --- a/arch/riscv/include/uapi/asm/unistd.h
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -12,7 +12,7 @@
>   * GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + * along with this program.  If not, see <https://www.gnu.org/licenses/>.
>   */
>
>  #ifdef __LP64__
> diff --git a/tools/arch/riscv/include/uapi/asm/unistd.h b/tools/arch/riscv/include/uapi/asm/unistd.h
> index 0e2eeeb1fd27..f506cca520b0 100644
> --- a/tools/arch/riscv/include/uapi/asm/unistd.h
> +++ b/tools/arch/riscv/include/uapi/asm/unistd.h
> @@ -12,7 +12,7 @@
>   * GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + * along with this program.  If not, see <https://www.gnu.org/licenses/>.
>   */
>
>  #ifdef __LP64__

Thanks.  This is on for-next.

Unless anyone has any objections I'll eventually go remove all the license
boilerplates from arch/rsicv, as it looks like I missed a few when I converted
them over:

$ git grep "GNU" | grep riscv
arch/riscv/Makefile:# This file is subject to the terms and conditions of the GNU General Public
arch/riscv/boot/Makefile:# This file is subject to the terms and conditions of the GNU General Public
arch/riscv/boot/install.sh:# This file is subject to the terms and conditions of the GNU General Public
arch/riscv/include/uapi/asm/elf.h: * it under the terms of the GNU General Public License as published by
arch/riscv/kernel/fpu.S: *   modify it under the terms of the GNU General Public License
arch/riscv/kernel/fpu.S: *   GNU General Public License for more details.
