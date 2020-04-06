Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A1C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE86206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db1mD337"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDFBk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:40:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39565 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgDFBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:40:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id g32so6794889pgb.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=JfqoETVUbeVhuWCheUwvSsR2etx95rp9fIXx0CAktnU=;
        b=Db1mD337TDZnTFi/Tz73h/PVt4R2aQ1DYIK0G8QvmocwEW5tlUl1tlDREyJyzjZ5SQ
         1YzVCx7wvDtmYmYnfKkcR9F0FlN+CeErACSUwUqfTIHsq4tjv02yFfE/RL8TxcosgLVn
         W8Q+mt16/0FYjQHTdWW+qG9kKZfMzNWIb5yDifxtA+wpJ3Ps8UU0QFgTvdm/zhDh/dkm
         hqYWSd3RQWQhkh0eS6CfWFWNs4TPgc0mahNUlsv7TPIm9ySpO+vOZa+MnD8JXFS/2r8o
         Ciej7DSXJx5KA4BtnFnWTXDoFQx5JC9vdlf3Tfnh0KKYRKJJprxAhs9z94D+O6vkKydE
         XHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=JfqoETVUbeVhuWCheUwvSsR2etx95rp9fIXx0CAktnU=;
        b=U629dim6wwoOWgfA78pHQD9qjQbNMvLwqtTOCGUDYgCP0V1mgLbd2RRn85tz6/eOKE
         Ghe9oqbNPFUBBWGdOflSyM43Xyl0KkIVlidpGn76c5oetm0qJLOAHnduE4cBKnRnNjBI
         8M5JQUrZE5ukhkmRWxojTU0ezpP3t2UlGvCiomu7187WZIEnz68tgUF7R0NbwQG/OA1S
         0+sBPQPRhc0JI3jrTo7vHO/wbZ1ouT2wIi4GOv9kGDOmXgbtqlemUyyWSM1T1ImuPTgo
         ouCTrfIuPROhU9AB3nGr8DgC/MhD7sHJvsOs9fty/n0lsC9dmqfr1eY/NV3hHsGzaphS
         Pxkw==
X-Gm-Message-State: AGi0PuY4hMz3Y7lIgektwMppuTT8WGWI5a3GK1yS6TT2QyN2CINsWO/+
        NqW03QpG2b8Z3pE/gnUOxQE=
X-Google-Smtp-Source: APiQypLNW+UjSKA27NgGh3BBUC9+7L3ENfp9aWDYv0xjAvUXTTfG6+lCmp2h+1lXbOHFzeuojRpYSw==
X-Received: by 2002:a63:e558:: with SMTP id z24mr18572992pgj.368.1586137227327;
        Sun, 05 Apr 2020 18:40:27 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id 21sm9761512pgf.41.2020.04.05.18.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 18:40:26 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:39:19 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v2 13/13] powerpc/kernel: Do not use READ_ONCE() to
 access current thread_info flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
        <3b9257ea1f3e107b81437671fa9d3942e31c6735.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <3b9257ea1f3e107b81437671fa9d3942e31c6735.1586108649.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586137083.v4cw2k5x9e.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 6, 2020 3:44 am:
> current is a volatile pointer hold by r2 register.
>=20
> READ_ONCE() is not required.
>=20
> Before: 327 cycles on null_syscall
> Before: 325 cycles on null_syscall

Patches against Michael's next-test branch have a few small changes=20
here. I need to look at the fallout on 64-bit code, although most
likely it's not measurable so if it saves you a few cycles we can
lean toward what ppc32 prefers.

Same with the compat test.

Thanks,
Nick
=
