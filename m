Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7641C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86427206D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1XtA+ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgEQWwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgEQWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 18:52:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD2C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 15:52:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so3411629plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=bE/bwCtV/S89QlNR1MerVFx47fg6954LpqGiTJHEXMY=;
        b=Z1XtA+ZWkgvp6bXo0Z9jF1nhsITTl9xulHzuS0+4YnumsAmEFfKe15OlbXfL1Z14mm
         Na4eRY1nPuNYJXpg20WI+mwBrSN1jxggma4EX0euYccqBg0j7DkyBQJwLirgNfCZWgSd
         27PYWkJP7cishtQJIO2TvdwKTMiO/Q/YgeLZqZGU1FKyGOpgudaJnh5RcDHdXrl7sc9c
         Guo6N/j6SG3t3E2Nl09WGqCB6kY78gWy10PBmDPfDDxU6l+1XXXUBkO51gmRqw3KALz/
         SF6g0uobMPFPURs58A3iTFTEigF7JHKwgQmrlrzv/e/zFePGgcQaT4fBafom0tkFHfUr
         iEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=bE/bwCtV/S89QlNR1MerVFx47fg6954LpqGiTJHEXMY=;
        b=S5ZxrElB1uiTRJcHgRz5nC/Y7kyUw5OPVWE7fh3jFSuhFJRfsZ6ofSegwIflXuSmMp
         qqDuZfI4vCpYWRXZmszji769PzFFVecqQUedbdJmQmZQ6URGM7sOXSBZ5Py/Mlw4aeq9
         6ng6Hu85nqa7eCnPAkEe/1DKFGXLONoIlC4ZDlZoqu1O/x57K9g3IFUlSv+CMSuMf4UG
         N64sIJZI8+fvzDGw7iEsALpaX0+1k5dGMESHE+VPMtBJYt2z/oHVZkQjl5wL2sWq2uXY
         vVBdO39eTA5+X3q9hcB7iibO9zL/oese/ptUxfDqY6z+z2q5XPWfi/rvzTqmqURpOMJM
         Xgng==
X-Gm-Message-State: AOAM533vJNObZGItOZaQLjuwkpII9nuJJpkx8BxAgdwlQpmP+brRM4mT
        t3gmQbrEFFPlF2Pq6DWKo38=
X-Google-Smtp-Source: ABdhPJwKKNtgPuy4yKiir3YzoI5BTiaP/vVXwthmJFgGm51HGXTz01vAmAA16QdHi+rX5JlIPxb7nA==
X-Received: by 2002:a17:902:d689:: with SMTP id v9mr3871689ply.283.1589755931916;
        Sun, 17 May 2020 15:52:11 -0700 (PDT)
Received: from localhost ([124.170.14.63])
        by smtp.gmail.com with ESMTPSA id p9sm6180932pgb.19.2020.05.17.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 15:52:10 -0700 (PDT)
Date:   Mon, 18 May 2020 08:52:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 2/2] powerpc/rtas: Implement reentrant rtas call
To:     Allison Randal <allison@lohutok.net>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Axtens <dja@axtens.net>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <namit@vmware.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200516052137.175881-1-leobras.c@gmail.com>
        <20200516052137.175881-3-leobras.c@gmail.com>
        <1589614523.yfijifo1n6.astroid@bobo.none>
In-Reply-To: <1589614523.yfijifo1n6.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1589755794.kmbg5am170.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Nicholas Piggin's message of May 16, 2020 5:36 pm:
> Excerpts from Leonardo Bras's message of May 16, 2020 3:21 pm:
>> @@ -202,6 +220,7 @@ void __init __nostackprotector initialise_paca(struc=
t paca_struct *new_paca, int
>>  	/* For now -- if we have threads this will be adjusted later */
>>  	new_paca->tcd_ptr =3D &new_paca->tcd;
>>  #endif
>> +	new_paca->reentrant_args =3D NULL;
>>  }
>> =20
>>  /* Put the paca pointer into r13 and SPRG_PACA */
>> @@ -274,6 +293,7 @@ void __init allocate_paca(int cpu)
>>  #ifdef CONFIG_PPC_BOOK3S_64
>>  	paca->slb_shadow_ptr =3D new_slb_shadow(cpu, limit);
>>  #endif
>> +	paca->reentrant_args =3D new_rtas_args(cpu, limit);
>=20
> Good, I think tihs should work as you want now. Can you allocate it like=20
> lppacas? Put it under PSERIES (and in the paca) and check for !HV?

Oh and while there, could you prefix the name with rtas_?

Thanks,
Nick
