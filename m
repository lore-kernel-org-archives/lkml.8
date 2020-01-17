Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF9C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8582B2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nn60vdPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgAQUlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:41:35 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42006 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:41:35 -0500
Received: by mail-il1-f195.google.com with SMTP id t2so22336829ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=l67Q2JaZUuxYTTc14dadVG8CPVycSfA7W0h/5578mZM=;
        b=nn60vdPY5om2CTLHZCbVBXuD2dZtq3zIDLFjv2f6o6pOmcpQs/R92aqkvIGklG1VpR
         XpNW7h8CCl1ZSya8QZWLffcfrqvDWXl5mpvfQHLU6HDBeUc1PDAD56OIt0QJlcN/XWZ+
         2sTUPoSecKfaTR2L4Ci21mLETPNqvNgPUoYE0OSz2plDFr+UCSZjkOPhI+GiEOQaaJ8H
         oP6PnPn12MdknimQ5M8Fe85zN/+BQVIoG07WB//UeFh1qz+ilqI3tk07zQRi2qS27RNW
         YwaR7d0Hzjdm+XiTGhn0sXAazXuwx8zTapGag25WVCVYr78/TJf9U8BhImtBvcbES8t6
         qk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=l67Q2JaZUuxYTTc14dadVG8CPVycSfA7W0h/5578mZM=;
        b=d3ymnaQE0m2WOOCykpfU1ym82lXF+ywpGlaydqpJDpdFVY30uk5neG3CUjaj/X6/Gs
         vyrU1fIcuMaQ+Jd/OssHXYFO4MeUVB0NIiKV2M8vUue/6szgoSpoVXAu1tBFE6l6bcXH
         HiCE50LCb95ny8W0h7/rRFmBR3n9SXA99DS77FP1iEHEDwqPnRh4nwhcg10AebM0KhU/
         RSHUgemQCX7Cb/hHVKYjz+DpfitiU5Qi0Gso2fC26KXY5iCoU74WejYG+TUIcKuN89qC
         ehZM1g6GY2X86mqTU+NMjUhH4oo1X+iYf6OJ0FSPlXn3zWVDyX8+lEPXgyFeqErPulql
         Il7w==
X-Gm-Message-State: APjAAAV+e5N04i5Yv3Ms95JnLnGLErhBXKc5eGg31l30bN54ru2dTXaJ
        PiueIK/WzrMhfQUCLrrBe4JvJA==
X-Google-Smtp-Source: APXvYqyhD/DuCNRVkINRezmPM4CoIncLA7Blgo9UbiMKgcAlY+o2QZJtykuXI74GzHHVKdxUjToU5w==
X-Received: by 2002:a92:ba93:: with SMTP id t19mr369490ill.0.1579293694120;
        Fri, 17 Jan 2020 12:41:34 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id x77sm8237951ilk.34.2020.01.17.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:41:33 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:41:31 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Michal Simek <michal.simek@xilinx.com>
cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        x86@kernel.org, Guo Ren <guoren@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Wesley Terpstra <wesley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Message-ID: <alpine.DEB.2.21.9999.2001171241070.98477@viisi.sifive.com>
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Michal Simek wrote:

> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.
> 
> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv


- Paul
