Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846DFC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5261024673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gqq0t7c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWAWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 19:22:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37087 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 19:22:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so541310plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 16:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=UAm+y673BEPrHXldf2cTkx9EiCWchkK86gahuOo9dk8=;
        b=Gqq0t7c92u8Zn8crwvApOUsfht3cORZv7uVMYRvrtTIgWsm23Net97AVNClAcOkmmB
         pxqGhUp0ZYwu1u7hel7fdiadtQOUCuDIxGH7sjYeVOV+SaeLJY0jUh94/2JgvJqPJTtp
         jPuJ6Leh4h8sRMpi7JGtMxxhmpL0ySPNaGJ52/Vk4UeDZjpRUmlIxU3a1KM6ZiRVyEie
         KeRRkSy4qzpFfH5rytbA8QAb+12ZuybdunJ2zFVkuk051N5+XKRI/PJc5NtiRqMgZsUO
         fy+WE2zUY4svBIjixpgXQeinZSsRNVV6YR2+eeHsXgBXUqk4iQ5Ewog33ZCx0qqjNtze
         lpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=UAm+y673BEPrHXldf2cTkx9EiCWchkK86gahuOo9dk8=;
        b=TwpSqn9exgPTEzCX9I8b/EPNhDlKn2mB+1nMsTBo9MT/Bm//GXPNMs9w64oVoSf9Vu
         8Np0VQljXHZiUy7fFrt78Rn0190D3F52CQemjOLztVUWEUAE+A9HZKPS6T+fiNWzhBcQ
         HQzA2hhMzQaJB4JxX0xvoovTZljfGg8yVgeLkuyOEeIRkVf9DhdaqRsUPT/vUBcueGYz
         DOadbAOD8ZOrkdaPnoDohVaQ12gG0IPbzO+jHSxxQj+d6HPPRlUh1nTKRHb8TniEPZcF
         uPqP6rbmVYlD6Nc2q3CI9VZ7QAmjf3+aO1ySX4EdS+kbXGfrpwDo5dcFG9tmraljnYSg
         hFLQ==
X-Gm-Message-State: APjAAAVQtXsOxcHPhZX/Nb20ih4Wi5xEtl+kstSmEu8/uSRNySt6u114
        LaLT4W74SOq3MHVr+Y0VLYSfMw==
X-Google-Smtp-Source: APXvYqx2V97ZyPLOxzNfRyOlfnGOYECZDnsr0TDNwoPNFUjkpuaMeWSR8pcnWnTvlQo3qPZ0SwQMdw==
X-Received: by 2002:a17:90b:8ce:: with SMTP id ds14mr1301887pjb.57.1579738949984;
        Wed, 22 Jan 2020 16:22:29 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id p18sm4086431pjo.3.2020.01.22.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 16:22:29 -0800 (PST)
Date:   Wed, 22 Jan 2020 16:22:29 -0800 (PST)
X-Google-Original-Date: Wed, 22 Jan 2020 16:21:35 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] riscv: change CSR M/S defines to use "X" for prefix
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, maz@kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
To:     Olof Johansson <olof@lixom.net>
In-Reply-To: <alpine.DEB.2.21.9999.2001070314050.75790@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.2001070314050.75790@viisi.sifive.com>
  <20191218170603.58256-1-olof@lixom.net> <alpine.DEB.2.21.9999.2001031723310.283180@viisi.sifive.com>
  <CAOesGMir810kVTDyoTFuhK-PdFe4J2u2VM+L8jOdO8DghAELQg@mail.gmail.com>
Message-ID: <mhng-55d1f282-e2ee-4ff3-b2c0-1701d175b426@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2020 03:15:56 PST (-0800), Paul Walmsley wrote:
> On Fri, 3 Jan 2020, Olof Johansson wrote:
>
>> Sure, this does the job. I'd personally prefer consistent prefixes but
>> that's just bikeshed color preferences -- this is fine.
>
> Thanks for the ack.  For what it's worth, we're in agreement that we
> should prophylactically place RV_ prefixes on the rest of the CSR_ macro
> names.  I just would prefer that it's done outside the late -rc series,
> since it's not technically a fix.

Olof: are you going to send a v2 of this patch that converts everything else
over or do you want me to?  I think we all agree it's the right way to go, Paul
was just trying to limit the scope of the change late in the RC cycle.  I'd
like to get this on for-next sooner rather than later as it'll probably
conflict with everything.

>> (Builds are still failing for some configs, but will be fixed if/when
>> you pick up https://lore.kernel.org/linux-riscv/20191217040631.91886-1-olof@lixom.net/)
>
> That one is on my radar - just haven't had a chance to review/test it
> yet.  Thanks for sending that one too!
>
>
> - Paul
