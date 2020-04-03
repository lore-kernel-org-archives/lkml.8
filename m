Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2913C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9018206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="OO+xU9Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbgDCPxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:53:25 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55197 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:53:21 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so3146422pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/xm49Z++pPKUR61EZS+Ss5H1dGEkXCmYNh/ZHByg8BY=;
        b=OO+xU9ZjWeXXBbbxY54oMK9qwQpE29KtSHVy55/UlQcomZeLThV9L5zZ2jkhnO/LaX
         mWOwjVeSSqF52W+F7oU42OZMvGz2m06+xM/mXl6YK2uU0R2TXYQcVCCdaPirZ9tcJ6Of
         k7lJp0LdY6iwI6zFWeCgs6UOhZzHDs4gRgi1uuMv4bhxufvGCDjSrW6QUJj886V7+YPW
         CY+DuxW1ixapCWIgtrcyaqakmCSBiK7qnVtO9m5CbORft4ufPleGpNufHUMyoQctmH5V
         STd4bg080tVmzFpXhSi9LfmGfB3f1ahWXQyH9xYeFjWYCrgbm1d7xrfZm5MSDMrE4Vgs
         yPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/xm49Z++pPKUR61EZS+Ss5H1dGEkXCmYNh/ZHByg8BY=;
        b=mIM13e0qYnAbcXPzZmDap5jZl/viJqPug4KFmx1E4DhOriMdDmHRkHu5rtq8YIqj1g
         RZM5eVKDs4t61ILPWmFDBCaBXBop/pHzhxpVCp0cqCA3Do5MJcrunpQM7WZdrTpcM5+E
         8SDkw1r/qxmCB4Wri5Ka4KifDZsxvZvhkPDWsCokmBb7fN+vgtb/tES3kgMeznsvGLsW
         W4ZVpSPg20KeNxqiKvNZqNkx1+jhNY0ClxraM6xI8vuTP1l7dP/ZEisW76lph7dlD5QY
         0kBq6gv0bkQbCmnMRdq4MWYWUW4Wh3QmWYstFxL/RlKAyykPonmfqmKvupHpwNcKM8n5
         w4jg==
X-Gm-Message-State: AGi0PuYBNYz6D1Wm3P1OElLeRdmvj1xnMKhNiI1GvseoN+SQDCfSjOn0
        6MMGjNqSGgtE92GzO9Vys133kw==
X-Google-Smtp-Source: APiQypI5TwXVtJtEQDczHc+8pBRTgdZNzjuGiaQfEhTxLcFOZnq/2CVnVL92LFNHOX0GikIGpdRb1Q==
X-Received: by 2002:a17:902:7046:: with SMTP id h6mr7980617plt.250.1585929199901;
        Fri, 03 Apr 2020 08:53:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 67sm5978019pfe.168.2020.04.03.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:53:18 -0700 (PDT)
Date:   Fri, 03 Apr 2020 08:53:18 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 08:51:17 PDT (-0700)
Subject:     Re: [RFC PATCH 6/7] dt-bindings: riscv: Remove "riscv,svXX" property from device-tree
In-Reply-To: <20200322110028.18279-7-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-264d030a-d77e-43b6-a2d8-d4598205e2af@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:27 PDT (-0700), alex@ghiti.fr wrote:
> This property can not be used before virtual memory is set up
> and then the  distinction between sv39 and sv48 is done at runtime
> using SATP csr property: this property is now useless, so remove it.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 04819ad379c2..12baabbac213 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -39,19 +39,6 @@ properties:
>        Identifies that the hart uses the RISC-V instruction set
>        and identifies the type of the hart.
>
> -  mmu-type:
> -    allOf:
> -      - $ref: "/schemas/types.yaml#/definitions/string"
> -      - enum:
> -          - riscv,sv32
> -          - riscv,sv39
> -          - riscv,sv48
> -    description:
> -      Identifies the MMU address translation mode used on this
> -      hart.  These values originate from the RISC-V Privileged
> -      Specification document, available from
> -      https://riscv.org/specifications/
> -
>    riscv,isa:
>      allOf:
>        - $ref: "/schemas/types.yaml#/definitions/string"

I'd prefer if we continue to define this in the schema: while Linux won't use
it, it's still useful for other programs that want to statically determine the
available VA widths.
