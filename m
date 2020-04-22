Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FACC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520E4206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587544266;
	bh=6mKw5Xt6j7tOLgVDJ+VCoanJlRGTeZitW7Ao8zuGAus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ji5DUOVnGIKpTr77VgWNM9sfOthccA159QuMuBcjTtlj7MTf5/7JNv02rUj67nDCg
	 mkCNs1xmn1lfBMNAzXDiw5ZVuy+kVogiQY+1pytjyqLMjVgVFJ+TOaKsFMEQsLQvwP
	 N2Rg/L7m7izZIXkktFYCTTPKutBtgKnyz5eZAluY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDVIbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:31:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34372 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgDVIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:31:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id s10so669311plr.1;
        Wed, 22 Apr 2020 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s97SDRXqlAdd9mHwA+NMgZaoH23nHGMSFxZOHwMKFy4=;
        b=Jl2K612g9W0KiGOeQeROvUrAvOxFcFOoGnj73Jx5eFhV5tCCzOeNAbDpt8m0Jv91qh
         TadydVgS0r8Rnmq7ZpJ/4WsFDSilDkrBNbL+jr6HKUK7CAq0VoHAHprrs8dx70o9JCQP
         11fLGIFXsUF19S4hrd31UZrSQ/pdaZd9lP1pHQs+3tenVIcKFItoGOzUwD9MvL0yZI1B
         jPytCJ4mZrpL8tRrbJsKGjpSPssHi5EZ6tfgNh0ktRh7bSjkuloDh3f3oHY/JcsXGezw
         w32VAA4uDXUY/dQdMCtYwM4N3aKAY2fFbDbDf1qVTDEkbgrJjmjySOKBPexv+3ZCE6g6
         v1UA==
X-Gm-Message-State: AGi0PuZwUXiPS7q8MEmCuuDbpVA0uUAQLF42nY/Dx1nID3iozmvvRX4S
        v01jK7Ng01eno5MHv7SuUDc=
X-Google-Smtp-Source: APiQypLC+5l3Vomt6V1tjxuSMEOSaTQGxRu4RC97cmXMmvff519FuiqU2hJzm9o0idxvt/67s0u33w==
X-Received: by 2002:a17:90a:2526:: with SMTP id j35mr10033059pje.98.1587544264097;
        Wed, 22 Apr 2020 01:31:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a15sm4727083pju.3.2020.04.22.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:31:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F0C41402A1; Wed, 22 Apr 2020 08:31:01 +0000 (UTC)
Date:   Wed, 22 Apr 2020 08:31:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200422083101.GU11244@42.do-not-panic.com>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
 <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
 <20200420181931.GJ11244@42.do-not-panic.com>
 <675147f7-2762-c574-4c3d-de6b25a5a44a@loongson.cn>
 <20200421144931.GA20103@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421144931.GA20103@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:49:32PM +0200, Jessica Yu wrote:
> As for why __request_module() returns 256, I am guessing this would
> come from kernel_wait4(), but I did not dive into the call path to
> verify this yet.

I got it. I'll send a fix.

  Luis
