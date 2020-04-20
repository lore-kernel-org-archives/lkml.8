Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1769C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A8F2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="S+5BeLfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgDTSfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgDTSfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:35:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABACC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:35:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so5344793pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BVyxzO6w6KRqh5zTiPhAR3WguF52RcQy4LeNfkdXE5s=;
        b=S+5BeLfI2TmyfSan2k/CYEVDdox0YsV5vCj+hrbs2c+qoMYAL3ZtPvNeOESG/nM2c5
         4yoURWGbunwdWDiIBogB/kPUQKoDCzxbGyk+r1e6gXC4w3HR646WvvqRmK3TEt5VQdyK
         9hX+03iayDi27GDcxu+IGGwLWQHu872LdAyoSqEH+peMaXE03v+5kq8MHqqruHnyPk6I
         WaQVKmQQU6fNg5EqEAqUl4jyuZPfVclo+Wtl35fzV2J7qS5WFkKkxxFaaiL+nFu9HoM6
         t+zW7Ptw5/Vh0C764eH4Lv3ry5WW1nffvZdPIrY79DGlsX3EXviVufSWvYY/Rz819UXf
         ZqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVyxzO6w6KRqh5zTiPhAR3WguF52RcQy4LeNfkdXE5s=;
        b=j/jdpp1EtkcXRTs29WS26RQV0FcCGqaGXubkdyAxtofe9iAzoVBxpFlcaE6FRE/GEg
         5abdFjjjk+w9No883ghCR3/1QHX4QgXLL+OGH/uYL0B/wbJfh5vPPC7Orth4rEmhmvWr
         tgAgKGiblflTbzBLwNdv+fgQdmovfj3cv0Op1t3nsbWtFV9dIEMz+uE3yLyXf6UGmkYj
         oH6Vok41rzso1nhOKO7TVch9/EN13ad58G3df4s8jVi49rsg0Sw8AP4WrtfnWmZ//Gi9
         7ZJ1d0UU+Ko4Zk6EtfSETnXCwvCqFROQ/Xcs7racUdPN79Vtmk9V4VpJ5jU91rQMZD+f
         o4YA==
X-Gm-Message-State: AGi0PuYo3xzd/VBY7tkSbJm0Ra19KhGjtkQMlXCtAmbQEk3ImsIy1SIe
        jFm4lCv/uN5hhOWs6i1km2Pr8w==
X-Google-Smtp-Source: APiQypJ27QfKwierbm7XkX8Y3qkJZSMtvY5tcdA6Jc5QfsInRa2UZlTs9UzyQejBlHKxFnsslrKZ8w==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr17488927pgg.229.1587407732608;
        Mon, 20 Apr 2020 11:35:32 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i190sm175314pfe.114.2020.04.20.11.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 11:35:31 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86/vdso2c: Convert iterator to unsigned
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        Andrei Vagin <avagin@openvz.org>
References: <20200420183256.660371-1-dima@arista.com>
 <20200420183256.660371-3-dima@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <04b64d48-62f7-cf50-a12c-ccb2f8a1b9c1@arista.com>
Date:   Mon, 20 Apr 2020 19:35:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420183256.660371-3-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one was sent by a mistake, see
> [PATCH 2/3] x86/vdso2c: Convert iterators to unsigned
instead, please.

On 4/20/20 7:32 PM, Dmitry Safonov wrote:
> i and j are used everywhere with unsigned types.
> Cleanup and prettify the code a bit.
> 
> Introduce syms_nr for readability and as a preparation for allocating an
> array of vDSO entries that will be needed for creating two vdso .so's:
> one for host tasks and another for processes inside time namespace.
> 
> Co-developed-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
[..]
Thanks,
          Dmitry
