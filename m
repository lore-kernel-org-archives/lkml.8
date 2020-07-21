Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E450C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2192F2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTDq8VUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgGUOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:37:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A75C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:37:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so21390197wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=JnIy8b7JnpzdmcIgpVJbxKihlNWQMt2nBTi33743rcg=;
        b=bTDq8VUZtFWvxWOVMetsDQottRZ3MaBIBDpdXMfsWrkEkfrqYrv7w/Wz/9G4K2dzSj
         79XkgyDB1QYTWDlBuG0l+2vSwvBSOzdfT/xm8vzUgbNYA87FVfJPd+y9NrA+YZY84aMF
         9BygtaBEFWSFRwfVY1s5REOlJOqXdpU9Z1qhKeGjClj0I7W3qkVehelAv4XgS+J59y8d
         OYtxGEGJOsSdvqrpNHM/CVrKiJ6byt1+AMACJE/ptxqq5m09jmAcNRP9YTFCCw3J835f
         fnzi7cSAgDvuj7Pfy2qin5tq9Z8k5Y3EOEIOzb9kJvqo/8U6nVWusi8uoH/ydYxocbgU
         O/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=JnIy8b7JnpzdmcIgpVJbxKihlNWQMt2nBTi33743rcg=;
        b=oRbSwCeiU5+wLvH4KdwvfnRIFKAs+z/KfhmkMl5ukggtWuR4+M80ZhR8hJmDQoU53k
         ecwfeyrWRH+VJMVT207kBnP6A3rM8IyPRDS1mFkrxV9TAgCKWf/5Fk7P72OHvn0/bUiO
         WxUx3oELFY18MK93MWWD2VgOYHFG7GVr90Wxcq+rSKlWkHoEf1McZ/Y6wm12hfXPGvBq
         VOabBZ3SnAZi0XbvJXZxYKVGqhE/nQO2LPCGWOL7UpC9Mg14A6/0ZS/VViKpUHEfdvKm
         05XToGTbAAREzaIjppyveJSlgNG5mhaKzEexWh5VmnX953yA2X2OqndejyGbAobFkGEz
         21NA==
X-Gm-Message-State: AOAM5320fUtgrBV02bosMlKVWwcWoKWzb3jVojI6AmjRke8Y7fmh1X/O
        FtLNPxagOWDZo2Fnt/vAIOFwZ0N7
X-Google-Smtp-Source: ABdhPJwEM2zAzSrBnxsLfc+qZxea4pNgOzpy7g+iFwxaW8xtzhmq24DMxaWi8GMjy9mSPUT6P61Www==
X-Received: by 2002:a5d:56c5:: with SMTP id m5mr539260wrw.356.1595342268872;
        Tue, 21 Jul 2020 07:37:48 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id l8sm37128263wrq.15.2020.07.21.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:37:48 -0700 (PDT)
Date:   Wed, 22 Jul 2020 00:37:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 2/3] powerpc/powernv/idle: Rename
 pnv_first_spr_loss_level variable
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com, Pratik Sampat <psampat@linux.ibm.com>,
        svaidy@linux.ibm.com
References: <20200717185306.60607-1-psampat@linux.ibm.com>
        <20200717185306.60607-3-psampat@linux.ibm.com>
        <1595202681.bt4670u7q7.astroid@bobo.none>
        <81dcf34e-870d-b3a1-7876-a6a2f0b37d1f@linux.ibm.com>
In-Reply-To: <81dcf34e-870d-b3a1-7876-a6a2f0b37d1f@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1595341835.8ad8mjl9hm.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Sampat's message of July 21, 2020 8:29 pm:
>=20
>=20
> On 20/07/20 5:27 am, Nicholas Piggin wrote:
>> Excerpts from Pratik Rajesh Sampat's message of July 18, 2020 4:53 am:
>>> Replace the variable name from using "pnv_first_spr_loss_level" to
>>> "pnv_first_fullstate_loss_level".
>>>
>>> As pnv_first_spr_loss_level is supposed to be the earliest state that
>>> has OPAL_PM_LOSE_FULL_CONTEXT set, however as shallow states too loose
>>> SPR values, render an incorrect terminology.
>> It also doesn't lose "full" state at this loss level though. From the
>> architecture it could be called "hv state loss level", but in POWER10
>> even that is not strictly true.
>>
> Right. Just discovered that deep stop states won't loose full state
> P10 onwards.
> Would it better if we rename it as "pnv_all_spr_loss_state" instead
> so that it stays generic enough while being semantically coherent?

It doesn't lose all SPRs. It does physically, but for Linux it appears=20
at least timebase SPRs are retained and that's mostly how it's=20
documented.

Maybe there's no really good name for it, but we do call it "deep" stop=20
in other places, you could call it deep_spr_loss maybe. I don't mind too=20
much though, whatever Gautham is happy with.

Thanks,
Nick
