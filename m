Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22677C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D9F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJH7yZNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgGMQ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:58:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:58:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so5759092ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ORIM/ZNEBl74OqQM8L2yYxI+Et9/wiuEeRnDUO3EsAQ=;
        b=VJH7yZNscwaYbqE/omlmt9Ksyur+12V/TuE/UzLDXZk/SEEj0A641Rrw9RCiT75aVt
         c/cWhEOhvn7WEAaw428XyuGfpY8+riam1LEjec4bzRUGLaXawH/7y7eVgkty0X8/OFOD
         5Bs6J+bA6AWv9xdq7GQtl2DfW8yf4wP3HlRvlnGpvHLd+gL2Ps+l1HfFk27Qza1vmgqI
         +oAKrctQtMbvS27Hts2r7k6nfJjisE/B8j3gfbNY7Ktm04fS+UpEsQCeGqNZfow5hWf5
         Hi3yVTrCbJWqlfa4SumRjH/GNjpEMx7RW9wmECansF4SxxF84A/18y0h5buEW5r5f4EP
         dWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ORIM/ZNEBl74OqQM8L2yYxI+Et9/wiuEeRnDUO3EsAQ=;
        b=VrCVji43+tD1cvmAzhtRnlAnmtakmvqQPyMjx3K4SRvg0OjrFTFgMTRoZVkAIzXWzi
         peobppMDiQ6faZbNVpaeMNlLoIBr8bUpAhy57yB53mSI59Ktim5wvQktwsrRmShhKnHk
         YFzl0rsqyPFdBUrcy3ph1qp9wl2BkS5EA2MGsuWCVlpqdnNIjRLHuLNv3SN6Xvp5pfJd
         djzZguV7VvsmiAZ5ZNQN7L2BrVK4XGzJ9E3CVVkT/rvSNjBiICRZUEK7tp7MmZ8U5XOI
         jNQNxzH/vPT7vbDuKeeBtVqX2431ejCunIYCA7XelmakyDyjT9w+LlT/NtbMI3WXAGzO
         2dXw==
X-Gm-Message-State: AOAM531ZIRxqHgARG5nogNVzC0aujnGk3lxT9amb4ln4DS3haWf2jO4e
        /ZTJZio5FACzVRzxye3wwBc=
X-Google-Smtp-Source: ABdhPJxL5V5S/nPc/nFeHkLhW85eHEO6Lep2VyhUBbnbRUMZvQGVbz0NRkKtExc0kLvNvW7ItibMHg==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23mr479116pls.167.1594659539086;
        Mon, 13 Jul 2020 09:58:59 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id 207sm15368027pfa.100.2020.07.13.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:58:58 -0700 (PDT)
Date:   Tue, 14 Jul 2020 02:58:53 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/3] Power10 basic energy management
To:     ego@linux.vnet.ibm.com
Cc:     benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
        mpe@ellerman.id.au, paulus@samba.org, pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
        <1594617564.57k8bsyfd0.astroid@bobo.none>
        <20200713104837.GG24866@in.ibm.com>
In-Reply-To: <20200713104837.GG24866@in.ibm.com>
MIME-Version: 1.0
Message-Id: <1594659004.tvqngaepru.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Gautham R Shenoy's message of July 13, 2020 8:48 pm:
> On Mon, Jul 13, 2020 at 03:23:21PM +1000, Nicholas Piggin wrote:
>> Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
>> > Changelog v1 --> v2:
>> > 1. Save-restore DAWR and DAWRX unconditionally as they are lost in
>> > shallow idle states too
>> > 2. Rename pnv_first_spr_loss_level to pnv_first_fullstate_loss_level t=
o
>> > correct naming terminology
>> >=20
>> > Pratik Rajesh Sampat (3):
>> >   powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on P9 and above
>> >   powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
>> >   powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
>> >=20
>> >  arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++---------=
-
>> >  1 file changed, 22 insertions(+), 12 deletions(-)
>>=20
>> These look okay to me, but the CPU_FTR_ARCH_300 test for=20
>> pnv_power9_idle_init() is actually wrong, it should be a PVR test=20
>> because idle is not completely architected (not even shallow stop=20
>> states, unfortunately).
>>=20
>> It doesn't look like we support POWER10 idle correctly yet, and on older
>> kernels it wouldn't work even if we fixed newer, so ideally the PVR=20
>> check would be backported as a fix in the front of the series.
>>=20
>> Sadly, we have no OPAL idle driver yet. Hopefully we will before the
>> next processor shows up :P
>=20
> Abhishek posted a version recently :
> https://patchwork.ozlabs.org/project/skiboot/patch/20200706043533.76539-1=
-huntbag@linux.vnet.ibm.com/

Yep, I saw that. Still keen to get it working, just had other priorities=20
in the short term. We'll need to do this OPAL v4 thing for it.

Thanks,
Nick

