Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479EDC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BE1222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RqbHK8Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAPCc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:32:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34215 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgAPCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:32:59 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so20097269iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 18:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZMxDPPtpfyDr16DAViPOjphNjCxUKCyR951nmWvnX+0=;
        b=RqbHK8VoNCXEI+hIdHVL/MC88sR1q4OPTXukFJTkCL/S7mLSBkvaWjPbEO2L6KiNFE
         FhJusyzBBdV6kQ+a+YlTrvqU1YKNRBO4mhi1ULYHYxGkptEAQoBXJsH3mv+FHZHbmjUA
         lwLqyjkVstTa24clYlsBGKvyucNtx5Vu6wGV8j+2BRaOcMvQaU0kKYIPj29mQIn+/36R
         0NiXjAbEOA0a3MXvPd8ZyKRp5YExsJTzMX6AD+vrtGPu2uRtZKQQS4IIkgAk7HSgJtC8
         tVDjeI9PNc+AZ/kdpwMMxAEqhSUELgnJcgLO+//z3PFC0Cx1sEcLfqiWo4CIiUoIzZFy
         uz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZMxDPPtpfyDr16DAViPOjphNjCxUKCyR951nmWvnX+0=;
        b=aqWvt4PDqDxLUDYVgUOSlWLSJSFwW0XKX9xorftxM86i2S1RDdUoqyVK7Tgz79KQaO
         oqCRyB6+AViPWbaY3Qm3Y2mBWV+M9sDUT0x2eBLvPy480j3UX1QtInhk9+o4mnLDMBP/
         sEs2+jx0eYrxPl8U7K7A/bk30nMeQQopp9Hha3aZXrxEGfoqq4acFAYH1jJDtsj+idqO
         W7z4MtV1e1NYARKltBLbaDWOPWzHCcrcSyk1zbQ8//WYBDX36bdK/PIvJQdOD7aKgrI0
         xA0K8++NKqr9LtMUhv20h2ewOEe0jlIecj+PB9rATpAY2PbGKae5SoKamhLKx2Kiga+q
         P/pw==
X-Gm-Message-State: APjAAAVoL8ociPyJpcwkZGojhaC1iNk0XrQnpCC1INTkLqkwIGmnA8E3
        axH8Ch4Q851hMtjAHpP+KP/VEA==
X-Google-Smtp-Source: APXvYqyh+g2Hzupz8itLKiU78z1Ffu3lm87KUi123IE5FELOjy2k517AvOgTd2cAPDjAJzP0F4bC4Q==
X-Received: by 2002:a6b:e004:: with SMTP id z4mr24598779iog.235.1579141978190;
        Wed, 15 Jan 2020 18:32:58 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z15sm6458956ill.20.2020.01.15.18.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:32:57 -0800 (PST)
Date:   Wed, 15 Jan 2020 18:32:55 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <greentime.hu@sifive.com>, anup@brainfault.org
cc:     green.hu@gmail.com, greentime@kernel.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        schwab@suse.de
Subject: Re: [PATCH v4] riscv: make sure the cores stay looping in
 .Lsecondary_park
In-Reply-To: <20200115065436.7702-1-greentime.hu@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001151832001.98477@viisi.sifive.com>
References: <20200115065436.7702-1-greentime.hu@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020, Greentime Hu wrote:

> The code in secondary_park is currently placed in the .init section. The
> kernel reclaims and clears this code when it finishes booting. That
> causes the cores parked in it to go to somewhere unpredictable, so we
> move this function out of init to make sure the cores stay looping there.
> 
> The instruction bgeu a0, t0, .Lsecondary_park may have "a relocation
> truncated to fit" issue during linking time. It is because that sections
> are too far to jump. Let's use tail to jump to the .Lsecondary_park.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>

Thanks, queued for v5.5-rc.  Anup's Reviewed-by: has been dropped since 
the patch changed significantly - Anup, if you are still happy with it, 
please reply with another Reviewed-by:.  Thanks,


- Paul
