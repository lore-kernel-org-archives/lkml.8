Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D483CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65C3206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaXNnHr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgGMQuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:50:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75124C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:50:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so6253545pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=nVkt+Xm/RkQTKeA2jb/S9J8CgntFMc1lva1n2yBK5Ug=;
        b=CaXNnHr+IzMUDxpQDvFSv/E5P7KIiogfIyf5xsA3V0eQmBRaj/nQqUHwox4eg1pHgw
         7uIsGBjNVBJuN3LBDH0YCBLucPbVxinNIdOSXnl5/Mas7DUjsbz38jriPYj2f0AtJX6Y
         tngEXIFoBSx8o/IVVWDmoLKnXmYVsjf7ixWY/w4wQS05xSFy5AxAzX4t+v+tNTOhW1Q0
         ewX9cIPKqNTXQiXUUPWp9/PoGvsr4GX2HgjxIKUafu19cJuJn9rgs2bskytV/ludgQbF
         62vpj90Hzj+W+zXOEGicCFsvnZqsbBathrmOP1TOslsn4Ll4fYw59XBPeDy8AA3dbQMt
         DR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=nVkt+Xm/RkQTKeA2jb/S9J8CgntFMc1lva1n2yBK5Ug=;
        b=cJ7w2mJX/NTn5LOPmH7POKE/nND+RQ7eZMRxFLCr2KSUPtdFkRNnXYdb4k/qygKMrM
         lFzwWYrBDHknrS0P1enTPcC2VDDgMGo9ioAiyRseVA0lujJDnXmVzG9j9ZTSmAL1/y6Y
         9Zu6803e4ZDKbwuRuL7YszrrQCoJYh3PVld8Rh4seGxhB/YeWA06wxIAKOjqM7fwTuWh
         I5cppfwGuRPOoVU61eNtdw5lU1EE1Zr7Nh9+0UTfWGV1oczWlD6wbaors8MTKO9dUJGH
         0IBsUOT2rgBywi5KPxiTmlkf1gKlsv3vP7pdJ10mADBWuNOvfs1RSA0imwwS5B2b0FZL
         rCtQ==
X-Gm-Message-State: AOAM531n8/YqB71cPGXmjhMUG4D0fNWAudiL6thtTe+XOlmlDN4XgGCa
        3oHMXc9Jt/QTLZZmE+gftdc=
X-Google-Smtp-Source: ABdhPJzOeudM5I8zL6WtkRfH73ta8+P2xSi1dulw3OXiBONHI3w8F2bCLGrZSAYaLXNb023RPhGS+g==
X-Received: by 2002:a63:1007:: with SMTP id f7mr78840pgl.147.1594659006024;
        Mon, 13 Jul 2020 09:50:06 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id x8sm14640967pfn.61.2020.07.13.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:50:05 -0700 (PDT)
Date:   Tue, 14 Jul 2020 02:50:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/3] Power10 basic energy management
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com, Pratik Sampat <psampat@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
        <1594617564.57k8bsyfd0.astroid@bobo.none>
        <bc6494c0-9a17-2416-c6cc-15612020f497@linux.ibm.com>
In-Reply-To: <bc6494c0-9a17-2416-c6cc-15612020f497@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1594658947.97ndhsx6xh.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Sampat's message of July 13, 2020 8:02 pm:
> Thank you for your comments,
>=20
> On 13/07/20 10:53 am, Nicholas Piggin wrote:
>> Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
>>> Changelog v1 --> v2:
>>> 1. Save-restore DAWR and DAWRX unconditionally as they are lost in
>>> shallow idle states too
>>> 2. Rename pnv_first_spr_loss_level to pnv_first_fullstate_loss_level to
>>> correct naming terminology
>>>
>>> Pratik Rajesh Sampat (3):
>>>    powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on P9 and above
>>>    powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
>>>    powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
>>>
>>>   arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++---------=
-
>>>   1 file changed, 22 insertions(+), 12 deletions(-)
>> These look okay to me, but the CPU_FTR_ARCH_300 test for
>> pnv_power9_idle_init() is actually wrong, it should be a PVR test
>> because idle is not completely architected (not even shallow stop
>> states, unfortunately).
>>
>> It doesn't look like we support POWER10 idle correctly yet, and on older
>> kernels it wouldn't work even if we fixed newer, so ideally the PVR
>> check would be backported as a fix in the front of the series.
>>
>> Sadly, we have no OPAL idle driver yet. Hopefully we will before the
>> next processor shows up :P
>>
>> Thanks,
>> Nick
>=20
> So if I understand this correctly, in powernv/idle.c where we check for
> CPU_FTR_ARCH_300, we should rather be making a pvr_version_is(PVR_POWER9)
> check instead?
>=20
> Of course, the P10 PVR and its relevant checks will have to be added then=
 too.

Yes I think so, unfortunately.

Thanks,
Nick
