Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A435024676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CPm8ZJw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCBSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:42:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40504 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgCBSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:42:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id j80so249132oih.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+8nfoKR15NmxwB0eviFINMK7mfZ/bWjSvXOrhjIWgPw=;
        b=CPm8ZJw3+TWEjm2lgHBD+rU3/76tOPOt/12fFrgnw2C+/jUxelaXCBy/mledMuM2H4
         UlAIyFz070RaCXY/KEZln/OokcFWj7YxyxPjwaN35ZO3D/q/BDSWAYwsvNEO+nt31v7D
         49Fax9alh1vhw1rCVJrTQYmQBkemdlKDDBgXcDmdS4MqnUEeqaaULI1Dog21/vZ9Quzl
         U6ZoxWzBEw6oxC63miSYvzacQ3XQyRUEWCwa16y36z1EtbdkjlHFU/DB78WUlcsAgTQj
         X4vnNZR9pmMEaoIOyifJCVVs0MyiH0ZaOQ7V6UDcVmgE5ZGcbH8uFVpH1Adv5G/V1hVJ
         M83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+8nfoKR15NmxwB0eviFINMK7mfZ/bWjSvXOrhjIWgPw=;
        b=t7fSdqz/ugAnDl8z804FKTyUtlavIp4ZhQsfX0IoWDw2M04wxFFhMOXCt05umMVUXX
         UvIL3oRuqBaD1CpfTfvxWUBnMhpOn5FDgO7vhFlkuwm4PuRbdM6Sr/aR6r3Z1Z5HGE4K
         aSounbhQ7xHKTPZOYuh3ZtQfZsQjGrjZWWfkA4KPYUTZlBrZbBtNCHtSvguj1offPYdO
         iLathhzklyS0LnkZzbeLBkgYwKu3Ut6F+ZyTRCvicrtz3JPE0JzKc/7Kt65YDMeY4l+9
         o+pSzkYLrgvPbJN1ZSL9oSiA+A0fcxSgrzmkJu6O1vDiJseTlkJkIdIlz/crJzrq25Ae
         JsMg==
X-Gm-Message-State: ANhLgQ3/4qntZ2BswumU72qXDRCHK4Xrs1WRqJLFL1M2+B0wOQxTrgXG
        qec7xxwSKZbqGg+XvYsIYhUNSmVwnZf1ua1G1FMwjA==
X-Google-Smtp-Source: ADFU+vvxBj3MBEqz5EKGoBOP9Q8Qnffyo4RLmccwHWhZAvKECUrDC084nmiZgFmtaJWkabRCBnu8WgzsenpBXgnwu2k=
X-Received: by 2002:a54:4098:: with SMTP id i24mr9465oii.149.1583174537330;
 Mon, 02 Mar 2020 10:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-16-alastair@au1.ibm.com>
 <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
In-Reply-To: <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Mar 2020 10:42:06 -0800
Message-ID: <CAPcyv4gCCjQFnLaSpRPEuKoDq3gOHSxjxLT_=X3N_nr=2ZOcSA@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near
 storage commands
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 9:59 AM Frederic Barrat <fbarrat@linux.ibm.com> wrot=
e:
>
>
>
> Le 21/02/2020 =C3=A0 04:27, Alastair D'Silva a =C3=A9crit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > Similar to the previous patch, this adds support for near storage comma=
nds.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
>
>
> Is any of these new functions ever called?

This is my concern as well. The libnvdimm command support is limited
to the commands that Linux will use. Other passthrough commands are
supported through a passthrough interface. However, that passthrough
interface is explicitly limited to publicly documented command sets so
that the kernel has an opportunity to constrain and consolidate
command implementations across vendors.
